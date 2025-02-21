Return-Path: <linux-pm+bounces-22699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414DA40231
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 22:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A386B19E1D5C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AF253F1B;
	Fri, 21 Feb 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYGip4rx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4D2500BC;
	Fri, 21 Feb 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174080; cv=none; b=hbAwx24+PsVYX3g4dk5ft18qbv/+QQ/7bwH7ovWv6wrSpbtJ773U10/l5MiOwg6OlerriuQT6ywnQwPs6FJ53jUvWg3Ql1OYPU1E/OZjcQE7yzjVXLZup4AnNv7Td0UkfwsHPHNAxTnmGVOiJlYS9xSCYpOrLeywYYAlts50qbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174080; c=relaxed/simple;
	bh=v/SnGzcx/eJMMDRtXAJDI041OLygL1homwL+H1J7zik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpEbpzeEs2qBp5cal9GPIXav5sFrtpYuwuqe56PvwhCR6ZHgfEMpEkhKlNzhxdGlEVCq6b+cuwcBJXZgq00ObN7XrjLZMFOAGLoOZaNVljOYfXyrNxNrh6t+WHPakUhjmLz+HseKbjexs/YE7xmvc+/Ba63RuWXcXMtStwvHjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYGip4rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C381C4CED6;
	Fri, 21 Feb 2025 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740174079;
	bh=v/SnGzcx/eJMMDRtXAJDI041OLygL1homwL+H1J7zik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYGip4rxDmQyH7aQXu+iG9aeJNld3pXpDWP3s2+vbrAuZT2ifOoC6rEkPdTaPSObk
	 EWa6Cep/KYehSBuvj2FoGKJQBbcCB7hqAO24VFEdgZVcYXa6jcQbTLOrsccpVyA/y2
	 vuJrQl9cJGqr77is6sZ7RO/KBFNVFNe75Mdx2F6jKhKSgY10Mv+Ri21iSgfKV3YwMr
	 gXN+9qZ3tn9y7ezxuCq/gJwgotcNmER7dFPTpXOvTLPNDUg+kPWBYWwM2lnlmBMuaD
	 4zP/LDWnktt2NGVhjCWQafUR3sIF9JOZYPPomIvgiNWLZb8OcmxB2Lv5TFNnwMIhH2
	 iXtW28jAwc3lQ==
Date: Fri, 21 Feb 2025 15:41:17 -0600
From: Rob Herring <robh@kernel.org>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/5] dt-bindings: power: apple,pmgr-pwrstate: Add
 force-{disable,reset} properties
Message-ID: <20250221214117.GA119777-robh@kernel.org>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
 <20250219-isp-v1-1-6d3e89b67c31@gmail.com>
 <400d64ed-670a-4297-b43b-cdf4e8599c7b@kernel.org>
 <CAMT+MTSb2gdkfCZE3i+0ah8AgE_G8mH2MFTms=QgFwd-nbA8Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMT+MTSb2gdkfCZE3i+0ah8AgE_G8mH2MFTms=QgFwd-nbA8Ag@mail.gmail.com>

On Wed, Feb 19, 2025 at 10:43:17AM +0100, Sasha Finkelstein wrote:
> On Wed, 19 Feb 2025 at 10:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 19/02/2025 10:26, Sasha Finkelstein via B4 Relay wrote:
> > > From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> > >
> > > Add properties to set disable/reset bits when powering down
> > > certain domains
> >
> >
> > Please explain why and what problem are you solving. This looks too
> > close to SW policy or really arbitrary choice. Background would be useful.
> 
> The ISP block has some weird requirements where some of it's power domains
> will not power down correctly without using the "force disable" or "force reset"
> pmgr feature. Basically a hardware quirk.

Add that to the commit message.

Rob

