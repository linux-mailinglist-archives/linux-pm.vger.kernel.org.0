Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4251225732
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGTFtZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTFtZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:49:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F54DC0619D2;
        Sun, 19 Jul 2020 22:49:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 207so8505487pfu.3;
        Sun, 19 Jul 2020 22:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7LmlwjhyROxGu+ou1P/4GlA52VraI1gAuhKVajVWMw=;
        b=HHezWH7s44GjRZbiyvcinfZIpq2gDyPgY/X/U0OTsDyL7WGdonMs71Xt6Tcws68NLe
         YrLyUTxu2mlN6Veq/QmPMUUUdBXtGag91IFNgO+1cuKgfExnB5vT8+g2PxeG6K75LJWs
         VRryt1BTVsH5nETAaE6kl07Fv4cyIUaa8YHr7B/u2AiSsKCwfklJOncosV0oR5r3dUBH
         yD2yXyEwJTpUQ5djX3UE7jMpv1y5CDC/MbySjSfSgZIFamHn1Sf2jVCZ2S/v3ZQ9vHfO
         j4SiUKZVvEhNaKGs2wqNYem1u/expzMx73MhwP2+Sa3yJ6G2SDzt1SPDMw0CuVBlpF1u
         EKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7LmlwjhyROxGu+ou1P/4GlA52VraI1gAuhKVajVWMw=;
        b=WG3+UHBQRyyJc16XQsGMWkmuEpkN+Hc7HztDhug3VQ2adzBZLi/wtWTBA0Gy2TcxoD
         4b0DyRQ41AbBvItPmEgGgMzm6F1Lntf2RvIeVnyu0UoPzkGRP7xiKKxyyX6gxmU88uKx
         QnWYzocgjs535f9xLjTbJv+f9oB+CCaE90si7XRoBhGJHzgX8XtyZxj664ejIStwi89J
         8vVDxvYNUhFDCpSMENTQauBWKoBI1iLpv41dq9m2wa+Pf9Wn9kBELyqovT9BSrVX3r6v
         N41nJfnDQKTTfiVuGivVb1f9zRakwwAMFtFG5BQlfrmMiydNUHy5e3IQPHp0G+jwf/0M
         c0FA==
X-Gm-Message-State: AOAM530mHs4ly4mypbpdz8gX68Sokftg82KTI1hGlQHcH2WpUV+2rgSw
        BzKs9TaS9Qtvjl4fwvesgYFPRmCT5deAeQ==
X-Google-Smtp-Source: ABdhPJxi960BymfHLyIWfBVjQA9Thw7VCOgyY8wgl3sbvRUvyXljiGpZ/Fi6P0vbzfe3vzqW+Fo9iw==
X-Received: by 2002:a62:31c7:: with SMTP id x190mr18825075pfx.100.1595224164759;
        Sun, 19 Jul 2020 22:49:24 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id i7sm13627833pgh.58.2020.07.19.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 22:49:24 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v4 0/4] add some power supply properties about wireless/wired charging
Date:   Mon, 20 Jul 2020 13:47:13 +0800
Message-Id: <cover.1595214246.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

quick_charge_type reports quick charge type based on charging power.
tx_adapter shows wireless charging adapter type.
signal_strength shows degree of coupling between tx and rx when wireless charging.
reverse_chg_mode supply interface to enable/disable wireless reverse charging.

Qiwu Huang (4):
  power: supply: core: add quick charge type property
  power: supply: core: add wireless charger adapter type property
  power: supply: core: add wireless signal strength property
  power: supply: core: property to control reverse charge

 Documentation/ABI/testing/sysfs-class-power | 71 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  4 ++
 include/linux/power_supply.h                | 31 +++++++++
 3 files changed, 106 insertions(+)

-- 
2.27.0

