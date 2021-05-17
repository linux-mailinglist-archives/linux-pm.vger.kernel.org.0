Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD3382A33
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhEQKx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:53:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:29001 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhEQKx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621248752; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bbBugWMAXPY0x5O2WIR8tzxY8oLH+9Em6l8WAALxh4wcqPphbRKur2hst09f6mHe57
    kncv4hCI+uPe9Ck337tVvSo5aemUoqYSKpn63kg/fB+Q5uGBhKd2fdvoYvKFE+xEKYHZ
    ev5f7EH+pmocBcur5B60rVNYXwLbrDj93zZEW+FsNYbJLk90wFDmjucWSRAy0+lKi0u0
    6sbpXV+oZfPa+AX9da0WkAsRVjFzdB2AQI092H7jd/WXepBJt/uYuKdv1D12MkXx5+xR
    IG9+KVZsa0vuIheZhPqsI4n/+ByBMpW5YdLY1ErfX7MrCbXZsbPaAnAqrdqCuNKRgtS4
    ZmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248752;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UVrmOlkunBWm8CTCc2zVAt3rt0YhWagI6/xeD1B+H7Y=;
    b=Lk6nQN5SpBvHKpwviSAN6vQWmGlUwOHOTF1r6q/eI/zZHRKwjOeVHzrndqFu3LOWsJ
    UGbqFdFkrszIXKQUt/M9gMJ5Wc+VrKQPAJgtCupgVW0bo8pqEEfeVfkIClbnbb15q7ST
    8nO7nzvFtj/5xnA3AMBGdjJi4yDNyT4tksT1y9vrzVkyUzYNCDPwui+BtNAyK4iNCOVi
    CVhkkkBy7K79tywI3Cm8t8Ihl48QCuT6r3HZnGLwF+lWHxztdQUYMuih/gOybARkG28f
    IpNpCyOzNv1Sn9EDKM3vI1f5lRyRDQuN/qYPGokm8WaS9BSXiG2ydj/PBLTneTo1N1gl
    72Jg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248752;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UVrmOlkunBWm8CTCc2zVAt3rt0YhWagI6/xeD1B+H7Y=;
    b=KhayggNT2xefDq3dqPIYZwNWK0VyBu3Op4EQ+wMyOm5CEGYZ2sS3m0hipKZ1HgRmaK
    UUlCdUUB+RGM3amahKZyT/Vy9zikoNDCx+csNjjhyBUHN3eN/JMYkAFzTUQgtdPlkxMZ
    w4cMsmIBYRkv4vyVE/ty2qaxOSo0pjiDxvz4/cB2uRLFEfAUlzo1Tnxmjwrl542k0Pk2
    Q4XqLpmkqq1c/bqL0rPl4kgd7YJRGZC9y5McRJ+pBOBfVNklZtAK9lBrqE26AkzQffVj
    3znh0GYuI6m8JvOOrpVX3jH7F9OmZJQu65fllRhpIL+jqjyghUFQ5jhDCA9XQaR+jQzd
    Nkow==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAqV1VY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:52:31 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/3] Fix RT5033 battery device tree probing
Date:   Mon, 17 May 2021 12:51:10 +0200
Message-Id: <20210517105113.240379-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At the moment, the RT5033 MFD and battery driver suggest that the
battery driver should probe as a sub-device of the MFD driver. However,
this does not make any sense since the fuel gauge part of RT5033 has its
own I2C device and interrupt line.

It was also documented as separate I2C device in the original device
tree bindings [1] (that were never finished up and merged) but for some
reason the code does not match the documentation (and reality). :/

Given other fairly critical mistakes like setting the wrong bits
in the regulator driver (see [2]), unfortunately I get the feeling
that none of the RT5033 drivers were ever tested properly. :(

This patch sets adds a proper of_match_table to rt5033-battery
and removes the rt5033-battery sub-device from the MFD driver.
There is no compile/runtime dependency of the power supply / MFD patch
so they can just be applied separately through the power supply / MFD tree.

With these changes, rt5033-battery seems to work fine on the
Samsung Galaxy A5 (2015) at least (it reports a reasonable
battery percentage).

[1]: https://lore.kernel.org/linux-pm/1425864191-4121-3-git-send-email-beomho.seo@samsung.com/
[2]: https://lore.kernel.org/lkml/20201110130047.8097-1-michael.srba@seznam.cz/

Changes in v2: Fix stupid typo in second patch :(
v1: Honestly, not worth looking at :)

Stephan Gerhold (3):
  dt-bindings: power: supply: Add DT schema for richtek,rt5033-battery
  power: supply: rt5033_battery: Fix device tree enumeration
  mfd: rt5033: Drop rt5033-battery sub-device

 .../power/supply/richtek,rt5033-battery.yaml  | 54 +++++++++++++++++++
 drivers/mfd/rt5033.c                          |  3 --
 drivers/power/supply/Kconfig                  |  3 +-
 drivers/power/supply/rt5033_battery.c         |  7 +++
 4 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml

-- 
2.31.1

