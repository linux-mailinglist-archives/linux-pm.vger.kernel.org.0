Return-Path: <linux-pm+bounces-16422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1909AF554
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 00:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF01F243E6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 22:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20E218320;
	Thu, 24 Oct 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtBio/n9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406222B66F
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808672; cv=none; b=pu1ROpB833ZlIDu6nATtxNqxQEyFJUtJuFudd6+Why5z0rCFhIaR8lVnJ8plRNgIbCJZkeTdnQngI8GVPXwTXPNYUFOjzCw0dAbG4Obq6/BfIXIMx0P8U/bQ5u+BQ26QpUD7Ht3zltMvRVhAzGv+u+6xfP6xIxTPMtVdW55sp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808672; c=relaxed/simple;
	bh=b3Oqdz9XIKXZD2gr94AL8g1IimMVqiVBRgfe0bV1erk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np8ZOXE5CbuUtzkljfrgiLxnWt6Tx00GxZU6qHyrvXRFDJpa500IqfkWshs23hXmDyu7GZzUDZLeqFlW+PMsaCjjp+sc6vJd7GGm85poSN9KWlR5DvXrf+zoke3TjG8KsTiadXW5tLFdgrzxnRCpyplWMnVBmxlp5lUzAsUMW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mtBio/n9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f7606199so1857086e87.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729808668; x=1730413468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNMGjw++sMHfaJpTwkpeeb5+CZwbF2kDV2e17WrmTm0=;
        b=mtBio/n9Iy30NY/Vx+xkT+laZSzQFD52QUrDpLiZCNtoIGrAx/eqyIViKrwSVaIie8
         WCMWQghjE5gXWrhFoWApfpQRNbHMTM3AWj31HKZyDYBTYHFtW6uBDFXEx9vrVLfc8JVH
         +ZDsxQxbP1UWwBigUGi7QrXPbaBb13dHZJBLYTvPJR9g3fwoiAL29hkONX2uvTH5EV0S
         UnjoxtlN3XgSI8fq8FSTofI3ddPC07vOpD82y2p/Ww+XEWJYxzKJNOk+pc4EnIcBuKGJ
         U6lU/OxAvkHJXM9clTrA4axWjsHrCRJJMHuFWsoFFoiK2BkUkIsfuPenlOsryNUweGTd
         2PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808668; x=1730413468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNMGjw++sMHfaJpTwkpeeb5+CZwbF2kDV2e17WrmTm0=;
        b=R3ANZ3u1cpuuctLYwoTUUYTwIiYDhvOzfLPaZjIUx8dkvpYbn4RaFxDLwQeOG+emfA
         rNAA8NpLuaTYAiTXq1fELdne7g1sxmSeHMQYsn7CeK5T/bjxR9smRz8EkYaMc87JZhQF
         +ZlXA78xcR32v7LPk6dl+EHbImGWoBLmY4Ii+nAhhvOre9jCq/+LJdY1/55C3+2rj5+y
         agelCeOfp8AaeKIH7XtLCanGDhH+AAdZ8EkHzXMuoO0GLtMJbIS/5YDW53GZLM1fTBTD
         8eDvabSeNGl85BgUki4FdjKFoYjUQfuM1o9462+eb+MTfZKuLluH94JYicICxpbfy6zM
         XLAg==
X-Forwarded-Encrypted: i=1; AJvYcCWieduFblrWyiK1GRmzab8U3/GNJasY1gGXx93LoeLVL4gAOqau9gGouXunuJdBxjd6d3elbluNqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoqHRO+LxZrCjhqqqZh2+6iGb1oLC521lnlaYIUBLNVXUadIq
	tpa6e9FTAmNF/H/SXw1g6fqwGL1JVV9C9/wtXvnQaR1fRhJscTfne/8CjBlowfU=
X-Google-Smtp-Source: AGHT+IGMGFhwLsswBUxiX+Gh6Mwmw4Gpv/RT0zNWikzUs+v1WjRd6mzd0pMZGj9Em8bkTL+w/Phbng==
X-Received: by 2002:a05:6512:6511:b0:539:faef:35ec with SMTP id 2adb3069b0e04-53b1a375c09mr3432667e87.49.1729808668438;
        Thu, 24 Oct 2024 15:24:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5ab6sm1481972e87.13.2024.10.24.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 15:24:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 01:24:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH RFC 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <h4dy2fesraalsri4gclenp4luwqjoh7iv2xysqnf6uwy3qp5de@x6iqc6pa365i>
References: <20241019-msm8917-v1-0-f1f3ca1d88e5@mainlining.org>
 <20241019-msm8917-v1-12-f1f3ca1d88e5@mainlining.org>
 <2iayllvk5ohrmbhnn7up5gvys2ijzxuyf44c53uwcbsunre6np@ncrimgac2idz>
 <19884457f1133a20a6ad014a75906e55@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19884457f1133a20a6ad014a75906e55@mainlining.org>

On Mon, Oct 21, 2024 at 11:14:55PM +0200, barnabas.czeman@mainlining.org wrote:
> On 2024-10-19 15:43, Dmitry Baryshkov wrote:
> > On Sat, Oct 19, 2024 at 01:50:49PM +0200, Barnabás Czémán wrote:
> > > From: Otto Pflüger <otto.pflueger@abscue.de>
> > > 
> > > Add initial support for MSM8917 SoC.
> > > 
> > > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> > > [reword commit, rebase, fix schema errors]
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8917-pins.dtsi |  344 ++++++
> > >  arch/arm64/boot/dts/qcom/msm8917.dtsi      | 1557
> > > ++++++++++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/pm8916.dtsi       |    9 +-
> > >  3 files changed, 1909 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..f283ffd59b8aca8e510ef95d5526af9592a1c036
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8917-pins.dtsi
> > 
> > Please merge into msm8917.dtsi (for generic parts) and
> > msm8917-boatd.dtsi (for board-specific parts).
> > 
> > > @@ -0,0 +1,344 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > If possible, GPL-2.0 OR MIT, or GPL-2.0 OR BSD-2/3-Clause
> Unfortunatelly i cannot change the license i do not own the original code.

Ack

> > 
> > > +			tsens_caldata: caldata@d0 {
> > > +				reg = <0x01d8 0x14>;
> > > +			};
> > 
> > No, individual bit definitions for each of tsens fuse values.
> > 
> > > +		};
> > > +
> > > +		rpm_msg_ram: sram@60000 {
> > > +			compatible = "qcom,rpm-msg-ram";
> > > +			reg = <0x00060000 0x8000>;
> > > +		};
> > > +
> > > +		tsens: thermal-sensor@4a9000 {
> > > +			compatible = "qcom,msm8917-tsens", "qcom,tsens-v1";
> > > +			reg = <0x004a9000 0x1000>,
> > > +			      <0x004a8000 0x1000>;
> > > +			nvmem-cells = <&tsens_caldata>;
> > > +			nvmem-cell-names = "calib";
> > 
> > And here too, individual bits instead of a single blob.
> I do not know how to do that i have only find some parts at downstream
> driver to be able to separate
> the cells but i do not have every information for it.

Well, you don't have to describe every information. I'm simply asking
you to replace single tsens_caldata entry with per-sensor and per-point
data, see e.g. msm8976.dtsi and data_8976 / ops_8976.

> > 
> > > +			#qcom,sensors = <10>;
> > > +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-names = "uplow";
> > > +			#thermal-sensor-cells = <1>;
> > > +		};
> > > +
> > > +

[...]

> > > +		gpu: gpu@1c00000 {
> > > +			compatible = "qcom,adreno-306.32", "qcom,adreno";
> > 
> > Is it really .32 ?
> Yes it is A306A (Adreno 308)

Ack

-- 
With best wishes
Dmitry

