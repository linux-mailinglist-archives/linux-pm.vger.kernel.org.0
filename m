Return-Path: <linux-pm+bounces-32894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C326B31200
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66E4C4E2BC4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6542EBBA4;
	Fri, 22 Aug 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="je0N7Nlk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09D287276;
	Fri, 22 Aug 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852156; cv=none; b=eiMHIxLqvHNYgkzWfcLkFqCZuleumJHIGvSWWx8mzvCRXCj0bVuTrQRng53xJ772VtBRUXqoE9ibs1Jjy2q5nDivQYBUb468WPZEhn5iPJqFjWOTGPGdlqshBdpDVymZ3WOonT4a2xJ6UXILZ78FIj916wBGQdlkfWvS88+Lg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852156; c=relaxed/simple;
	bh=WHCfEIYrpZ9r/ypC/WgaKQSC3GIDtKB9TvHLS/cyANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtlxwKYfIYgKDi7gb73UY9Lv4Pv1ygQAz1MSAbptX6zLK3zUxKvUchWvv/xGb4FIKsdfAmh195jr+GgVkiRCjZSbrlMjAF9otFJk6UA5ErKXFIJ5XXdB36rsKYHoE3bQkB2yMLExQXHKPTlg0e0DfNiTtGMugal8VR5n1GicsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=je0N7Nlk; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XrMbvNKRSNnSF17wBBbmWQ82eEPNaqSlEuR4cZ/H4CM=;
	b=je0N7NlkWm2hwsblw0RIflKegRq7k3Te40Q5yJVH9a/Z3td9XRc3Z8mqLIrYIL
	ydY7X5rlP6z80W6dVxUbz3XYMZvx7Z6yq0KsBoV/uw0gXOjbKB4Kha1iDMPNUQ6K
	mTxe+NMwbIJRIv2WOA6wHHIgySXcZFOJYchR871XRCztI=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBXpG3mLKho6HQVAw--.9849S3;
	Fri, 22 Aug 2025 16:40:08 +0800 (CST)
Date: Fri, 22 Aug 2025 16:40:05 +0800
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
Subject: Re: [PATCH v8 01/11] dt-bindings: arm: fsl: add i.MX91 11x11 evk
 board
Message-ID: <aKgs5TylbGJ2GBiQ@dragon>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
 <20250806114119.1948624-2-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114119.1948624-2-joy.zou@nxp.com>
X-CM-TRANSID:M88vCgBXpG3mLKho6HQVAw--.9849S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5qXdUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhuxZWioJsERLQAAsG

On Wed, Aug 06, 2025 at 07:41:09PM +0800, Joy Zou wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
> 
> Add the board imx91-11x11-evk in the binding document.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied, thanks!


