Return-Path: <linux-pm+bounces-20259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1CA098A1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE673A173E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79B213E8A;
	Fri, 10 Jan 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQY3KaEq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A3213E66;
	Fri, 10 Jan 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530529; cv=none; b=lviZlatzVY6j/qLhkPo+yB19w6EDKgG9luBXMrFUJSCNm8WDW7gFHETnz/3Q+CKw5DXd1p3F7E/iYxycBINjAGArkRhC29PPPukYTbHM1q4IdKFx/8O+Z56DobGx9px+QnXaI4e6+vslHnxadLXkuippdNRjnWci6lV3FMZBepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530529; c=relaxed/simple;
	bh=dqy6Su4xWEL2z2N8ms7ZzIIFROCFqjxSrqCu8WepwaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL+OcgFdGIE2GfCvFm6qvT78GSCopDwPpxT6PlfXpAZXL41JyADeBjXRT2CXTdvG4+x5HK/futt5T5vC93j+odkOMOAjMkmY8RVKnCubGSWcSovskwLuHlzxqJ6HQVxLIOINKrnmzAswr3nHunwriVd9HF7HHqbHOhIs8CNqNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQY3KaEq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so39404355ad.0;
        Fri, 10 Jan 2025 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736530527; x=1737135327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNq0f4XftzS2xuukWCisc0SEMMCFATHmfoybwHMaJnU=;
        b=gQY3KaEqhv/FlFKUh9XwXRORhzqgUATU0qJy/jWPQns1B3bTZHiXftytt4wFFEpmgH
         PIohw9pv/fVRrRIbjUriTTTKoNAu48kV2XQ4RSWAzTe9aXdk5lFLAoX3n9siONhIN1Bk
         3VlGj/28K6VLfpBhEcAMhIK5TN9LdfI96nI+SXWrayPoKAXpCKpKfvH2ppZu3DgWml8x
         8pgPplAPwBrLhCJFpK68iTuuEA1XPMrtiFuX24bC5MUgRe3lOCK1uqfmR08NOhtNeSA+
         K8KUzkV5l1u9PYbfk9J2mIDEanxDsc3c6VonAKdYupF/c8+acvduNZvibc5DYG3AFxst
         covA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736530527; x=1737135327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNq0f4XftzS2xuukWCisc0SEMMCFATHmfoybwHMaJnU=;
        b=lkZKUHIk0FkQuvGFvkJFfw9PDGYZLeHjjBCvUboG73XbOF7jD83cAcIaYXXpi4C1Z1
         ZICWmsVp+GB2FvEAIU++HAfHf3iMNhcK2w/wDkWIYYzr34zOwlq9tBe/QMp/3EQiXOG3
         ifEwKnNJBC8ESlun9Dhw+Ui18vPCH6VlSLnu4hQBTptHTLM6gtrLZGDdN2JzCYslu/+f
         unKUEcUJw3pbmRX6HXRIpfa+SpYjAaeVTAAib544sZQFTtApojEOairXClbi8yo7hj21
         RXb/teAVSWlRI2A7Fvl5ec5FL+k+GsnnxqI66orA/JmyTjdI3KTsHR0Qn8CHw0/tyoiU
         N3ow==
X-Forwarded-Encrypted: i=1; AJvYcCVSa20RQNC144R5oGAvZqvOuLqpraZxyJe3k0ohDWxbyndm1THDDEBAd7aqcBamkgSWIBE8wNiLNfVJRyM=@vger.kernel.org, AJvYcCW+LaW64knScO61T01jb8u2+Lqb/LeThjgitZmLKVBEBvGing73rDL7MKWFGMFIlBo9SyzzPdHvxxg=@vger.kernel.org, AJvYcCXoBJx2/9Bpv0cjtcEAq5XGEEAsCyj4BOCO5NqFvB4h/CXw8LxUQYByqxwa4+pcpiRkcMCc/V9rQjK15JsCRO7z87Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQBxUcoNxxZ/UfZThOTH5QvxlJyImkFkLk1Sl2vYw/X/aGdMA
	vY6Fa8KCPeGl2tAuDf0MXfkeWdkscgJyfXs0CtgDHd5MhCwMolmd14HtPiUO
X-Gm-Gg: ASbGnctl/K1O3B/W79uqmhvyNGXEtRZItVHisFYaoIMqhk/BfR+UocYoIdIHFrl9HLp
	r4+XYTAGqD7O03NSSyWJXX3oW3Po0HY166e+EahiesI4KpUnmnzvkw3zaqpdgB1MCo/CDex2IBI
	ag2vtD/3rprcx9EVBvPzPYMBk0MNrMvo0HG3SYQdPOF4HmPxBiuk6obgGyImQBy9AirFJu0ZouF
	hzyPWwbfpymUl87AGmWa7EZyVSK9WWitXr05TwkVqduKn/834Z26j7SF54Lren5BSth5djpGhYB
	Bnnp1Q==
X-Google-Smtp-Source: AGHT+IHz3J3zjghGX0Jx5hU6nlWiQnwp59UrsYV6wKHypX5OcQXwxsWlNvJPg+GwCc78s1/h/I9Flw==
X-Received: by 2002:a05:6a00:1152:b0:72a:8461:d179 with SMTP id d2e1a72fcca58-72d21f161a7mr15449756b3a.1.1736530527393;
        Fri, 10 Jan 2025 09:35:27 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a94edsm1839963b3a.174.2025.01.10.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:35:27 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com
Cc: krzk@kernel.org,
	alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] PM / devfreq: exynos: remove unused function parameter
Date: Sat, 11 Jan 2025 02:35:20 +0900
Message-ID: <20250110173520.78464-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exynos_bus_parse_of() still declares a parameter struct device_node that
is not used yet. This parameter is unnecessary and should be removed.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/devfreq/exynos-bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7d06c476d8e9..b9ea7ad2e51b 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -236,8 +236,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
 	return ret;
 }
 
-static int exynos_bus_parse_of(struct device_node *np,
-			      struct exynos_bus *bus)
+static int exynos_bus_parse_of(struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
 	struct dev_pm_opp *opp;
@@ -408,7 +407,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	}
 
 	/* Parse the device-tree to get the resource information */
-	ret = exynos_bus_parse_of(np, bus);
+	ret = exynos_bus_parse_of(bus);
 	if (ret < 0)
 		goto err_reg;
 
--

