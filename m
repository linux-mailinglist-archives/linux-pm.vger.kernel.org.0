Return-Path: <linux-pm+bounces-28015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45034ACC6A0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B39166BC1
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557C22DA02;
	Tue,  3 Jun 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQQao7Av"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FC22A4E1
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953669; cv=none; b=p6v8pmRTyJ2gBNlVcfuPxABeavlCU4qO5q0iVf0h2feO1xvlyRvpHCL0iviF08IAWejqiYLm3dAjtS3ojmuw5mEUxHvAcFSPrgQejUvUNlr9oSPw8uwNSJctsYU2qvssmq7ygx8iTYsEMDjzMJPn2VzVSAFM6HUEl6ZpIAfMpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953669; c=relaxed/simple;
	bh=U9TZhzl9LGoUPww5lpOtQmKYBtkSSXsm2J5aXtd5Vbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQO4ASDZ1XdPhb+DdWKeE3pJ+AnBN7JVp2uwzQVMY7kRtLrLcAWg6YlIrO4urc9jzuCdHaDnibcRHP3yLD7ik/8HpTgn7qmk0frxdS4GasD+hiPuPvLGQ+K1O4HBhQkWpOmBPjKHnyDq7FYjv9VwfjdSXPPTmhDKBEaT8V0ixfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQQao7Av; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7f6c5978d2so4057730276.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748953667; x=1749558467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zkBUpTusJpTA0VXTt0i8mXorEGwS/Hyqj+o9q7jAdU0=;
        b=cQQao7Avf2nKTsXVByFZd6nXqpN0S6lZb4dJ3bv4Ijb1FYWc6rego/h6maf8yGp55j
         L4WZNKhXD4V7il3neMw2eIsAfpm79+dv7R2oj/JVOQ0YYBxXEpjoZYfX6iK0M3dKmqRq
         qPc86RyXwH0XqSjbuC0+Wewdx1lNgFMVkQV+b0fevNMbjZ0XreRnvKpFYfKCfiy9AYBq
         HgiYhCAxmqxKqphUg24OwK6Zi8TDwGWq8VgCg6PlZNzYu6b9yCBSNgdRIDKTO7mKfxxq
         hdrhXQ/s6X5PiLJRdVUmi6gzPOF2Dx++70AdRZ1VZzo8V7ZM1WokBNL74O3QnPCySUxt
         iY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953667; x=1749558467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkBUpTusJpTA0VXTt0i8mXorEGwS/Hyqj+o9q7jAdU0=;
        b=nhg665TdWjdqhvubVovAWVWwM9QwrtK3ITBZRkcZBA2qVrJ0cbLi3eTJT+wORtGFhx
         umFj8h5XmD2+9d9m7q2sUec5b0CxeWpEmsNcccnxCgSYHxHCTc8+e3bafhTvQmNPAx8W
         tKzHyrMp7zwCL1C1SHqxx4fk6Rw5sxEiCK6Xnjzy3+Z/YiWZHouR2m5zggHE7sorX+L1
         4gD4k3jUo6WL9pqxiG0b+AdAf0FnXgTlbziKZTl0V0Vzxip8WDKu6wgIk0ipPpfTErch
         w21L/TjuZRoEwNmMsoqWQYdC+iBosE0XcjDjxVOuhJgXiQnxghi7mc8H9T+mOMA++Wet
         FP+w==
X-Forwarded-Encrypted: i=1; AJvYcCUPjtkpIvD6p4u4oR0PLoCh945OkNiezjTAIME1saruGYSew6X3Qscl1MYM3L/QSj/0uzwn0MZYaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YymKtv3JxxK1a14gE70OChZ7wC9thts0uPpbpWKiwo28Te4k5TB
	PiLg8Z3F3dgq/2+L74QKUwKWeDBW/gq5KW3B+roOTsrVlW37t6Q2o16t9mfrAU3NF1zOuW2uahr
	hZjN3T12RZsRBXcQgpdSBQ/+tOhGIe1yx2Ga15447Bg==
X-Gm-Gg: ASbGnctnTpMwwiBkdSyM7vaL4LE7NH75br4k8ophzBQBzBQCPsU/J0KOZsNh1ceGxjO
	7ET+SJ16v9efZLwrLnxZhUHheF9OMvr4a3YFkIuqvnew+v/g656fTXaOA2GpBdsuYFf/XyRCd8V
	JvStvsQ9s57zsRNVCH2fnK7nwo5l8XUJqz
X-Google-Smtp-Source: AGHT+IHrpeHkj+2BBo06F52MCRNOttN7I/OSF6yK1xPb3e+88rZaXmBzR2xH+shfwb8QDbG4StP/a4Wb3x5cAxCSx/4=
X-Received: by 2002:a05:6902:6b10:b0:e7d:b0b6:1bf6 with SMTP id
 3f1490d57ef6-e7f81dfaa44mr21941753276.12.1748953666949; Tue, 03 Jun 2025
 05:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944@eucas1p2.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com> <20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
In-Reply-To: <20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Jun 2025 14:27:11 +0200
X-Gm-Features: AX0GCFuhikVc4rQPnpXMCgeyFTV30-WWzpds7-nPqvmmTrY7jKqhLTeVB-8SqLA
Message-ID: <CAPDyKFpYfZNthdRN=pCv4FEdFCzrKEH4aFBy4ew-xLKtpbJ5Tg@mail.gmail.com>
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

On Fri, 30 May 2025 at 00:24, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> the GPU using the drm/imagination driver.
>
> By adding this node, the kernel can recognize and initialize the GPU,
> providing graphics acceleration capabilities on the Lichee Pi 4A and
> other boards based on the TH1520 SoC.
>
> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> controlled programatically.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 6170eec79e919b606a2046ac8f52db07e47ef441..ee937bbdb7c08439a70306f035b1cc82ddb4bae2 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
>                 #clock-cells = <0>;
>         };
>
> +       gpu_mem_clk: mem-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <0>;
> +               clock-output-names = "gpu_mem_clk";
> +               #clock-cells = <0>;
> +       };
> +
>         stmmac_axi_config: stmmac-axi-config {
>                 snps,wr_osr_lmt = <15>;
>                 snps,rd_osr_lmt = <15>;
> @@ -504,6 +511,21 @@ clk: clock-controller@ffef010000 {
>                         #clock-cells = <1>;
>                 };
>
> +               gpu: gpu@ffef400000 {
> +                       compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
> +                                    "img,img-rogue";
> +                       reg = <0xff 0xef400000 0x0 0x100000>;
> +                       interrupt-parent = <&plic>;
> +                       interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&clk_vo CLK_GPU_CORE>,
> +                                <&gpu_mem_clk>,
> +                                <&clk_vo CLK_GPU_CFG_ACLK>;
> +                       clock-names = "core", "mem", "sys";
> +                       power-domains = <&aon TH1520_GPU_PD>;
> +                       power-domain-names = "a";

If the power-domain-names are really needed, please pick a
useful/descriptive name.

[...]

Kind regards
Uffe

