Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF2030616
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfEaBQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 21:16:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37365 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaBQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 21:16:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id e7so2796626pln.4;
        Thu, 30 May 2019 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLXj7SNsIj8HMSdYiQOSKdVgfa5Ol1Nfhh6XVY2TIDE=;
        b=MuAVA6GLtz4NhogDw/q6IUmvTdo3V2l3ftVmCQ145byUcvTJ0xuuq/czk5JMyskzK8
         IYrwEmHiIs8tvOnT5oF6TFc5JozBcZ7qxHxsJCy24GzaWXuln3gkn3ZKzQaCD/ajVo8F
         l9UWEGpDFeMuVtzk+ym9MgfmgS6enbw/Atc+Bk8Cn/YGi4y6LklIeCbdX5KCQwqSIvlh
         +vffeioRk1+Qq7gHZ/LCCUEvRSGhpxnI+eyZ4JmL5V2Wnj8/+wTtjDrZzTPF5nVkDbu5
         dDMC8FHjIT0lMcjNfq1vO8hBWdr8YICmsmP4inDdITYNp3Q+Uo9OlZd4ZTrwaVxTzuT0
         vUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLXj7SNsIj8HMSdYiQOSKdVgfa5Ol1Nfhh6XVY2TIDE=;
        b=iosEoyy3dsrGBKam3ZCjMBplfTEOeXkfsR4+YDIN/gBMaLCiAoXGj8AJEln13wRpo+
         o5xt2bpXrjjA18rEw/hwkdkUVHDkGdJFKfcQdclDkrNKIe1duGpig5E3ZxJ9oa2+ab0J
         DXUD8zbaewtHptl3sJ74shlaknNj+POOVB7NzFJwz8G+wLN+96lbaKclLggfJUaAyPOt
         WF48GcIH1gvVlZJljHqc5zBpZaKhBTscSSXTswC5JfnNz3lB2BijtH1O9kzJQfYbu3MQ
         8Fl4asTaYpjMvHS7Bdszp5fs7xytstDYJPUAPUMp7LgU9XObyScfQZUgAMrHztMmnzG+
         a3Bw==
X-Gm-Message-State: APjAAAVZhpqFTJI8fn1txqX4rzA5kCwPuohL5vyEAjaYx9Rh8R+T8tii
        EO1jZXSk4TlOfnZvBUM2x9J5CAvCNrE=
X-Google-Smtp-Source: APXvYqxI0VFiQXPy0cW0eTAPQXkCFQgZY43EA//KH7MT/4y5HSQYXi/MN26OOMClsQy+mtwg5Fgd8g==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8mr6088108plb.206.1559265412795;
        Thu, 30 May 2019 18:16:52 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v93sm3807335pjb.6.2019.05.30.18.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 18:16:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HWMON compatibility layer for power supplies
Date:   Thu, 30 May 2019 18:16:18 -0700
Message-Id: <20190531011620.9383-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Everyone:

This small series contains the code I wrote to expose various power
supply sensors via HWMON layer in order to be able to access all of
the sensors in the system with libsensors. Not sure if this is an
something that can be accepted upstream, so I am hoping to get some
quick feedback.

Thanks,
Andrey Smirnov


Changes since [v1]:

  - All multiplications converted to use check_mul_overflow()

  - All divisions converted to use DIV_ROUND_CLOSEST()

  - Places that were ignoring errors now don't

  - Alphabetized include list

Andrey Smirnov (2):
  power: supply: Add HWMON compatibility layer
  power: supply: ucs1002: Add HWMON interface

 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_hwmon.c | 349 ++++++++++++++++++++++
 drivers/power/supply/ucs1002_power.c      |   6 +
 include/linux/power_supply.h              |   9 +
 5 files changed, 379 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

-- 
2.21.0

