Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839A022C509
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXMWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMWB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 08:22:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41848C0619D3;
        Fri, 24 Jul 2020 05:22:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so4342191plx.6;
        Fri, 24 Jul 2020 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KA0BJosXtAeexsqs49sZ0prG2OIgAF6XF0D2f4gkqFU=;
        b=J1EcZzV0C+msUn7U8aZ/vDkyHLQ/z2gd7IsBhlVoZd/lt9zm5huOKz5zXNGr/vKzR/
         55UNPVp6tCX82rPnG99I2omBXcG9bzDIoGS5JtznaDfQJjsLGVa1ga5CFlzVLlHnbiQL
         BhRFUpi1V4Zht3/TrZgo42F/DJYMfaJpOkwD86ASZAxjAtoxjmXraJQnrGFlWcS1uZnL
         yQoBxHQXQ6DyuEpTioOClFDIOec+F3SNesA5ovmZ5DENmD3e1OYuNx/s+PjtVewLTUGB
         MR+dy+KeDsP6NR7dwyn3wh3URXnDvwZva3p1nc0xAnuC5GcIzYAmgHSxOjxUCMdZZgwo
         zYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KA0BJosXtAeexsqs49sZ0prG2OIgAF6XF0D2f4gkqFU=;
        b=cU0dz+ooyrjZRCQOL6chn4z6Hk58w1t2TsKDpjwT2Y7A+jczPkI6WwWwfqm7keKcj3
         mk7PP5obApcjnbFB7aAXzGZokrvxuECcXLSaBjFoismZA6AjJY/MwnrekpFnNWpgJdPB
         8LH87E+0E4jWFD60bOnbTZg3wTk7yiTQPxlCbCBQj+VrzbKsi3LT8HAZ+SDJuDd61OfP
         fOuK4ElfpfFOrLbKsDxIWwnLo9NbfcDP8exczjy68Pq2W8rILKA8IIKW9H2Y4lOqkhpJ
         FAgxvL5uIL2mgfMXrDhFs3gT/syRTmc/IDB7+jiVwXic5tyDuxjdt75hfys6xaOGAKoR
         +Hsw==
X-Gm-Message-State: AOAM530HOrNFnvo8dHbvTkA09Vl/k08Bltndb5XqPcslsXc+o/Oz9sQU
        DssxBgYGy/U++tUKZyycG+Rp/3VV
X-Google-Smtp-Source: ABdhPJxUQ45LCtJslTm+NOisZz+gCAiln04+CMq+Obeg3jVJ1DXTS/GQ9HfUdWP3xnIAm26yKGmnpw==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr4782829pjb.21.1595593320770;
        Fri, 24 Jul 2020 05:22:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r185sm5766819pfr.8.2020.07.24.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:21:59 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen Yongzhi <yongzhi.chen@unisoc.com>
Subject: [PATCH v2 0/2] fix an overflow error on sc27xx power supply
Date:   Fri, 24 Jul 2020 20:21:46 +0800
Message-Id: <20200724122148.26541-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The patch 2/2 fixes an overflow error by changing to 64-bit divide operations.
In order to avoid compile error on 32-bit architectures, this patchset
also introduced a new 64-bit helper in patch 1/2.

Changes since v1: (https://lkml.org/lkml/2020/7/17/63)
- Added new help macro DIV_S64_ROUND_CLOSEST;
- Fixed an error reported by kernel test robot <lkp@intel.com>.

Chunyan Zhang (2):
  math64: New DIV_S64_ROUND_CLOSEST helper
  power: supply: sc27xx: prevent adc * 1000 from overflow

 drivers/power/supply/sc27xx_fuel_gauge.c |  9 +++++----
 include/linux/math64.h                   | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.20.1

