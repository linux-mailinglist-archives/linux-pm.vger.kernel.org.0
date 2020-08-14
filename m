Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C82443F4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNDtL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 23:49:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737BC061757;
        Thu, 13 Aug 2020 20:49:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 128so3890582pgd.5;
        Thu, 13 Aug 2020 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UcRAYSeL0jNLaTeq0ZQKJeIrLT699AYEwZvDI49xCA=;
        b=OhD6d46fPfM9Goj3SPsorYzgqDl0C+lUpvcVL1VG2De1YMMBmD9YEDJ9HCbz9HlEBU
         RlmqFSgR271m7nHASmFtl21WZQ2vHwHPHQdHhvzW4b+j7kY6cnOI4n6e18oB09pMDsPy
         Is/pAP7ySe/D2xB0AI+rhTOzL+hUokKasIpn9izaASneqAfS4vyoy49RnvjPcqCe+JQg
         xmavOG11SOpbGFInH2DzgbG/fg7ARK+iuevR3aqJ7qE7qEPwzKwpUeDy/K46TESVqiPV
         LpV1NKV3w5t0rDLdzCQBGFhHAb32Flv6Ze5MQLf4/D5jyUPDyb9zykAXV6oNo56HxVwG
         FSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UcRAYSeL0jNLaTeq0ZQKJeIrLT699AYEwZvDI49xCA=;
        b=DglMs8raVpkFghPtllVbNAH3y/w4a2Y8OipQk4TZhseUbD4qK8XUh8qTE5x/aMi4sf
         uID6Lc7iTzIp6YuDg9GRK84Ad6DhmFu+8trgadwo7gNbgGLDRnFOtTSscUrg2d1DBV+Z
         SYBwUNBduwTJWYLd3JqqsPO/tK378iNPfVfvV0eDX4sod95P5F14H0hrYjACaXLS4bw+
         alB4Gye3553o20kX3DIZuAAtt7n6ddyobuGOu9FQawLdaiYN4d6GV2syCNSEdpxS+FLp
         rO+tb9pS7KBtT4PAm5/OFSfvqRpYkE8+dP0TeNijPSCF+ylNPoMxcmM4KYoLXO8GmT4/
         aQfw==
X-Gm-Message-State: AOAM533mrvwk3B2U9T4jShZ+f9r4fI1KHGfw3o6smE2Ao+JNEP/XTegM
        LuivshR6Gml4YoBcM+buHB8=
X-Google-Smtp-Source: ABdhPJzrz6NU42ssElkxLSxke9H82VkiapwJnWdOQ/IvpJ1ceWs0zlOEsMsuGcPd6PR+JRf6qRT55A==
X-Received: by 2002:a63:1814:: with SMTP id y20mr502992pgl.45.1597376949644;
        Thu, 13 Aug 2020 20:49:09 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id n26sm7253385pff.30.2020.08.13.20.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:49:08 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v8 0/4] add some power supply properties about wireless/wired charging
Date:   Fri, 14 Aug 2020 11:46:53 +0800
Message-Id: <cover.1597376585.git.huangqiwu@xiaomi.com>
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
 drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++
 include/linux/power_supply.h                | 35 +++++++++
 4 files changed, 175 insertions(+)

-- 
2.28.0

