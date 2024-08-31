Return-Path: <linux-pm+bounces-13274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB4966FA5
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 08:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3922843D4
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D979152790;
	Sat, 31 Aug 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkZc0BL1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25A17C91;
	Sat, 31 Aug 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084664; cv=none; b=rNR3ipknHWiNt2Q+gZZoKemrnBnZEllroKTtcs35A847DF31YhafyN7gRiaYV5UO5OePPstIm3WimEWHRWo6gzrCfir4n7s96LPpWhAjbvefTL3vgNivzYu/ZIT0Wo3XrqNUJmIKnOeC4khWcRGT02CMk14BUfOtEUwqeMOXKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084664; c=relaxed/simple;
	bh=MWcMGcmgy0DSAwlMthRl8Vzo5Q7i8wR+63kRxTfgfjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRykj6UgrIqDgO3oLUgmcohR43Qq8Uwk1SMe47zXXuF8N7WcEtD/yh+eGcvvKGRnoORiBYc3so7YCET6GJLoZob9jirzgaXAfSc0hSPJCdPHq7bQS7RQAfPx0Id4Vb8Z3aDQtL6Xuk5s/2WwRg+J0maf5FdGTPluwfzl20YIh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkZc0BL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF7DC4CEC0;
	Sat, 31 Aug 2024 06:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725084664;
	bh=MWcMGcmgy0DSAwlMthRl8Vzo5Q7i8wR+63kRxTfgfjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkZc0BL1wQbhHmu1+kxy7hfKKDWQrIV7tMA26lJJD8pD6tXdD/K4jBqMfNduqqlsg
	 AfBM8yLaCIhTvbwrL6K/ODMHSYhEvXQtxqR2LsJYf51cD3mRVqkxGh1lVJy+NjBm5R
	 T5Jel5eHlO7y7FwAFG5NaJJMWujhHtkpzjeU58buUsJQRitZNPYDmvTzZGwN7sAkr2
	 iGXGszUwZEPXjDEXnDGneHkdd5bvPUzq62TgAxisised2YLU03imy6ct/1g8rLpnTD
	 9yvfShW7T0WZl0OH2YpawAKZS+mTQtDANmCFrn1pmg4v7Ex7iZA1WE7qiASMw3hquC
	 RiYMl9P77nOiw==
Date: Sat, 31 Aug 2024 08:11:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, djakov@kernel.org, richardcochran@gmail.com, 
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org, 
	arnd@arndb.de, nfraprado@collabora.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: clock: add Qualcomm IPQ5332 NSSCC
 clock and reset definitions
Message-ID: <gomm5yozebwfuhmgziajmkflbj6knmbwae4mls5kuwl5ngcbrx@mndpiktfken2>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
 <20240829082830.56959-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829082830.56959-4-quic_varada@quicinc.com>

On Thu, Aug 29, 2024 at 01:58:25PM +0530, Varadarajan Narayanan wrote:
> From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> 
> Add NSSCC clock and reset definitions for Qualcomm IPQ5332.
> Enable interconnect provider ability for use by the ethernet
> driver.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Marked #power-domain-cells as false
>     Included #interconnect-cells

Then this might not be GCC-like clock controller or gcc.yaml 
should not include power-domain-cells.

Best regards,
Krzysztof


