Return-Path: <linux-pm+bounces-29091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88EAE097D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 17:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0503F1C208FF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234FF293B73;
	Thu, 19 Jun 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlHJ+7f5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEA28E579
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344936; cv=none; b=DDEAVekVowlnjzFLjxKSmqEN0ToEtb2AzEemmKPpvz0bonawahULC0yhbQxfpZ+ANLqq+aU5nXZdjJeZ3YxTnBcbg3NBONQ4kX8A8+rzC1VIStfs+p/OCRX7uYWRN7eB292E+XAGgoCfS3UrHP4aEoyLolqS0ZZCwi5xu+inK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344936; c=relaxed/simple;
	bh=YP0zt4hpy/+QohBC/5B6cnpj8boqADRBumXOjSIf4CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8WtcGSznk+rliYuy7D+5V4IVFo8t27xkom0Dzn/U88iSRApQJrzsX3sMYMSyk9U0nkU0oPUVd+wTK5NfLf5UzLEoDHO4hTMCD0GfoWdJQcKITK/m6ZqfLdehksHKFTM3ziWRfed7jbyqXfCXLld08E7TQBlBXL1dyqbbIFis80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rlHJ+7f5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45362b7adc9so2101865e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344932; x=1750949732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBJGB2IFTRq6tKiBkTAUGMtzlXPxtbC3+kWone/1CwQ=;
        b=rlHJ+7f5KSTeauWalJ2t90BaHdHKQAgq/lrvN1OtMXUkzgzfXBj0twZqp1ydbVPvXK
         6jt7L93h9gr5Py+g1wh+n6BUzSgbwL0xWxLEthvSb/J05W77sN0/I6sTWlGKm1GIIayS
         jjCvfW+0N4k2ejoAPCKmyLwgyUJ40SFf2DPvBapzubjeExQPSSZN6Z49ceM470QryrAj
         FoD6as8ZoCLX5KOxEE4TtXE7gk+tg0O6TfvIbR7cG/SrkwyqdEnV3EBFOEipZU3InFzB
         2cEcEydeBfTY2gm4tnc/QE3U140ZikfTrRkp4pPgI8F1SMHRLpjj6D/WQOJAvA9+WNw6
         n32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344932; x=1750949732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBJGB2IFTRq6tKiBkTAUGMtzlXPxtbC3+kWone/1CwQ=;
        b=uZK1/gffF9v/X2xJJCjD73NBqVNvDO4VALCrizOktprLmjhTYklSY7Liu0mYXnwR5y
         emwiDArsvUXy1J1uUD555AKuCWtM9AtDxW7pYoUeysl6b6y18ZOK1M3q57FkCtXYxxMj
         kEDgs0mIOcn3QaxrrexQBa7Jl1FL3F6f30jekqNmY9xi3upgBCf6DhvgmJ85dQoxTeh5
         QZ+x3kwTM3F+RgKXifZoVxs2MOoYa6ip2uiAXY3JeVE28ne0cdD04J8Zm6Gu29VPrZed
         iwrIz6HAFWOpQetZAWZb7lD8hDlFsKvnSdl1G15U5404xenn02+oAuHA/vofoQ6hAays
         0Uzg==
X-Forwarded-Encrypted: i=1; AJvYcCULXQDh0HTsFglC8lR9MDJaAPIntzy7Ex1Lp6mc8dhdrHcjoXHyyDismknFJogkzQyXZv4XDilgIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4j366gX4EcWP4OTsrmJRb4k6TFFYdBYi0R3ODpMTT6xqa8Ut
	CrpkqzUesgFVUMEZ9aivMZED6F1GicjuDy7iytvQ3ynSNrf8e+fnlKqzWco9tBhgGl4=
X-Gm-Gg: ASbGncvm3ifIEg254JBOqH+/ly7x0YrdzRVhqynorUhNuCpX6CWQb972lD0+gBGnP/c
	RTU3V5tqFipMrnsUyRFl2Qvq2C90bzeYAqgJLG20fEd0N8GDUU8iVUzC9KyuCZK1nEXhNhfnWZ8
	HuS1rClbrBXnyGxJGYEWbEcpp2eJ+YDMpQahv+9w6RQKVscbQ1I+PUGCGkmqeak0s5DRX0Vu8hQ
	u24Ld3AQt5PcPU6ap0QTXzHf55W4+piJQHIANrJWNoH84CEYTJiT9NT0cO58cioP9SekkvvK5WI
	cPdGtg4PAPahIfyOSJXFlzyB5WQyw/awBZrtMTnlpzZJVwwFWaMmgJcjqyWeAsWUMF7jWt2AHbI
	PwWw9ccuZP/0=
X-Google-Smtp-Source: AGHT+IEpgGoxp+M5mGhGo5r5ZpYgsM8+xMnfypnt8FDho/UvFufoTJ42LhVuCalDv5DlLjJTI36G7A==
X-Received: by 2002:a05:600c:1c0e:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-4536039db67mr27292135e9.14.1750344931932;
        Thu, 19 Jun 2025 07:55:31 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:19 +0200
Subject: [PATCH 11/11] power: supply: qcom_smbx: program aicl rerun time
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-11-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=YP0zt4hpy/+QohBC/5B6cnpj8boqADRBumXOjSIf4CU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTSy356L9shN5c24CVtxUhXn7Isx/OY3glPA
 Njrh6FHrbiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0gAKCRAFgzErGV9k
 ths1D/416VKScj4SMjUY0dv9PE8DXWzElEj6lwhr74bkfBMEyXyWErzFcn7p+c26A0xyw4LPSli
 cCXOvIZdoQrrxI8PDRNaZ73fzrRNgtDuzLxwCrfXcQRiCH9SO0ieiIRI+5fPXHdEaoEI5Ann9Dx
 CLlkOlVjDNm66reyGz6UwnEC/tcjTxQotB8YSymDjsECxum0T7XNMlUFVz1vfyrC/nDNhqbhOGj
 X8fZPAw5aYA3X6f3CmXSvRPNU/7x6RDVwnGTEpJxwn7mPxFq8cb2nTOje1WHK1m7fQN9E5xrAOn
 LkpPn2Eipam0XOjMbZi2nBaFevKkBndswNwCzPAl+WvGwN410CGlFlMkKFDU/SYnfnzeeeOTImP
 SOr96Q7my98Y7z0I2muRuO8uRZXiELIXPDSLowsQpo+sbZJecbb2Enn3MJjcxDetCJqW/+kZs64
 djtXTLk8GI5HiMUeg68zIT47TZqBTOxvcnvvkKiRfDGuRaXPLrAdqLuX+/1MG3BE/xunB9bQBfo
 j7qcLS7tknMx7AKLUS1PxopW3jBf7no8aur/cdd12ZDXXoGkdEETI7oNC5v+lRE9KCGXi4xlWpU
 Altxv4gCDNJCGnPAZUvq6yRsaE9lb2NXIWSrS4MsBjFA6P8Bxvk6awFpy24FFDhGe+Dyai0qcBD
 e0wbf419TZNGD7A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

We don't know what the bootloader programmed here, but we want to have a
consistent value. Program the automatic input current limit detection to
re-run every 3 seconds. This seems to be necessary at least for smb5.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index d902f3f43548191d3d0310ce90e699918ed0f16f..b723dba5b86daefb238ee6aae19b1b7e5236fce3 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -1091,8 +1091,14 @@ static int smb_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return dev_err_probe(chip->dev, rc,
 				     "Couldn't write fast charge current cfg");
 
+	rc = regmap_write_bits(chip->regmap, chip->base + AICL_RERUN_TIME_CFG,
+			       AICL_RERUN_TIME_MASK, AIC_RERUN_TIME_3_SECS);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't write fast AICL rerun time");
+
 	/* Initialise charger state */
 	schedule_delayed_work(&chip->status_change_work, 0);
 
 	return 0;

-- 
2.49.0


