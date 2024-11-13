Return-Path: <linux-pm+bounces-17470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DA9C6A6B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FD91F22873
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7D18A6D7;
	Wed, 13 Nov 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYKN+R0z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9845170A03
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485712; cv=none; b=Z+xb8vRsIZzshriHS0N8cyxOPlEwWa/uD84B38kRvHlxD3mOcA7gCzb1WUIl6iWB8hGBdj+K4rbjb6bauU9LshO8Tf4ad3VTSjXRz3cu6Ri8Qf+fglHHy5ZQpwbAFKalAOQ/Lpwvf8jHkLX16oVQ+9BKJstvI8eYnoqt0FLhEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485712; c=relaxed/simple;
	bh=8Y0UPyHRHBU3AJ5BIj2LNvoRsdFm7+hymI+IvfPQzM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHol58A8obELDZTEwla3ns2M+oXC8uEIVCrvJSKuj4tho3cR/G6Mr4wrEfSL1Ds3FUTvG7XNU3MpeesAjUAXPcViLTXCDRmtSRUtlkSsFZEyHNW4KxWJG8Agap4QRDmdSvi+zO6lDP0Wvd7bclevJuSLpSQ6erL1QbSdAi/rxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYKN+R0z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d495d217bso5932185f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731485709; x=1732090509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQbo2SNWl0pl3CFAm+W16lnOLJFykustp1lz60+nR4M=;
        b=gYKN+R0zXaQl8gIC0e/U1UvIeObn4BCcsyHYqxsp7YBeMZJWwMp13hT2bp+B7taMQP
         wTt+1TzIYDRLmkZtbu0kpK4EMJtiU/e9JOe2EfJO3Cjx9tXAhgjkzRceTj6auhNntPRz
         TuxJPN/moJXHkDIn9Jg1WvXBv5xdoTxmOqt10jgUVokcFS+bHO4A/HQiAzq6tmnshpCF
         sh16EELhrb+TRxcWpfRdGggOXymv6jpfr2/BhED2y9o9dzwKFF1+lZxmw46+s2A/mkHR
         TV7KwdeQzUAcw8pdMAVtM8p/nrkrcxU0oaLvi4tKdPLCJoJr8Q+Laok+wSrO9WW2FEun
         7yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485709; x=1732090509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQbo2SNWl0pl3CFAm+W16lnOLJFykustp1lz60+nR4M=;
        b=TgNQbXJ+UY9bMEohZddZo3AHQdpZ7z0vWqjasEy7JFardPERWn9eWRJJU8aQSoTy2X
         /IL8EIBT3PWPWmQgTu6sBhc3MgKIJQNd5v8ZsOCGcTzjQfxFKlYFXhfbF5sCsIp3SvK9
         J+owyprf4AJHJ7q1mnVQRin9jw1QVDngNTS7tOyPxVO3mR/rPRGjhtDPIEiFpFhpCnRT
         CIQGK5uFcc2FNmWR7r4sfEgE7e3VR4zLDp6tp6aGrV1WLwQ78ZkxT3MtR6l3ErcI++5+
         Q0pblVFlnL3U7O7lpeu56sB49ZG64eCi/YNctHiPQKY48s9hGF6DvveCBBELqkqSO6Pd
         vPww==
X-Forwarded-Encrypted: i=1; AJvYcCUZoZcJ0uKj2vBVkdKFEuwHnTQZONDKFWgIQPGMcedlIuKmCkwvmvp3VPfMrm8CKZF+c63blnoCXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGH2EuMkre0zmvI/buNYFBvcVy7FWpegb4Syqm9XVE5XsBs1/
	YczEKq/B00qOX40Ui3GK+qr0vOb+l6qqhT7rnbMkmX8cUpvJvozmS37jedJb8QU=
X-Google-Smtp-Source: AGHT+IFFYloC/8jCwGxKk66s8CV5KsxYaWdZM5UqRntsEzLJT6asKbsQu3Xzl7h4UFRchhvMK6KVFg==
X-Received: by 2002:a05:6000:178c:b0:382:10dc:594b with SMTP id ffacd0b85a97d-38210dc5c10mr383607f8f.34.1731485708986;
        Wed, 13 Nov 2024 00:15:08 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:fca:835c:70ab:eebc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm17576494f8f.64.2024.11.13.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:15:08 -0800 (PST)
Date: Wed, 13 Nov 2024 09:15:03 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: Add initial support for
 MSM8917
Message-ID: <ZzRgB_U3qYtV7O0h@linaro.org>
References: <20241112-msm8917-v5-0-3ca34d33191b@mainlining.org>
 <20241112-msm8917-v5-8-3ca34d33191b@mainlining.org>
 <ZzOQEgLLhkH-IymV@linaro.org>
 <4c34cb8eec5eab92501011e446b5362d@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c34cb8eec5eab92501011e446b5362d@mainlining.org>

On Tue, Nov 12, 2024 at 06:38:04PM +0100, barnabas.czeman@mainlining.org wrote:
> On 2024-11-12 18:27, Stephan Gerhold wrote:
> > On Tue, Nov 12, 2024 at 04:49:38PM +0100, Barnabás Czémán wrote:
> > > From: Otto Pflüger <otto.pflueger@abscue.de>
> > > 
> > > Add initial support for MSM8917 SoC.
> > > 
> > > Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> > > [reword commit, rebase, fix schema errors]
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8917.dtsi | 1974
> > > +++++++++++++++++++++++++++++++++
> > >  1 file changed, 1974 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..cf0a0eec1141e11faca0ee9705d6348ab32a0f50
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
> > > @@ -0,0 +1,1974 @@
> [...]
> > > +			sdc1_clk_on: sdc1-clk-on-state {
> > > +				pins = "sdc1_clk";
> > > +				bias-disable;
> > > +				drive-strength = <16>;
> > > +			};
> > > +
> > > +			sdc1_clk_off: sdc1-clk-off-state {
> > > +				pins = "sdc1_clk";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_cmd_on: sdc1-cmd-on-state {
> > > +				pins = "sdc1_cmd";
> > > +				bias-disable;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc1_cmd_off: sdc1-cmd-off-state {
> > > +				pins = "sdc1_cmd";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_data_on: sdc1-data-on-state {
> > > +				pins = "sdc1_data";
> > > +				bias-pull-up;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc1_data_off: sdc1-data-off-state {
> > > +				pins = "sdc1_data";
> > > +				bias-pull-up;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc1_rclk_on: sdc1-rclk-on-state {
> > > +				pins = "sdc1_rclk";
> > > +				bias-pull-down;
> > > +			};
> > > +
> > > +			sdc1_rclk_off: sdc1-rclk-off-state {
> > > +				pins = "sdc1_rclk";
> > > +				bias-pull-down;
> > > +			};
> > > +
> > > +			sdc2_clk_on: sdc2-clk-on-state {
> > > +				pins = "sdc2_clk";
> > > +				drive-strength = <16>;
> > > +				bias-disable;
> > > +			};
> > > +
> > > +			sdc2_clk_off: sdc2-clk-off-state {
> > > +				pins = "sdc2_clk";
> > > +				bias-disable;
> > > +				drive-strength = <2>;
> > > +			};
> > > +
> > > +			sdc2_cmd_on: sdc2-cmd-on-state {
> > > +				pins = "sdc2_cmd";
> > > +				bias-pull-up;
> > > +				drive-strength = <10>;
> > > +			};
> > > +
> > > +			sdc2_cmd_off: sdc2-cmd-off-state {
> > > +				pins = "sdc2_cmd";
> > > +				bias-pull-up;
> > > +				drive-strength = <2>;
> > > +			};
> > 
> > These are not referenced anywhere? Not here in the sdhc_X nodes, and
> > also not in your msm8917-xiaomi-riva.dts. Would also recommend
> > consolidating these to a single node like in msm8916.dtsi, see commit
> > c943e4c58b2f ("arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl").
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c943e4c58b2ffb0dcd497f8b12f284f5e8fc477e
> > 
> > > +
> > > +			sdc2_cd_on: cd-on-state {
> > > +				pins = "gpio67";
> > > +				function = "gpio";
> > > +				drive-strength = <2>;
> > > +				bias-pull-up;
> > > +			};
> > > +
> > > +			sdc2_cd_off: cd-off-state {
> > > +				pins = "gpio67";
> > > +				function = "gpio";
> > > +				drive-strength = <2>;
> > > +				bias-disable;
> > > +			};
> > 
> > It does not make sense to have different on/off states for the card
> > detect (CD) pin of the SD card. It needs to work even when the SD card
> > is suspended so we can detect insertions/removals. Also should be placed
> > in the board-specific DT part.
> I have made these based on this https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.9.6.2.r1-04800-89xx.0/arch/arm64/boot/dts/qcom/msm8917-pinctrl.dtsi

Yes, msm8916-pinctrl.dtsi also has this in the downstream sources, but
as I explain in the commit linked below I don't think this is right. You
can probably just change it to bias-disable like I did for most of the
boards. There is usually external pull up that keeps it working even in
the "cd-off-state".

> > 
> > See commit dfbda20dabaa ("arm64: dts: qcom: msm8916/39: Fix SD card
> > detect pinctrl").
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfbda20dabaa1f284abd550035db5887384c8e4c
> > 

Thanks,
Stephan

