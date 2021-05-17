Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89B382A08
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhEQKmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:42:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:27289 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhEQKmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621247894; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N3J6s6zrMN+loV5cQFaAP6JLxzJmQxPNN7Dh+VpN/Pp3BTRcEmR4O132WDjg0PlkVZ
    bNt5NHxYBshOzdo6CiPdPTPg5ZVS17Qu7lGGmXO0qiwjQNBR9mRxmyUFVXfOKLNrPCL7
    7pndFISsYkjxwrBy+LZMrekY1HtIA2JxVBP5gH1SoNIvhGhngpo0OLbuUnDWkLHiY2w+
    +a+ZT6H+z6veQbohSGwIjwilrFVftljsmiDrpGy5426ZC+3CiL4O+oO6+NdPh3B67f+9
    Gm6UQtNfYPyfIx9DLnz71sUelepbbm3MfD8vPs2G224b1/5th/k7MWwBcfCg7szJoYJK
    O6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247894;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v32wUkqLcAoYLrAdRMAH9OgsbN4EMWWzzWzMugcjqZY=;
    b=bzf5UrepomYjIheHR5NZH7CZx9SJkX3lqw4ucDR76JDeWWiD90yGrjFFQNQ30zKSfe
    TpuZ8ivlQoRGYVJPF+lojEDdtbRZ+5Lu2TEyJH1Y4QZz7DRnGNf1+kZUQUfkiykp3p5Y
    mgLKanwnbPfxmDMw05ZPX46ko/JbsZSI7D2aaWLFfYjlfNS7NvOHn6QvTeKPxicKF4Yx
    Q1IsZK4N+IfIH243W7qZi5abXvcKOGAUpzq4CWDdO/yRDEx940Z7bL+FnExjptFSTzwW
    9iHg8TrndAkAKf8ffN8BVC1n5OJxNd9RIcMOWoVy+ZVjVmRrprUGeal5yVwbqb5kmm3r
    WcLQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247894;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=v32wUkqLcAoYLrAdRMAH9OgsbN4EMWWzzWzMugcjqZY=;
    b=RbYAiHNfU+WOG4UzdWhTF/Xsc8ZWtf35mLVJLeW4yhrxKftGTz5z2lGlqMz9an/9jq
    xp2RUR9qrUwPgms7vyKPIEVYKRzGj6YlBD9riW5VrVb655z8KgBXwLefUal3HGHLNxcu
    aPiBZETWx9hzf01vhdQ/NT9v75MpGOO/saMsm94CQlIjoCPoKWozfa4rlxI/dZJ0EH7s
    K5jreoRz3v7AisPQAXsQN7B8AHUyEXdkXz+Vn+mseopeFFoZPeEtYW+7zI2pZZYjwOjR
    NXvg5SyzAdMfHUoTWjHXdKDeCvQA+miTL4qR5gV1h7uTX+HFz+witviEfCrwy4KVgL/P
    5r3w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAcD1PR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:38:13 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] Fix RT5033 battery device tree probing
Date:   Mon, 17 May 2021 12:35:51 +0200
Message-Id: <20210517103554.168159-1-stephan@gerhold.net>
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

