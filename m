Return-Path: <linux-pm+bounces-12503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E575957AEA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 03:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149BEB2120F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 01:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28911DDA0;
	Tue, 20 Aug 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtmnZqfz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCB33FD
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117186; cv=none; b=kWHXD2DO+dkaR4PGuPiHZyz405zsUf7DLzTu3v36xLKDXyS0Arub4lBRiG7BlILcMDsS0QuCOvirCnsSK7jRtJ9Ct+3CQe17QmvuQm5KQdeTYZbdXeDIUv5vGlrYDl10q6anEGm0N2/WO0G3VzHG+HqSQBQEp21yhPkh5R9iwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117186; c=relaxed/simple;
	bh=9pvnGxhDwHg/alX2fleUrRu/Znfdb5+ztqmuhkoNCJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aTm/vpzzyePig6g36f7dI3q/2fAZH502bgNuUkegAwDs7J++ZokA2i9L0d8dGdW6XdVON/gDnjNfF4Hm8udpb1X1+G7LhAO5teakCnMtbJXZwifqviyysuDEbBngwlcbSlArJ54hcCwzhh85zBu+GGst032NF1tV7XLGZA0mfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtmnZqfz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so388585a91.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 18:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117183; x=1724721983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ZWR4wFNq/RfK4gRHcyv4MECArx/MA9NIEmfmRX6sU=;
        b=MtmnZqfzBK5PouzrEika8dvW6/9IZCc54Ky4w/cTnpdd1lAvpgwbXn6ydFkr/KqjeI
         8xx8sdSDQ1tixMgjcx3keGRQ6f9YhiEQeRV/6zNWALJGUzj4IwSRWZ854sexMgMhTv2+
         BaYrAZETpdKaIhsDMH/wlAh3vwgnF5rAgbkTmyRcfkR7Sf0ue4POJmkraALVYALdysB2
         BA2WL30JREcQ1Vg3x+dOVg+gNOXdG9qIHcORNj1rzJc5wcUWFdFFP28lGC4BLH00KAkS
         wrXVmhKosNVRj5vbGVj1hkgc+YYjQww9DOF+nRBQjgydQo3CnAnIClWmgRzQhT/4X34r
         Lkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117183; x=1724721983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6ZWR4wFNq/RfK4gRHcyv4MECArx/MA9NIEmfmRX6sU=;
        b=S/vxpI7FCD4BbGcb/vCnQj5lrIupbCBcK6DfiRPikYcp0oq/TOAwydCmvITOabAV+W
         3ZiRLvIkU+lHvCZF1YREHVWhkj3qCPcgKypudGL2w4mwO5EYK9hCistEVRE5xKSNHkEL
         BjwFyDL9yxnZHk9nsJFz4qR/4YwTYN5XdPg/Dla7xzMXveWo9jpur1uqk3DvZ4/jGpia
         zA8Jb5cszjQgMxsYfEynB1PPHoW+7VS6A8uszsnnQvW7uXx4Z7/74lZC+rTJJ24pTRH3
         kVnFuvsOauYFpiswbEwMRi6rNrfBPQei3pAVu9nbZtiqcqjCFPQBMBKcMWlxrOjRCVR+
         aTXw==
X-Forwarded-Encrypted: i=1; AJvYcCWZi99hUotMjn2/qPfhyp+JIGtxC8zddeqInVPIuKuitR5QlYCWsqtcNJD9oDElu1gJHvAKEot1yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NQTDMYshR/SfNqLXRwIqAE6OAI1EdHlfsm/gPxKcb3S9gskZ
	+Evaa/QMtHkTuR4PAcixX2K8JtUkwtJtAR0h7P7cSialSSglROfjmZWWMw==
X-Google-Smtp-Source: AGHT+IEjUdts40sclSfjPfJOEkVtItfKT7t25KUQuu8yMeX2fIFHd1In5msG49QPFhsMO5etFOyUtg==
X-Received: by 2002:a17:902:ea07:b0:202:2af7:b50b with SMTP id d9443c01a7336-2022af7b661mr55888585ad.5.1724117182693;
        Mon, 19 Aug 2024 18:26:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9187:7fc0:77bb:926e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-202405921e6sm23193785ad.265.2024.08.19.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:26:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] thermal: qoriq: Remove __maybe_unused notations
Date: Mon, 19 Aug 2024 22:26:15 -0300
Message-Id: <20240820012616.1449210-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

The combined usage of pm_sleep_ptr() and DEFINE_SIMPLE_DEV_PM_OPS()
allows the compiler to evaluate if the suspend/resume() functions
are used at build time or are simply dead code.

This allows removing __maybe_unused notations from the suspend/resume()
functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Use DEFINE_SIMPLE_DEV_PM_OPS() to fix build warnings.

 drivers/thermal/qoriq_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 404f01cca4da..52e26be8c53d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -347,7 +347,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
+static int qoriq_tmu_suspend(struct device *dev)
 {
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -361,7 +361,7 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused qoriq_tmu_resume(struct device *dev)
+static int qoriq_tmu_resume(struct device *dev)
 {
 	int ret;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -374,8 +374,8 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
 
-static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
-			 qoriq_tmu_suspend, qoriq_tmu_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
+				qoriq_tmu_suspend, qoriq_tmu_resume);
 
 static const struct of_device_id qoriq_tmu_match[] = {
 	{ .compatible = "fsl,qoriq-tmu", },
@@ -387,7 +387,7 @@ MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
 static struct platform_driver qoriq_tmu = {
 	.driver	= {
 		.name		= "qoriq_thermal",
-		.pm		= &qoriq_tmu_pm_ops,
+		.pm		= pm_sleep_ptr(&qoriq_tmu_pm_ops),
 		.of_match_table	= qoriq_tmu_match,
 	},
 	.probe	= qoriq_tmu_probe,
-- 
2.34.1


