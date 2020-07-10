Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFD21B734
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGJNwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGJNv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:51:59 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA92C08C5CE
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:51:59 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h17so2585326qvr.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBRBCvYRb3MFXeLAaBYfIDC82lDpr+ZILSytnXeYPUo=;
        b=WTSsDLYLfQgMCAnUH4/Wqr5JloFcts3FrYAvJpo6wwj9aeDvhhgnniUbW/OPDIBiqw
         hs27Or8eysCLp1tmD+t1kDIFUV/hF7caPVUTfbz3ByeN1IouhxjwAVQiH5/e0pgnaInj
         Bx8bKTZbrzIugx4OkiISTAtq6glPdIwCTEF8cXO3CAaF4VOl6rbKzqNJ8tXF1wJlif3K
         oRHhjEZU0FttNgLDX8RdFSCMJODaf76heuZu6uZ8C7mU6rDeqIb2uSpohF8Ci2jSnAPC
         HjWh5UfSrkThuHVGW9SGRMeB2Bmf+MX+WD4xo7R8iv1kVgs60tgZrzmdzgVKF/pgZhJJ
         yPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBRBCvYRb3MFXeLAaBYfIDC82lDpr+ZILSytnXeYPUo=;
        b=e8FzRi8EXyChZFZl1MAJaDxanuQSjvfpFprU71whsFB3s8hWa5SkiQqPKccdZO2Eha
         RNL8VRZNqqkObtdGlLd7SIzVeDpXyMN6fjFTifCk1AryAJhLy1af4/Wv0+bO/l63QDM3
         At8otnwiUwmnwXAAjX5qjkGhzsQ3pqiufWzGZp+GhUbJ4fTJF8D5nRJ47yFHberKplmE
         SW+fmP4cbAbczSEUadK5qgvwbAU9Fi7GDL3CpQjSKjwvEsXYHAmNh3hZe9FmLtXMxQ6l
         qc6iRQhFU43NmBgdPKOmZtgtNp0IlHV4lt0oy6Hw90QyTJc/YahOokGa7tCSC4aOVbE/
         NVKw==
X-Gm-Message-State: AOAM533q3k3lF8+HeXu/UazdyQr+Esh7DhXVq8wilkjHqfSAJ/L4g39o
        MG57r62TDzvHFA31QxoT4ZB+2QhH+6U=
X-Google-Smtp-Source: ABdhPJxOpaz40f83i6bUlv3F59q2FwQsGgFxw6OSxcPxh4MtrsRwByb14d1wBdQV5q11pP/lWtwO4Q==
X-Received: by 2002:a05:6214:170a:: with SMTP id db10mr59841986qvb.216.1594389118405;
        Fri, 10 Jul 2020 06:51:58 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] thermal: Add support for cold trip point
Date:   Fri, 10 Jul 2020 09:51:52 -0400
Message-Id: <20200710135154.181454-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new trip type indicating cold THERMAL_TRIP_COLD

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_of.c | 1 +
 include/uapi/linux/thermal.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 69ef12f852b7..b4e564a422fe 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -754,6 +754,7 @@ static const char * const trip_types[] = {
 	[THERMAL_TRIP_ACTIVE]	= "active",
 	[THERMAL_TRIP_PASSIVE]	= "passive",
 	[THERMAL_TRIP_HOT]	= "hot",
+	[THERMAL_TRIP_COLD]	= "cold",
 	[THERMAL_TRIP_CRITICAL]	= "critical",
 };
 
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index c105054cbb57..7ad62a33457f 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -13,6 +13,7 @@ enum thermal_trip_type {
 	THERMAL_TRIP_ACTIVE = 0,
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_HOT,
+	THERMAL_TRIP_COLD,
 	THERMAL_TRIP_CRITICAL,
 };
 
-- 
2.25.1

