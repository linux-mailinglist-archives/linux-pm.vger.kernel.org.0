Return-Path: <linux-pm+bounces-12179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40445950D2D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726CF1C2375F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAD57CA6;
	Tue, 13 Aug 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBK5qn3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6C1DDF4;
	Tue, 13 Aug 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577605; cv=none; b=b5IhQgBWoHGiyVKNBw61DyjnjLh/9PbadX4xHWFHrieWIWVET6WOndoVS0cFkHfMId5cPa5NP2Lvi13XDTtdugn/HdY83NmNU06M8suvo9QEbwnNw8ITEwWeMczPDLXUV6SK6MiFDdmEHiye2WE7W/JIk/u1fgzsaR/1Zdb3+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577605; c=relaxed/simple;
	bh=rm97gXI+l1Fwe6Kn2YMqYOXmvbNtrrbI4C/PzxPhonU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1lvJv8S/Vmr0FgzyioeEHTJQW3ZNe3sh53nmY4pYc5zEqod5z7snnzqVAWsw10vDdBbwGI02HzjsZYyLLdiz9VNxEdMTkpAWJjPTvAse//KAa4j9vFDuu2Z8E/zE9N3wa8HRmkKBLmpGux9nSro0lVo+WE5ZnSR+40HF4wP+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBK5qn3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DAFC32782;
	Tue, 13 Aug 2024 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723577604;
	bh=rm97gXI+l1Fwe6Kn2YMqYOXmvbNtrrbI4C/PzxPhonU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBK5qn3Fh+9veh4jfspLI6ZCtcpaFLIMdcZQlwvXpCX2gRMfhsGRsPkEkbGwZr0Z8
	 gZ7WwKJXVmmta+QoGGxmpRbhkZq/0j/nvtrYKxqOc1GztqWU6IDjDiIiW1RhMxCXAO
	 njdJ7boURAGkoFyzs9ZMuEhmA3tkghHRtkUVH2YJWq36ZEpDgDZzrVATdxlVUAFY/k
	 HxErlrv63ULNtbPqAwF1v/wl3NlyARiDFQPMTbSznCuLWVdBdcqdrOuKezCR01DL0/
	 Gr+839yc2umGohfk9Ka2LQjPOXdVFY/WidoQHG3ts9b7Xt+j0Ls3APrtGTKBf7T1+y
	 PCLj5GY0MN3Pg==
Date: Tue, 13 Aug 2024 13:33:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: quic_rjendra@quicinc.com, ulf.hansson@linaro.org,
	linux-pm@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org,
	konradybcio@kernel.org, kees@kernel.org,
	linux-hardening@vger.kernel.org, conor+dt@kernel.org,
	viresh.kumar@linaro.org, macromorgan@hotmail.com,
	dmitry.baryshkov@linaro.org, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, davidwronek@gmail.com,
	tony.luck@intel.com, kuba@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, andre.przywara@arm.com,
	krzk+dt@kernel.org, rafal@milecki.pl, linus.walleij@linaro.org,
	andersson@kernel.org, netdev@vger.kernel.org, fekz115@gmail.com,
	davem@davemloft.net, edumazet@google.com, heiko.stuebner@cherry.de,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: nfc: nxp,nci: Document PN553
 compatible
Message-ID: <172357760218.1617229.6241404560319061675.robh@kernel.org>
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-7-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808184048.63030-7-danila@jiaxyga.com>


On Thu, 08 Aug 2024 21:40:20 +0300, Danila Tikhonov wrote:
> The PN553 is another NFC chip from NXP, document the compatible in the
> bindings.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


