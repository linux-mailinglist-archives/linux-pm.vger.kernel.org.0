Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7F227E91
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgGULRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGULRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:17:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0EDC061794;
        Tue, 21 Jul 2020 04:17:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so11797230pgk.4;
        Tue, 21 Jul 2020 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1sUu7IRkmKxX3OgEjjqPHVwVLT2AAnTvOPxWUsKTqw=;
        b=U/yo2P4MMX3QLNOeAoYV+mfCmXz++pGqXLjZrX8UYkOInAOX9Hf9YVSBk9fD8tIiPG
         PInnW+rlK79jCQb08dWUa7Bw9TS6ZrlvTK9p5007bPWAypwZi80j0BycYFBxLQ4ISYYv
         007pGBj7yyHW2n+GlbuEuYf5b2py97hIW3cPZxqeAp05DQ3QtHv12n/TJt4lHMSutR8a
         HwMWB+OJOdUiF8gDmIcJ+1E+1M4342L/2CGiqc63m4rdS09k0VnQT7P0iK/Jjd81q9Bo
         eOoXqCPxRREZBQpow8rzhSh9XyDljARP13Q3djLvt5PQgdMR9VJ7RKSilkP4b1DWjrbT
         wbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1sUu7IRkmKxX3OgEjjqPHVwVLT2AAnTvOPxWUsKTqw=;
        b=PqJKZPJeYGLkC4FOJQhNUML8SPji8TQ6Ric8H4/1ZoYdmTmUIAdEFtWN0JAZ38fmka
         3KnDyhWwQdB3s5U1Zrpv7L4Rey9Hv77yTISemBbnNi6Z+HiEGYHY7L7VQcNesdkDKPzB
         jbrODF7kCgHmaqIjzagVUvCkxibZHYW6Jjyi1LUW51c9d47Se9MOM+3vvKeYyzgeshmc
         DYl3CiqSDu+3r7WQtNbdqdLQYS5ZFDXq6Nswbmt5w6HV6fF3TRe45u0nP2ZTF1eo0qfV
         ErPv8j46NfV3xKSZuz0WrQQN42bC/W5vW7mHF3uahHt7xPElZBV4F7go6SZHLNSU3iL9
         m3zA==
X-Gm-Message-State: AOAM532NwErd6OMPlvuwC3GWVQGrcnLxGZ2gut+czLLlV596ZJECwQjs
        2FOlFrjpqZ0mr/S6IUhaIHypBdFQhCadjg==
X-Google-Smtp-Source: ABdhPJwyZfXrpfnLamuLLAu4Zuy/FyjGG3kCi0olnVdM4M4e6E3RwysvJTMLGniwr3QZh1LS7nlR/g==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr23129574pfa.119.1595330266390;
        Tue, 21 Jul 2020 04:17:46 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id f72sm19829566pfa.66.2020.07.21.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:17:45 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v5 0/4] add some power supply properties about wireless/wired charging
Date:   Tue, 21 Jul 2020 19:15:35 +0800
Message-Id: <cover.1595329640.git.huangqiwu@xiaomi.com>
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

