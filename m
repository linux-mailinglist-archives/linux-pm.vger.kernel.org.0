Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2C265F97
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIKMdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgIKMcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 08:32:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E67C061756;
        Fri, 11 Sep 2020 05:32:11 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u126so10775028iod.12;
        Fri, 11 Sep 2020 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sb49eUm0XrlnNsnZsPLqQ9U00n3jcPCCGAV2VtAgHI=;
        b=lc6n1Kaa/wF17ufcjPO/ngCuQ9lEKwpFewkLAgOal4k3oEFKEtZXMsHExvbErNgW4Y
         /1yhBN0xNaa+MvorWG4lj5SgsR6MdfF97Xtp1GEdGm9fV4Awomp/ru6KijDP0c4hG/Wo
         1LLBcfx1S56swAtpr2fddq3hE/WBos01siWq1ERI6zlYru2wPoqsvsuG55A7aqM5kxWG
         3GnBfYI+/97INTUmjaNNR03oi7Abq+XsngKHVdNdDWJEBj0tBn2BjHxQ8Zr/mvsAW9Sa
         Bk9J6QJro6g5qnkb7vr8feWI4WjANL81MGy1wd9ibe/CjgF4nOzi4Me+SuBVq9DABK82
         exbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sb49eUm0XrlnNsnZsPLqQ9U00n3jcPCCGAV2VtAgHI=;
        b=F9mxqBCuOxVbWsqvp2+RBj8WyhYlUl8/5pmH9dvdS2/mInoyZ+wPt4lnG1kMquHbDn
         YsqPPeo4Xg324CmsR7tl8+PRS7ZLM7U5l+rcPDFtdnR0Yp7Nl+neA3zc81REp7RToq1w
         eq9OSOnfEd3B5mD/H54/jpSNxzA5+3EpKRt8TvCE3Y/M/1GF7gJmtfb5kV1c025WtoaO
         EXhZLbKgm499y/eYBRU3cK5CQ7W4WajBfPQvybn26ZSXYlgBKn6Hjj/zn2weopv1Aar9
         xai01IBMZsvXx5qDT2w7aQ7117VugeWxacPPBINlt2GZ+Z5sCQKT+UllAGCdsCaLT+4f
         MANw==
X-Gm-Message-State: AOAM531DtqYIYHC0btvDQ/X8vIDiuss5RsT1pIoj+XOlx7n1UhpSs2hT
        4C+K/IyOqEWKUHevEWeANhQvS4/l6j4=
X-Google-Smtp-Source: ABdhPJzHNqR+nZ6mQlao/3kciscoqAvYhSU0szgSBUbX1aqkqbfkR1HY4Kh8e/C90MsLYuX+4vS2Jg==
X-Received: by 2002:a6b:9305:: with SMTP id v5mr1503265iod.201.1599827530934;
        Fri, 11 Sep 2020 05:32:10 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (mn-10k-dhcp7-1791.dsl.hickorytech.net. [68.232.239.6])
        by smtp.gmail.com with ESMTPSA id m18sm1144277iln.80.2020.09.11.05.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 05:32:10 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
Date:   Fri, 11 Sep 2020 07:31:57 -0500
Message-Id: <20200911123157.759379-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911123157.759379-1-aford173@gmail.com>
References: <20200911123157.759379-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the additional power management options enabled,
this patch enables OMAP3_THERMAL by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No change
V2:  No change

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index fe383f5a92fb..efcc46305a47 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -303,6 +303,7 @@ CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
 CONFIG_CPU_THERMAL=y
 CONFIG_TI_THERMAL=y
+CONFIG_OMAP3_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y
-- 
2.25.1

