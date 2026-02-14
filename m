Return-Path: <linux-pm+bounces-42652-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N1hJtq8kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42652-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:20:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEB13CCF5
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA9D43008D2B
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C32DCBF4;
	Sat, 14 Feb 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqFX+ODh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B1299950
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093195; cv=none; b=ih9nMbhv5D36IhkwOSk0/gVVDPdvIH1JAQbeke/DEZh4j/8ML8QW82awg5hWkofmKctyd9bMrif7AiMaJ+ipxNluz9lI4gAcEaZgo3kx19ZHLuSKOVxtxiIDrWj9ay/Vt6LwrU+wMCp8P57rkffVyYCDnTpxy7U39rSQRf34+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093195; c=relaxed/simple;
	bh=pErvtY3ihK17Sb6LHbdNsewtgB3895221qeOyAaYxy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVcEORiwVCET5UT4QvIQdajFPPEcfXfGxQupiXUa3MYzJi4zqmZ1/eZzgud7cM6LH98tqjyAcKOQxePQNtsDAhc+mecmV9xLOdO5bP3+do4QyZSGU7YCApTD3d7pcD6jyJoOlJ3wAljAV1x1u4Go9dVZq2eSe5nNmHU3Jv3yTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqFX+ODh; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2ab232cc803so9070715ad.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093193; x=1771697993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af3N+2yRmzcUJywzp/ZUMgm21c6Xt/FcL9OpDD1I9wg=;
        b=KqFX+ODh2sbu4S6ALbYF0n3BXe5Q7aTS7KbA0tI4vUMxSO163cd8gLFaYcdIbsdu/1
         Klxua+Fc3QK98dP9Qm7T48tpZhE734vXnnNFVdnTQ/d6XigMh7cNqd+ERV3mILf9D+gl
         g0ft1T5aCTwN0xyRFyU7IONAyd9Z47haiPq9FGI/q0BR8dLyNxlXmdXsXyUnr5w49+U4
         i4Yc4GgzrdSfEq9ybP2x0oQtY+C41yzLKq8AuH22j4AG5i2PR/owtlTPVkLgVAdj1A6X
         E4ky7Q+uXDRn8oJqkYsNJzKfO0OzKNpFlPWeGqSdR/DlYwihcJH29eTovw0zqCahIe7M
         CXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093193; x=1771697993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af3N+2yRmzcUJywzp/ZUMgm21c6Xt/FcL9OpDD1I9wg=;
        b=UdjJ9hJbIIZODCh+1ZMM4wW4muOTy9FA8yypY/GjLWW5+cxKrfwhcRDATakYohdH4G
         evPtFsZWO1pJuwws4DsZvMU7nFvaNKrQ97rXaS3waS9RnlRiX5Gk74zD9NQhHRYKYqr5
         u8T5Oc00nH4R5VJkFoi7D7TwLAhrUSymOtzTCEKGNqlpvhqjpGTuwWeLnke/pDqrWTbx
         TBU7kDib1cMQmbSHwWa60z8lJ4JCALhthDXFxqKUOlS3Ow6NH9JdDlQLSpT9N0Bm+wiI
         hux4GJuwXNGSKdnZDYOq3zZFErIRpdvD7589Uz0LWVY75lfw1IN1JLvL3Nl1rvHkoUO1
         m5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtdO76vRswIGnkFwkLcQAeD7DDwHsP/hZgXO1kZ2O/Eo/w6PpN7x8v/0T+nfd+Ah+lcuCQ5U2m9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXBQHfn3juvKcZ451CRZYWZohu9gkXVAh/ZdixplcQbI/ri4p
	VuRmLCQwqWm8dxTQjNSzUu2g8b5o1F+53FzA4RLLstuYspSl813Jal4g
X-Gm-Gg: AZuq6aLuJbK8/AVZoYGTo+TcRxjRJcpBYNigDWp6tvhDS2Q2ZSRs38EgEV+69Mbsn0H
	DTUiQi3q4gXLfl7wC+nTaSplvnlzObeESWDlgqnqvp061nn7d8g/6CTCTkJhI7i/yJG7Suy8PcQ
	52SgP5ZV9iQOuRn+W2FNqzX0Db9gF+L9uLhzhdvbL8/8xVnK4Da1I+ahFtpgrGa6mbeDgaOqGw6
	0DGhyGXxO2TUpgnIjVLwaD8IIUl101WRMEl0KY9z/04rXCPulz7bT7QzB2+SuQbxgrk43X+xrFc
	m2cYK0/cBxRUiU0kAA/cWuwHdmuxEabvH7imnwjuMGH1+Q8fhg6kxHHa9SvAU2D8f9lOf6a/s4K
	ZmcUuJMyhN/LLqhPJw3WdECL0f5E5g+bdZCCChy1xFCEW9F6ive+QCYwrVwzd9SYhNZ6stDRCuZ
	2qYV8SjVaTEpHUTHowx1E=
X-Received: by 2002:a17:903:1ad0:b0:2aa:e3d1:1438 with SMTP id d9443c01a7336-2ad17431b9amr32756855ad.12.1771093193179;
        Sat, 14 Feb 2026 10:19:53 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:19:52 -0800 (PST)
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
Subject: [PATCH v8 2/9] thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
Date: Sat, 14 Feb 2026 23:48:59 +0530
Message-ID: <20260214181930.238981-3-linux.amoon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42652-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: BDEEB13CCF5
X-Rspamd-Action: no action

Use devm_clk_get_enabled() helper instead of calling devm_clk_get() and
then clk_prepare_enable(). It simplifies the error handling and makes
the code more compact.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: None
v6: New patch as per Daniel request.
---
 drivers/thermal/samsung/exynos_tmu.c | 77 ++++++++--------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 04517d52afbd..aa0726b33c84 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1036,65 +1036,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->clk = devm_clk_get(dev, "tmu_apbif");
+	data->clk = devm_clk_get_enabled(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
-		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
-
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to get clock\n");
-		return ret;
-	}
-
-	switch (data->soc) {
-	case SOC_ARCH_EXYNOS5420_TRIMINFO:
-		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-		if (IS_ERR(data->clk_sec)) {
-			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					    "Failed to get clk_sec clock\n");
-			goto err_clk;
-		}
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to prepare clk_sec clock\n");
-			goto err_clk_sec;
-		}
-		break;
-	case SOC_ARCH_EXYNOS5433:
-	case SOC_ARCH_EXYNOS7:
-		data->sclk = devm_clk_get(dev, "tmu_sclk");
-		if (IS_ERR(data->sclk)) {
-			ret = dev_err_probe(dev, PTR_ERR(data->sclk), "Failed to get sclk\n");
-			goto err_clk;
-		} else {
-			ret = clk_prepare_enable(data->sclk);
-			if (ret) {
-				dev_err(dev, "Failed to enable sclk\n");
-				goto err_clk;
-			}
-		}
-		break;
-	default:
-		break;
+		return dev_err_probe(dev, PTR_ERR(data->clk),
+				     "Failed to get clock\n");
+
+	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
+		data->clk_sec = devm_clk_get_enabled(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec))
+			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					     "Failed to get clk_sec clock\n");
+	} else if (data->soc == SOC_ARCH_EXYNOS5433 ||
+		   data->soc == SOC_ARCH_EXYNOS7) {
+		data->sclk = devm_clk_get_enabled(dev, "tmu_sclk");
+		if (IS_ERR(data->sclk))
+			return dev_err_probe(dev, PTR_ERR(data->sclk),
+					     "Failed to get sclk\n");
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize TMU\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
-		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
-		goto err_sclk;
+		return dev_err_probe(dev, PTR_ERR(data->tzd),
+				     "Failed to register sensor\n");
 	}
 
 	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to configure the thermal zone\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, data->irq, NULL,
@@ -1104,30 +1080,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 					dev_name(dev), data);
 	if (ret) {
 		dev_err(dev, "Failed to request irq: %d\n", data->irq);
-		goto err_sclk;
+		return ret;
 	}
 
 	exynos_tmu_control(pdev, true);
-	return 0;
 
-err_sclk:
-	clk_disable_unprepare(data->sclk);
-err_clk_sec:
-	clk_unprepare(data->clk_sec);
-err_clk:
-	clk_unprepare(data->clk);
 	return ret;
 }
 
 static void exynos_tmu_remove(struct platform_device *pdev)
 {
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-
 	exynos_tmu_control(pdev, false);
-
-	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
-	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.50.1


