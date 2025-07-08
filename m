Return-Path: <linux-pm+bounces-30391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD44AFD4C8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 19:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B6188F465
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0512B2DD5EF;
	Tue,  8 Jul 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVaTHAoU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637A202F70;
	Tue,  8 Jul 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994387; cv=none; b=O++9qehiFK8EJ92cGqms2eDOJJUJqW1dA2kup9Ksz1UU1VOfRZk1OE7GODh01idWXNFGytL+3FkSkqqTBhyYy7K624UPXVv14cyQtLa2yUUl52i7AX4ejNbiAB4uk2zh4v+T+kxb9Pk/JzEVSbDYroPxhuhmR0v4VjXZF829CZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994387; c=relaxed/simple;
	bh=8ifDg8SArNC+rBce95rWN32spKeHoIWeM80KoB3c3Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbxrUTnAQvZgf5EIFylPHSO6FMrBlQE+i8jw6et/FqhNdxjrKjteB+Jb7J7e8DOSoB0lH61PdPhxjWsfkSJi7wun38clvgIlT2Qh4MY2xYcr90bOvd3Y5ga++7qUGT/JEW6YXzq0AT8TIgW5U+B7GC3NEekU+M8pUJ0p96LHJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVaTHAoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEF2C4CEF0;
	Tue,  8 Jul 2025 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994387;
	bh=8ifDg8SArNC+rBce95rWN32spKeHoIWeM80KoB3c3Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVaTHAoUeICmwkF7/uRzMNm5R5uIma512L2DDSmMoEHSRq+r44f1VNx8+S4qy8lgd
	 8syFIHYpv1dtZt1d9EPoFSBHkLyO4i9pLwZcdro5+YkAnoSOAV8W01s6poVy4+GGtU
	 zKW82Qb9oTr64BWdpwT+cTYcwZundZPQp/Q815t2FyvPu4w27jB3gS/dkukpom4epn
	 0h7xTEMcmFoy1ksQOu5J9dApvmmBpywKXFRJnMTsaPyrGjP4Yz/1kSNPLVwcHe6zD4
	 PRDrx9Dc8GgV5vsLW+dTrnqQfqFg3g37uXe9UyApaHNv+rL0Fn5HYwZsngeyEteR9P
	 j2NIZndUpDMjA==
Date: Tue, 8 Jul 2025 12:06:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: iuncuim <iuncuim@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Maxime Ripard <mripard@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: nvmem: SID: Add binding for A523 SID
 controller
Message-ID: <175199438588.636779.3304055956997373541.robh@kernel.org>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
 <20250703151132.2642378-2-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703151132.2642378-2-iuncuim@gmail.com>


On Thu, 03 Jul 2025 23:11:25 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> The SID controller should be compatible with A64 and others SoC with 0x200
> offset.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


