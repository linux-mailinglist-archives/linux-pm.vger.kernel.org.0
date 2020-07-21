Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E203A227F83
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgGUMBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgGUMBu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 08:01:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22457C061794;
        Tue, 21 Jul 2020 05:01:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m16so10165855pls.5;
        Tue, 21 Jul 2020 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPUEFyO6GrJbWlArnra90agIJPKyOH5916N0ngmcw1Q=;
        b=rJO2Y/1eWWCttoEkGBa785Q4kTRw4oId9KqBYRKb0XkkpuGqTbm4vrIrD9OkmbYgEn
         gGZbpBO7fR/UcxdqPGDLi/WXOqObcOZGSjpyDHQyeZ7AXB0oJQ0moD0bie96BXMSWn4N
         uXRCk5RM0uWU2hp/192q7Xry5iRi1rvuIatC/SdgprJ/7XNv6H7FRC3y6QA0ngcjY2lp
         RCTdvRBIiGR0r2Q1Aho/vMUYYAbdibIGo22IJP9FJojKZN8MCjea+QZSuA73q2JS667e
         TyIn33bdnaBX+ts00GM6R1GBy0b1BJtMNAPvwbxiWFb9BltYRReBDd7F3edlIKPBFMPJ
         ozRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPUEFyO6GrJbWlArnra90agIJPKyOH5916N0ngmcw1Q=;
        b=XPKNnV22hlTcH4fkS3My6OxytSeGOdd5GRowoCtuhb1W+9cFNjoxCaDXkLxDOGZ5zR
         uCMraYl0UsOuSgl/8sfJwnINTYTxrCuhPMgYZWt6jr0hljoaA3pNaveYRprtLN4T+ZFy
         VhA50FkXbQLlN+HHB0omjdSTi2uzXQ/HKrLXOVMyM/qK8HUQZ9NM6eSq3k+mLG3fIX2y
         54NEDTHtvWzUxk4XmWl+q3MPRUqaQR/iJiEVtIRSQcdzqgFB9dPvDZaXYzrQiWLdRET3
         yLkDIgwI9qjGEb7tkJTYC//TqSktpO2TFChi5Sw/owmgwdy1PAmEyKp5+tGDcRWbLde/
         oE1w==
X-Gm-Message-State: AOAM530dczh5so1HhtMrMb0jUsGafI3qv8OKkM34H3xL/Uo1jPqomhYJ
        Uw0uyMf4m8+9vJN8rJRk9+o=
X-Google-Smtp-Source: ABdhPJwmxxvTnazWoYbXLSzoevnmccP0ZHKZmDl/1gTNZqx6JdSaphm9/9R/Cm5whNHa0Am13Lu5vQ==
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr4683672pjb.191.1595332909282;
        Tue, 21 Jul 2020 05:01:49 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id t73sm20542041pfc.78.2020.07.21.05.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:01:48 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v7 0/4] add some power supply properties about wireless/wired charging
Date:   Tue, 21 Jul 2020 19:59:38 +0800
Message-Id: <cover.1595332392.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
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
 include/linux/power_supply.h                | 31 ++++++++
 3 files changed, 120 insertions(+)

-- 
2.27.0

