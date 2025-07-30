Return-Path: <linux-pm+bounces-31639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94EB167E3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 22:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C740F3B01A1
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50435222586;
	Wed, 30 Jul 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/abVUfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B6222584;
	Wed, 30 Jul 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909017; cv=none; b=SEx2GV13r0ceZ0cUqJeHwDGBXbexI0Z1+hTi3T5PQc0evqw2D0QFj7+U0zVKqHlEu1FOyL29+NlS0YDBps2+V0Le5blpKEtsvsT41CINnAOKyLMRWSiXWfKt3f5LJuGbw9IUrhRb2SEyxD0xQ0QOBIJzSFNx9hCgfbeECWqcNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909017; c=relaxed/simple;
	bh=meJm08gIW/vRrCYpVEM3urM9k5Mm+PBeXQeuvnQVQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4pgASKI5evRb4nkYY2skvTW3yJ1TyKfdMIUfvJPbPIvpnV2Vri2IPs092CrnfCrEj+jzu3NRnaOBwCpPn3u/YwP27spHp4chvgwQAEJEzx55wOM6kAoaOQ/gTKUjerZGurYiSjmFornPn/DkOqN6abUsmB03PhpzcOPsURRJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/abVUfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D34CC4CEE3;
	Wed, 30 Jul 2025 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753909015;
	bh=meJm08gIW/vRrCYpVEM3urM9k5Mm+PBeXQeuvnQVQVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/abVUfbuP7icZl+93Lwq3my8o2/6jYbJCSJ0QiaT84VAMWsguxPTRoaNY3GpCz6W
	 TyzKtkhybnWvlCMN/wRcxd5rwQd9lzfZ4gBQ1R5snp7d0gO2KB0wqAUBzQgvDWQDv4
	 gvKTMqalfwzGGXkZOb52EDKsLC+5bk2v2cgq1IBaqlHWcjZ16LasrbxA//uQ462lrc
	 I81cbSHyXF9EeRXShOA+lG3Ex2Qt7PJx3D9QmZl80sRV2Z0MCRxig1sWAIHGtJ+oEB
	 l4FeT15ITP8uapf9qWEUqtO2ZartcWM0t6tQrgJ8GJhO6Vbo4Z2fQFo+t+/VvxKVqe
	 UcaQvCMWw/m+w==
Date: Wed, 30 Jul 2025 15:56:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: mcoquelin.stm32@gmail.com, krzk+dt@kernel.org, festevam@gmail.com,
	alexander.stein@ew.tq-group.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	Markus.Niebel@ew.tq-group.com, ulf.hansson@linaro.org,
	imx@lists.linux.dev, othacehe@gnu.org,
	linux-stm32@st-md-mailman.stormreply.com, richardcochran@gmail.com,
	frieder.schrempf@kontron.de, kuba@kernel.org, Frank.Li@nxp.com,
	conor+dt@kernel.org, shawnguo@kernel.org,
	alexandre.torgue@foss.st.com, davem@davemloft.net, peng.fan@nxp.com,
	edumazet@google.com, s.hauer@pengutronix.de, primoz.fiser@norik.com,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	will@kernel.org, kernel@pengutronix.de, pabeni@redhat.com,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v7 02/11] dt-bindings: soc: imx-blk-ctrl: add i.MX91
 blk-ctrl compatible
Message-ID: <175390901389.1733801.13463071578614787293.robh@kernel.org>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-3-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-3-joy.zou@nxp.com>


On Mon, 28 Jul 2025 15:14:29 +0800, Joy Zou wrote:
> Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
> which has different input clocks compared to i.MX93. Update the
> clock-names list and handle it in the if-else branch accordingly.
> 
> Keep the same restriction for the existed compatible strings.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v7:
> 1. add clocks constraints in the if-else branch.
> 2. reorder the imx93 and imx91 if-else branch.
>    These changes come from review comments:
>    https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
> 4. add Reviewed-by tag.
> 
> Changes for v5:
> 1. The i.MX91 has different input clocks compared to i.MX93,
>    so add new compatible string for i.MX91.
> 2. update clock-names list and handle it in the if-else branch.
> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 59 +++++++++++++++----
>  1 file changed, 47 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


