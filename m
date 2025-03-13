Return-Path: <linux-pm+bounces-23952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F1A5EAA7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 05:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A9172C16
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C913D893;
	Thu, 13 Mar 2025 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXg543e3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D11386DA;
	Thu, 13 Mar 2025 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840580; cv=none; b=sj4zIiaJGJAsZq4cnTcwx01hcxauSt9NCKtMnF6HppYbHtjEjddHPi7p4uWiYWzCca92J9ISNjjzzvrGTc9j/zfI1y4Ek/JDEmFsnju7zgNgTjrSvGHa3y3i0Hb6ORCT0Gj4NWNo4rS3mwdrcwQ0VmXGpHnGE/EhWb+McYxZrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840580; c=relaxed/simple;
	bh=poDSq3c/+Ogs+u1G3fiKjF8Ul07WCCrlskdvEFohxrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=irlJpGjhW7bdvxEHL0K4rbeQQ+VwQl7BBujws4/ZgOtaMkd9qJ2JvKQcbgTIshEbSBCRufBv+Ltjt2FZp4KsTlUKnEAyq6LARFfV7c6E8eBEtE59Xh9Wt6XEsAYXIIE31Clbx8tng4uLlvv1Zz292n2KVss4MDe69T3pY4EPLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXg543e3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fa1f99a6so518546d6.3;
        Wed, 12 Mar 2025 21:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741840574; x=1742445374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slsulH31X6Z0v0G795q8VNo19hZffiGI8EJwmN2Ou9o=;
        b=EXg543e3aAdVBhchvs/lVXCVtR++ZkzlTdE81PkLTVO7bKG7OIbME4BuNSLadLbdvT
         z9d7g1He/WpMqITmwI8/V77/I5miiW8aHNu9kflJkZJodn3tkxIBccBzcg7gQPeubmjO
         AMZv38vrGiIQrAaVtrSKM6HiRk3/xZ58axHTJct4Tl8fa9FnH4CDsscxpxNiDnq/hJGI
         0WCelm9Of5wMKZe+w1FyNDeWTtapdnJTGnwPnojdDgoDIVvoa+j/yt5Wy7HOFabLo3WF
         1lv3fDQgt1IExC1QBEfqfZ8KpIm69WYg5UymFbbvjZZ9Q/HH3RsjFP9chVN89azAf9sP
         mmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741840574; x=1742445374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slsulH31X6Z0v0G795q8VNo19hZffiGI8EJwmN2Ou9o=;
        b=YtZxyeGjULVoMQksEkTRMoAunQ3Vztq0ke7f/d0UwxC0PxKa6nUjE86azpr5KDSmI/
         KQ7Jd6FRlNd3px2KChPVwuob9+d1ONqqVJysiCV+Yj2m99O7uqEpBPi2ZRr6j1NzEQxD
         geU/0oNh8RIP+I/QbCXKcn8QrHkSQiGb8CAMGzAqWNKZGXzbzWl3FuwCoFAQVeSlJzyg
         EjOrw/PYHhn3Dbbor5AiMIHIcTlX7O+fEOUMCuFToP7KrZz0pVY55bQ37gbjPbLggBl0
         6ZBNDboLTu5Q5NGV9olUBTxZCnwA9uGP60I5aBvZl5AC3JNpA+pRcLo+YXVFqiwpfy5n
         svWw==
X-Forwarded-Encrypted: i=1; AJvYcCXGc56bMdoOrKHEW2BW/Mw0REqOlZkOaprn67bbrg/g8aniHt3siTRBO2PpANbsGrbDQa3LpBoEDA5Y6Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW0RJ2hTqYofpJJSFR9eFQ6KW5qhpnK3sU1ep36eRP2WppkB2o
	NgyINLP3anGdjAEHrRPAV4gLMHO+erTPQeq1PTyjAHGNCKtNnqU=
X-Gm-Gg: ASbGnct820DZLNz9Wffpu3anOP9FFMWntmv+S3N17YfZiR+b2ivphrpL5aj2oqloiKC
	amWWmTiIcBSWG8oJMUqHKUFmcB+6QAh+RmfHwEoje5Exkiyf8OokjsD29phS0q+XBvmn9u+Kj2+
	2fqr58HMalm8kXnMw68F/Bw6n1Sqx59R/Fi+BP4LVTML5PlG8wix2HH5hoBD5BDSR53RRb2MNpp
	t8wfLLnQmDW5bSTEzG9rjDeYmEzFYD5mv6jxe+cyP/cH7m03L2dI3mx4qtIfS7TT4x6bbTrAGDe
	M+vtWLI1yaDap/Ond1PLpnGJDHunKooxUb37KUSLmFWPG8NzdsvO
X-Google-Smtp-Source: AGHT+IF5YB97HetbVUkdqlBkx7GTkWZiBRUUTwZ4B5HrDCjhn6X+mUy6jUHGd+6QPO2Qch7Of42vOA==
X-Received: by 2002:a05:6214:76a:b0:6d8:e6be:50fc with SMTP id 6a1803df08f44-6ea3a68c0c7mr55023226d6.6.1741840573921;
        Wed, 12 Mar 2025 21:36:13 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c121sm4602266d6.107.2025.03.12.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:36:13 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	u.kleine-koenig@baylibre.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] thermal: int340x: Add Null check for adev
Date: Wed, 12 Mar 2025 23:36:11 -0500
Message-Id: <20250313043611.1212116-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all devices have an ACPI companion fwnode, so adev might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in int3402_thermal_probe().

Note, under the same directory, int3400_thermal_probe() has such a
check.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 543b03960e99..57b90005888a 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -45,6 +45,9 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	struct int3402_thermal_data *d;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (!acpi_has_method(adev->handle, "_TMP"))
 		return -ENODEV;
 
-- 
2.34.1


