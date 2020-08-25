Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCA251230
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgHYGkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgHYGkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:40:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06EDC061574;
        Mon, 24 Aug 2020 23:40:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t185so3424492pfd.13;
        Mon, 24 Aug 2020 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzcoYMUuE0A3TyBtVxNIYJ1tmV5P8vpyiIgbPolenCM=;
        b=bA++QO0UQlAMoT3SsiJxUdWW2i28AXLem7rUv4pv2adRX2xDNx0KqR89VroXjfwiLk
         Pl4gKykpKsrft/6aaBPJy0/0w/N/6LNovK5W+h8SfAIFzOTD2DtkYnk9cW1aWQRIUpWQ
         zi5n0hVP5Vv81jIj9Mw6417S4q08R1cf3XDCopu7AmE+VuKtrueb8bnm0JnNhdIfM/z6
         5XEBttJ/Ubd39fBntASAcMgurmcBhZixV1J9RmYNhzRBgo3Y9nyYfxVAN47U/mjzGIqj
         uSlwe+1RiVv/YgfpzFYOG9HHirsGECS3XhM1Pv5RBiV3ZJ5MvCIaxmr63HKakv2G+p/q
         bFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wzcoYMUuE0A3TyBtVxNIYJ1tmV5P8vpyiIgbPolenCM=;
        b=D8X0UKRAkgQBUqP/4jagyqzdnLKw3Px4uxeS6IbL/SU7V8SmCW/nmlD+J8sV4luFFC
         Z2PoVv3UEGTy3xoFm3uCHg+2uJFA41N8oqhjCNxXuMZQHp1D4CrmQJ/MUdWQBQJYQXdV
         5UErVP2T0PrOLHrhWmn88d527Hk8SFzWapqRFZl/3QiIZ1PDymucBSmJjR+pT00C0qAl
         Jb7zaCG/HWbJdfylL3NwVsGXVffFmS1tEM22FBij+8Q3YL78116NRPe9vsSqENcZIDpa
         V8BT/G6Tl7cHpuYZV6sovQR4xaUs439SSE2mcv2ikfo1g0yuPLwIU4w03nN50NR4xJ+0
         ybsg==
X-Gm-Message-State: AOAM531a0E4gWVG+VovbxTXoHyF4mxz8y5u+qU+pLK4fum/JQQQLIUm9
        PdCAUyQWa48X0AM1Vzmlydc=
X-Google-Smtp-Source: ABdhPJxzCULDyfMyChJMZHrJj8XbQjHcrWOWolLXFz1A42X1Sb9XPK+USDiHGBcLs5a3QXZKu8fIWg==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr6614461plp.67.1598337607174;
        Mon, 24 Aug 2020 23:40:07 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z2sm14197283pfq.46.2020.08.24.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:40:06 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v9 0/4]  add some power supply properties about wireless/wired charging
Date:   Tue, 25 Aug 2020 14:37:55 +0800
Message-Id: <cover.1598337073.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

This patchset aims to provide power supply properties about wireless/wired charging.
"quick_charge_type" reports different types of quick charge based on the charging power;
"tx_adapter" shows" the type of wireless charging adapter;
"signal_strength" shows the coupling level between TX and RX;
"reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.

Changes in v9
 - Set bat_imax When get quick charger type

Changes in v8
 - Add quick charge type driver in qcom_smbb suggested by GregKH

Changes in v7
 - Fix PATCH version error in 0/X email

Changes in v6
 - Replace "phones" with "devices" suggested by GregKH
 - Add permission statement for "reverse_chg_mode"
 - Update description for "reverse_chg_mode" in ABI suggested by GregKH
 - Update description for "PING phase" in ABI suggested by GregKH

Changes in v5
 - Add details in 0/X email

Changes in v4
 - Exclude the patch of "power: supply: supply battery soc with decimal form"
 - Fix some typo

Changes in v3
 - Add enumederated for quick charge type
 - Add enumederated for tx adapter type
 - Update the return type and description in ABI

Changes in v2
 - modify to capital letters for "power_supply_attrs"
 - Update the return type and description in ABI

Qiwu Huang (4):
  power: supply: core: add quick charge type property
  power: supply: core: add wireless charger adapter type property
  power: supply: core: add wireless signal strength property
  power: supply: core: property to control reverse charge

 Documentation/ABI/testing/sysfs-class-power | 85 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  4 +
 drivers/power/supply/qcom_smbb.c            | 79 +++++++++++++++++++
 include/linux/power_supply.h                | 35 +++++++++
 4 files changed, 203 insertions(+)

-- 
2.28.0

