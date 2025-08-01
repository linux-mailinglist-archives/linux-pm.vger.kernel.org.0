Return-Path: <linux-pm+bounces-31735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1ABB17D83
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C111C26253
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63321220685;
	Fri,  1 Aug 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dB87r9ua"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73621ABAE
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033331; cv=none; b=cmKSuwDv7zcW0uHmlaINOvGv/761phojmCdwr3BLgLECyU3veAeugjFA+veielXn+7LUqm6q18O57P99G0mg0QMzoQotUpOo4aTx/Qnl2oykd/9oCxI3mh4eOW1RUnJXW+zoAfnWsqj9Xq3iir7zCYedUiNlqhB2j+hERJIbcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033331; c=relaxed/simple;
	bh=CqrQYPbngH4gLmvaALqLQbhUf1mxtvza2ZZJS/+cKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqe8jPxj9VWr4jO4GOxxL2C4jyrOdcKJAdPruTURBywydYlh+Ubt3RkgXIZ6mB9KzeAxu1S0prSCdVghXmmkAwSvj6xDOTAFiJ2EVqaWtv+KA2WRwVTbB87mkBuKWs5wzNLFAston6eqZoWbJHYAU/228ktjysyOcNJWqKtoxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dB87r9ua; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748d982e97cso1157462b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754033329; x=1754638129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpEuo4BDT0PzWNynKyWHN573No1LAQVNOfN+WCfJMR4=;
        b=dB87r9uahyGEtgCMSwZ7ZU3bKSyCc6wwySGN3iUT4GI/UDle2iRBu923NEjgF1+Vle
         B2xlF7RR3Blzf0vHCSlAGlEmfAVFpVjsm23TwpmKCJ5j9RagnTAB1F0oZc5MQ8L+y8ng
         Lqxtvy4NkPnb+WSxyrSUeSORHWKD60YRF+3P75Apm5rlsUSwb7zpWMQCDDG2gcNmqJjY
         WNXF8F81kubzyLYxZf9mZUFgeQzNPaL3X3IZuYlL0NwyHYtQ38+4TuzIOK8yVc9veaQU
         CoSQOC8Kkj6JWn7Rgjkj4V9enXtAIkD8kR5WnfTnG09OlsUHRwwjoRwIZvBu8QoeOs4d
         6UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754033329; x=1754638129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpEuo4BDT0PzWNynKyWHN573No1LAQVNOfN+WCfJMR4=;
        b=Uut6MrQlE7/tP5BMi0EiiZOhxC4I1g2lruZjWc41RnfaBRrTi0cYpGwMysA8sWu5dZ
         QlAc9VtNrPLugaOaGu0nEaFF7f1WUfFi3nqNj3E2s2F4CqhueuavB/BPAjcG5vgrBC/q
         y1ScmlkMfkS2xrx86YV3gqDWzipb1SfFSfsHV81iBFsxapfKnwJiLSghYGEWoiD4l1k8
         UHeTck2JFGpwlmJdZ4vGA16e4i7/XS0UDwAMEOakWTJZVGg3kgyutgJz4iSMLV4Oy6LW
         fqx+FYYO/uYeLFpM06XF59nyDhR4ek7SJ3CDSzkw01wMNpqii1y75TREMtudtTQKOLkC
         G9AA==
X-Forwarded-Encrypted: i=1; AJvYcCWQOtHx8K3iaF7PT93vXt0lrQiboVP0x0FsH+7DAnAys5jFgx8p6htgP/VZgUmWwDmCfCIrT+15mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkmz4d85FCv0uxrOM+w3oIfu+aCXDbtgNTl/8jaruwcHO3CRta
	VqfogrLdu2iYe5/yjgp2GNwFuauFsvS5l2nQeI1oxGvE/6SuCeHKwabmrHXT+/m0f10=
X-Gm-Gg: ASbGncvd54BI7fdF6YsMQAzowMGcwUFpzEPWynjzXovB+0cP1d7LfJ5BoXyulrNRbAH
	lD3FfRY18P1GaeSinuRvfUqsp1eS///fxYpArgLbT9sCaYmvXQ+qztWVLQAtnwD/tAPo6SYWQY4
	6H0PWjWRcKD8X/pjyqcUzNVj4q0Z+bMSM9s/+gEYrFS3wE8RB8ILK8s7AG0ilQL7qxqHP5pFIu0
	R5Fm3KupHNQjRZGCkvJO56M3sd1xDV9Voqd1Wm6ujvJ4VHS9BgzF1wcqgbvMBHl2vQ07aOyKMFK
	6WMhGh4zgoAVpFPQ91fPy9nfBlXqaFusz+vH/LPRKAsDUELVKXxiuyvbuwYXKSuKt9toBpsGDcZ
	K2hiVsVaAbyxeDxOfujbr57ivzlqYXDTKzg==
X-Google-Smtp-Source: AGHT+IGSdX0UyQUNm5XJ/ZBNM/4/pg1b54fM7m9r5KZvvoYq4sBygbeHXrF0rtDWYuflNPBaXiwwJw==
X-Received: by 2002:a05:6a00:4648:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-76bdce7e38fmr3006512b3a.8.1754033328877;
        Fri, 01 Aug 2025 00:28:48 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm3362367b3a.58.2025.08.01.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:28:48 -0700 (PDT)
Date: Fri, 1 Aug 2025 12:58:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Message-ID: <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>

On 01-08-25, 12:05, Krishna Chaitanya Chundru wrote:
> Can you please review this once.

Sorry about the delay.

> > The existing OPP table in the device tree for PCIe is shared across
> > different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> > These configurations often operate at the same frequency, allowing them
> > to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> > different characteristics beyond frequency—such as RPMh votes in QCOM
> > case, which cannot be represented accurately when sharing a single OPP.

From the looks of it, something like this should also work:

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2af..0a76bc4c4dc9 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2216,18 +2216,12 @@ opp-2500000 {
                                        opp-peak-kBps = <250000 1>;
                                };

-                               /* GEN 1 x2 and GEN 2 x1 */
+                               /* GEN 2 x1 */
                                opp-5000000 {
                                        opp-hz = /bits/ 64 <5000000>;
                                        required-opps = <&rpmhpd_opp_low_svs>;
-                                       opp-peak-kBps = <500000 1>;
-                               };
-
-                               /* GEN 2 x2 */
-                               opp-10000000 {
-                                       opp-hz = /bits/ 64 <10000000>;
-                                       required-opps = <&rpmhpd_opp_low_svs>;
-                                       opp-peak-kBps = <1000000 1>;
+                                       opp-peak-kBps-x1 = <500000 1>;
+                                       opp-peak-kBps-x2 = <1000000 1>;
                                };

                                /* GEN 3 x1 */
@@ -2237,18 +2231,12 @@ opp-8000000 {
                                        opp-peak-kBps = <984500 1>;
                                };

-                               /* GEN 3 x2 and GEN 4 x1 */
+                               /* GEN 4 x1 */
                                opp-16000000 {
                                        opp-hz = /bits/ 64 <16000000>;
                                        required-opps = <&rpmhpd_opp_nom>;
-                                       opp-peak-kBps = <1969000 1>;
-                               };
-
-                               /* GEN 4 x2 */
-                               opp-32000000 {
-                                       opp-hz = /bits/ 64 <32000000>;
-                                       required-opps = <&rpmhpd_opp_nom>;
-                                       opp-peak-kBps = <3938000 1>;
+                                       opp-peak-kBps-x1 = <1969000 1>;
+                                       opp-peak-kBps-x2 = <3938000 1>;
                                };
                        };

The OPP core supports named properties, which will make this work.

-- 
viresh

