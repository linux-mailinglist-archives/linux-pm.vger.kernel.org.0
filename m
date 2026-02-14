Return-Path: <linux-pm+bounces-42654-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGB8IBm9kGn5cgEAu9opvQ
	(envelope-from <linux-pm+bounces-42654-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:21:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BC13CD65
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00DE6303A85D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC130F7E8;
	Sat, 14 Feb 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nak+0a3C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0530BF69
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093207; cv=none; b=PcGkszqiTI0I3mUTqD4dTe/syVlMPFbXnGL0+xWgq3LOSdrLGTO+gvuSfm44ra5M6Mt9gVJNCjCRL2OFY6nOSjJYlHfrClx4gxVrZY2C9wO5B4mIqT8tIpyfp7gHtkoXS3sksgdzTTACjSnl33BTOrUChIG2p9S+UlrFeV/eBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093207; c=relaxed/simple;
	bh=kn5V7b3COcuwYHlqKgJPX/LLOq0wc1sfglnkMH3EOts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP375GM0eOm0rls1QgjsmYhyPEy3uGZK/J9p4wTiZPvf95wAAso3zTrihcxXY5PkxP60NPng6DDF8LKbqPCMNBrFXgU5UTJf/UDdlBEQDlWxLi2JsGpMrciV43xqE8gyUdJu9mgbvgcSwRqcFd5y3xOfz0LJlS083zyPKfxk6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nak+0a3C; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a91215c158so11082635ad.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093206; x=1771698006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9mMRm9Rf8IRm6thRLVnHSRFul8AYpRyy4igzBQWHAs=;
        b=Nak+0a3CiZK611zbMOYsxjbkJXqPY+alovtFqv+4yhj0auijZqk+HAqWtWZGXxaA9D
         KtlakTyjNEKJcQU5l52zxbxUulT478FQUtq+zMB8MxWWpPaypLgq9ru7jvHrM+4DA0Sh
         ZvBaHdcz/vpdvj1D6xvv04tMSRAH5da6D/7atfqU3Kg3suz1nksDiByw2SYSZu2nF/EN
         LWI1QOAhllQ7rLa80lfef4in08RyRQBUEgIsjHoh/LrOeoV//14t+dDW0x92mXvzTeT4
         MbusSGjCNmQzq+Bjki9megfV8tExODQ8apvlR/ltJxs5wjJpQ22Bhk1EDzVdkIhAId1E
         Ccmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093206; x=1771698006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9mMRm9Rf8IRm6thRLVnHSRFul8AYpRyy4igzBQWHAs=;
        b=td8Iw97SHxuVBAdYoV4NR82ULac7KDsaXptW3o9Amu9v4VgItVtHm/EnQUw+7uxybj
         uFdUJ7/e24UdRdiQV0WHPPWL8AWh94uBJAkEeWlMIHmSNdxKqqqGB/lbyGTiuv+hECSm
         RsDA7OnA9GBNAaSpgmcs4Rp69nWVEgBF2PGa98CuE7D5rAGuXpe3jtthiSy5M7okycux
         hLG6w/RDI4D8MopxhnvEBBkVw7LbDC/2KyfX/vQdOaQl/Kw4T8yuFnwf69oYVALL+c0Z
         5YdM3n6oih6jRFqyQ22SJJc+e+bG40LPrz4TLEtJ0Cj7rXebKN+wqEyRf1VldztGL9pz
         oqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4vcEHisp2qpNvGtjPzETKiohWS15vIgdcMo47wSbyDYz0lwPv0Q7jURT/U6+vLRWlCbsNWmeEww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVije4cNbH8QVPM9JRfLaf1s7Gdrmfz7fMMynuFrrSARhhkOHo
	tVHaMlRC7Y1NflSaAj0+9mKB6jOTXTBaXnW3cBivMzkh7xz1P2zE7nPj
X-Gm-Gg: AZuq6aKpjzNykVUFsKfNtm25Wy1YxzIcZQnCnPHqz2GoP+eA7XvTEdfZM2KAoCZ9Imv
	6faZN5E+XvQFXOFkFalGM+R7qSulvKD1ZXwhWuwSPW5BPKa6tz54Q5Q8FMkwJYbgOdnmtVscDrR
	qEczYZexLPbtOrgvw4cuR77/mh80wO3rv7C5RCHgttCMyd27oUCOzx+ABb8VklG+ORZlTHpC7My
	SzhA/wOHsIJi6FTBGnryAN8ZoMpr8QU6c2UAopmADDkHfIlZAOPIUIVjpbvx/DNvHilM00SAGob
	+v7L1XbXfkUyr8OCdg3P/80rjI1dMS74YVYnexrMSRWtv3REKqNwzNkcTn38o+F/L/EBJaZsfea
	39M6C59b7Uhaj5Yx5RC+VadLhQiXr8hgi5T8Ad67IuN0kmBYDhdE08uyLtKWXIugpSMBg/jnCUR
	+WXI2kPt2B7iwVnFYoUoY=
X-Received: by 2002:a17:903:1b43:b0:2a0:9fc8:a98b with SMTP id d9443c01a7336-2ab505d91ccmr68367655ad.40.1771093206154;
        Sat, 14 Feb 2026 10:20:06 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:20:05 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 4/9] thermal/drivers/exynos: Fixed the efuse min max value for exynos5422
Date: Sat, 14 Feb 2026 23:49:01 +0530
Message-ID: <20260214181930.238981-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214181930.238981-1-linux.amoon@gmail.com>
References: <20260214181930.238981-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42654-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 029BC13CD65
X-Rspamd-Action: no action

As per Exynos5422 user manual e-Fuse range min~max range is 16~76.
if e-Fuse value is out of this range, then thermal sensor may not
sense thermal data properly. Additionally, refactors the efuse
initialization logic in exynos_map_dt_data() by replacing nested
if-else blocks with a switch statement for better readability
and maintainability. Ensures correct efuse setup based on SoC type.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v8: None
v7: drop the Rb Llukasz, as we dropped the nested switch to set efuse.
v6: Add Rb Lukasz and fix typo in subject
v5: None
V4: None
---
 drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5f017a78f437..3d12e95703bf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -884,6 +884,22 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS4412:
 	case SOC_ARCH_EXYNOS5250:
 	case SOC_ARCH_EXYNOS5260:
+		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4412_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4412_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4412_tmu_set_crit_temp;
+		data->tmu_initialize = exynos4412_tmu_initialize;
+		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos4412_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->gain = 8;
+		data->reference_voltage = 16;
+		data->efuse_value = 55;
+		data->min_efuse_value = 0;
+		data->max_efuse_value = 100;
+		break;
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
 		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
@@ -899,12 +915,8 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
-			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+		data->min_efuse_value = 16;
+		data->max_efuse_value = 76;
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
-- 
2.50.1


