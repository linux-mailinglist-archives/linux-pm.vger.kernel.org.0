Return-Path: <linux-pm+bounces-16953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4D9BB55D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC794B2392D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0D1BAEDC;
	Mon,  4 Nov 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1P4W1pq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC81B6CFB;
	Mon,  4 Nov 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725498; cv=none; b=Y8ZbAoil0K5jvuxSmE9HpenU6/lFidhaE1JUTY9/mGx2ra0IlOjHM50QxX/XGJ1bUNjUXHKaDaAF3ohKz9E6d2ZWQaBSKFHMud/hdGaL/GZdgKYYWoGnNYPZPg8c8bLHI7ux2GzhYF+ZKS1HVuEtCP334SEif85r5a/07ShqdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725498; c=relaxed/simple;
	bh=ha2WREfzZnU38hHV4Af6RxNYtkwq0CkjUcQzoBg1APg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKRtjxpUm5VuYvhGN1PYXWS5JhX7K55fxGfcS0qJNRqQXQYi/Qyd3+UKIvTz8H4AtinWKnDkwWEsatM3dv0MoKxINJaAgqMedp8WtNGsTGfz5IVmzJs6JRG3RkHEpW0KQ5Gw6IrPxwN3jP59R6wE6NRO0DUOpRaiBbzphxhiNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1P4W1pq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso2475443a12.1;
        Mon, 04 Nov 2024 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730725495; x=1731330295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxDDT+8gLPpTmJ64UxTQbFfD25Hh0bkUgNP3CfG2OQA=;
        b=l1P4W1pqYgdf9OlAMpZ/ZObSiiP6wfxdBFrccraHFRuqqHJfifB8HPDxSRuqgr/17Z
         F4R91JOkCV28FYF+oQ+xcjpA4TyUkI+j9cVy6vUAvdylsW1wPhpQb/ZZGAeEhEkMahJR
         xhqeXL4WdMQK9TOU4WEnSFazyh3vMauUiZy2qazkCK43iENUmuEjkjYXavPj3scXv2Rb
         FojnOaJJ7Ef8Kbnc7TAK1J94ofiZNfUsbn73kKR2FTQpsY6FYd0pECZuIjl86TKbEejQ
         ivvfPNXF8C7zpEczjsQsNq9HLTOrkD4iTkexoxuVdn7sYBFuj5588zN+KgIXKgsgzzw7
         KCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725495; x=1731330295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxDDT+8gLPpTmJ64UxTQbFfD25Hh0bkUgNP3CfG2OQA=;
        b=EbpWq+u4NmSR5DT7MNlXikeSzpC35LJpWxvosfbUlSLUyHQxu5K3XlBR83AQHwzU3v
         DiDCMOdz5+8/5BohKNX6XOB7rZDiaazbcdsj/pnxClZb+MWVVGf4KgBTeOCL7BAuuL6F
         lJ2Q1/MNnDA69KHhWI9zTtGC/Cjgsl0j3Ty03RRbELHSfHo5GYB+8OElY/2tgtXrSCD/
         qZwP/3sg+QVHnDFI+tHl2tEGkpThq6gGUp42AqNH0T3xDISAYuuIOu2krxNu1LY7/I7R
         UJblcCB2KBVeJO1xnIPBcSkq4BU+qMcqz9Z9jYy0pswW/EPwkj5VI+Ov6RCSjI2mu2Hj
         Ezbg==
X-Forwarded-Encrypted: i=1; AJvYcCWDqVWf6LZ9tWMZI6CEsCwYy9vVTf16R9EGc5Q8zknQFuyI2rpgH5O8rO7SCgzG/Fs0nz31XdKj/k95ZIzI@vger.kernel.org, AJvYcCWRgP7GfuTjcyYzs/xGv64iWpjL7Xu+MJXLYKJkMsIlYgRHj0dmEKO4zbcU6BcxcfqXbWEw3uf655/D@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxVZURGV38i1tDRGxFERoFvVx/V4bYzBpSq7GIDSYRGH1s4l2
	uvsiNTR2SlFr9c6ezEhL+RYFWnaNH2vW0lXucqjRx212TANahAycctw1ZA==
X-Google-Smtp-Source: AGHT+IF419jDf2I+AZuj4AKg1Lcj97Eo5N1PyxPAp4Cxa/RIm/npxXlbdxE5kunK/+FcBjtEF38CEg==
X-Received: by 2002:a05:6402:27c6:b0:5ce:dfcf:7029 with SMTP id 4fb4d7f45d1cf-5cedfcf70cdmr1086411a12.7.1730725494601;
        Mon, 04 Nov 2024 05:04:54 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d58sm4269628a12.73.2024.11.04.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:04:54 -0800 (PST)
Date: Mon, 4 Nov 2024 14:04:52 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: sprd: Fix battery-detect-gpios property
Message-ID: <993f4a485d5c8b246d4a8c128fed19cb5e500cc8.1730720720.git.stano.jakubek@gmail.com>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730720720.git.stano.jakubek@gmail.com>

According to DT bindings, the property is called 'battery-detect-gpios',
not 'bat-detect-gpio'. Update the property as such.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- actually fix the property, as per bindings
- drop Baolin's R-b as the original patch was incorrect

 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 12136e68dada..b8e70c337d40 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -97,7 +97,7 @@ pmic_adc: adc@480 {
 		fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
-			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
 			io-channel-names = "bat-temp", "charge-vol";
 			monitored-battery = <&bat>;
-- 
2.43.0


