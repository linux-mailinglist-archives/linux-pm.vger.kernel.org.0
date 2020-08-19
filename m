Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F65249F14
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHSNGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgHSNAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 09:00:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B03C06135D;
        Wed, 19 Aug 2020 05:59:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so24472938iod.12;
        Wed, 19 Aug 2020 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtzkSuCwuVd+0UO9n6oA+BAW4tVVE+zEGyv58T8TdB4=;
        b=FBl+WwvRGqGnorKLY+KDejdhfQgPSnP1ekvH33MA/ME8GETj8p+yLDx5UHYD8st7Wc
         05o982Lz0UMjp/ZrZ5UCXLB4/HbZTywC0H1YmS5I58nLxcCoSbQky5c6U/SwreWXxTEq
         PpMZX21CdKlOkg5dWPlRVxJ5G1uSNxLbpj5XygJWCjlwzielL07egsxNXKX3yHWTcWz6
         D+KN4Fljr5dhFNeMyT+uE1zK1b6nGucRCnbLbULlgIfgyKmdxobG8yJr8r5RAGu2LciP
         Ufu6kR8RkCsOvon1Hzo9ge+vLW0vwRZRdbSx9cJIbZF+DtTAN9Ujp08IZqX/Kg6QP/h8
         K7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtzkSuCwuVd+0UO9n6oA+BAW4tVVE+zEGyv58T8TdB4=;
        b=udgR3Y+fnC28tj7HruFfOSxseR8nRs0k1RSL9SOPuuU49JqrloyUiOfiNeUQZg2IYq
         fczzj+aKnIVnt2akOI1/4KLSzXeLrZuvDRGWeFB1+LL+X/uR6PgaqiCmoCfbjIqJjq1T
         qkjk586+c3zg6eggB4gfKCXGlwwzn2bT5rWAnxGeQWySV1JtfuvmeIlrXFyYQntL37OG
         oMX5HAZ5SQjGvRc9sQTPT2BVBl1/A8qsd1l0UPeS14aQQip4EPvhLkxF2KoDvP+PoZB9
         75GUUx8gQlnu6QXiL6yypu24by4BDm3msrSU0rQ8mRKPW4bDOKjXhtzr/3Xh2UoDqCQp
         b3ww==
X-Gm-Message-State: AOAM5314KZvbrFZ6TTH4gLBlbzm7vCSi/WxOTpOsPGKpT8Aj+niun1fn
        tqFQy19khlNoskJ9kHPugWxRtaO/E3Sq/4y5
X-Google-Smtp-Source: ABdhPJxoK4y5weKNZKYd6Bo31UrzQruDNpkUn3kcI2PMlwC+ga3JeKSQlr3x0203g5IVWZcE1EWoJA==
X-Received: by 2002:a05:6638:1393:: with SMTP id w19mr23503106jad.113.1597841975108;
        Wed, 19 Aug 2020 05:59:35 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b588:1a5f:55c3:870e])
        by smtp.gmail.com with ESMTPSA id i5sm4138388ilc.69.2020.08.19.05.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:59:34 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     aford@beaconembedded.com, hns@goldelico.com,
        Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
Date:   Wed, 19 Aug 2020 07:59:24 -0500
Message-Id: <20200819125925.2119434-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819125925.2119434-1-aford173@gmail.com>
References: <20200819125925.2119434-1-aford173@gmail.com>
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

