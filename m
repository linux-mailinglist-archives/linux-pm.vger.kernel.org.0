Return-Path: <linux-pm+bounces-32895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A003B3121B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F19AC189E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F32ECD13;
	Fri, 22 Aug 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Mrr/ECZ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8119D880;
	Fri, 22 Aug 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852260; cv=none; b=EDR6ncOupxI/+McwEZBP19nCff/F3z00HgNloencoldHBaLaTgalc1nYIsXfnBPK3FDnEpG1dceYIcSpFpNePD26ofQAOEN4kfH+ARf3AW8MdAcfCiXnqD36hw4N5r3meoHBQciK722ddUnk/qfGsx84sR/pEWuUEZXHeD4AVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852260; c=relaxed/simple;
	bh=i5MGaGPZFXaGix0CeJMOQeq3AS/r/2cOZSfHKXkBdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M72BE/4MN1vW+A/uDQXnd2LMoxocZCnGZh4s9Iu5s9+6At7hLONcKib9w2l5Q5Hf8rngQaxycNsM2kN/KDC2+msyhtJU+inbDrPA1MYCcqDIQtPgb805tl0inHptHiwESXThqSqw0Wz9wsrNgsJYHljwnz0xP5kXvoj35/CTaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Mrr/ECZ1; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=YcyCpXC//LwKFU9yjAyJNXfcojjXsbo2azge4YgyYVc=;
	b=Mrr/ECZ13cJlTtArHixXMkiu25wJJaamvKcsqFEDchBndXLXXtYkoq3en9d4SI
	Ai7V6QkKTRYiNwm/SIhGD9mCkpNJOqGJlhody5pzkemMje/TdILct0kEEwQcH4CN
	9S1FzV2e314/87B9dGhuPfnVdRH362k4EdTMeE9QxzQMk=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCnZW9sLahoW3sVAw--.14819S3;
	Fri, 22 Aug 2025 16:42:23 +0800 (CST)
Date: Fri, 22 Aug 2025 16:42:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: Re: [PATCH v8 03/11] arm64: dts: freescale: move aliases from
 imx93.dtsi to board dts
Message-ID: <aKgtbDHjU6Ldku5T@dragon>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
 <20250806114119.1948624-4-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114119.1948624-4-joy.zou@nxp.com>
X-CM-TRANSID:M88vCgCnZW9sLahoW3sVAw--.14819S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUorcfUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAQSxZWioHpAnjAAAs0

On Wed, Aug 06, 2025 at 07:41:11PM +0800, Joy Zou wrote:
> The aliases is board level property rather than soc property, so move
> these to each boards.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Joy,

Could you resend those DTS patches with a rebase, as they do not apply
any more?

Shawn 


