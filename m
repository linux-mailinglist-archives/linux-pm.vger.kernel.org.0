Return-Path: <linux-pm+bounces-42909-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/MH3InmGlqBwMAu9opvQ
	(envelope-from <linux-pm+bounces-42909-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:20:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A86166211
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66655306078F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEE323406;
	Fri, 20 Feb 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="BM6nE3bq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3331ED88
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579158; cv=none; b=HAGhPOAAILc3r6wGZ7TKuCqwDfL966EeeYkyLgqo6ibK5MnS7Zva6+OktKDzRHdstEfd07k+L5YxmoZIEq9HqTfMfBMnm356oqHrInQeLaS0e01kIowxfXg3OmeYwr3TmYUxJRN3o7pwwGtIUn1I3YmncWfZmhVceUFS5xsBKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579158; c=relaxed/simple;
	bh=YivXcgaeSy4QpelRV9DOtIokhuwXBYKEbFlVEzS3lpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQskTDUFFmPQARmbodb/QWzD0ijMv+x5cNYVcPF3woHnKPsuE1gVpRqC3djLch10EcV1vahZ2KdlJobK6H3TsH4akvk7GKo5x3MEDuZ6i47JJkBRSdD6YKsKNdpP/ebOFn6fLFdmI4uEexC0y8WppWZlADywekvivcjLqb4OvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=BM6nE3bq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8871718b00so300660466b.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579154; x=1772183954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLnypLVR9kDKeATjKH+xrFf0kQ5EEkkXkqVAX1JHxt0=;
        b=BM6nE3bq7abmYjj4dSmVPfsbpiNDKCGYSUeEEz1/ZfdMsZ3pvu1YYezJHlXCuanE7o
         B8bUCYrSj4Lb2cRcbFvoKMC2EhnlggJAV1ha+XeuP5Fte0pZyI/IR2+5fRL5GzoQZLKo
         iGwRxzX12dyJKB+AUI1LgTL76Z/nRYzdbkOGNpTAnyQZEBx2HCIqwP3Z2TfvTNERRNCr
         Xp3w3GaZjtrK9Jd37tSA/t6TAlOasgVTv5D9gz876pwPUiRFWtOseJZB+QRg48kd9PsW
         JDUfyV5EfpPMF3qtoiu849btB9JyJm5qz+43t/ouqJbJKpSavlhV/tUfdU8/EqYn+i+b
         zb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579154; x=1772183954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLnypLVR9kDKeATjKH+xrFf0kQ5EEkkXkqVAX1JHxt0=;
        b=BiTNfq5MbR6h9cX6wmVJIwMBVmUdYXuuZZ3/+VK6wRuuRN5d99U0OahluviHIxXdG/
         8pwMu+jAiphe0wmsrWLkUjCeh29ICHYYuKQHSWjAJS119isbwNIdDEtN0ajtDxbdjkU/
         11BI2ZWCCLm1yt3Lca/mL5WI4hcYizwht0iRtF6zkGA8xMmjUUe/O1N2nON0inLYW9HV
         +GyaPs1eWpTDGYNhPuLScrN/aoYq5APsc2WSdbGNoR/fR5qjj/UkQ3fRoI3crrC8Pdxg
         FuNoedjkGgF3fVBDtO+TIFkQAILulIKB3IwCw9bXXKMC46CEkf+91gycnCN7FPKM9SJD
         sLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeU3nGdUPl9BZRaM5H1Nzt+KuwfZe/xPIPmUQA/Y7K0zwp+UcxrSTYZoInCZVpgQS+SZrnFsGTHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTwWtdPIPkqGCA0F5g0Zrx9dbvvJgEOcraSkO+Db9OGvt2vRXc
	6ddfRUNHR+4pKxV3aIWMpznblgTxUyRVUKgFY3bFYjzxYkAc1Vzo026n64Nc3iz/P2s=
X-Gm-Gg: AZuq6aKa86GkoMadkKfsvMAyBiugLobhKaMhtYgODBfIh72jTwQ+4xYFD4mFirH7RbK
	z9vhAkNxvJD4f/l7J74qqHlVmVzcC1CIEG40IMaWiz8mtphMTUIIOvNnuJlNW/AiEbxazyd5KPk
	L9rJkERmL1i8ecN9P/rJTBhCiGh8kqLDGb1YCIBYrW1L5OQe36s8MyKiTwj2A2wejaPG2af75C2
	Z8YUrD554d1qtgaAWnXLd96G7aPJC34uiROi8qcKu8sqcjIs22lZnxP4Py31xOencIJUewXFyLJ
	FyoJNU7TN19HTFYcJBT8QBOKnmVO9bRmczTq3NPAqEHGvGxXJXrgQAS+yQyJLoC2NPpaClg9TxR
	mEDec8M+Ot1/zZ3aXHiilfPPof0C/o00nzSDR/MaFW5ocZh1CxA68gEwLXSEIvA+oz+rtNiuw1y
	D5/VU1OKteC8CHcBqoPlSlZ/DuPO2VfWQWwBPuZVQz/Uoztv1YWPJbFAlUsuUb3AymEp2DpuSlH
	UJfYA==
X-Received: by 2002:a17:907:1c13:b0:b8f:a033:dea8 with SMTP id a640c23a62f3a-b8fc3cb0063mr1256153366b.52.1771579153680;
        Fri, 20 Feb 2026 01:19:13 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:13 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:07 +0100
Subject: [PATCH v2 3/5] thermal/drivers/generic-adc: Allow probe without TZ
 registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=2004;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=YivXcgaeSy4QpelRV9DOtIokhuwXBYKEbFlVEzS3lpM=;
 b=qWYp7BdWMKuAhoenfEM06j8Q/89bWGGCajKBj/3ld6dfa9CRhyH0+n0CikO8ZiIZiFZpeKwzw
 Irfto7/gBVzDLJtZTCfThE3vEpXL8m+GOfcstnRd4K7t2IcaEUXOXw7
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42909-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:mid,fairphone.com:dkim,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3A86166211
X-Rspamd-Action: no action

If the devicetree node is not referenced in a zone under /thermal-zones,
devm_thermal_of_zone_register will fail with -ENODEV.

Since the driver is now also registering as an IIO device[0], allow the
probe to continue without the thermal zone.

We also can't use gadc_thermal_get_temp anymore because we haven't
necessarily initialized tz_dev.

[0] commit 3762f5851ac5 ("thermal/drivers/thermal-generic-adc: Add temperature sensor channel")

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/thermal/thermal-generic-adc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 7c844589b153..4852e584468b 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -86,14 +86,16 @@ static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
 				 int *val, int *val2, long mask)
 {
 	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
+	int iio_val;
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
-		if (ret)
+		ret = iio_read_channel_processed(gtinfo->channel, &iio_val);
+		if (ret < 0)
 			return ret;
 
+		*val = gadc_thermal_adc_to_temp(gtinfo, iio_val);
 		return IIO_VAL_INT;
 
 	default:
@@ -197,14 +199,14 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Thermal zone sensor register failed: %d\n",
-				ret);
-		return ret;
-	}
+		if (ret == -EPROBE_DEFER)
+			return ret;
 
-	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+		dev_info(dev, "Thermal zone sensor register failed: %d\n",
+			 ret);
+	} else {
+		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
+	}
 
 	return gadc_iio_register(&pdev->dev, gti);
 }

-- 
2.53.0


