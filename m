Return-Path: <linux-pm+bounces-1182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7AE81399A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1883C1C20B65
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2168B71;
	Thu, 14 Dec 2023 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmxIajsw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A9120
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:13:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bee606265so9040038e87.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577631; x=1703182431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMx4XjMEUXuFYA5pBx18NGkYFcvy16oralmVb/gOmdY=;
        b=XmxIajswJcFXJA6CjCTt/SIx+EnQ/Sk1L7t+9xvQTzWOM+4vx01B5F7nYqL35QJIYb
         Wc6s+mDrRb6V/NgsT6BUxTjAWesM7tSO1iqGWqaZxDueVCwWwS8CJ++V/TJHac6w6y8q
         JT1EYuASd4Eokhs5kt4DaSCRzFEgBBn+54NvwsK5skVK4WgMcGrajmuk7i3RgDX8KWhL
         UUkcdPWh57HvYjcSvbTihs/BYZNned+A13RgoHBmHluZe1pTVYoAqne9LBNXLEfO5vTG
         40PfbJQ/e3e9Xj3uruXBxo1vbnG6agc7W08r5K3kzFs8+OKqPiBuZE7GkkmIvjVbHmDX
         3plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577631; x=1703182431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMx4XjMEUXuFYA5pBx18NGkYFcvy16oralmVb/gOmdY=;
        b=tTGskhoGKXwuDq+inVPP7W6oY1UDWJkXrBDSh0i7x0iYQ3oLSenPOnv3oOlbYY/Adn
         zTKdIwrj5UKCNC+iYuO8EQsdLC+oE+nOGqSqK/ae9KmjWdUrtf69It6LjfM/egmEWzZv
         KLrOV5Xgc/WItiWCKZVLM6rhm/HuOlaQ4AUOGOWRdrN7jSIHs83fCU03qJxjcwUrk4pa
         +VHWCndUOn0B9fSO2XiPwdNsKsWu1bpMu43n6YTpDK5/m46GoWtHf/DloKCKnKeJ9gri
         en8UqUbQ/5uSDb9AS8dvD2xGcZTOqfazrWrvAQjpSDvcndbxCPi2rxos2erHH2oEDWRt
         t2Fw==
X-Gm-Message-State: AOJu0Yz928abB8SfxUCHwE9ln0km48+NuA6OWHFdys/oxu6vt1iZ1y+H
	Hiz6PUJBk89ArluRS7crZhWP+w==
X-Google-Smtp-Source: AGHT+IEu9dXQFBaqMYJ+X69RlJ4+zf3oIcdvrbMBRHhbl71TJdITQrXpgbz1sLqSWFMJZE916w9O+Q==
X-Received: by 2002:ac2:428b:0:b0:50d:ae2:2a9f with SMTP id m11-20020ac2428b000000b0050d0ae22a9fmr4280323lfh.24.1702577630824;
        Thu, 14 Dec 2023 10:13:50 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:50 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 14 Dec 2023 19:13:39 +0100
Subject: [PATCH 2/6] arm64: dts: qcom: sc8180x: Add UFS GDSC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-2-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Gustave Monce <gustave.monce@outlook.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Level: *

To make sure the UFS controller and some relevant clocks have power
flowing to them, hook up the forgotten-about GDSC.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index b857959a896b..09b4e66367bf 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2110,6 +2110,8 @@ ufs_mem_hc: ufshc@1d84000 {
 					<0 0>,
 					<0 0>;
 
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
 			status = "disabled";
 		};
 

-- 
2.40.1


