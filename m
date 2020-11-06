Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FD2A9428
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgKFKZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgKFKZr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:25:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C13C0613CF;
        Fri,  6 Nov 2020 02:25:46 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so889466pfn.12;
        Fri, 06 Nov 2020 02:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FLfHJOXQm1uej3hFUFpWXlA26tRNkCfwwdzbi5ScsSQ=;
        b=boAnYnnlhauGDB9+l9QIEa/OGeuCUKGw0IVSxJN9gJdIC6hpZjnMNyZCqrt7ZNMHQH
         JNLfY5fx2T/HPrDCz7hd+ifKm7zIUt7eLpf1GeGmHdQCmvp7eBQuMHrPlqoki1NVuCsu
         lT0WnCkWIf5pvZ9cMAKm5dfsThtHn3sU0jxdWx8Hvkfd02p8fPuDhZZIK3O5pw+Q4nig
         a6NqUtyUFW8iEL0JyBqyZzoVC/Eh8EpvDNTrbsCTv1yP5enjlX2tjuTndCnznUfvhuv+
         Uic8zjjG78/Bka3OyV1IXZxlKLcO6E9PDLXdOWJGPfdm2XnenJjENK5yOKW/lAK3Bjhd
         etSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FLfHJOXQm1uej3hFUFpWXlA26tRNkCfwwdzbi5ScsSQ=;
        b=ghrmwFxnRMhpG535Dp+/zat4DUUU2HdThflPW1aL9XxCzgb7YaJ62tQwDkmL33KS4T
         6GNjKZHui+uXQdjBoVqApUtFmHemHNe0SroyFXAIyCueqOfMh+LSoVFiSKaBC4qAISTH
         67YoeLCUeOgsAqmPykIFwJEM6R9Ny4oQUsgkdoay6KRxUdPRCHiDGzaoHVYYupfeXx8V
         r0bKuplKNX2UuMd4ffjc8EjID8wV5fxsoYmG8J3mIuqfIEixZwZAve6zTMu8/FSbkLLs
         WrITSvoi6eZSnnOUyEb7SgBvSQ/NtiZWunPt+QJGgp6jWpJnyCNmTVnTA1qERIHjaabD
         VGAA==
X-Gm-Message-State: AOAM531RC/2GYLrafbPXoIN7fgeze0+NB6p71MUSoBlW8h/ppzi5aImM
        n5tcz5OcWuItikYpC5+6sIE=
X-Google-Smtp-Source: ABdhPJyLnNz9MpjtBAmV2AxZf7EJzZAtleTlmjqsR3z/9TVuGk5DSmdR9uWoBTFar7lvtqlLVgMuNQ==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id s7-20020aa782870000b0290142250139ecmr1228237pfm.59.1604658345723;
        Fri, 06 Nov 2020 02:25:45 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.25.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:25:45 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 0/11] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Fri,  6 Nov 2020 17:53:41 +0800
Message-Id: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
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
 b/drivers/mfd/mt6360-core.c |  555 +++++++++++++++++++++++++++++---------------
 include/linux/mfd/mt6360.h  |  240 -------------------
 3 files changed, 377 insertions(+), 419 deletions(-)

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

