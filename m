Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3F227F35
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGULp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgGULp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 07:45:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80479C061794;
        Tue, 21 Jul 2020 04:45:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so10591098pfu.8;
        Tue, 21 Jul 2020 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1sUu7IRkmKxX3OgEjjqPHVwVLT2AAnTvOPxWUsKTqw=;
        b=p8kM4ZEM921Rnx31tg42y4gUgRIi8DEiGh63WwfBAvBEANt4B0hSXXbr36naNeLLy7
         f8OxBDKpjtHsltH7llwMynl0WrSt/Z4jSa17m8ILL64tnTuyVc4GgDLPp7yCE2Pqckbm
         xi+7kNfgrRFZxF1KBr8NL7NdQ6LaL7bD6fTasjweasf19+7B+4aNZ+9iL9NAJuX9TU7H
         fiMYNDXF7lgaKpke1wTvS2tCk01Bn8YXNE+SRO3l1x1at4RZeO+lgRIb3/BQrnf504db
         3vklBe3GciolaNzf33CJbBot3sUf68pML8vZ8vZGmPPGdXgN0FIKjDxn8tzRACmSQblG
         9wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y1sUu7IRkmKxX3OgEjjqPHVwVLT2AAnTvOPxWUsKTqw=;
        b=S0ZJchY8H5NZjahjjP/eJ7WxRnysrbToTGHE8w6QuBTBMrR2lo2QRHXizADF8DwMD8
         6TGkmOQz7QF628jl1u/jz8h6KNqzBiZ9lMEtLa7pnbrsMgxxXVZzgEeRAA3gQx+NQOvn
         bOIjXgQPQzBuCTlvVbEZBeVhMxKmjlUS+bCCsDGUc0lpnYgBVlfW2RQclfmy1QKyPD+O
         J3wuxdlpNbztO+1TmF+MiB7EEedatWLzTFWP4tRad57L6NDEcTU7kAX1G43Z8jAso8uD
         6c3yXnCEvrBEk3/BRjzheTUBKzU1WGnfwFfZS4bFhDuRx30dQOUat8OE0poNXrQC2+Nk
         iGIQ==
X-Gm-Message-State: AOAM530QE4OVkkj3LZ6ELiHDupMLmaGx97hj8aWoouVu34Y4ndQzjLys
        TSkuUxGDwv1keMZNs5qa2IA=
X-Google-Smtp-Source: ABdhPJyqcuvHliiKiP5huvYK7V4CHNGgIwSfV8Uvy+9NY2jKwNZ6oZ+YCKezwhQDaTKxh/y5jSPh9g==
X-Received: by 2002:a65:5201:: with SMTP id o1mr7897382pgp.404.1595331955911;
        Tue, 21 Jul 2020 04:45:55 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id y24sm21233376pfp.217.2020.07.21.04.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:45:54 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v6 0/4] add some power supply properties about wireless/wired charging
Date:   Tue, 21 Jul 2020 19:43:49 +0800
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

