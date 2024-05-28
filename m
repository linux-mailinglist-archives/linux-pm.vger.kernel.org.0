Return-Path: <linux-pm+bounces-8257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C76D8D1FBC
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB644284E9A
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF717164C;
	Tue, 28 May 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJCFrejZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4741E880;
	Tue, 28 May 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908797; cv=none; b=MRkAhaOh2WBXc9WO5VBKA4t0o7dfik4Aq2xbjey+0owwdHPlEspfyhWqO/blciHp3uXqbxWEBOO5+wgW8+qTozxOIxeqgrUb7BnKQA2Io5Gj3b9Xj3WOaXQ0lwbbKJir2VcZaFcSFCH9lyQ6MpM5412DRrQH/VU5npjnuyLl5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908797; c=relaxed/simple;
	bh=WW8C6Bc9G0Yfb3CfuxmEdX54sinQDMOYusd6wezRaW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZCLWAE1EFnrwEfUscDNHmcD6F2rmKSxpL8tvJj1PHC1fgtKW3448F9X233Kd25Ra0jgzU+PXmUVoY110/Rv/twtymj60Tn0wVTvfMdr3sL1G0br6/oIeXmwsa0OuljL9PyVuU880A716qSfyenSBEj8VewkwIYH47v6OvdcPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJCFrejZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0864BC32782;
	Tue, 28 May 2024 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716908796;
	bh=WW8C6Bc9G0Yfb3CfuxmEdX54sinQDMOYusd6wezRaW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJCFrejZ8h7jn7LQBqsHSkoosHWCqAdx9SAEEq26xBbw8w1j/qr8vwinxz/VhupPS
	 aBLKEFm7aN/N47MatW0jKAJZhZDKT3Ah4dFSI+ZqIkDMPsej3xS6TRZgaflQ1C9u4g
	 uE8HcoBYSSXI//rquJlBhTjBeF5UIrnIUnOv/Laai5LFY3DzKTpB46j5lsgljrErTl
	 DsJOQlowXN7Z5yUHQ8TaLfthwG32J/zqo9beR4leCqRCC9LNWsN1/Om2+3rYh1/VFN
	 1sF2YhxnnsFsnlzUm5XjEdfeQEmEqTbvFi5sXs/phTLfKR9vuOtGDQ3a3WvtDtK9jg
	 KCzoZKJyez3AQ==
Date: Tue, 28 May 2024 10:06:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: c630: Add Embedded Controller
 node
Message-ID: <bbsdvqjo2ikljnuvupolpdfstsaegfqyg2ct7bt24evcorcfjt@3fw5eicxxuik>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-6-327a9851dad5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-yoga-ec-driver-v3-6-327a9851dad5@linaro.org>

On Mon, May 27, 2024 at 01:03:51PM GMT, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <andersson@kernel.org>

Please align this with the S-o-b - feel free to use either form.

> 
> The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> and provides battery and adapter status, as well as altmode
> notifications for the second USB Type-C port.
> 
> Add a definition for the EC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 47dc42f6e936..d975f78eb3ab 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -370,6 +370,66 @@ zap-shader {
>  &i2c1 {
>  	status = "okay";
>  	clock-frequency = <400000>;
> +
> +	embedded-controller@70 {
> +		compatible = "lenovo,yoga-c630-ec";
> +		reg = <0x70>;
> +
> +		interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ec_int_state>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "host";

I was under the impression that this port is wired directly to the SoC
and as such this would support data role switching as well.

No concern with that, but just out of curiosity, is this not the case?

Regards,
Bjorn

