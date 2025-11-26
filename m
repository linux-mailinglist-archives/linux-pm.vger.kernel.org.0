Return-Path: <linux-pm+bounces-38735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9EC8B2CC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 771534E6375
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827426F295;
	Wed, 26 Nov 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8Kr8ao4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtW4IYru"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB226ED39
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177547; cv=none; b=udTwFy6VHsVAg9U6dAAkI/RJfa/yAFIljjEZC/iZuHMKucFo2WpjA5E0BcwEV8/f0551UE3YzZe9kN3ZXWNQummMOP2JIWeAxSNS5ZJ/5sDAVBaL4wPsx1QqXoMrRfXb4ScpW3iLyqilW53IsIQK+TF/j5fHtwjHHeM6V7o5JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177547; c=relaxed/simple;
	bh=t3oKQjmWm+pD8ejyb3xy07D1H9qrD82Yy/oqPyukn+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDP6ImXwj+iFL9a4LakNTWequXFhBkE3WFb0wWtHJpW8X1ANgKLgMJ+JgM10PT0W8kErFkLKhNtfHCZxNqx+NFYlghw+QCUDZ+xBq/7lzfQ23VPqs45zLWFou8Td+0+UqAHaa23oReD6xE7xhQ7h6ZyWFsOuILIxtOeJmjXp4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8Kr8ao4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtW4IYru; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQFpBRW1235231
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9a8ShzG56IbjgQLSvtusIJmapvhX7EWXJD3
	6UQv0x+U=; b=f8Kr8ao4y1Q0g0JJUKBEVLgX40gyomlbzQMgZ5N8Lj8ikfpOuCn
	sRg/az5136z/yWmRufvlheRwwhsw3teK9e9erArTsveiDBA9zDPhDnRuqM/FlIaW
	uZPQ6nWfP5La/Vi/ts1aHZUBeBmR+P9A89P8iDD8Fq+sBPbkpUGdFHQU8FqWWoxs
	uX3tzhxtizlrObeUV8KjiUMPv5+IoMcIp2QCsfKt5pVl9v0iPDfrJrYUIkkry98Y
	U9NHsGDyzzExlHTW0Ija+OMA+g5ERXfp2HMafXK6q5IEYeBHVz+OEvX/Dj1ieedD
	damJ7RbLtW/zXgJNMOyzmHsKdLdzrqvTqMg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anwd41q1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:19:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb35b1147so1316421cf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764177544; x=1764782344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9a8ShzG56IbjgQLSvtusIJmapvhX7EWXJD36UQv0x+U=;
        b=UtW4IYru+EscjDkUUahWfQsTvCq3zK1o0pRPTa+CL9P9fZvWy9H+twG0vrIfwxCXAp
         rWzTRmQNGuu4wcvDgOkbm1lHXy83psQfcTOpJ4YxWgt0zYRgfGW6RE9gyiZx14FJqHn+
         dT4vCht6rmx76H0wRG+HhKJEkIxg7Ew6RI/weMWZCKf5zOya+/lp4LBQvkPmxBTcfq3N
         WRbdbRs7a7gkUN+VXNRI/4v1mUHREsbrAaOycOt7/rpZH2QzFk8HXYACWSVJUO7eqCE+
         KlbTg4y9sWKLOJQQgJ1d5C4x3/kgfiA/QtwDnSORYppyKbN1gR15j/qe8+eOzlS26JP3
         82lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177544; x=1764782344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a8ShzG56IbjgQLSvtusIJmapvhX7EWXJD36UQv0x+U=;
        b=G7KvFeJPhPvr52ez+PGnt1+i505WvD/98GYHLNYquWYRDfzzrjLN3CBxqwamcmw1tX
         RDX5t/JUpd7TpqGYT9dayNFgBcd9qigEx/1XYGD622TH64jk1csYFazrCBvnlnlkaH49
         XuRS9FSvuALKY3mFhWE0V7Pem5stdboFLHoSgFnPHh1xEFwk2dkvwXf5bn6EvPIrPatK
         irFDxFdyXIW4W0EbtCgRD5Jf+MvwvwHmdUzyMOivTdiTJaqflF+5uilvC7B5/jFnAEjV
         H4Z8MI9Eib5s7WuHRDljKxnovkn7F2kqX/irc4jbHOote0Yj7A1QW8HiJu+nesj/uDyG
         aOUw==
X-Forwarded-Encrypted: i=1; AJvYcCUF2SDbX46SH1tV7fkhfGlBeHLoEeCo9JeZraSQZGfDAC8k9kzUJ+TwyhHJ42fSZs9oBaNN17lmrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJC3FvdO4jdw0U7cv15W+qXTnPk+z/FvOhh+bAu5EZqZJHSpz
	xr+9Xvi/nepdgdSfCRbhYkK96RkECblregkrlvEli4wEBvtVzFta8g0Q+uA4Ud6h5xOJH9ScvGZ
	1r5Lbee9Hi++2a/zT0DREThebhBAlL38cspwXXkaXDFTvC8QcD0GEnMAWndgm/w==
X-Gm-Gg: ASbGnctzoynBCsRoIpB91ajnaQ3p0WKgBSdTg5CeMryt+zKNVfdfbj/FDSqbR4qrSmd
	cUT/lW54ysB+uApBsNeofe3SkV54GY1EXWqs7O/hp37vmDPOECWJ6ky/EJA/J0pt7lBBJWV8N7p
	YyDJpFP01tMK2frf+2je9vCX8NX1lhOkWVX+jN/e/oGogCxXzflK59AtihIsokT+tP40NZZzdit
	AZUBM3wWKDVdna0r4LYGCengHa8Oi3daSkF/jasJM84pjpbJKJ8fEKTt9dA9WQpdzvB9i2ssfWK
	xHg1iJ3LvJ1dmFYDBmjjLaBP1Io9PLeKKJtO/7jhuSLLfXmVMqMYhZs2cmv/ekCttm05mmv77pU
	YCumwwBdTcNO/C1DE8qA/jR+/v/F9
X-Received: by 2002:ac8:5d4b:0:b0:4ee:213b:3391 with SMTP id d75a77b69052e-4ee58821198mr318156561cf.20.1764177543916;
        Wed, 26 Nov 2025 09:19:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGukSzwDayPRubrOMcfSTOY/S9VhGzi6PysEta9HkixwMGAUs74GN/QUlco3HDJhHQkXiSjPg==
X-Received: by 2002:ac8:5d4b:0:b0:4ee:213b:3391 with SMTP id d75a77b69052e-4ee58821198mr318156151cf.20.1764177543510;
        Wed, 26 Nov 2025 09:19:03 -0800 (PST)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7a0f4sm1931944666b.26.2025.11.26.09.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:19:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] power: supply: sysfs: Constify pointer passed to dev_attr_psp()
Date: Wed, 26 Nov 2025 18:19:00 +0100
Message-ID: <20251126171859.72465-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zz-bVhPkW1Q0uMx8vlIM10FQIe19jf8Z
X-Authority-Analysis: v=2.4 cv=feqgCkQF c=1 sm=1 tr=0 ts=69273689 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Iax6wTeSMpqzYiZSKl48GQ==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MBccZs4zjy2wqTOGcdQA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: zz-bVhPkW1Q0uMx8vlIM10FQIe19jf8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE0MSBTYWx0ZWRfX/0UEtFMUUtov
 Sn7jYPCagq2kt3eWW4PbXvsg6qKrJWmmOgnSWTgA/MsJ+vi/PZzIUEm60b2RHTXCTobt04I7ZyX
 a7SJjYvzTxGk0CC7zfYWwdnTuxnXsDKZk4PeQ3j1Zo1KpTKyl7QarcrsT3v0Qii6JUyIlMxj1vM
 pb8sfD0rbVJPOg9568gH+uO4a6Klf8VyxJa3wO9tgN5h915EAuVCR0mdkOMArAvIm6mSqYCcyGC
 smf3FHQ05b9mzhRRI/t/k14oDPgvOHk610ekGg5DCHP4A457jH18jMs9iKYYDqvOMnTD7k406rP
 V8JOLWlRnHttW1vBajrR/CIxG//i0kW1FEQbA3uYGr2FAHiRjhuap4orSIpu3VkmLefjrhWpI5q
 uajb8wEu2SVmd3gqTiLJIMF7EO6lXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511260141

Memory pointer by pointer passed to dev_attr_psp() is not modified, so
with help of container_of_const() (preferred than container_of()) can be
made pointer to const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/power_supply_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 198405f7126f..dd3a48d72d2b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -235,12 +235,12 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
 static struct attribute *
 __power_supply_attrs[POWER_SUPPLY_ATTR_CNT + 1] __ro_after_init;
 
-static const struct power_supply_attr *to_ps_attr(struct device_attribute *attr)
+static const struct power_supply_attr *to_ps_attr(const struct device_attribute *attr)
 {
-	return container_of(attr, struct power_supply_attr, dev_attr);
+	return container_of_const(attr, struct power_supply_attr, dev_attr);
 }
 
-static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
+static enum power_supply_property dev_attr_psp(const struct device_attribute *attr)
 {
 	return  to_ps_attr(attr) - power_supply_attrs;
 }
-- 
2.48.1


