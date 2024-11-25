Return-Path: <linux-pm+bounces-18104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E339D8DB7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 22:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81F22850DB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEF18E050;
	Mon, 25 Nov 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9XC+PUl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8E29CF0;
	Mon, 25 Nov 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569342; cv=none; b=W5+3zn3s5xSugzPvrmb5bb4IIlt+CMIx1ZM2MKT7b5z8oMt2PP7dTsF4TPyfmzT/GaQSyTxzuFioSkyU6nFJwKm2wnDt40MQnIc05grYVPFSpI1igJpTkpqMvyw465MpvdXsUX2KJ6JWl6Irz5AWxeyvvTtui7bqf0iZCEQg458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569342; c=relaxed/simple;
	bh=VNKvbazTlr7tqJe/5NFn4HfqZ8zi0nHjhSm4KUsjBSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m3c29oElqqBsVw/Agth9RtMsoKRqolhR1QLgJRpAvWEVUQ74vyqdgDMgoBFXOrNRWiQ8KFaIPh/7JlQlKVXFOcygTVo6jKPKmzlnzO80zwQ+Zm9KQR+RwnBh7xuYygA49mC4oLeyDbnWdBWbT+oqn9s6YGR+7h+SJZ4tI1lZy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9XC+PUl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea9739647bso3879309a12.0;
        Mon, 25 Nov 2024 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732569340; x=1733174140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZHTGGztVRlr02UorCZLeEgiwydMSFEuesYKwn9RtUI=;
        b=P9XC+PUl6PVo2vv8E6YcpSbp3I1i3TWWwlx8SZLnCvNm8s14N5+YrR1w+MD87E+Dng
         V7Pt9sqoinqfBmDsHBu+Z0Vz0cBWitSfwfWI+cYvnXJsAy2ty2u2ZzeMUDrpj8MXgXVK
         iFSrq3WB9CxWM8vW25AoM7VLVLmysmgCk8om77DtS2kCtPNCr16JAkdwUTfcaBSu5u+f
         wkRPDu2GqBcJJRjig0+6sq8w9FI6ALUIV3O4L21k0xKhxai6N243najZA8xlZ4y0vx4d
         AMUarY4dQNif164DrtsKWFObFkH9M7vrSiPVOXBTM4LVZHorHOZ0ih5lGUhLe32tjhT6
         Qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732569340; x=1733174140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZHTGGztVRlr02UorCZLeEgiwydMSFEuesYKwn9RtUI=;
        b=qMr0cTxVH/vrTtUMX4pw6TBIZqzNPCDw2WzeSHUM4V74sm2b9aNDUd5GeRWGem6UJB
         Ui4qb2PAvvwi9zXTKpJv0FgW6jIkaQF3BWPArnJidyZcszfbHD63F7o0jJiCO/G21stl
         /Vx7VEcfN2k2/yNf52oTNIqdDqxHkJ0YTjzYWZEN54BISpL4jTQobuLG16BiOhi3LENg
         hr07+VEcGQzfV6oy+GnNN+hN9Uj57IJW2+LMhhO4axUczjh+x4uFsAPYDVIbcUYz3xBh
         gHxHrAoLxhZyT3fx4Oy8FNF2J5W3yvowhNxy2eOHXZeHi5l68+V1BNTkIqiXgFyAxE8Y
         4hUw==
X-Forwarded-Encrypted: i=1; AJvYcCUodHKvieddkk4TOpJG5MhDGz2M045/yvcjyetKKvgb6LrYoEFuTLko4Yk0UUZeFtZGMEt7b3CrSghza9w=@vger.kernel.org, AJvYcCWYEus1+7WaFCyZmD+8bHVFF1Nu7Pf20bvus6zonSlzZLLSfwr+0/VTWgQNxetfKvT5FlfBqsNFldk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBO+vbmORkymimRpn/yMLTFzVJtDKSC5RH/vnF2uMQ29PsRoW
	pF36WWcAn4rPZmI17F9sqRlGtGzdwo7aR+ccS5NaZpqH0jf+l80q
X-Gm-Gg: ASbGncvbzIlGHmtldX7gt397Dccw9K3dgRk4d7P7ruzm57UwGv5N3Ul5jbqycGb4OHk
	szAgbksOlIntmvcfv4izb/AAHbLB9ZKRRKguptTepSKRTq9eKw78gK8eeJ2rD7D65CB3KPkambs
	lTL3jYO28PUu+WODMhm6jhudYrvjqOs8SaACI5XfseCGt3VaR1VtBx+PuAWWiI5eX7b1kVkM6Lw
	3fgRVHYrrqqfUCMTlpIS691OrTN2N8oPaEz9TZ7Cc/1Au8YDg==
X-Google-Smtp-Source: AGHT+IHrsrU0BqzKKN0+sv8jhNnr6cs9rDOsCM8lLkVi9yLVElzX7tpOkme2fiVg4jFUx0MfT1dtog==
X-Received: by 2002:a05:6a20:c89b:b0:1dc:1147:a632 with SMTP id adf61e73a8af0-1e09e5cb4c5mr23461978637.37.1732569339517;
        Mon, 25 Nov 2024 13:15:39 -0800 (PST)
Received: from desky.home.arpa ([2605:59c8:492:c300:8a72:2d07:5f93:a09b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454967sm6907470b3a.19.2024.11.25.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:15:39 -0800 (PST)
From: bschnei@gmail.com
X-Google-Original-From: ben@bens.haus
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Schneider <ben@bens.haus>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Date: Mon, 25 Nov 2024 13:14:52 -0800
Message-ID: <20241125211452.14987-1-ben@bens.haus>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Benjamin Schneider <ben@bens.haus>

This frequency was disabled because of stability problems whose source could
not be accurately identified[1]. After seven months of testing, the evidence
points to an incorrectly configured bootloader as the source of the historical
instability. Testing was performed on two A3720 devices with this frequency
enabled and the ondemand policy in use. Marvell merged[2] changes to their
bootloader source needed to address the stability issue. This driver should
expose this frequency option to users.

[1] https://github.com/torvalds/linux/commit/484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe
[2] https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44

Signed-off-by: Benjamin Schneider <ben@bens.haus>
Reviewed-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index bea41ccabf1f..f28a4435fba7 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
 };
 
 static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
-	/*
-	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
-	 * unstable because we do not know how to configure it properly.
-	 */
-	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
+	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
 	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
 	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
 	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
-- 
2.47.1


