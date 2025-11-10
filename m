Return-Path: <linux-pm+bounces-37748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BBC47971
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84DA3A83C7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00B242D90;
	Mon, 10 Nov 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEi3pw/N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AC2264BA;
	Mon, 10 Nov 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788382; cv=none; b=TN4vD6Qo83tQ5snpsPxEA/ITtRFGrMgQswCDoZ0z1Uvn40MNcHekEgv1fwBl/OPI3vaVhdEEPZ9ETQB+rcF1yy7Xf0fWvMlXfIXAegDQ+FpCXIacXkd0IhcUyXwD2UjGoE2o5126FbN/WT3Zn16E7BtMs6Pw7qJiaPvVwWR6E0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788382; c=relaxed/simple;
	bh=oUgWF0RUu+mB1/5X7J8Lib1+YnLUj4YxOYKGEf0wWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxGyNLLvNKFc6l6+BTlb3Q45AhFYOIgOG3YIRfIHYQtC1X1ycNtaQ8LMEB4OOTfOzAhKFtP9RXuL1vZSAn8XfSnYTd0dSQzPY/bE0PmvKSkI6UFzXYWxHm6TBjIhCDYcTtpgZ4ozy9vtwaZIe3zrJpsS7/9g2Ml4H2aIwSv6IB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEi3pw/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86160C4CEFB;
	Mon, 10 Nov 2025 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762788381;
	bh=oUgWF0RUu+mB1/5X7J8Lib1+YnLUj4YxOYKGEf0wWH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEi3pw/N8drkjbFObP4vqAMkSx9U17WFA1bbYOZYToSNXxmPQLzT6NXLMV/1G23X6
	 QHehiRrMOiARo9hAnf9MGLSsJbV15Xs0N4T+ZACfLp/Vc9pUgUHiEGsG9krkL8k0q0
	 5friH9S5o9xUQNXyiBEiTHPr6fytp1DjQld1K0wumVqmhFjOXTVxTqEcCj4ZMztsK5
	 r8Xc+b8mVufve+txLpSjZFDpywY64xjKXsTG3g/+UmRWtFIGzHF0Iohlp5bwhAPq6J
	 0jtFJFBVDOY2VkHF5hPZnqBsCJY2rcjXjgHQR8sfLT53f76cI7+MdGOxW0DPojdKMH
	 39wTD61gcg0Kg==
Date: Mon, 10 Nov 2025 09:30:26 -0600
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
Message-ID: <btvknf3tcqhgxzf7ckyvfwix6hxle2bs4whyayan5haaejo3sm@gnbszdys32lm>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
 <20251110122824.5je5jfoanivl6xrh@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110122824.5je5jfoanivl6xrh@hu-mojha-hyd.qualcomm.com>

On Mon, Nov 10, 2025 at 05:58:24PM +0530, Mukesh Ojha wrote:
> On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
> > From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > 
> > Add support for SYSTEM_RESET2 vendor-specific resets in
> > qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
> > "bootloader" will cause device to reboot and stop in the
> > bootloader's fastboot mode. "edl" will cause device to reboot
> > into "emergency download mode", which permits loading images via
> > the Firehose protocol.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> > Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -935,6 +935,13 @@ &pon_resin {
> >  	status = "okay";
> >  };
> >  
> > +&psci {
> > +	reboot-mode {
> > +		mode-bootloader = <0x10001 0x2>;
> > +		mode-edl = <0 0x1>;
> > +	};
> > +};
> > +
> 
> Make sense for this as it leverages sc7280 and adding it there would not
> have made sense.
> 

Why wouldn't it make sense?

> Acked-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

Please read submitting-patches.rst about Acked-by, and use Reviewed-by
going forward.

Regards,
Bjorn

> >  &qup_uart7_cts {
> >  	/*
> >  	 * Configure a bias-bus-hold on CTS to lower power
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> -Mukesh Ojha
> 

