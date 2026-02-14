Return-Path: <linux-pm+bounces-42659-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIcmLm69kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42659-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D113CDD4
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE01C306683C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3282E285C;
	Sat, 14 Feb 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxIxOI/I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7A1DF273
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093240; cv=none; b=lXPwwCeML8slcTdhaxspRsGCrt8m/9dp/WSPi/0aNnnqY/sQ2RbWWtyEtaC7AtogKEGeYSgE03ZtjlSLr9yBYSDjxi8jLdT6l8c17a9lPDkiKHFclN6dyIZxdFbvZeSz/NvCyyhKYEyOubgzZiJUoWf/ioqnxQwAA/3xNwAzA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093240; c=relaxed/simple;
	bh=4TcBQPEAGKM05TWISFH3YhLVnNBHOq5rwTZKeWo8X1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXiShxCi5S2Jm5fEFy1uXvQCjhnF8t4qEExMSbAxrGQPZu9nEJ982ffl6Y8YdU/oWDS2+lMzZX+UhG/TmAhilrtajGSkmlsi7fce6t4dhzzdgwdnjaas9BmKsX86usgWp+8xjku4FY2CO5FRC9WaMc0JONU+hnPIxtHivdmtpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxIxOI/I; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab232cc803so9071985ad.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093239; x=1771698039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnXmUEvVp0FKiuAf5tSWSg+X4ncehtCc9Vi8+FOLDFA=;
        b=QxIxOI/IjjcE3tNN0PHIDZ7GryklbymZ3Y1FflrrbE6pJsS1IYPSqAWqeU8oTWSihi
         JVH+yoG6UzXAjFJr0Y8qCmO1ALkeGznnng4IPe6xAfWRo53p5ph1IslSNy8p7gnd2Ers
         UVKdJy1kCDzUoK1xM5Qe2E/vDV1Oo4dML3CSr2rSVIWPGR21Tx6GEbn+qiWp+1gOYbFN
         fEIKWkyUdCSdHULDnj5tT7Obs1s4Cobq8EhIsiJ73jcorLwQ8HMVDCa1TjW2XKsDxn7F
         x7CfM1RZz/djanfXHj7BYFb8+Fao2p99jmFsw+d/fiEL96YzFqN2j9r3vUccjKHb35Lt
         RlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093239; x=1771698039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnXmUEvVp0FKiuAf5tSWSg+X4ncehtCc9Vi8+FOLDFA=;
        b=pICsh+COPSfEgvkd7VsebeHH2Z6bezAgHkdbmVHMvr4x9V4XGVim2LKnNfTw86TAm+
         xBsjHjvc7odqxdorsURekjEhhTPZcfIR8XoRiAptrRcdPf1601S4Y8Z+1W1eF+F66jsH
         MSWXmSori/ZjmcOcf7dE1RYaEKxfZYWfHfmf6rtOaHm9stUlG/Wrz1C8FIHghVaTj44I
         SJQEzyczHDr7vlCYnBf1bt4+GI9ICuMl4ozd9MOrQekbkPmAJFDqDcixUKidT4YyDPqm
         cTvNRfO4819O7yAXG0am5wszgE3HtR/GAm0297WBnYbWjSFtkZP4u2KiCjHc+ncXvIfE
         3I5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuyKR5KyCzbokOayCTiGbIUHtwWsh+IuAoznLOUFpJsaGCPlVzd6cw4uv+E5OS5UhY7cKuhsAnBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKi3ESgBogVSOeQ1ljAh+3yBpr8trk8vFGWSMgeu+iFzMv2it
	u2JrC41O9oIuiL0lNLEluIOYgHzzhu3udiv/YLJBYCAZicZ8Mw6guVDV
X-Gm-Gg: AZuq6aLWV4CmD4s2vktj/IlJ9gNHweyfBymRPYwxC/eV4zGUscDLoeKxbCBJDbzWJlr
	xGJ6ewg98wjzwEtJcVW5ji1pIBDVlvVjJA2/vHW5fpRG3aCSXXqbQ6So6dMyxSIWlf2UTKC2uJa
	X3RpC4rOA8Y1AvaSGxAQzUQ5YsMc/szwPihh2+FG/nbejvW3pR31k+ywqS6S9P+UrZnNvVODjRI
	UEeuJiXmnDFMjBOZ1+UwXBpF0WfV9PAlWDg4GJVf/zJxuD6vXgeZH58b2tIgN45GJ1ImYR++IbL
	VRbKjxLaGqN0N17gIIX37vRjzC7UOZ+seB+tdwRF8b8wRkLzha3GexV+NVEH+eFIJOBW8S1N11d
	gkXmFV+jykfflwVAlx5ywXhMM0BdMJqFZmqGLVpba8zTVHoGxUEWAjGvCc36fnIAPQ6VzltQL82
	S2VaTGaiE4naE/xcghXyfWAsVVfHN8rA==
X-Received: by 2002:a17:902:ce89:b0:2a8:7814:47d0 with SMTP id d9443c01a7336-2ad1749829fmr30161265ad.22.1771093239295;
        Sat, 14 Feb 2026 10:20:39 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:20:38 -0800 (PST)
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
Subject: [PATCH v8 9/9] thermal/drivers/exynos: Fix some coding style issue
Date: Sat, 14 Feb 2026 23:49:06 +0530
Message-ID: <20260214181930.238981-10-linux.amoon@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-42659-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 367D113CDD4
X-Rspamd-Action: no action

Fix several coding style issues reported by checkpatch.pl to improve
code readability and maintainability:

- Remove unnecessary parentheses in sanitize_temp_error() during
  logical comparisons.
- Adjust indentation to align function arguments correctly.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47b92c84ae98..f7f604230cfd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -252,8 +252,8 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 				EXYNOS_TMU_TEMP_MASK);
 
 	if (!data->temp_error1 ||
-	    (data->soc_config->min_efuse_value > data->temp_error1) ||
-	    (data->temp_error1 > data->soc_config->max_efuse_value))
+	    data->soc_config->min_efuse_value > data->temp_error1 ||
+	    data->temp_error1 > data->soc_config->max_efuse_value)
 		data->temp_error1 = data->soc_config->efuse_value & EXYNOS_TMU_TEMP_MASK;
 
 	if (!data->temp_error2)
@@ -536,7 +536,7 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
-			cal_type ?  2 : 1);
+		 cal_type ?  2 : 1);
 }
 
 static void exynos7_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
-- 
2.50.1


