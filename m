Return-Path: <linux-pm+bounces-29087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FEAE096E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B841A189A614
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CFC28DB4A;
	Thu, 19 Jun 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5NbvsIW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168428CF47
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344931; cv=none; b=d75bXzv/EEp/d20VW3jq6iZgwf29pPBCFfpBYZ/sO3cDlqTTppzTmrJBFhMgFJ6P4xqBTqHHoSEC6xqcgSUl3k6bLLK5I5A6/ATZlY5epDJiPi/JX8QwokJ1+xWNDyeMEFyQ7SaHBGvn0WFlb3DxlgyznKWAUReXxwZS0MvlvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344931; c=relaxed/simple;
	bh=4C4/BzYVvqykLCWqBbtexksZlDrp0KmcIoZ0MxhlLow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aC/btg0ncIRa+PG1QsJHNOVszY9nLwM1L3gndG11UdGESlPBpQfm5rGutZOSHevr28r1XsvESaNdTRxdbh7Ro1K6Ylci0/PNnUl3dBb2wQEyztgYz/D7GwDZqdZCJxI8ziBRRJSxtc5C/bEp01gX/s8/wGrNkpmRfbksffVa3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5NbvsIW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a589d99963so903105f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344927; x=1750949727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiY+DVkF0Tx7wXnhclKSYzhcL2ot81tRcGxMxTU/GtI=;
        b=n5NbvsIWZM5mNmIcMxSGObHD4oh/+gSoVWheGopgdWuJXJM8a8YG9YCISaLYypmqYo
         NmBMjnWFzU6LfSv2R5f65UljTyLoqEHddG2CFmaj+iXt9oSQW4Cdi54l599H8GIP9Pe0
         b0gJNvI5ANTlTZvClbXjzKfpcnGUNEq/zepfHDSWKkajV9v9UXouc3yfHTUL4A66aT7w
         Gs7DY5c+JNtqSVVgTsJlhFmk0RblKTFAQC1R6jMEL76tIZ6d0UAxslSj2U44xqd3j3BT
         /ycPkxWGFN3Fd9MjsodMRG9L/Bb4lxOQ7rXk/mYGIB8TLSwr7QMKrkawqImOo3oId/ib
         hQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344927; x=1750949727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiY+DVkF0Tx7wXnhclKSYzhcL2ot81tRcGxMxTU/GtI=;
        b=DrrkNdcpdMhf+yhgDrfHJW//bfQm7EykG7mNLMlm5jiJItbO/igNRAx4U0+OjWE4v2
         RU4Fq5dU78rcaTZTkGBbeEMnTFF5rvmxh5txrueWOgQ2WGESPsxEYPkMU6lbbkA+Cll6
         mEJoYGtG6/1ueF4C+jwYhPK8OwTMpQCjijZyXOxmGaKjGsoB3Cd5GaeuoGzNlDMGdaoS
         VGE2aaFxtxHi5WaLCgfPnj9FUw8eDKurxExulISYIiWKxLnAVmcC1Bb9n708cAASZYfz
         ktOfDDmRNHtTdTt9b7HzRBdofI+iUJJjZJIoSLTSgx4KmZTa56q1OyKl6dtcmWUbWzRv
         wFZg==
X-Forwarded-Encrypted: i=1; AJvYcCVnT2ZC9Mb9vNmi8BZ1y0zgH8DrjdSd/2l1vjFib5ye3JEG9q4RN/Mwm4t41SlgzFWHVOzxZriW1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGOG8AeZfEk0akweV7kUXuxPMkHl9ek4lnn1bTjeYr8PQJr9Y
	WUx12slXhbjovpH5Eb1jdppCgOEt3sht9+8fuGv+T4Dy+07YQjzm7bOBq1IFONnY7Rs=
X-Gm-Gg: ASbGncutvivhgqK9/XddU1f5hfSLzaSYM0SI5qY2aec8q8VjReJivGh2BqnIGAVSgrJ
	QvuwknyEVLBZe7ysgwM0LgYgTyVKu1JI4Ggntm/SFqWAY2oTdse7zyHDdQFeeoDWCp1uRpT9E5A
	hmWuPl9uODM+0zFb25q+sxuA3GP+qZ06J9y+W8lzk/k1qLKy5Im2SVaBWym+hId4zaqzTu1Mta+
	Kl3GN7lTt3Gx8bDQF4lwQXVpBKCJbswBww30fEYZQxI41CZmpsyeiTHk2XUeGnZAiRTODj/fOlQ
	S7cLtecDuDbbmFGwpddl2s03q+MGuWTpOhqy7axcfSRYFuSZTQYAOhDqOwbjStqe5OjufDsPBqe
	+S2jJPIPXqy0=
X-Google-Smtp-Source: AGHT+IGgc5GkhPO/vj3LU4YDmcm6Dit5qWlLwjFG7XrsUFfqD8cTmVzqG/+/ie6nUOAJEDHqELYGwQ==
X-Received: by 2002:a05:6000:2c13:b0:3a4:ef36:1f4d with SMTP id ffacd0b85a97d-3a5723a4c09mr18760617f8f.38.1750344926745;
        Thu, 19 Jun 2025 07:55:26 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:15 +0200
Subject: [PATCH 07/11] power: supply: qcom_smbx: bump up the max current
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-7-ac5dec51b6e1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=4C4/BzYVvqykLCWqBbtexksZlDrp0KmcIoZ0MxhlLow=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTR74CQMAmQ7VTKPiBk6x+W6w8QNhr/qM/SB
 9TbzQLsqpeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 tjg4D/49MaTCqWbRpdaxNKlfjLtTNMq6C9Bn1so6q9lsEIryZcn2Ooc0TMkBNln+4horde0iNNJ
 X2/ofIrJou53ToJo3p8nVgcm3F1V7K1kiEJhuaoAWV0huFC0R4EOn5MGZq4Ezs9o9uz5XiP6kQx
 30i6f1fp0lsK1b9qFAP1JZGD3T2NYJOxNc8XhC5EOk03Rc/dHZZSgP+R8MLtTMo6kMCH4HevBg0
 QJZICJVFDAZcDJ+bDGgRLEf9ra7byCHf0xJpavDa0tGQzbCJ41HvLZBRe75gm23DF3vNEtrRcXh
 1RGcDK4tSecPLWogN9JP5uhg+791eX4EO3JatzB3IMRdqoBRqvuaTH0PHhUfDcdhxF32Jo7hBvU
 O59D+1xqoZZXiuu0HNJvYeAj7uqXIMzrvyRcTLBsw+49l63f6CAoj9tQ6l7TE+poi3X54VfrrVo
 50EIra7sk997D/cIaGfbrwA6DFvQfCCqDiufIl9ZIN43wPHH9I6Zbc9RhoWaiUaOZ4yZsFkrWoJ
 fs5cytgISNmqKCoPkcbYPTr5vNxwNc3YbNmO3dm9bWtiBVWof9hhTZWSwuPYIde2Gnhd3C9Fp3c
 8miD0OTi7H6GIaYNv6++MWsbUn3bHavXZ2wKR7kw8Es65a6jPDAgFo2eKcfWYeLDPiP9LF0SPT3
 U0dZAP3PMslLCNQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

I set a super conservative current limit since we lack many of the
safety features (thermal monitoring, etc) that these drivers really
need. However now we have a better understanding of the hardware, it's
fine to bump this limit up a bit, devices can additionally set the max
current via devicetree instead.

Since this is common to smb2 and smb5, move this write out of the init
sequence and into probe proper.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 7fc232fa7260a7422ac12a48686cd7d396edd9a4..d1607674d291d6ef5762d35acd3330e2116f41a3 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -875,16 +875,8 @@ static const struct smb_init_register smb_init_seq[] = {
 	 */
 	{ .addr = PRE_CHARGE_CURRENT_CFG,
 	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
 	  .val = 500000 / CURRENT_SCALE_FACTOR },
-	/*
-	 * This overrides all of the current limit options exposed to userspace
-	 * and prevents the device from pulling more than ~1A. This is done
-	 * to minimise potential fire hazard risks.
-	 */
-	{ .addr = FAST_CHARGE_CURRENT_CFG,
-	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
-	  .val = 1000000 / CURRENT_SCALE_FACTOR },
 };
 
 static int smb_init_hw(struct smb_chip *chip)
 {
@@ -1029,8 +1021,22 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
 
 	platform_set_drvdata(pdev, chip);
 
+	/*
+	 * This overrides all of the other current limits and is expected
+	 * to be used for setting limits based on temperature. We set some
+	 * relatively safe default value while still allowing a comfortably
+	 * fast charging rate. Once temperature monitoring is hooked up we
+	 * would expect this to be changed dynamically based on temperature
+	 * reporting.
+	 */
+	rc = regmap_write(chip->regmap, chip->base + FAST_CHARGE_CURRENT_CFG,
+			  1950000 / CURRENT_SCALE_FACTOR);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't write fast charge current cfg");
+
 	/* Initialise charger state */
 	schedule_delayed_work(&chip->status_change_work, 0);
 
 	return 0;

-- 
2.49.0


