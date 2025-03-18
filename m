Return-Path: <linux-pm+bounces-24232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE9A66DFF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 09:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C8B3B31D1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9811F09BA;
	Tue, 18 Mar 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPXlpZwd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898B1EFFA8;
	Tue, 18 Mar 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285859; cv=none; b=W1X/4VIxzU07Dzfa+FxiwAiLXow8hgOPCXENSN4riGCUtlFeVNV/WgVFsi75kGKugyFH5lduCgZ8uwW/YDsnovco41wrOai1xD3a1NNcyAWoEx+Pr8IKh/CXjIebSACSLLR9G0oeL2yOY2P2Ua3hd/EeMjnjCnsn1PSLymRb2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285859; c=relaxed/simple;
	bh=8L984J6oUIr8k6ovv1GbTnbV57ioRrqsuA0xfoQGt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgGZcmgF3VlWFH+s0yafHepLbgrhwULRmeC0PVzaAMdkDSM3aeTp3ULjLugH5lJi9Cf/q+8crAfbnwWboNIAW+bW6yVm4bibA62ln3ruX/Ky2ErxlwcgAuCD1WDj5OB/iMVjA2yuImqJy5t9xo1gOsFUr8FgsHsGX2i6ZvKM5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPXlpZwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E502C4CEDD;
	Tue, 18 Mar 2025 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285859;
	bh=8L984J6oUIr8k6ovv1GbTnbV57ioRrqsuA0xfoQGt7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPXlpZwd7hEZbeLrcqpxaTdTACHM4HRNB61g4/h3/w6YA6p0HBHxYFkmOG6Rlvofs
	 zcREguwZvtCooDayPCzH1Q+g+TjNtFgKz0nfJ6UWGad0WcYNS5uVrD+HN/E7ZD/dnY
	 nx+3wWCu1hPV4m97Ojfqr2JmN0l5u47MlIc/UH5XC0tBPOpq901MSyd2DeRIIlaPd7
	 PWWysezAqNHH+QjdX5/lDTsfZ9RKXtZsSNRFyXCsdLOpGaIujiw401O1v62fEmb3DW
	 us1spuHB4l28OQDzwcpoUSvy2UCEU0GGxn116ZTtFt7DL16POz2AJPi7b8o8xH/TLZ
	 kHmz1ru4E80tg==
Date: Tue, 18 Mar 2025 09:17:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	magnus.damm@gmail.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	sboyd@kernel.org, biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com
Subject: Re: [PATCH v4 5/5] arm64: defconfig: Enable the Renesas RZ/G3E
 thermal driver
Message-ID: <20250318-meticulous-cautious-gorilla-4ade21@krzk-bin>
References: <20250317143442.100590-1-john.madieu.xa@bp.renesas.com>
 <20250317143442.100590-6-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317143442.100590-6-john.madieu.xa@bp.renesas.com>

On Mon, Mar 17, 2025 at 03:34:32PM +0100, John Madieu wrote:
> Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
> RZ/G3E SMARC EVK board.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


