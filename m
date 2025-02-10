Return-Path: <linux-pm+bounces-21620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C7A2E36B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3521887F33
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F44170A2C;
	Mon, 10 Feb 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIoz/at5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F08F49;
	Mon, 10 Feb 2025 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164407; cv=none; b=KMSK+CJStYYnYiJg4fX5rTUKPtSUILx3biqollSyjtGlwyxI6ryZk7avOYZmnNP7drwdW5Y0AiT3M268GiQyck1YOON3DjsAB7ILCuR+VNULYMd/GCovn2UgZ6xt/T2wVaPwuQoQaLVxMnfHpBkabNQGZpIeuqcbGR60PmOEeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164407; c=relaxed/simple;
	bh=Yy3r4PsA3UNf/B+n+73OC53paIxgA1UuvmEBApzbu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IurBglFYHNybY6p/GxvPo2O8r3ejyf0FwPF4z+jnfBXOeQDi5rVegbR0gChhro/AT6qWAyHgJZj8YZD8xvs1TivCjnRv9e7q762U3AITvrmLd7V+yG6j/cMtVmdZc538xN+OcYC1cgr6ggLSX06++RptAGVvv+FlnNrj3xjIOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIoz/at5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4718d9dbcd3so12713551cf.1;
        Sun, 09 Feb 2025 21:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739164405; x=1739769205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agclTjP7fEfHE9ZbA7+HDdh1UA82ZmbjCh5m/2fX0Tk=;
        b=KIoz/at5hanXpNnsPT9RZOhKGzD5IeLWYKOfWx8RQMcakPpAm9YLKP7bmFpCkfKFVx
         0lqsAdHA/AXjfd4bhBF1JgcwwaEdypJkWJIpiJLJFrGjC32CA+QGi9TjAi8URHyNNsLU
         VhXY/kXqtDpUGVd1VUhuOwIl7kFVHQz2T0zSutdXhAKRpVSgA2lKsEfyuoBEz5SlGMKc
         fwAQM9C1JyQ3qasO9/iu1S0MXbitZiBNRa7h4HbBIpxnB2PWIQt10cilT5Eq0eOTt521
         sMXQRTJrCvbsi5qWR/Sc2oRiYIiDxaNn4AhrrohMH3SGL/acQTXhOUciUmIJL/vysKZE
         Dynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739164405; x=1739769205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agclTjP7fEfHE9ZbA7+HDdh1UA82ZmbjCh5m/2fX0Tk=;
        b=G+Zd7teDoAwNbDAExYpfhS8Da3lPKjDRN1NO7dCFavawE+9idTuyP49G1j3olxJglk
         0YTTtOu3C66cEImd+JQfEMTyGLwCaViXwXDw2luwIARa4jOJ2lXdEgbOAfvPBE02LgJb
         u/ikUSpc6DC0d5wDzuPK+yE5RrW+c5KCkYmptBkwTXAKC+apX4B4FlircVPTOxQR3xU1
         bmuekMXtfagL+0gBjQKK1CSk3g6XO/EeAiDsJtO3WE2nS1iAvbxU9bTuBSfpf8QDuf9n
         CAZKJGxaGQbFKelPLyh214HPvCmOQQU36PdCRQ8b3u/iM2D8nRewHtDSnAeV/IRWRuOJ
         Xgvw==
X-Forwarded-Encrypted: i=1; AJvYcCVmQzWGrZJB0t+nu0V9kXpawhH5A1UzCPbzrtjCdst8AEzCoyOAYsw2jerQeLqYYWY3NA9XBLae1KJU@vger.kernel.org, AJvYcCWuZnJjju2ajjde9wBORYQDxFRlI5RWQKBfFLIwnqxI2bH1MgOZ402Pe/4IE3QjkeAExb3PrcrsYHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pzgNKCvlzsrbf7HusHSaFc8riFo2N3QTWAO8qwZPlj6ZgbZQ
	WtidA5WVvRX15J0j1Ri+79Agz8vgbZACFA4Pg6prG7Pl+UWzl3bY
X-Gm-Gg: ASbGncvfNdlBehqWV2uSdzW00MAPvACxuloi//Lqe2iU/oqzlYhPIWznWk2/iPqkdVA
	B0Icdl7ai0EnGfHyPShgZ9IBIiV0W+1anWzySnXs71FuPLBBLZ0+RJJJdwhsK8/ZQzhq96tqD9v
	IfAOkyTd4Z8D22kv7/1IWpUI/6DQMCrtbBVkEHzh7pEY7P3AgJuXSfqfsMqeo5gTmQiyuTqBDPr
	05GKN4F5uQKONDDwwg6qr/0zFkNlp2Zy60NdIGDcIVe4akyFF9OAZp5h6Wk2SU52iQ=
X-Google-Smtp-Source: AGHT+IFb5+9bUDyZ2/KMakoA1ZjQWacjX2m04FzqnilqR+JO1e76blKltvPbpM5FBk/hlumRWhF7cQ==
X-Received: by 2002:ad4:5d6c:0:b0:6d8:d79c:1cbd with SMTP id 6a1803df08f44-6e4455fa8bdmr169993666d6.15.1739164404767;
        Sun, 09 Feb 2025 21:13:24 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e44715a9cfsm34485256d6.104.2025.02.09.21.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:13:24 -0800 (PST)
Date: Mon, 10 Feb 2025 13:13:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 08/10] riscv/arm64: dts: cv18xx: Add sysctl and reset
 nodes
Message-ID: <h73zitljaig7nrccd3f23i655imswv54tf667dhq3dord7rxsr@unqncqlorvc6>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <20250209220646.1090868-9-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220646.1090868-9-alexander.sverdlin@gmail.com>

On Sun, Feb 09, 2025 at 11:06:33PM +0100, Alexander Sverdlin wrote:
> Add reset controller node and required sysctl nodes.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> index 53834b0658b2..d793b6db4ed1 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
> @@ -309,5 +309,21 @@ dmac: dma-controller@4330000 {
>  			snps,data-width = <4>;
>  			status = "disabled";
>  		};
> +

> +		rtcsys_ctrl: syscon@5025000 {
> +			compatible = "sophgo,cv1800-rtcsys-ctrl", "syscon";
> +			reg = <0x05025000 0x1000>;
> +		};
> +
> +		rtcsys_core: syscon@5026000 {
> +			compatible = "sophgo,cv1800-rtcsys-core", "syscon";
> +			reg = <0x05026000 0x1000>;
> +		};
> +
> +		soc-reset {
> +			compatible = "sophgo,cv1800-reset";
> +			sophgo,rtcsys-ctrl = <&rtcsys_ctrl>;
> +			sophgo,rtcsys-core = <&rtcsys_core>;
> +		};

I think these node is not suitable for riscv. It should use SBI SRST
extension to restart.

Regards,
Inochi

