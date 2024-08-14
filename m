Return-Path: <linux-pm+bounces-12225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F709522FD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BFD1C21F5E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9401C0DDB;
	Wed, 14 Aug 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lo/7IS+e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2951BF30F
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665512; cv=none; b=bTrWQMEXVjeMZncxWKjLJPtHMPyjqk4ZwIcWPFLEmhc2ebxqpluGAVqc+DoMKHVkJ+yw4rdITn5N1Hqwendm4MHQ6UuJIyTZjvdhr4VscmaHgh2U35WJWoqUK5+YjLUrpnv68XRgiQUZysNDstmoNldFnfsdVCGI88aDwuAUcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665512; c=relaxed/simple;
	bh=DrwiAoxoyEqBFQNKyiASdBbPbGDrpRDECmNJiSspMII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnQNmxojoCilEvGuXSV9p5vryTjOnJPsECmWGroeL3eeuJM0OWUXAoTLdirc/NItuXpRKMh8/Jw1SrwwD5kmd1Y2tPThXNu3m1u9HWkBKw4daQTTBpDAQNsFljGkSothGnZQtadMyufaUKBilsIlqq5SB2BxiZzOB/Q315bwvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lo/7IS+e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3687ea0521cso160527f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723665509; x=1724270309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb257pBqZhP6UYLMmFTbQ8fmxgCfB52QrCQL5eJC8t4=;
        b=lo/7IS+ey3auZSvDTSEb9NhSRN8yGfx0CVjtG4SKmKZ8W6r6XQNu5suG7g6u3/CrwW
         5/HIGUctPpX8SKRjxLSGAF3FWYfbQzGCy+vFpll9WchS7tdOrYU5/fJsbA0rqxNrPLXM
         C5PI6BVuITA/chhTXiBmjBEaKmEpJKsDA2CYrQGpUwQ3VdVxEcJu5vGmP4PWBK3OcVa0
         TEvL3iU76aMx7QvmJ++zdnv+xlFrrUtjwusZowOSAOTDYIh/4cgX9tjCkXl6GX5KFAtt
         lruq7iZE3BgY3zO3Mq1Urct5Hj094ZXY5yXgI/ls3mbd2CPR1bhVvPlwyHHiUqC39Xb2
         /eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665509; x=1724270309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb257pBqZhP6UYLMmFTbQ8fmxgCfB52QrCQL5eJC8t4=;
        b=E3pyCVaZwV/PsN3sXLPKje1gyPr4Y9BrvVfYvj/mfwMPCZncAIMickJvGBFrkQ8Q9r
         Kb6BJxcjvFvSwp/0nl++VexwSuXew6XBKic1L5P3hNezbYS7huvegI6sRnFBnAQHdXhT
         0pFVW6Bgz8nO6B6Fv32QwZGkAl1R+Z9OkboeigGzyW9IkUT6l2vqHrtYaQRTfly/0crq
         CvDX98G68XfQsAIlWqFUy5iQ1aXDLKCWjI8ECq5Mh+147HKo6vEEvbSm1Pdw/wZu6mA0
         S8E5jwiG7PTqfmxjI2RyvMXMH63jgAONPT5NYT0ZXRsZLwHXuAWxjVD6phHttUOizkp6
         Yscg==
X-Forwarded-Encrypted: i=1; AJvYcCW9KTBw70xmSHhDBJnUK9GweiVtvNQy6AtWyhYaEYkaaAO1HEt5KwBRgcrW7GEilU9L8sAP9EN/YWF2afMg/tXD/tHD0vjLIJw=
X-Gm-Message-State: AOJu0YyrYuJ+LlfSF039d+lbmzfTLESnAzqZG475rw57o5Qtcb6EXpId
	HYLdRxU1dXqGty0HVxW7HsNVZ8Do6VI7Q85mi1C2j0tSS9K4Anrh2gbyLr61uRY=
X-Google-Smtp-Source: AGHT+IG88V2hU+EgJ7Lr0puPbxnLdAZ2m99QYLzaH5h8aG7w+H+SP6z/ChwWFYdSv8IxFj+SArDOkg==
X-Received: by 2002:a5d:4ad0:0:b0:368:6606:bd01 with SMTP id ffacd0b85a97d-371777fe399mr3092052f8f.55.1723665509278;
        Wed, 14 Aug 2024 12:58:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm13482263f8f.59.2024.08.14.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:58:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] thermal: of: Fix OF node leak in thermal_of_zone_register()
Date: Wed, 14 Aug 2024 21:58:22 +0200
Message-ID: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thermal_of_zone_register() calls of_thermal_zone_find() which will
iterate over OF nodes with for_each_available_child_of_node() to find
matching thermal zone node.  When it finds such, it exits the loop and
returns the node.  Prematurely ending for_each_available_child_of_node()
loops requires dropping OF node reference, thus success of
of_thermal_zone_find() means that caller must drop the reference.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 30f8d6e70484..b08a9b64718d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -491,7 +491,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_of_node_put;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -519,6 +520,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	of_node_put(np);
 	kfree(trips);
 
 	ret = thermal_zone_device_enable(tz);
@@ -533,6 +535,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 out_kfree_trips:
 	kfree(trips);
+out_of_node_put:
+	of_node_put(np);
 
 	return ERR_PTR(ret);
 }
-- 
2.43.0


