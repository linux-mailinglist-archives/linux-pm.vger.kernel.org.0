Return-Path: <linux-pm+bounces-32897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD2B3121E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76FD1CE27B9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B112EDD61;
	Fri, 22 Aug 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CDohxI7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DD2ED84F;
	Fri, 22 Aug 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852282; cv=none; b=D4pB6RPqxuPrQMrGN+BejBA2Vn3EcrJMOLwYVZSmpcwmNLA5QRhZgSI8Lxj7jWiBcnhJrscD0PFLUX8HnuMteBfMbkqODKkm0qYES3cx7EkrymLQVMdc3c1tQ4Qj4cf7c+V2gMtspIeDkyqndE96ttb5HfpdYbqq680vk3pbbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852282; c=relaxed/simple;
	bh=WIbTbcYWzk0LwWnpPaIMHccPvGBc9pWxBYx0XcS0yUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxz07JSOYW//lO87zU8HZ9UCs7jRIn+Giz5+ncyP5z5HeHDfRvul0s4/CyDFtIj4IzDzTEAIiEjTcvxKlqNj9D3zkMUuh+QymxYcShvKhEJTuNNEVng6eTem7cjaGOlf1uryg7EcxNoa310Q+b68zbpn7TR4R7i8VQKrUsvXoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CDohxI7/; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UISHobrNh95ObNFh3tYCD32MPVeq0eeo9WH+Sn/Lp0Y=;
	b=CDohxI7/RTmNtk8Lq7gKdoNqYdZtzyyReCeYNx73wEYD8wMw167gSXfwt5tQd/
	JDlfrLT9jjz5H6kFKQFyaeizeUAoQyh6GfZah4uYeVwr33C21BrE2r+9I1lkehM2
	Zm1nrpgc14EhL3vqRhZtb2rw8EoMmo67Gu+Km438xHpJI=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCHJdqPLahoTvcnAw--.15193S3;
	Fri, 22 Aug 2025 16:42:57 +0800 (CST)
Date: Fri, 22 Aug 2025 16:42:55 +0800
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
Subject: Re: [PATCH v8 08/11] arm64: defconfig: enable i.MX91 pinctrl
Message-ID: <aKgtj9UVLnuoJzrj@dragon>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
 <20250806114119.1948624-9-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806114119.1948624-9-joy.zou@nxp.com>
X-CM-TRANSID:Ms8vCgCHJdqPLahoTvcnAw--.15193S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1a0PUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNBKzGWioLZLpOwAA3h

On Wed, Aug 06, 2025 at 07:41:16PM +0800, Joy Zou wrote:
> Enable i.MX91 pinctrl driver for booting the system.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Applied, thanks!


