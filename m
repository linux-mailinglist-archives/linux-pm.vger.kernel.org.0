Return-Path: <linux-pm+bounces-28710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931FAD9E6C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA86C3A6A52
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538882C159C;
	Sat, 14 Jun 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju9KVuUt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E1146D6A;
	Sat, 14 Jun 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749921411; cv=none; b=DaYWKX7T82eUCwkSyTYlAXFMfYPrzQquC2OllA1PMEKMfvW6AilK2QPX8nM0rABLwO7pGi8FEINaKz67spXw45koVeUGLKtpa0baY2Hr7yAEuS4LSgK83MeUCIt0fG/JzIWcHzv6X9e5j167QbyC6mbkMm9Kz2ZG4igTDVoKlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749921411; c=relaxed/simple;
	bh=SyhuSHTiP7kYh6dQdHpRWX3b0foHA/A5vUWOW9/wys4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8KgcVy4LtNUL2BQYRVcmksfW25s51RwmKcHwK4yWSlvqCrMS/d8ncR3Xef+wEY0wxeKKvHupg5SXs1QI7ue8GzX2C7O2nMsbJ2H+AqqWgvl7NpfUNNbpa8w2LA9uob0L+qmG2thr44RxUU2fMmoAHLuYULBkrC4UVJmaKgY3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju9KVuUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA60C4CEEB;
	Sat, 14 Jun 2025 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749921410;
	bh=SyhuSHTiP7kYh6dQdHpRWX3b0foHA/A5vUWOW9/wys4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju9KVuUtGxQXCAjdaMZnZyfnQ7oL9HN0ghc7Crpm6kBXNpPwCv6vUHTg81o8eQtHn
	 7N/vjHsfsXTGqG5TEg+tfGzsKAMV2QMQ5SOmAfhVkKxN2/xjOOQj3g5YCBIw3EDqp/
	 /0ObAIAI2A2ImOL6KOHef1moBxj1Z28yzGSVTPURTkbHslRidL0NBQOsky9Pj2v0iX
	 j45c5+u3wZCb9dgin1Ll+yTXMkq7gdr2ySd6x+V5gHLalOb65MnULoXDA3aCpMB+C1
	 cNOkCekXOmUPb8vJ6ttwcI2vcj75E5ECH3sAUH3UHaTCiScHKRWN6OHUeZktGsaue2
	 bC0pOIKwGCPog==
Date: Sat, 14 Jun 2025 18:16:42 +0100
From: Simon Horman <horms@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ulf.hansson@linaro.org,
	richardcochran@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.org, frank.li@nxp.com, ye.li@nxp.com,
	ping.bai@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v5 1/9] dt-bindings: arm: fsl: add i.MX91 11x11 evk board
Message-ID: <20250614171642.GU414686@horms.kernel.org>
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-2-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613100255.2131800-2-joy.zou@nxp.com>

On Fri, Jun 13, 2025 at 06:02:47PM +0800, Joy Zou wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
> 
> Add the board imx91-11x11-evk in the binding docuemnt.

nit: document

> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

...

