Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F33B4AB4
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jun 2021 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYWug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYWuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 18:50:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214FAC061574;
        Fri, 25 Jun 2021 15:48:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so15560127eds.1;
        Fri, 25 Jun 2021 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwvHh55LcSYnXzmmGuQCH1MSG36L8iCah28pi91QZyE=;
        b=FJHKZ/Abwa6ukbLeMQeNKroNgDPdPBIcURidXDyRCQoEoxRGVebx4/13mw+kkGKaFo
         1UeXom62Vsb51xnsP123yZONrQbxKW71JyQ1s3uYS+N1N+iVmtECmTgF0Uv8nqO9V27Z
         3pjTkwp8k5ZqVBx02CHSAUlehshRO1oQyozNDmMRCjJIbAwC85eP+1NXavkvNPNojWqj
         zT3rF0cpnutggsicdDoz+b6nqBkJ9bxTXM5YYJ7iLHhLUpBbdSQjncKVlccYefkAK3tI
         0cjdwWSRBU4uMWfZdXJcqbrAVwJpeVxAnWcP7AHT3GLQ64CVAZ3BRvdYFkgpwDgRWCSH
         Tysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GwvHh55LcSYnXzmmGuQCH1MSG36L8iCah28pi91QZyE=;
        b=GhrfCcmucCFwRmQLpR1br7fp+KebwnkZU3X8i2f6Filunupejk2/W7TWm1/pogEDqT
         6bkEKCY0DE6NINHNQuR4843Ygak8RCh1Sw7K+SuzcuO64eT68VL4dP8FV+ORYFdMy0dw
         L4KOebOSuoup69E9M9UuL4wUVLcl2zoGRTws1vohr+ro/idMOtkD7IbZX3ra4/HyaSiP
         BqNOeo3qkjNIVczEXsI7ZX1GDb0TDfFJJTvh4bVtIm17S4StC3vu8b/pX/qlvzSa5+ok
         63/qU6lSCZ+E1lQx6tRGTjHpDHqL1vKS8IE39ajDCDM4s75dN0muoS2eCcnocOn6XHRN
         RWAQ==
X-Gm-Message-State: AOAM5318RKHPl+eWcM6q4iXuG6BX9AWiG9xpSJoMCwvTQMcpm9JW8rF/
        tok1ZmanXH9SOgQRmfitoSU=
X-Google-Smtp-Source: ABdhPJy+T78o4HjFa2vn6tfrdxhsAcbPhpemEzM0Ex0MiUE7jhOjAc3gvDtwoyuMq/cn9PmdUyd/kQ==
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr17660625edv.315.1624661290121;
        Fri, 25 Jun 2021 15:48:10 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id w1sm4719399edr.62.2021.06.25.15.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:48:09 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] BeagleV Starlight reset support
Date:   Sat, 26 Jun 2021 00:47:41 +0200
Message-Id: <20210625224744.1020108-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds reset support to the BeagleV Starlight board[1], and
converts the TPS65086 PMIC device tree binding to YAML while at it.

Support for the StarFive JH7100 RISC-V SoC on there is not yet
upstreamed, but early feedback on this part would be very welcome.

[1] https://github.com/beagleboard/beaglev-starlight

Emil Renner Berthing (3):
  dt-bindings: mfd: convert tps65086.txt to YAML
  mfd: tps65086: Make interrupt line optional
  power: reset: Add TPS65086 restart driver

 .../devicetree/bindings/mfd/ti,tps65086.yaml  | 124 ++++++++++++++++++
 .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
 drivers/mfd/tps65086.c                        |  22 ++--
 drivers/power/reset/Kconfig                   |   6 +
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/tps65086-restart.c        |  99 ++++++++++++++
 6 files changed, 242 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
 create mode 100644 drivers/power/reset/tps65086-restart.c

-- 
2.32.0

