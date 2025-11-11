Return-Path: <linux-pm+bounces-37796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699E6C4F251
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 17:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBFF18C2789
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D73730C2;
	Tue, 11 Nov 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sowvj686"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83F3043B5;
	Tue, 11 Nov 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880096; cv=none; b=ivjxD57lFVPUvVQ1vb7CrsbCWdgyIUUsJpCPmiQWaAgSLKZ1KmVh1jEm6tleNvT+a/e6rKHvcfqncWQt60Hfwt0U5+82w5EeDnZeIT8PLj5Y8GrYGDaR2Tn3SnbEzK9plIv7ix4CW63nTwdZb28uH0/Wx6LSpFh78MukOtsuI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880096; c=relaxed/simple;
	bh=g2qpKek/bXepoXeAYoO1uBMn56y2jG6J5EJpN9tjKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUR41GG8K0C7LVPixTt132hQ6Kl5hQ8bfvC+PZ6osviCc+AxGNiNWu9WEjbe5acpptmbEDu4z4SP86Y0kmXlADUIKt035AfAOy1wxUva3qmWefBIfcYj2cb2Gtqjbyrb84exiIk5JbZC2/+2ZfnWU2JtwnLKMP4pOCWiqVlm8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sowvj686; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA336C113D0;
	Tue, 11 Nov 2025 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880096;
	bh=g2qpKek/bXepoXeAYoO1uBMn56y2jG6J5EJpN9tjKjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sowvj686mB4AULMiD8qJK6S2VhQ1Sma4nzGBWPdbbM8oe3byYncZiEsFGYMlJAtM2
	 aob9db3XYuX57073ozMNPXu8hYl67LpTglrrNf2Jip1rlyoWTOXwtye3lIOm3m6eB5
	 fQmISuNe6u7iFskf9xY2zbIVjT23iM1wu9c8hnsARtPkLuOuEAk6+HFKj9BEno9hgy
	 ZPxTYUqfineEEfdQGgbMUi+EE398+g7NZgFAaT/kB/9n9XZRiLmePY22lDhSVQGBQn
	 VL4lF4h97MXDchOsD8rETXHSSQE26v7Gg5MYGxS3Rcc7WRz/BiG04givnr7l1Z+5xu
	 uB7j/fhTdDkGQ==
Date: Tue, 11 Nov 2025 10:59:06 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
	Xin Liu <xin.liu@oss.qualcomm.com>, Srinivas Kandagatla <srini@kernel.org>, 
	Elliot Berman <elliot.berman@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v17 09/12] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Message-ID: <3gvxaeun4i3ajoo3perjvdsohmtzgstsctdilorr65eexesxfh@hyoinhvkgi3c>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-9-46e085bca4cc@oss.qualcomm.com>

On Sun, Nov 09, 2025 at 08:07:22PM +0530, Shivendra Pratap wrote:
> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> 
> Add support for SYSTEM_RESET2 vendor-specific resets in

Please rewrite this to start with the purpose of the patch, introduce
the fact that we can use SYSTEM_RESET2 to affect the reboot mode.

Make sure you include the information that this isn't broadly available
on all sc7280 devices.

Please line break at 72 characters, not less.

> qcs6490-rb3gen2 as reboot-modes.  Describe the resets:

This looks like the header for a list, that documents "bootloader" and
"edl", but it's just one lump of text. Please improve the formatting. If
it is a list, then make it look like a list.

Regards,
Bjorn

> "bootloader" will cause device to reboot and stop in the
> bootloader's fastboot mode. "edl" will cause device to reboot
> into "emergency download mode", which permits loading images via
> the Firehose protocol.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 721a26d49ccaeb1429e2cc1c3a5c8d9517da3be6..cebdedd5d614b9efb6dfbee91dd67f3c3e322a38 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -935,6 +935,13 @@ &pon_resin {
>  	status = "okay";
>  };
>  
> +&psci {
> +	reboot-mode {
> +		mode-bootloader = <0x10001 0x2>;
> +		mode-edl = <0 0x1>;
> +	};
> +};
> +
>  &qup_uart7_cts {
>  	/*
>  	 * Configure a bias-bus-hold on CTS to lower power
> 
> -- 
> 2.34.1
> 

