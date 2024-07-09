Return-Path: <linux-pm+bounces-10873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D992BA5D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD64B2883FE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F1176AC0;
	Tue,  9 Jul 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBlF/JF0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF716F83E
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530015; cv=none; b=FudAFNyoOvc/kS6xv+WB7KIAjSsRO6DaERhPLip+logo8+yAyE5vNZzpnDVZ5biTfINAu3p8zJ321e+I2zH2LmVK0MXTy/TAaeerUUuecjK/xKsDcfgUwwo0bs44Dwu6Ay9BeV+sF/A9kHGOdipnEvhX465zsbWibIz4G7fg/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530015; c=relaxed/simple;
	bh=5IfasFFY3DfwFwXO+QTo+29xzLGaIOqvgBXD6dEEpag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffGUI8sERmBK3kYAjXoPHsJB84GThKsUfma2Wac6fk8epXlsDGOKoKxJH/e0jlz7F5jnMLzCDd2/HON5/djS8ibHcGLl8CrM1sdMQ0zQo27hOI2OfjhyRU8CtBFCPsJX8IQduZPOtEYwNY55NOpUEhW3Czjf+s7mSBg0Jjdk7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBlF/JF0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so6121848a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530012; x=1721134812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RWLQls8UMaDFCdMRrldbSCrQAHJtmCuH0F3BM+9gso=;
        b=VBlF/JF026NjXBl6Ph/NblzNp7uJP5NVHTs/PMrh2E1TOhwqjlLqgsvyhA7pZVIIYQ
         uzkOsp6oGnzWlzcBNhSieZA5XKIXE/5Hr3U9zA8qeyEsDnOVJXFUSglvccmZU//UPVp6
         kzSWUWZsoJY8OH71DmZju+HPpgLL/Zf2mcSktdJmjfPp0NFeZPvYzuqChNfkpOJm1Ez9
         H9dkuON9PKnfVRdcwthUjLDRxbw+e1Gvlnr2SRSOERuRlxgLVWyoAJy4BU55PbT7+qqh
         m1uE7XOZ4ZaJYSLQ+/EWyrj8je2lm2KVOi86REUMN6oKL0F54fE4d00dnvuW1dLyqyIl
         VBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530012; x=1721134812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RWLQls8UMaDFCdMRrldbSCrQAHJtmCuH0F3BM+9gso=;
        b=fO/LKGhsVbFCgUkIrvI9c81hBEGAfoLeenfq5zGNUkshE4Mv7KIxT5cCs0jMhnUUT8
         jJW1hhNvMutMdCgr6nRLlF3/d890EnwI/FU4MbizEUXpYZ/uHL6OD3k/A7/k4IepgG5Y
         jx/hcLacXrd+Gkyf7HFzrw0OO+2HIwmKkOoGBvgp0NekzEytBVAFwatEGv/fMxLD22eb
         wkXBXRiCczK12krwmz3CEaHDkeAX9/aihC+RlR5KE8WDW4PwJ9IiuVcvUrQznM66+/59
         owvBILmCeZf+yp+eiqKwKqUHrc5rc6JJTyEZTLxN3cYo9T7mI5mXGUmWOcgHI28uby0E
         iwQQ==
X-Gm-Message-State: AOJu0YwQkd/2TrWxRmJL9+JnpRmmEV3loDZwQ8UQkV/ErAgurc6foivl
	LDvNqCJeswie34woZRh8dSgCQCjPMkorugIJ8f7n0VvhU45qYbZ5SG8IIOo+6i8=
X-Google-Smtp-Source: AGHT+IFxglRz/Z5T+VfCsX/knJGO7KuIZUuhmH15yka6InP9OkfkQM7bbBSdAh8pScc3pequE2wBPw==
X-Received: by 2002:a17:906:6895:b0:a6f:718f:39b6 with SMTP id a640c23a62f3a-a780b6b1818mr140960666b.25.1720530011696;
        Tue, 09 Jul 2024 06:00:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:40 +0200
Subject: [PATCH 10/12] thermal/drivers/qcom-tsens: simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-10-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5IfasFFY3DfwFwXO+QTo+29xzLGaIOqvgBXD6dEEpag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTREx8HXAlALPSavSuuehlkOZw7wYt7TltXug
 BcAVDhX8R6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00RAAKCRDBN2bmhouD
 1wUmEACGBJgbDwCnSdOFOG0UyK4a/q4rkg3R57Bwxj+JAepNmOkUzQPiVQveWtHqDxBbUYj9zfX
 vOKb/EKrO0f+MWilnskaKaVfllMwrCAsBOs3lPw7GpwEst8xe3ss+RZrVhS5FI7474zjTAhQ+1J
 J5tp6vCxsg8fL3GkKDB/DmAHDNojB4kmAjBCkNmmswkzFlGRMRzEjP/8vkziDz69+Dg34UhvVsu
 jfAAeVOwpXB+4gzioghBrp1lW7nsghBQsc0QXODurL5K7CX4bEVQ7ZEEeOj/2Ug/Z8JnAKhS8h+
 h19BaLIC5si+YuZ4D9DNLfo3yiDZOQWoUubij+Dlvn/zXRtzAsaeBfUxwQGzI2EMPuCqotzS9sl
 4QDYE3nHKah6mramxKTgnNIr/WXgM79N3qz8k2uTNQVLY2khFESwvrsxSLsRKxUtdI3SmZivv6B
 axMeFJyKOtY4Hvfup8JWAu1dYeF3KY9rSYC//n8Ho0l+aRbkmQasKC0ZJ7Q6uynJfYYTZUzd3yJ
 TW6dTT6R+HvfIwlEcRm4iLQmKVfKTVMpvVgpIC6eFf8B1mlBQgU6awT8nGy3H9iF/zScQ1lqjjO
 UxBnAS+lCWkHcheXC9YiZPskR0Q7VnSezb+0IQFjSY4qb39j1bLd0s/itc7o4hCUJYQTJnpw7it
 gmMBEdcuKixzSCw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e76e23026dc8..0b4421bf4785 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1336,11 +1336,9 @@ static int tsens_probe(struct platform_device *pdev)
 
 	if (priv->ops->calibrate) {
 		ret = priv->ops->calibrate(priv);
-		if (ret < 0) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "%s: calibration failed\n", __func__);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: calibration failed\n",
+					     __func__);
 	}
 
 	ret = tsens_register(priv);

-- 
2.43.0


