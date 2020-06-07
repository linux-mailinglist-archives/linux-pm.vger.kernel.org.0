Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210E1F0E63
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgFGS6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgFGS6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:58:02 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4CFC061A0E;
        Sun,  7 Jun 2020 11:58:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x18so1289272lji.1;
        Sun, 07 Jun 2020 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DU8gMkYFBfK9hw25Nj54hMRcSzVpbsQ+pPiJfYX2eco=;
        b=afosJJ+iztw7ZgiF5QU6AGJvvn+gSSgWHwQZfPP7ZeRzwMQscRGGPybu19wh+Do9O8
         OgDW9Rbwjavz1ZXXrXw1ZMO26kxYS+arn0Jzm3H2Kll7MzLRX714DwbT92h6uJkqH//Q
         SPvoElbSNjttu7uHYp6jvoGRdeni12WU31bVQhXwgJdfcygvWYjJQMAjnLVgKsB6RTXP
         VqOn6zPXj431CceX5Zv5LZN6MggTKAoz5CyvOiNXmNeeJn/meiLKG1Y2XFnvfnyHvNN/
         fmWCdUdlJ20HxwiU4psTgDDBinXHLD69nnoa41CGGqrG67td+btFZeConFC9aGxy1t2W
         rdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DU8gMkYFBfK9hw25Nj54hMRcSzVpbsQ+pPiJfYX2eco=;
        b=g5toD4LJWyb/U5pxGqTaojK6KW/UKAhQY7RGh86F64XpAzRakXoNuIqinmszWzacGS
         kR8AqD3yZrFEOSq1bXuh9UQHi1FfKbeGVCy5levKpxY0vdUGd87SYUh9M3BdUMGImDY1
         UCp2y0N30OUoI2JqOV408i4oRBEezpgGsBruAfRQ/f5oSDputjfWikLLqiVneoW6jyre
         vuKYSdjlWsSO304HVgR9G9HC4BCX922DdM7DxWReU/JOXme+Tj0HuGX6pP0zFFgjhVDW
         mCn2OyW4qKJlGCSUePem+j8qeVShv0MhVvPLcQiftCuCrxdvQnglj96qEyZlalUAk4Zc
         xrQg==
X-Gm-Message-State: AOAM531jStx5iB7bS1vri7YcQDyPTELe8pJJSvAliFWZudYpvxA9gdX9
        Mn3JhLx6YoqV8iIn3cF51oI=
X-Google-Smtp-Source: ABdhPJzVs2qIvHg3P4vb8mwyErgjBalaGQTGNXA8jyoxrDPJV03MrWqalkX3wx/tfMmcqfcWnQ0WPQ==
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr9785491ljj.149.1591556280653;
        Sun, 07 Jun 2020 11:58:00 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:58:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 38/39] ARM: tegra: Enable interconnect API in tegra_defconfig
Date:   Sun,  7 Jun 2020 21:55:29 +0300
Message-Id: <20200607185530.18113-39-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra now has interconnect providers that are used for memory bandwidth
allocation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index aa94369bdd0f..0029259a6bf5 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -268,6 +268,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_INTERCONNECT=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.26.0

