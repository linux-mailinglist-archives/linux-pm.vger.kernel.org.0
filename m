Return-Path: <linux-pm+bounces-29085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260EAE0952
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1F41653A0
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345C28C5C0;
	Thu, 19 Jun 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXV+9nc/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48728BA8D
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344927; cv=none; b=HZ2xQ+2eTIL8DQ/ODzTpbMNKLgPb+oUXe6beSurdEPHSje+E/lsOGZOwLNwe/4isUIGQAe+OqJUceoHokQmCV/nG8fBhxSJ3LHlwE9zXI7kQY1WhVTOfFGhWeK1EIBLZz4IvMT+ldwFfmzAGZm8eEdf1zg0lQOz5WDqOB4mPyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344927; c=relaxed/simple;
	bh=5zLQjefFl1xoVe/hjAGrMynvu2zXA+YnEoPsGjdFfEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+7xWuewSAKsalHJsZwiSnezKDREzwdMJLe9ElZThG/rQ4TcQTxKviydtS12X/nTURgwu8jbjW0Lm9UpDJbIuz1J20Berjp5czUmIuS9uWaft9iNp7mW/AvSJkr9IUCgkjM7udEt5XS2ZoYpmF6BoS9kxW+h/f0SAwRB6egnhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXV+9nc/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso573333f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344923; x=1750949723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLzhodFNjkX+gPU6aAgcbyZ8ijaQa1ht97PNw+na+88=;
        b=LXV+9nc/vNCVeHlWGbgbDdZH3dLqOuPng4aK846sesQD+tVwCDrEbNGd9GY0iEbVAM
         iTcVa17ToqJL4kH6wmbbiwNvOzRPJ5xWJCYH8+BnJ1wNo1tIa9tTtLcr8Klxsncsx9Id
         qXIkCzAAmfC7m+rfBXJOzT/8XamfD+VSEP6h4geTYMWotij7lQKMeRaUWhNxzsWSKR2n
         Q1a4jHXwZU/FT3wqqRNw3P9yqOOm6rjlo9k194gEwt6XT8b/qp8rnfbL/Y+klom13g5R
         7Ns3KFD58EuMQntKt6nzOTbNCeyr3iim41oXnfRb95gqgf6FeTGkEdvYlQ25Jna0W+0m
         P8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344923; x=1750949723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLzhodFNjkX+gPU6aAgcbyZ8ijaQa1ht97PNw+na+88=;
        b=eCe48udR6HrytC9/KickI294vnwL1pcnictgxHdVd7546LJ6dvS/S+Zd30zykS0Rem
         eFfZMOUHQUC9CqwSsWTLZhYZvQD+W1hEag6o7gMdTXR1JFG8yQMT5xWVF9ApAnl6e7LE
         oa0j6IH/bPENoEFlFLZ32zKprlrekH8f6qem42Nb13PvYpF+TEQvIXmpwmKNrQTwDIkr
         rEF9Q/lWQ69KNdWdtA8AqDEwdi7X3TiN1RWke4VyI2zQGjfgfmRvNvElvsA/9PZVKrLq
         Js9Rdy/AYPTQEj98xOj3SD0WUYjrdTAL6t8bbg+UFLrRFg4I7aVnINIAcSuVaP2eee/2
         1WEA==
X-Forwarded-Encrypted: i=1; AJvYcCUQCg3K6+g3s58I+yoYdf0sybQJqneOef0J84FUFmz011llR7/x/D83nzqeyWVQgI1wD/TwDxA03g==@vger.kernel.org
X-Gm-Message-State: AOJu0YziMfx0Gbe/qmPmFkN92zHCFGwwxmF+tziIYKNrJHbp9O0ENOZE
	yUsXiohN84JG9Ihh0d3vN7r846FNd0SbPNjyKfcFLbVfVgV0xyk+A7pdxlVNUjOPhfE=
X-Gm-Gg: ASbGncu9ZmHGvMmOZk1btu5oy62CIFS3lUIPPuWzNbxKACS9+o8edlHDOKFeZ3ypPz9
	t3Fr2dGfruceGlYmkwSxeLfgHdyZfBZxFktAkxYVJmLCvlmGXZwhqaUyvT6Y9CWLZSRgeHWg25H
	zzyUnCbqP/y4y2TETGae9jlIq47Y1pQoB3QaSyHezQArQ3DnFqdnMnByewYmHijgOQQAESCakUG
	A25csqTeQs77XgQa1GdNxHM/kRbX5p2xmTMK5TGvROMqmG/86pEIT2/Jl8hDClemrstdw49mK4V
	RZXY6eJoHMLS/k38BRg79Jw7MSy1Aq7t79W1Jl6bmz3G3lASzU3SftiLbNLsZcdZwT5n6kUKLKm
	1kv2eo2Tym7I=
X-Google-Smtp-Source: AGHT+IEDxOs2fv0eODh32EDd8cdAU32JALjDJpZubvkYuesAwi2i9gcqAOAB2Ga5J//4M2trs4Fd0w==
X-Received: by 2002:a05:6000:210b:b0:3a5:8abe:a264 with SMTP id ffacd0b85a97d-3a58abed70emr6303048f8f.37.1750344923430;
        Thu, 19 Jun 2025 07:55:23 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:22 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:13 +0200
Subject: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=5zLQjefFl1xoVe/hjAGrMynvu2zXA+YnEoPsGjdFfEE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTR5g7afOe/JLNddLPQnw8+CLIW9X0RRbizc
 AD20INQzGuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0QAKCRAFgzErGV9k
 tr3SEACdCNo03bzqVOxk1mrxOgrONtYGGJjUcXqLvWuPXcJs2Dngoaq/Dg3UvuhGe8oGlZwrD+I
 Fzo4PwcBuIqf8SOc9A/MJsNyS7FJX0oYJrpNI/ta8TSk0i32NTYFCpVtmIRPN+RZ3Fpxzr1uzAL
 sqHS1LXrjlth/+XJwkdtPyFavnmeKl2MiWY6GtsC/UVNaVMKLtjA0UTv7icN/ozvlSxNhKU6tEU
 UoLYtPz9Fqwp5QiAKn847s/tKxODhKRYFOPYA0rhB985tOyhpHkYsCk+4IPIwAczS4snyPa9uuB
 YKy5vRvAT0lsVAd6Vh6UGyXh+ZXIZjXwpibHxG4yRqGSsS3qztTOfeJ/C6bXLEZ6i16fx7cwZaF
 V/9yRpXf5Aj7TTyBq8C3mXogqE+hn7RxSdnGW+PTlwKxfmzY0LQam5UY81bxoZ8ZzcNa01EP5Zf
 +kkcNaaVJ3PPSpcRRsVP7UXgNotlvibEA8VFJmQnh3EqmA5Hppn3XJfHoe+BmNnOp8h/YRfH+n4
 htj80jTZ3GTFjCOgH7wUAOiQt28xTy/QUPfcVWIKaavS4SKv40NQpof49aLlY2ArkCy635xjTuL
 Z8IcsmPymiw1jJ1zDNie+RbE6ONBiA4PQ5Q1qAx9yNC5wu5AHv2/5UsRLB+v2rk8SztZdJHlvo8
 /lcBkraryspc5oA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Hook up USBIN_CMD_IL so that writing "0" to the status register will
disable charging, this is useful to let users limit charging
automatically.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index b1cb925581ec6b8cfca3897be2de5b00a336c920..fc2a8e20435639a9da4d966c43271beaeb57a03f 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -692,8 +692,11 @@ static int smb_set_property(struct power_supply *psy,
 {
 	struct smb_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return regmap_update_bits(chip->regmap, chip->base + USBIN_CMD_IL,
+					  USBIN_SUSPEND_BIT, !val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return smb_set_current_limit(chip, val->intval);
 	default:
 		dev_err(chip->dev, "No setter for property: %d\n", psp);
@@ -704,8 +707,9 @@ static int smb_set_property(struct power_supply *psy,
 static int smb_property_is_writable(struct power_supply *psy,
 				     enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 		return 1;
 	default:
 		return 0;

-- 
2.49.0


