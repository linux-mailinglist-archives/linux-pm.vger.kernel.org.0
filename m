Return-Path: <linux-pm+bounces-31092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13209B0B0F9
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B506A1AA2480
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452628851C;
	Sat, 19 Jul 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pDnwgip7"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21320B80A;
	Sat, 19 Jul 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752944278; cv=none; b=quNhEYnTlMtB+t5dMy5g1JOo1u5A01lGZKtgxF2bgHIVacjCBoT35r7+ph/y9V16NALRzxTqwT+AfdfeFH24SeFmTxEnsD4z+B3vfao+gyfJpsmFPJlkww1Z7qQPK8hzhN1liDIP2sl44KZwfMpa9qJQW2hmfnwwjeGgrLq84sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752944278; c=relaxed/simple;
	bh=vqvz+1tGu+LpaR4QvDy5MuUcglJGRzLgrNDVSW5K+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGgpCFIl7BhPAqr+xNjAph9LyyFcnYfP3ZskIeU/nTjLy1/e/cSGhtUESJ7/w23B+1oclmAMKp57MbsnoTQ5ODG7S91BVvhTbRphsm20LUFrTvVn9uOTwk+1f24IXb7zm+Q838OLlqBVM+O91ODcoO6p3nxLXko4VgO/R+CBtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pDnwgip7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1mfA517rjzPZoRXNHzM0lVU9Rb/n66iO6+Wm0YH3JEY=; b=pDnwgip7JjpRRWIQ+7eRa13nTL
	sQhiLhgkqwUNQzTMjMiV6IwiXk3MJxORqA/jcroj65TMl3vSBO6v6/9F/sFhmRJLyGC2ssIVr/z6t
	xIGP+9TukEbjzMlariteXOPgxw88EJGzpxqNhZ+1M9Fk8GCP87KYK0v7j40u+srk3kNg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udAsS-0025PX-Nw; Sat, 19 Jul 2025 18:57:36 +0200
Date: Sat, 19 Jul 2025 18:57:36 +0200
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
Message-ID: <8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
 <6vlm3ybjpy2jq3cr2pzj4vcmqwoissdml2xmhfzlulfbrpzakt@xrepu6c5zykb>
 <713b2cc8-1bc7-a8b7-678b-5fc7fe25615a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713b2cc8-1bc7-a8b7-678b-5fc7fe25615a@oss.qualcomm.com>

> >> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
> >>  {
> >>  	struct qcom_pon *pon = container_of
> >>  			(reboot, struct qcom_pon, reboot_mode);
> >> @@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
> >>  	ret = regmap_update_bits(pon->regmap,
> >>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
> >>  				 GENMASK(7, pon->reason_shift),
> >> -				 magic << pon->reason_shift);
> >> +				 ((u32)magic) << pon->reason_shift);

As a general rule of thumb, code with casts is poor quality code. Try
to write the code without casts.

Maybe something like

      If (magic > MAX_U32)
      	   return -EINVAL;

      magic_32 = magic;

You might be able to go further, and validate that magic actually fits
into the field when you consider the << pon->reason_shift.

	Andrew

