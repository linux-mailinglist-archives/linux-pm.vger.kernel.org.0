Return-Path: <linux-pm+bounces-31134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28462B0B919
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888D93B66F6
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DD22D4DD;
	Sun, 20 Jul 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSbI/dIx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF9185E7F;
	Sun, 20 Jul 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053291; cv=none; b=nlZGJ2abZlDAQSjz5pvLjt6rZqc7ipnhsDuZAj848F5rGVaSW3fsISX26vRPyKFYVW7cZ8msNHHmo8IcaysHhwY59GFqAWhvMA6Mx9Ub347NZt56m8qMwTf1eV5FBrG1LPO6bKaFBZUxJACd4qVO5j9rm+9N9F96OP22IrrlfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053291; c=relaxed/simple;
	bh=OQwQvxm6Q2KinutCS4PNCDJD90HO+SHTV3G6rx0KPdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCAiZuNFiZ6MDrn4gUkaxloAklVL5qUt69oszodyLWKqEq07HUfhqgcd39iJ/5lus2pwap31H6XH9AQCMKZ2CEEXWJypjDbUrHrMc9iE7OeH/vFFxakqaqo+XvO3Izb73+QLnbH+kwojGweAwxSpL871+i9Tw83E4J6mkLB1dLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSbI/dIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189B4C4CEE7;
	Sun, 20 Jul 2025 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753053291;
	bh=OQwQvxm6Q2KinutCS4PNCDJD90HO+SHTV3G6rx0KPdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSbI/dIxz71Cic2xTDFwVvGkeh5HWmxIJDt0kp+Md0Sjo+qwAc/x69L27yYAVduti
	 itazWQnzkyM61aKMvZZBsEBrrUhuCqS93KAbPMTV45HxaKpuGzX/dFq61Kqf5arc20
	 2tWOerr+d1k4EXaWdgvCI0KnvwDJ4XZQJ+iTzewSZHVty/qVJl6haPFXtdASAA2mx5
	 kbDByq9dd7EfPJ8wXnUIJJSBsG+kWii0hLrsHZpq4VLDG6N7nFrDDwmmEfHR4ggt5w
	 DHdkLoKp7Uw6GIYjS6/U+CqfqzIx4cKGuYTrGJKS/BgDc469xXxM2XnwdYIRK46wbW
	 WsdUj+HBw9Pww==
Date: Sun, 20 Jul 2025 18:14:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: a39.skl@gmail.com, djakov@kernel.org, krzk+dt@kernel.org,
	raviteja.laggyshetty@oss.qualcomm.com, lumag@kernel.org,
	quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
	conor+dt@kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
Message-ID: <175305328995.3049333.15023006374330516032.robh@kernel.org>
References: <20250716151535.4054172-1-pankaj.patil@oss.qualcomm.com>
 <20250716151535.4054172-2-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716151535.4054172-2-pankaj.patil@oss.qualcomm.com>


On Wed, 16 Jul 2025 20:45:34 +0530, Pankaj Patil wrote:
> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,glymur-rpmh.yaml        |  84 +++++++
>  .../interconnect/qcom,glymur-rpmh.h           | 205 ++++++++++++++++++
>  2 files changed, 289 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,glymur-rpmh.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


