Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557EF2B02CD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKLKkG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 05:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLKkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 05:40:06 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF1C0613D1;
        Thu, 12 Nov 2020 02:40:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id g11so2554657pll.13;
        Thu, 12 Nov 2020 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A1kCd9kxhtGVEoKnBufAkxHSe9byym5wk2cdTksfgzQ=;
        b=L/lRn3vST0A4TsCZYBx4L94+MANXkREvNi7cTkcKw8nwivywBn0AEUBpwGya/5ADOT
         PgiTCFJDdr0KiuFAKuGMQIeHXRMf+g8LIvaO/IyEvlPjDJr9TTbzJvBOu9lw6st/W+LO
         qZlbIvOl8+EbPlXcrIeF2iZZm4jc+ElNufRAX/H1Pf6MQOO9YS59RQyimPoGkvL815Kp
         J7hbXrbfcqsPfR94DVUUo+glMvdnygKyxx4wSNktxs4fmTU7jxo/McAT8jiK9Pid+S1l
         sCvam8jL8FWqcvTHzuFTGidZ/55u2VdTEtWtoT0PkCLWWcQb/fVdl0+OmeQ2nE6Dhg4r
         kM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A1kCd9kxhtGVEoKnBufAkxHSe9byym5wk2cdTksfgzQ=;
        b=UoVPgoGZw96ZZJKXSY+9plLZ2/Vub22RmGq7pF4SlcwixfE0H+BoLKsotqFcQ5gIBT
         5d+DVR3ReKPnm5Bs76hRDyE7qQF0fuJ5KUWWJrEAoCdah1TMa2Qp7lbGhYxaGZLvdMOj
         EEsrZxueXKMSfVPOflAubw7hJfKzXYv+GM2QvK7TQY60BgL/RFPYV35riIr5FBGuSbAg
         uRwAgQYv8fYNVqnoMjOyxyKTT7gdnmJjOT2v4jNHwQsh/GhNHSueogH6v1TagsoYavJo
         Bchs037BFMnuEAcI4gfNoDVk0OVke0UzI0haZFy38J5Rc1s1qc1pw05+pQE9JhG20Hqe
         cAag==
X-Gm-Message-State: AOAM530ULP0i2Xw9sZarH70nMow+N6g6nwJpgOTEuf6Ch28zQtAUqNac
        GElYlFOhBSbldIGX8fUpNlrAYKD+46o=
X-Google-Smtp-Source: ABdhPJznNX8YVTi2I1uQjTgJCiLAWfcJFHeM4bA36FXxplxx7vsm7XgOnX7IIfTnOOeMxg+0bP7zCQ==
X-Received: by 2002:a17:902:eaca:b029:d6:807e:95b8 with SMTP id p10-20020a170902eacab02900d6807e95b8mr23007860pld.33.1605177605556;
        Thu, 12 Nov 2020 02:40:05 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:47a:a27:cf8e:7817:51df:a883])
        by smtp.gmail.com with ESMTPSA id mp16sm6414094pjb.13.2020.11.12.02.40.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:40:05 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v7 0/11] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Thu, 12 Nov 2020 18:39:47 +0800
Message-Id: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series merge different sub-device I2C read/write into one Regmap and
fix coding style for well-organized.

Gene Chen (11)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge header file into driver and remove unuse register define
  mfd: mt6360: Merge different sub-devices I2C read/write
  mfd: mt6360: Remove MT6360 regulator of_compatible

 b/drivers/mfd/Kconfig       |    1 
 b/drivers/mfd/mt6360-core.c |  554 +++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h  |  240 -------------------
 3 files changed, 376 insertions(+), 419 deletions(-)

changelogs between v2 & v3
- Replace mt6360_data to mt6360_ddata
- Split I2C read/write to regmap driver

changelogs between v3 & v4
- Merge back mt6360 regmap driver to MFD driver

changelogs between v4 & v5
- use devm_regmap_init
- define crc calculation magic number

changelogs between v5 & v6
- Remove unrelated change
- Remove regulator device of_compatible

changelogs between v6 & v7
- Replace OF_MFD_CELL by MFD_CELL_RES

