Return-Path: <linux-pm+bounces-37795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A762C4F1D0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 17:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381F03AE237
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994923730C2;
	Tue, 11 Nov 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX/zQ+Mr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F62D979F;
	Tue, 11 Nov 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879704; cv=none; b=U1TnR2t0riYUpcrzI7ZxoueIAKusunbeCZaadyTJLBv9fUEzSVL35udM4pLSIOoCw5LEfM7nbx4WxdNn6S/cUQTYSh97bdCu37mL5Ja2SQTrb0LjS3cibsnDIdcMVvwoF04vYQwaROk7uybE0R+2rQbrVtVn9b8GFDSh7kjdU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879704; c=relaxed/simple;
	bh=QAvwD+snMlu/Jt3TEUyKWNI/wTAgmcqVgGGWrd7NCxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw0TUNkVYX5mixOCVIE+qx+GxY3hzi7P0FjKPpRUDO6IBE5LKReq1jcut3kuVVStRSmKBm43HA2RdY2A9hN7zyLv4B5yGK/QTS76F/9aQYOnZPJe6CAJ/K/+TN+hWw4OODwE6e16l0G+LeRKkGUhOzaIKl2dpxYaNzKVZAIe8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX/zQ+Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D216C113D0;
	Tue, 11 Nov 2025 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762879703;
	bh=QAvwD+snMlu/Jt3TEUyKWNI/wTAgmcqVgGGWrd7NCxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VX/zQ+MraddmjGS5f342TmJypvx87sOhUbJxHx0rqYphAz3YQmrJUNZuQBNXaRXGm
	 hrfBbAUIvwgkEvXJMgQUvHLi4bgfa8AlbUlOzsJkkDfWOC69e4Q33z/O93FyufXUk9
	 P/aA7/fHxMEcwzOtHB2sfxCuFSOZhKsFRys6LHAUnteHtY3ctsHN/gLFHgGJlwUtGw
	 WDGrLDBSa6pW4WNWoE83le9Q1tpITLm8SmWmBqt06uxcnZAeioOFZqTlEWF45/5dMv
	 Pal1wuA4DLTVZX6mU+TS4qq96/+JuwEG8bL9GNUtLjAvmuWUYdVKsbwX4X41oDV1Gd
	 N7BvOLOnr9z+g==
Date: Tue, 11 Nov 2025 10:52:34 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Moritz Fischer <moritz.fischer@ettus.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
	Xin Liu <xin.liu@oss.qualcomm.com>, Srinivas Kandagatla <srini@kernel.org>, 
	Elliot Berman <elliot.berman@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <cvfr4zaceknma6camborq4ro3lwbx3dfps2zjagwhwmvwoxriz@jwybwtzdd46u>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
 <20251110122824.5je5jfoanivl6xrh@hu-mojha-hyd.qualcomm.com>
 <btvknf3tcqhgxzf7ckyvfwix6hxle2bs4whyayan5haaejo3sm@gnbszdys32lm>
 <20251110161950.ngs4ihn3asijoqks@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110161950.ngs4ihn3asijoqks@hu-mojha-hyd.qualcomm.com>

On Mon, Nov 10, 2025 at 09:49:50PM +0530, Mukesh Ojha wrote:
> On Mon, Nov 10, 2025 at 09:30:26AM -0600, Bjorn Andersson wrote:
> > On Mon, Nov 10, 2025 at 05:58:24PM +0530, Mukesh Ojha wrote:
> > > On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
> > > > From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > > > 
> > > > Add support for SYSTEM_RESET2 vendor-specific resets in
> > > > qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
> > > > "bootloader" will cause device to reboot and stop in the
> > > > bootloader's fastboot mode. "edl" will cause device to reboot
> > > > into "emergency download mode", which permits loading images via
> > > > the Firehose protocol.
> > > > 
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > > Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > > > Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > @@ -935,6 +935,13 @@ &pon_resin {
> > > >  	status = "okay";
> > > >  };
> > > >  
> > > > +&psci {
> > > > +	reboot-mode {
> > > > +		mode-bootloader = <0x10001 0x2>;
> > > > +		mode-edl = <0 0x1>;
> > > > +	};
> > > > +};
> > > > +
> > > 
> > > Make sense for this as it leverages sc7280 and adding it there would not
> > > have made sense.
> > > 
> > 
> > Why wouldn't it make sense?
> 
> It is better to add for platforms we know their firmware support this
> from day1 and not add for something like chrome or any other variant of
> sc7280 where this support would never come or not tested.

So SYSTEM_RESET2 only exist in newer firmware versions and hence this
isn't (and won't be) broadly available in SC7280 devices.

That would be excellent information to put in the commit message, so
others writing Kodiak dts doesn't feel the urge to copy this and debug
why it doesn't work.

> > 
> > > Acked-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > 
> > 
> > Please read submitting-patches.rst about Acked-by, and use Reviewed-by
> > going forward.
> 
> I was acking the idea of this particular change in platform file compared to
> other patches, if above reason looks fine, can be converted to R-by.
> 

That's appreciated, but per the documentation, the meaning of acked-by
is different.

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > >  &qup_uart7_cts {
> > > >  	/*
> > > >  	 * Configure a bias-bus-hold on CTS to lower power
> > > > 
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > -Mukesh Ojha
> > > 
> 
> -- 
> -Mukesh Ojha

