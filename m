Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E94C2D5F8
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfE2HL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 03:11:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40498 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfE2HL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 03:11:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so1007886pfn.7;
        Wed, 29 May 2019 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0vuhxFJ4P3xa4ba7rfnmssCc9gPY/5ngJ1uDb8sraQ=;
        b=FxUrCIKbpsemDl54cej5m10Lkp2/tzg+aAHea4gxFGKDPfrbNjZqyEbiwQ4TY6EN9m
         LU7f3HoqhCOBpzroayaWv45u9hBt+SHMf0Mte4/Tdd56I/lGpoAfamigXtHnpZUxA/J4
         ubHKSxbprZHUsbjQpz5gFGCmmsR9xJV6jKu8cR/s0mkQtYjuR2fQ+Kn9FfLX+bAKzq3A
         UHohQd2pKqEGWHu9j95M7otGTQNlLzACUmVbvNoKS5i0b+Yx7qHeLYEpm7CGfz5kV1pP
         8/M3EBRTAxl/U5F62Z0Nc8QTt1Hbc3qFDvqRchs0MmJR7AFguaqSuHQmRGkOayYWpcQH
         QTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0vuhxFJ4P3xa4ba7rfnmssCc9gPY/5ngJ1uDb8sraQ=;
        b=KPbBH1jWQOPbL1TIeT2vSCwVteWVboG4qlZYPkrg2xXaWwVCdD9lk492y10ACB38oj
         wDXnp0V7rAWAmnWq/4W/WG3xjQB8u8UObGc3c7FBXw+9YWxACNgJbsUfpPoDUscbVPW8
         JwuNJy6NwdX/A1Tg6GB3fA8Y7aTxDxeXbN3JezICBItvm+7l5MAm1g/yxittbFZVwgA8
         26Vb7WEViz77PEUju9HrfrXBkzVYvPCQAO2Xz7G/uz5eLPQLzZdV90jZKABBNT/g1+Jr
         3Qo/QOTcVoRDyRX5WFopyR8NlvQAnvQ6ifDrSRAllfWnBzRAK8dxqvdZ7R7JSOnfayRB
         7cTw==
X-Gm-Message-State: APjAAAXNJh1ucsQU4CiJdjOJbDPikb9h6XXqzuT+hGjkQ0/uzouHz0Mf
        ueinJ03FiuFmY2DruxxmC4E6poFImUw=
X-Google-Smtp-Source: APXvYqyA0cgRs4d8BMUG8ICod4xsdfhU5/i9Q9YNIMhPacbAUkUZNzwzlbc4fDd4tCPvxh+NJYU/GA==
X-Received: by 2002:a17:90b:d8c:: with SMTP id bg12mr10322688pjb.63.1559113887117;
        Wed, 29 May 2019 00:11:27 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u20sm18083307pfm.145.2019.05.29.00.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:11:25 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HWMON compatibility layer for power supplies
Date:   Wed, 29 May 2019 00:11:10 -0700
Message-Id: <20190529071112.16849-1-andrew.smirnov@gmail.com>
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

Andrey Smirnov (2):
  power: supply: Add HWMON compatibility layer
  power: supply: ucs1002: Add HWMON interface

 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_hwmon.c | 329 ++++++++++++++++++++++
 drivers/power/supply/ucs1002_power.c      |   9 +-
 include/linux/power_supply.h              |  11 +
 5 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

-- 
2.21.0

