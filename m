Return-Path: <linux-pm+bounces-19362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B79F450A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 08:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A26188FEE1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BCF18A6CF;
	Tue, 17 Dec 2024 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VckP0Aj+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63E1E529;
	Tue, 17 Dec 2024 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420316; cv=none; b=TdsNfwLwlFyFOvhFTMYCgh4CFisDWhw3bnfnoo+v7TOUaVswANIyFWT5I0HrQgeh931b9YEaR7CahRLGotSVnZuQGXp6cfehDO8/SVXveYtrgaRenJeJPielc4Mc7tqPA2+S3hNZhQVref1t648ZMQ0PEMkY9XNTKiey9AoPA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420316; c=relaxed/simple;
	bh=SIqktI3t0AAhjSeYSQWiux57263h5Nx+YwGr7UnQ6qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2NFCgpPddWFazrXU5Oz/hzdWa/u4onljctuuyDGvSEjn9XAr+OwbkeKs6IkDKmH2KU9lb8X34bt5fx9MgD6Kj+oJ4bVVpoVAsVo07D52QbntvziY7kVFamqicz+681Hi8ox+4Pmka7ePEoUfHSLy8b/VrMtqsIpdtB0y6YmklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VckP0Aj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765BCC4CED3;
	Tue, 17 Dec 2024 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420315;
	bh=SIqktI3t0AAhjSeYSQWiux57263h5Nx+YwGr7UnQ6qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VckP0Aj+Dqk2g4fmpH3WQSfPdFr6hDVsvhKgGIlwewonZlOpgBsT87wvDdMNTTv6c
	 USqLU7mwP43lb84GQpH3a1O/SnDvdAw0APRtLUthlIWPWXJAQPskMoxJsaAPGb2t6S
	 W3reYwe4iQJy4S5TGjZtDAl7IH+vkSVFHFsHa5J+NIi+iqV6TmoA+t7wISR3WsQYBo
	 q0iA3mJ6zbZAf7Ou/HLQPO5h95+xNv1tMKD+6F1NcHvbb5ghGp86sP8V/H9YgMv1Sn
	 Iwy+ceb4m6WNklNv7yoIKjA33dLPLUoLhg8p/woX4QkUa61aD6eaQG+dho8K7SaXBv
	 76m1xWDFWb76g==
Date: Tue, 17 Dec 2024 08:25:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: interconnect: Add Qualcomm IPQ5424
 support
Message-ID: <yloopcxo3elwkrhq5cncy3bnbxyyi4wvgtvoslc6v6mc4ecwqs@gknbpccuwqao>
References: <20241213105808.674620-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213105808.674620-1-quic_varada@quicinc.com>

On Fri, Dec 13, 2024 at 04:28:07PM +0530, Varadarajan Narayanan wrote:
> Add master/slave ids for Qualcomm IPQ5424 Network-On-Chip
> interfaces. This will be used by the gcc-ipq5424 driver
> for providing interconnect services using the icc-clk framework.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


