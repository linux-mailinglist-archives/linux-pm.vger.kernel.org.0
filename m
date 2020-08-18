Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E1248AD1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgHRP5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgHRPqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 11:46:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E57C061342;
        Tue, 18 Aug 2020 08:46:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b17so21600548ion.7;
        Tue, 18 Aug 2020 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpcsNzkAMDE+NE5CExnC5iIWbWS0MQMV+dfpRNB/riw=;
        b=LTsd1LjsrCLzPuwc2S7Ages4odkwdUd/orSwwvAaVGSMmkNy2rzr6rxpbZXywiYzmd
         wRhaoEjAEbvHfBa9PM0FMk/jjghuWw8VOWdA7p3ImauoyymzPLC+AbT+nUvLfO13KGxf
         PrQFpYM7gDrvoUCoecNEeao9rXU7cprR2MdWerdiNT1MjzICwuybSGauPjzDqjEUxEfm
         fINxhoIOsH7bNRwheI23g2Ifvgqg3ZINRrlALCC02M2mTfA/G8VB9UzxUbT1WlahPx53
         V7Qr1SVW8+uw5akLVM9YgUQxoZfx8PrCcI3SJRxtMVo1yjw42u76YFi/o29VHLLvlkNh
         DrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpcsNzkAMDE+NE5CExnC5iIWbWS0MQMV+dfpRNB/riw=;
        b=kN7hw++4kMxQZoHXUIHK09RIj+WlUtst0O1+CsHn4fx8ikXyYDL9sqSZH/CZhaQiwi
         eL7TWu3kFGasxRU4DqJs4jCu4VQQmZoJecgciU1Oh6eQ8f/+1wf726LGqf0afu8Bg6Tl
         nM2Lfh+BDHrRyJNukwQp+SmiyUvmUMtlPx/TB4kJjiZheq+9QZwFrE1KhqZmmT18CL5L
         NynOyNIj3NP5ZIQXwserOPiYUxq8OtsPU9aGQZ7Fqix14GESAbNYH8cONLYd1sdnt8hv
         DZhTWIKWiNn6DXXiC19vogrX+++EPZ/iS9ZqZeHZwgbaJZ1ss1wxecuKJgbvC4Eei0H9
         tMhA==
X-Gm-Message-State: AOAM532wnXMWb8ZN9+H1xAbsFIn9v4JYe43PZNr7KDLa/NVen0CbnTYY
        /yjGlmPYKhM88SQC+oXK307tPLq2Hwqp8A==
X-Google-Smtp-Source: ABdhPJwx8qWomQtlosTWe8r6s7ROViav8P/asi0DxBNbpGIMpnE0w4BCLWsczjGwYLtI7jbNca/y5g==
X-Received: by 2002:a02:7786:: with SMTP id g128mr19118716jac.45.1597765600813;
        Tue, 18 Aug 2020 08:46:40 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id z1sm3113625ilh.13.2020.08.18.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:46:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
Date:   Tue, 18 Aug 2020 10:46:33 -0500
Message-Id: <20200818154633.5421-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818154633.5421-1-aford173@gmail.com>
References: <20200818154633.5421-1-aford173@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the additional power management options enabled,
this patch enables OMAP3_THERMAL by default.

Signed-off-by: Adam Ford <aford173@gmail.com>

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
2.17.1

