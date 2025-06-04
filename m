Return-Path: <linux-pm+bounces-28108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DEACDFA9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA5B7A5871
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4428FFEB;
	Wed,  4 Jun 2025 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRoq57/T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818B2557C
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045487; cv=none; b=fG01SKVh51OFPTA/b9o530nSLa9zDemsr9qmRiQabLY5qTRXkMyG/gPJp32X3sMmpjFLna8zpPfY8Or0qxiKqKg2XNs6AHBJFTvuo/4QYJJLY5T25DmigEUclH73J/3QLm+FSeV4010Akouzj3CoSGONyQpAcdQbPQz9D/2Fq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045487; c=relaxed/simple;
	bh=zRFxwlOuzhqwZx7qzxl80h5Bo/0p7oc7WIbfN8Qjlw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+Q18UYuasyY4bU700hhcNPmKmWdx/H5O1CsxvMsiEIrhbfBs3lKKxELayqflsV8Gc6z+9KGyD7w+f9gAePoCvCzIOxpZ+Fi5nnH8r2EAwl5eXAC8gsWl0LGx2LJVJg+exmb0Hb/oT5KUVei1xhjxvtKq1p+TaOKZGQA6WCjzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRoq57/T; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e812c817de0so3996605276.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Jun 2025 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749045485; x=1749650285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFWXnsIMSq1bn0DUFYmY7z6V87/rRA1du54TZxFaV2Y=;
        b=NRoq57/TUbyB7bb5VxHVyq24yoAGAr1hQ99CQFtbu6trcUZRoVYF23HAk6hj45wG3D
         xLe1YFmQwsOHaa9BMDXe14VjCzh96PvvR5MUJNO+l+6aOU9AEcCfRV2eQXWBsinrtB8e
         kA7MBL8cGEHkE2KlegjBelu5eMfxydvNaMguOW2laDNBFcNSQkSll6Nkz7IEey4Guwd4
         e7qStXO29JO3J6kXMPCMFiM0TYqmMgOpi4u+EEWdWhHwSKZ+J4Mg4WdzGWZyTRTfZQ6f
         rs2D2tVO5bqTuHr7m4Q8BaMd++fXkMlFMTwk1Z5gYK51QjoqSP0HG8sQltH7IStlAGTI
         g0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749045485; x=1749650285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFWXnsIMSq1bn0DUFYmY7z6V87/rRA1du54TZxFaV2Y=;
        b=RUygDNjzIHr84lsWpaQ7mfJRAU+CBRai2G8qeMf7HabVoJkLUtFPXM0ZaCIQaelveG
         NiBF/FsLvGlEuxP9LVevzPPamHw0fIqE/wynYc1noTca9tU4s+RWhQ4PrzuVzW/5oslu
         nFwXMcGFBxWyxjN1llqDiU9W+Ot2/2SWTnH3uLbawO36I2e2+sZ7++ikwViHULMDLTzt
         8iEaTwKiisGYjp3satiYH3uFlHL9Q8EcqOYpXDTaUR0LlT7+xXGx48kInZlweYeV9rFZ
         VOF63tWvcuo7mIApgD/BMflbzUj1o0TGdvvhSi33IQs7Vrq++w+nYc2QespdgLPUFak8
         ACDA==
X-Forwarded-Encrypted: i=1; AJvYcCXBX/dMA9zfmrNB2S9yW3kITXlK7bOeqx+4/Dhqzyx0JUxhHAvZ3lhdGNnZIPhqX8r0a81MLxuakw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sLc55S72E0/9mhzqVmAy9cT0570V1ALbUsbWlt8WZCuUeJjd
	VDHGZBg8c632vDxEnBdoRNrFwNbnAQl6R3AY/suTeKDlznC2S0XscH05J6vUTuLZPb/O9Im5blT
	LRJ729tiQJEvM/7xy5trAxamg5VKBEWt0L+GgTRY3kA==
X-Gm-Gg: ASbGncsAApRO8l9sKEqA1fPBltbTW/qRc9aDXwM6+TNOpB7dhrA4iqcGjfDtrJOAMfm
	oQ0GTSz24UBFdB9Bx/yH53d+PFQCWHUB9utPFf/cYthnsG6ZYSzw0ZS20W2FkTspCrDOs2tG5tR
	Q7EmB3jRrSvuhBAvJxV1qIvf8iAZ6n9ExPbA==
X-Google-Smtp-Source: AGHT+IGXFY8gppNCB1I6k87GeD/bmWPUV8R4mMgK2i7dZCLcfF2RhkUBwoySiJMKIOMWeHJraaSZXAxgR7paTZPeyFU=
X-Received: by 2002:a05:6902:1383:b0:e81:2447:6b74 with SMTP id
 3f1490d57ef6-e817a0011f4mr3409868276.43.1749045484537; Wed, 04 Jun 2025
 06:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944@eucas1p2.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
 <CAPDyKFpYfZNthdRN=pCv4FEdFCzrKEH4aFBy4ew-xLKtpbJ5Tg@mail.gmail.com> <a68e3bee-f4ad-4d73-a5a8-e39772c41711@samsung.com>
In-Reply-To: <a68e3bee-f4ad-4d73-a5a8-e39772c41711@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Jun 2025 15:57:28 +0200
X-Gm-Features: AX0GCFsKqqHfcoyjgQNY4Bx0T-G_vnaUmkhnEv_Xdt_09WriRo8KoB3SpnFxVUU
Message-ID: <CAPDyKFo8scYL59+ELgawop30habZad0Xsd6bKGLXtSF+UNd9Ng@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 14:40, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>
>
>
> On 6/3/25 14:27, Ulf Hansson wrote:
> > On Fri, 30 May 2025 at 00:24, Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> >>
> >> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> >> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> >> the GPU using the drm/imagination driver.
> >>
> >> By adding this node, the kernel can recognize and initialize the GPU,
> >> providing graphics acceleration capabilities on the Lichee Pi 4A and
> >> other boards based on the TH1520 SoC.
> >>
> >> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> >> controlled programatically.
> >>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  arch/riscv/boot/dts/thead/th1520.dtsi | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> index 6170eec79e919b606a2046ac8f52db07e47ef441..ee937bbdb7c08439a70306f035b1cc82ddb4bae2 100644
> >> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> >> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> @@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
> >>                 #clock-cells = <0>;
> >>         };
> >>
> >> +       gpu_mem_clk: mem-clk {
> >> +               compatible = "fixed-clock";
> >> +               clock-frequency = <0>;
> >> +               clock-output-names = "gpu_mem_clk";
> >> +               #clock-cells = <0>;
> >> +       };
> >> +
> >>         stmmac_axi_config: stmmac-axi-config {
> >>                 snps,wr_osr_lmt = <15>;
> >>                 snps,rd_osr_lmt = <15>;
> >> @@ -504,6 +511,21 @@ clk: clock-controller@ffef010000 {
> >>                         #clock-cells = <1>;
> >>                 };
> >>
> >> +               gpu: gpu@ffef400000 {
> >> +                       compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
> >> +                                    "img,img-rogue";
> >> +                       reg = <0xff 0xef400000 0x0 0x100000>;
> >> +                       interrupt-parent = <&plic>;
> >> +                       interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&clk_vo CLK_GPU_CORE>,
> >> +                                <&gpu_mem_clk>,
> >> +                                <&clk_vo CLK_GPU_CFG_ACLK>;
> >> +                       clock-names = "core", "mem", "sys";
> >> +                       power-domains = <&aon TH1520_GPU_PD>;
> >> +                       power-domain-names = "a";
> >
> > If the power-domain-names are really needed, please pick a
> > useful/descriptive name.
>
> Yeah they are required. Even though this convention doesn't seem to be
> enforced by the dt-binding it seems like it's hard-coded into the driver
> 330e76d31697 ("drm/imagination: Add power domain control"). So I don't
> think I have any choice here.

Well, unless there is a DT doc describing the power-domain-names it's
perfectly fine to change the driver too.

Moreover, it looks like 330e76d31697 is a brand new commit, just in
linux-next, so not even included in a release yet.

Kind regards
Uffe

