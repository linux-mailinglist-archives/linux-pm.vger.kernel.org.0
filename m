Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733641F0E3E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFGS5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgFGS5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843BC061A0E;
        Sun,  7 Jun 2020 11:57:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so8854925lfd.7;
        Sun, 07 Jun 2020 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzjWXOFJZUWh4EJTzInOXHHEbdt+siqMf/YejHURVDA=;
        b=hLlbN5QYcF1A4KVzUxLK2BgoLYJMQG7Blmal4anzav1J2m26hk7H82gnkxk1js+Xni
         98o3OoyeT6oRqwdE1zr32OawoCqKpjc0jEO8PsYmabIVg12Ibet0bVUN3sN/vwbnCrLh
         s4gc82tZaSsdcozgTpT/gq7Gpb8/boqO1YTkDdaOX/rfFvSVEawK+e59GLxWCMffkz5G
         cIO/Z+0Hsn7hbZyeYMXaZ6cjmS+cq94dp4GV5yyAzHOdbtr8oxcaVg5uhiFCQjAKFC+C
         RCcxjNrZqBI4lXtlSxVPBJiZHnKQhQsZPkk39djKWeUjs/CVYbhnbdKxcdm/0/I6UyFI
         CbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzjWXOFJZUWh4EJTzInOXHHEbdt+siqMf/YejHURVDA=;
        b=t0d1lxHwwa2s1XzxohBoRB8zlQ2f48DhGbFsuz3+wpCx6x7YeN/u4KcDRpm7zov0W1
         cSZee6P+DF9ly+PhBcDulP+XkXiL+DlYcKEZuBeyooRh0k29tt9NCtAzj3cLC0S0b9Dk
         uvIEG22H+1bQXjTWshWWPgjUdS2arGlGQpXM3MOi6bRS97KTyYATbepDuOJ61c/+VeX+
         IO++Q3o+RPCDd4gQ5xVOlPPhYO8Qh1DqIMFyRpL/mz4/V1Am1cpZmDfaw1tZpp7zJIEL
         OcMR1JXKY6+T/JHKEa97HXmmbQjWDoW86hRNjTIBEx1b6MYX1fz6Lcs/zBKnLR8//9/I
         BuPg==
X-Gm-Message-State: AOAM5338vTTuyD1+DaALVnb8u1eY3FVedbFjLRcvKsuP8QbKL7CMvASv
        CW2jUYXBweiGVKgRLKtC5dI=
X-Google-Smtp-Source: ABdhPJz95THuT13m/xyIJeJooBD8AxA5DNApvVZa6hnrfOxX9B/baYyCOZvQxeb4UPEHYfdsisVEcw==
X-Received: by 2002:ac2:5324:: with SMTP id f4mr10821248lfh.209.1591556240161;
        Sun, 07 Jun 2020 11:57:20 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:19 -0700 (PDT)
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
Subject: [PATCH v3 08/39] soc/tegra: fuse: Export tegra_read_ram_code()
Date:   Sun,  7 Jun 2020 21:54:59 +0300
Message-Id: <20200607185530.18113-9-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra_read_ram_code() is used by EMC drivers and we're going to make
these driver modular, hence this function needs to be exported.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 3cdd69d1bd4d..b3c930b805c5 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -65,6 +66,7 @@ u32 tegra_read_ram_code(void)
 
 	return straps >> PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
-- 
2.26.0

