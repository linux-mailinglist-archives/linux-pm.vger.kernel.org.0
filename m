Return-Path: <linux-pm+bounces-29475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81820AE7CE9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334D016EEA2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329F2E0B52;
	Wed, 25 Jun 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="qQimaYIy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F072DECB8
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843395; cv=none; b=kAtRTsdgRAt0nHMGVxooIzpRnoNeCjPNO7p5k8gx3XS1aWSXVOiZWcp0xiTfyKx6TXEFuw21NSP5Wi4zw+nL2M89jRF3WOQ7A7rbq/iOQ5t7RavsmXDM5bZfTYtyDZGRvSr1WB3xcfcLj+oiiDlPFlDIQL3Sm4Ye6CCnuvsCSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843395; c=relaxed/simple;
	bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvFXTiAw6RjhL8lqrQugVZ1frEw/LW/zqRL/xub5c4XLE/U4Gu/oq6xZuKzZnAxjl5gaqnlRxjsLOZXJEd433enWEVXS+uVTau4f8UR79/6EYOhCVzhbsYPwI5r9Czs9FT3/COgVyaoocHOQHurv37KizaZB/QoeLKr5ZiMN+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=qQimaYIy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0c571f137so76918166b.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843390; x=1751448190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=qQimaYIyKlpWXgEyXsJfceYSlAiWv445eBYouhKZTk7GRDZF9NDZI+OORDr2FZoiMG
         QK3B2iBxgNv1QEToOJK2HOSn6ultvfEnrA+AwHWhxmvE4PR/DC3iR2Q8ucbzR/yvxV0k
         X+I9erIbTIcoq20/bkchLLRiou+5tx1VLUrqGHwseFFH7AoXYnRQ5tqtp3mHH+9aweno
         dz7ibgia4pGRS+EV74ziqinpRJObnfXvyY3z43I+b9vIowcrNIXnQbF33k0rYiKA5aPS
         znj2Dux9yYKnUw4R399gnDhvl41G0C1z62gkeXrkEknJsdMaF4BaViziEs9mkvJmFglV
         SgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843390; x=1751448190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFtr36P+rCcWPRSy5N2MbhYZaAtcWKoXHXQTaJufVVw=;
        b=ADIOIW0FGWQ+wsg2S6zmY2wYOfA2xG1rCDnT8W4LsFBcVKNu3xo0kmSfkzQq7sxUAm
         KToWs5+pkWmoySKTVgmnEJ+SOU2guAVvzrIMoUMtWH47YaNi2anm79k6uojpvnEMlilI
         wgC/OjVlJe9ci749VYI9WsZO6eaqZt8IvE7aj4W5NLRh1GcZOD7ZrRdpwuWJiTfN2j9I
         /XbX/DxgN4p3my/gipnK5B6gQ87bhpcSRlMEksEg40oxJGVXc4VL6SZ2GfrU2i+Irwm4
         D8gbB2Fzq3m3NiTZg1K+HjHnyJxLm5kqIQ3+rEexZo7lTLCBTrytHdfUXx4aFjvzxc5Z
         cPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3N695/R1KD9HEMYLl8iR1swqdFra8FCEu/LtLPCv578wttMbKbTfcsRJlATASz7H9r4VKWRIEGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwABNyGJGA3XNBKDwTsmUJlErgmSll8HSfgcxSwRkf+fCsL7w6O
	57Tz/0HOrKrY+GfaFSGwE1l1x/m0hFE6DiUz62UOz2pGMyUvGn4chITy00JZw6Uq38g=
X-Gm-Gg: ASbGncsjVfQ1yd6wF2E2ANYeIHqFjL9YBBpuzotJHJmltqTgjUfvyCSC2DZvGOtU5VS
	6f5deRCTEVCOs/cEUWqOBrmxJe+Ipbx2hiHDTnGURGH4trb54yJYcJkV5u8FLubXAet8tmM+K4A
	+zDUovhKmo+UJGvBlGqW+pdnCQLa+dH5tcXarvLBOwo6+aJflfphiVswrqeoaqebMEDhFEXWbzA
	XgRKPralvqBOg3VAy/oNCC4p3eAkS4aJMQEuwbfT+rTaPsBOPzGw2NpGujoEaunD2HE+TpCKdRK
	+pvfKuK7Ib9aO6pEGdGb1kUoHaDvHy3uRGK75o5lNDGcu+emeLhc1FXATlohuyQpDbqGzmzRFvI
	q1EHcSuyND8gZlhaYntR8atwtcb1rUx1p
X-Google-Smtp-Source: AGHT+IFJ9o4JWl7lIDkFxyVHQOH8cM1/pOAHHQWQqVQ98/eGA7Vc8alvEQuTG6jNWUZwYJgy53sTvw==
X-Received: by 2002:a17:906:ae88:b0:ad5:3a97:8438 with SMTP id a640c23a62f3a-ae0bf1b4c54mr195255066b.41.1750843390328;
        Wed, 25 Jun 2025 02:23:10 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:22:57 +0200
Subject: [PATCH 02/14] dt-bindings: cpufreq: qcom-hw: document SM7635
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-fp6-initial-v1-2-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=1256;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cHqszQuBCaVtspU1t7iOjEc+5vwmG2p0Bi0y4m/DFOg=;
 b=kCR5siUeapo7dxDWp4dWExqPF+lGnBc97GFA4dxfQD8XoZ1lE5aOP6CJT2iAzeOSwdIFhC4/p
 Z4uY5ayq4rUBb21sP5ZjkiYsj+KLEC4ZuYf4Q18vGbyiwI2d+IWW6Oq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the CPUFREQ Hardware on the SM7635 Platform.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index e0242bed33420a39b8a8cff4229ba9eee994ca30..58a2222574e57a8f9c114f5fc3f0aa19d9794965 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -44,6 +44,7 @@ properties:
               - qcom,sdx75-cpufreq-epss
               - qcom,sm4450-cpufreq-epss
               - qcom,sm6375-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
@@ -169,6 +170,7 @@ allOf:
             enum:
               - qcom,qcs8300-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
+              - qcom,sm7635-cpufreq-epss
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss

-- 
2.50.0


