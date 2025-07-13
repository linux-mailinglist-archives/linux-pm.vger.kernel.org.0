Return-Path: <linux-pm+bounces-30743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C1B02F7B
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2AC17D48A
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9E202F71;
	Sun, 13 Jul 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yrzg/RZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D71FF610
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394005; cv=none; b=HgQoUtAM88T/q1d1a0p4GD6qchnB1YmhsfUi8fdExiVAz2HnN1ujZO4ssRk9ha+WX6l9qhc8LSi3LZxvOmgEbBPJTPoGfmPmeNxBSR7EggcMw799DySWLyaHYDEJ20o/Ml84ec8i/GNLGXS5TfNT0cLdOxDoDwIo7VG+gs7lF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394005; c=relaxed/simple;
	bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH5UtS3E5TH7XMC3+L/NmShIDJ64sXe+CwTAbphAtJyHK7Ut5WD3W4OS4tvetu6Qquk/DQobu0klQR8cUeWUyfXmoeAMIf6qTWYCBXSDAZOrFSXThWV0IvGp/FEGWGd74GgDUO+PJ+QnsTJ0LcgN8ZQKeyqyTHFkThzfhAXWcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yrzg/RZS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so4680865e9.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 01:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394001; x=1752998801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=yrzg/RZSbkRCAWDNuAre/ZMEHVwFjv3P+GTZ7YwKmqhwz1U/ldqpMjXeO6cwdnMOaU
         iPSgc1nJthruNehCsXOtSuQWw8rHRyeciTvxrnt/vhPP527EA1v8RqqKjsJVcgT2b1dz
         GNvjfxWp7MNXlHMiCAkxk86nsYypGD0BgPVHpXsodf4biaCOpwgE2Ss3/WxHnQB55r5U
         R3AV37B2j2HY8h18JbYzT2pJELqfPuKfm1YZm6sv/Hk2BdTbFSOt09ltWmodaPYFvfAF
         JzTu9h1Xw5w9RJSPZRHKDOE+epZQIlyCjyaki9vyKFrkZfLB0BHRLrGRHLQvogk3tGA3
         88uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394001; x=1752998801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgf1Do8YljBtD81sfx5m266n9gTHXW+o9sPsSEgzP8Q=;
        b=vQytubIXhV+px+VYHDDUXyr5DGapgTtzX3gu/vrg/iCS64taNHcTYedPYrh2qWGbcC
         vuDXuSHW2Jkui9uvXGGi/u4pL5xe8rJ0YKkQz3LR5U/vtg+RsRxlGAsZppi7YZUlL487
         UFHeQto1VstIjNDATmS3tp2g9OFcaRa52P4EWBiccNpYH46uOPYyWH/YE83txAOlQoIH
         rULyvZyhU3CPiv/4Nd7NIvzqfrRgrLsXRdPu43HlE4QBcD2atHhKy8HFrDL2V06QPpL0
         amV4eDnuTnFU/czGgRrUPGfAwxz4nHrtxow3OVMn7C/ao3CkBUsyNLqMz8wlwpOBcvWJ
         NnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg6uiRjhaksg49FLIwnnRtU3uGNgSgqouavtQ8Va9gtBWgPl+9DhpsYMA0TdTemnFAjClfBlLtbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfrJ4iD/LvR+vnsH/WgYWYG4LSyffb6asIfIj5lPZxTykHqX2A
	bsjxGjfH0BMHrxeEkbfpLfs5P+Ui71/2bIuhe4L77dI2IWjKGvsD57UNuo0SaBYm7dw=
X-Gm-Gg: ASbGncuM00ocdijsXCpJKhW0fgI8JA6EuuACERuagNm0PxGDF2e7QszorDmNsX+auKp
	eMiyDMoTlul+r1SbxU7eT1fDZfUE1EqZFL7brEOuMy0w5LO43zu7TP/M/XXWIU6kDTnGaJCIUOf
	mwM7EFQykmnGePrbUZFHgF4KYz5g92XAGYBJPFXIUavXE1q4LMDEfIWKFPGIAkN2l+5Mi9vp1QZ
	UcgrvNbN8xwDRaKaBwFdB9LR6U0i0Q/oHR/ZBAsHFdc76LxY/a5Gn6RAPCHzkZouqRFGmcX0TNs
	eTJOkRhKKUJ5/PDSzHZKcvTzzmwSxB3VOdaj/uytcu7iM1fDzvfcVubkxo6XcVVuoAgcDuCbLVy
	bZrIOzyvbYAyGcagas8OLxgiht/p8c7+O3cjd
X-Google-Smtp-Source: AGHT+IHyWnqMEVpaRvOXMO0vblvM86y2YgLw6BQSvoG4RgYbH/Ui7SAEt4W5s37bEA/xrCAo7hGufA==
X-Received: by 2002:a05:600c:3f07:b0:456:15a1:9ae0 with SMTP id 5b1f17b1804b1-45615a19f78mr8952975e9.13.1752394001510;
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:41 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:27 +0200
Subject: [PATCH v2 05/15] dt-bindings: qcom,pdc: document the Milos Power
 Domain Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-5-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=844;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=15ZIEjfNdTMtgNXBiiZtGshrEuJe2UKgX3LhuQVRQYU=;
 b=XFV7UWYTfrWv1RcxcWxJVUHuCP5Ysa43LHrg+BrPBDS/KgoKimDYxgTjN9ghI3i9G3ovnwPgG
 q1r+xiIEV0UBYOCual5XEBtwmgOfedsf3RrNLH/7nc4A/rgd1Nrjzie
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the Power Domain Controller on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778929579ef9b3b3206f075e140ba96..3f90917a5a4dd9d068ec472565f5009690ea2c5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,milos-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

-- 
2.50.1


