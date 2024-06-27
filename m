Return-Path: <linux-pm+bounces-10143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A791B02C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0973B22C8D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1675C19D06D;
	Thu, 27 Jun 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEXEDyGp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C519CCF9;
	Thu, 27 Jun 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519078; cv=none; b=k4zUsZZcMi6sfsHgYWkWwAImYHuxbxCbETRxoOMQCEDBaHuBex7hmU4CH9LFoKt8EQl6O8tPs0cVWyZ+AfNw9dclNEp2NbJTrBSMqcHUF2g0gs3VUXPNDLGe23496D+6n/8gjlapEa17OUttXE2hYFmmOBzpzb45WtHuCCHBnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519078; c=relaxed/simple;
	bh=30VpcP2HQszuamE+pYvGHUtD0iR9Lcf18YCqMcCnn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Y/DcfPQEutgP1U1zttPpwN2pDSHiMfQ4fnVis+qSIz7EbPRfO/xlEpWReIm7aT8HomzmSOhhpqobXM1oxWW75D8VDj/NpGOdohToIpHA9CXSLcN9Sjzgld5HxLD3BpwSVE1cabFyjl2Mvac3kkO8eJQGz473xVeifv+arA7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEXEDyGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA39C2BBFC;
	Thu, 27 Jun 2024 20:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719519077;
	bh=30VpcP2HQszuamE+pYvGHUtD0iR9Lcf18YCqMcCnn7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEXEDyGp5Z7fLNp/YFcANR7YaDNOs9xbAN07QdAZMrfEW/vFJaGVqX9JImEXUVQxN
	 YMU86Zsb6/FDyvkQnzBfsICaviaOaiHPPdwz2DNWpS0v1s7uhzPkbsBWbQyIZAGvhv
	 V1XHUprDfdAhUu4TM7SUhh8XjA5nrhr0Cq80Pa8rIS6mpzcJvSleTdMXoNUbBP8JL/
	 uYTP83i0aVWbqwvy7q9nu0vf2NsyexeP1AeJKByefobzoT92K4nJWbEgOyDP9SiTuE
	 BpE1Ynn6IXXY3UFdSJf8dDV3xtY1BJw5BzKDqTolKfOVxw42k7XUloPYze1Q6wQMKG
	 eew4hCvqeVaJg==
Date: Thu, 27 Jun 2024 14:11:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	devicetree@vger.kernel.org,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm: Document reboot mode magic
Message-ID: <171951907413.454523.14280050979481568902.robh@kernel.org>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-2-086950f650c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-2-086950f650c8@quicinc.com>


On Mon, 17 Jun 2024 10:18:08 -0700, Elliot Berman wrote:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


