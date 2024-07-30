Return-Path: <linux-pm+bounces-11718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10150942154
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 22:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB59A286E21
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1018CC15;
	Tue, 30 Jul 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwjCx34K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1318B479;
	Tue, 30 Jul 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370292; cv=none; b=cf9FHBFZkhbHpV3pgo6QMcIWrfjLFT8dqtn/OPvlZ2W4spsr/2/mcKx5uamkfrY/w+OzKcC5Tag2j4gJbvaJPZNSxwrb1Ecy6+EkEOgFTleWc53HCSW/jIKcV7WN8JEeV8nn74uDtmGJYqB9diroYXpZ5WkLitdBVTq9WOyr7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370292; c=relaxed/simple;
	bh=h7xX26OUGEpC01WYdJ3hZXmyAhI3DKjPX1LnEyj8824=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS43CtiJrvH37b6GzQ7aX81c8TO21NOILyQRi1TUHG8s6Q6e50GjDBdoUsLArJM15RltKlfpQB1V8kthi7lJ2rOIBSXi9F2jNE7l1o/aksxmsxbBWNsZNrqJXzK0+EA5oWnZ+bVojyP9xFGx6jbi9KJiRxE0Kh5Wy6F2Z8jbfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwjCx34K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D1C32782;
	Tue, 30 Jul 2024 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722370292;
	bh=h7xX26OUGEpC01WYdJ3hZXmyAhI3DKjPX1LnEyj8824=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwjCx34K+uBYqyDO2TeGAoWeLfBrz65dSk4iUyUi72Uz5xOp3OPezmamBQ4KEeWwI
	 zBXCCaEz3efqUabyLYLWgE1I03N2jfyOR8ueD0FGIOeYtMfOYyId3HQhalGeIEjpW7
	 dzwgL/ps4093qOl9thTjsqMtZ9d2x7x5c2cO+9m0cPHUFjaW9e6zIesxKv7MB/FX0n
	 tZ17bSEjw+OX0nFIM6RN5NDQPeth9KrKY/fwRpt2YTHkEWjeXA4PMW+goxf5G9Csbh
	 Cr/EBHb3iTuSF4GYozPA3zMl/EWSNo6xS93HBSoEeF9ViyUhLzNI+u+QE1Kk4tnY0U
	 fM7vrjPIs3ptg==
Date: Tue, 30 Jul 2024 14:11:30 -0600
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, rafael@kernel.org,
	viresh.kumar@linaro.org, heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org, kees@kernel.org, tony.luck@intel.com,
	gpiccoli@igalia.com, sudeep.holla@arm.com, quic_rjendra@quicinc.com,
	andre.przywara@arm.com, ulf.hansson@linaro.org,
	davidwronek@gmail.com, neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de, rafal@milecki.pl, macromorgan@hotmail.com,
	linus.walleij@linaro.org, dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com,
	quic_kriskura@quicinc.com, lpieralisi@kernel.org, fekz115@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux@mainlining.org
Subject: Re: [PATCH 00/11] Add Nothing Phone (1) support
Message-ID: <20240730201130.GA2074210-robh@kernel.org>
References: <20240729201843.142918-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-1-danila@jiaxyga.com>

On Mon, Jul 29, 2024 at 11:18:07PM +0300, Danila Tikhonov wrote:
> This series of patches adds support for the Nothing Phone (1), identified
> as nothing,spacewar. The Nothing Phone (1) is built on the Qualcomm
> Snapdragon 778G+ (SM7325-AE, also known as yupik).

Your email header has this:

Content-Type: text/plain; charset=y                                                                        

charset=y is not valid. When git-send-email asks what charset, press 
<enter>, not 'y', to accept the default utf-8.

Rob

