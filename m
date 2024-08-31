Return-Path: <linux-pm+bounces-13275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7165966FB0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 08:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896E51F239CB
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A515F404;
	Sat, 31 Aug 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN5qrjKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CD17C91;
	Sat, 31 Aug 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084691; cv=none; b=EWqNEZHkLWSZ0XOZtN8X0Uq+KJP6w/1o72cHlKB/A54KbOCBxismy0WMjySFy/uOEx6h9ZNMqB3gnv3a6TSMe5SJ5TnPqY/a4V0EmpzZ+TnAuoEqgwlGTqbsg+ad0yA09E7X6fvINHf3qIq61hSVvkzMkyig/ao8nTsCjpI5fqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084691; c=relaxed/simple;
	bh=osC7WiacnaP7crO1hS8j91BzniV/k027bYrpl9+d2go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tppcpPSyQz/15nCYZCUrTVFfHsCqtRrsr4VyyH/8zGqbtVizETIsrSOdth19tXPGl4r9azcAfUDT1daHUJW+m86R1Y3Q14GThlt/n1OFXXJriTsljBneiG/TYcH3EwBFxFIYIYK+vCSf7U7cnnK0WognC37EjBPF1Y9vgzm/8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN5qrjKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373CBC4CEC0;
	Sat, 31 Aug 2024 06:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725084691;
	bh=osC7WiacnaP7crO1hS8j91BzniV/k027bYrpl9+d2go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FN5qrjKNSmOTZoCYtJdxP4132AXTzYbnR8NKHzLRjFeIeAVNTOL8a9+2eZqAAw+/b
	 YpalDJhT2HV2R3JxRSX++pZVlMq5obv7BsTozR89epLNPkxxXrpBTW1FNQDOnMr18p
	 6ioZt0JfHMhLa5P7AGzBX0bavbvrMLixuwVy8lmcUHMlybgGiHQcvOpWZz2eGB26ql
	 gceNc4gq2QNFzdXZk4et5D5Fz8teq0EAoltcsdDBeMkBoV1dGN6864gNzVKmA+TDKN
	 8RXNmZZQSmWGuX2LCK/n0/PNNIBlxXD2HfWPOtWhkCb4kCaA1jGmaweYRJ4JFv9Juj
	 nIJKcMFaz0sPQ==
Date: Sat, 31 Aug 2024 08:11:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org, 
	arnd@arndb.de, nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/8] dt-bindings: interconnect: Update master/slave id
 list
Message-ID: <jg33xalhdrae5kkouhptx75qy3dvb3fe5ktw4mxi6va42ptcv7@ujhkpen5t6db>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-5-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-5-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:26PM +0530, Varadarajan Narayanan wrote:
> Update the GCC master/slave list to include couple of
> more interfaces needed by the Network Subsystem Clock
> Controller (NSSCC)
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq5332.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


