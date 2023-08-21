package ru.jdbcfighters.renthub.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.jdbcfighters.renthub.domain.models.User;
import ru.jdbcfighters.renthub.repositories.UserRepository;
import ru.jdbcfighters.renthub.services.UserService;

import javax.persistence.EntityNotFoundException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    @Transactional
    public User create(User user) {
        return userRepository.save(user);
    }

    @Override
    public User get(Long id) {
        Optional<User> foundUser = userRepository.findById(id);

        return foundUser.orElseThrow(this::throwNotFoundException);
    }

    @Override
    public List<User> getByFirstOrLastOrLog(String firstname, String lastname, String login) {
        return userRepository.findUsersByFirstNameOrLastNameOrLogin(firstname, lastname, login);
    }

    @Override
    public List<User> getByFirstAndLast(String firstname, String lastname) {
        return userRepository.findUsersByFirstNameAndLastName(firstname, lastname);
    }

    @Override
    public User getByLogin(String login) {
        return userRepository.findUsersByLogin(login);
    }

    @Override
    public List<User> getByPhone(String phone) {
        return userRepository.findUsersByPhoneNumber(phone);
    }

    @Override
    public List<User> getActiveUsers(Boolean active) {
        return userRepository.findUsersByDeletedNot(active);
    }

    @Override
    public List<User> getByBalance(BigDecimal balance) {
        return userRepository.findUsersByBalance(balance);
    }

    @Override
    public List<User> getAll() {
        return userRepository.findAll();
    }

    @Override
    @Transactional
    public User update(Long id, User updatedUser) {
        existCheck(id);
        updatedUser.setId(id);
        return userRepository.save(updatedUser);
    }

    @Override
    @Transactional
    public User delete(Long id) {
        User deletedUser = get(id);
        deletedUser.setDeleted(true);
        return userRepository.save(deletedUser);
    }

    @Override
    @Transactional
    public void hardDelete(Long id) {
        existCheck(id);
        userRepository.deleteById(id);
    }

    private EntityNotFoundException throwNotFoundException() {
        return new EntityNotFoundException("Пользователь не найден");
    }

    private void existCheck(Long id) {
        if (!userRepository.existsById(id))
            throw throwNotFoundException();
    }
}