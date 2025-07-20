Return-Path: <linux-pm+bounces-31117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6DBB0B69F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957A63B5B29
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9E1F4C8C;
	Sun, 20 Jul 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6WsW40lE"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB63FE4;
	Sun, 20 Jul 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024640; cv=none; b=cLODwFffD0E4O3vtH0QTatT2cMHfmCJfJoo+Dr+TwVP/XpDCnuUBQu3em6juJdCYtTe4I/CvNWP5OphvgWBK99SsSqZtf5ATP3LY7/9QYCd8/EFAgb5pLaWhl14oGGIZZ6XNBOSCpbIWcLwIUZE4t+ZQf7v05vDo32U72sZ94xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024640; c=relaxed/simple;
	bh=iAz1FYQdJdIkdCmqXmtDdtw54PK547ppkD9AaNVMKRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxE9+wwYbsmzW1JmRgFxxTB0n8dLB9ZkzAzuKFq9y5QsuNUrKUUWZ2JrfJVtLD72xm77NAL+F++oz3bTQla9A9SdKgbiI4O5n0DSQHrtmJxy8FdpbIf6+4QjWJQnySsCxCNKQmCmbXlU1E4C+OqNQMgwlPQs8R5+6CnxvWrhi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6WsW40lE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iciTdbozgbEwpx/j+Tpe9MpyqER+JXwr8LFwyB0pkS8=; b=6WsW40lEAD7TZLkmADom+46xBC
	aO9R8B1l4cvgNm3Av+QCn80uQhZNJVzKsKo0mUQBQ21RG/DsZgaZLswUGUGF/SSV5uDg65iOU1ry4
	eebh0ZPMHSD1J1jSJCcuzQPEZ0WwxogXTY886yw2EHCQ7IULH0GeGm59T4b5C/R6sogI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udVmX-002CZR-Qo; Sun, 20 Jul 2025 17:16:53 +0200
Date: Sun, 20 Jul 2025 17:16:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v11 2/8] power: reset: reboot-mode: Add support for 64
 bit magic
Message-ID: <6227828c-5db0-41c8-956f-eea6f790ccac@lunn.ch>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
 <6vlm3ybjpy2jq3cr2pzj4vcmqwoissdml2xmhfzlulfbrpzakt@xrepu6c5zykb>
 <713b2cc8-1bc7-a8b7-678b-5fc7fe25615a@oss.qualcomm.com>
 <8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch>
 <1653597d-4d6b-a771-fbd8-c129c630ac0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653597d-4d6b-a771-fbd8-c129c630ac0a@oss.qualcomm.com>

On Sat, Jul 19, 2025 at 11:07:47PM +0530, Shivendra Pratap wrote:
> 
> 
> On 7/19/2025 10:27 PM, Andrew Lunn wrote:
> >>>> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
> >>>>  {
> >>>>  	struct qcom_pon *pon = container_of
> >>>>  			(reboot, struct qcom_pon, reboot_mode);
> >>>> @@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
> >>>>  	ret = regmap_update_bits(pon->regmap,
> >>>>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
> >>>>  				 GENMASK(7, pon->reason_shift),
> >>>> -				 magic << pon->reason_shift);
> >>>> +				 ((u32)magic) << pon->reason_shift);
> > 
> > As a general rule of thumb, code with casts is poor quality code. Try
> > to write the code without casts.
> > 
> > Maybe something like
> > 
> >       If (magic > MAX_U32)
> >       	   return -EINVAL;
> > 
> >       magic_32 = magic;
> sure will update it. And in above, should it be recommended to add a explicit
> cast(for any avoiding any compiler complains)?
>  like: magic_32 = (u32)magic;

I would hope the compiler/optimiser can figure out from the test the
line before that this is a safe conversion. So i don't think you need
a cast.

	Andrew

