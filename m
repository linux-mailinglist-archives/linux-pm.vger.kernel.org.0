Return-Path: <linux-pm+bounces-19363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3B9F463C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778207A13F8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556D1DCB24;
	Tue, 17 Dec 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mfWapWyI"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531B1D88C4;
	Tue, 17 Dec 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424946; cv=none; b=b21THbSseC6rZmWBk0v3eDYcA3hIgubE1WaLib7KKlBvOwtVklJ5cN/41U3IUmVCzOvYFoppTUOOnS/YmdPflPmFDZTYLs383dymNv8Ew4KSyA5QyibmQ5OgW9hYQN24qTmfaXu4XtZ0JoH+OKS+MHS61J52+JgUOOqzKWgtEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424946; c=relaxed/simple;
	bh=QSpktkEFl5aljmBnez15ONkM7IEJyEoiz/F4IZQK7S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/UzQQzrG9YW5qHBas0tdZz3loem9CYbRh3rNlnoi9Q1S/KURSRpzbpEQsssgSJffvSboyZjeOw6rMyXC1nRpi1Gl140DqETVU5s8+Jj0QFFpO9MMfpgnpaDkb9SHRb/7wllrqa1uPIswnKFgRj4muV+TaPWPoz9QwFe82RyQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mfWapWyI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B074C0006;
	Tue, 17 Dec 2024 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734424942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9idV19gXA8JkUDickvfvx0vTW3usv3OBF/gTIq+FKLM=;
	b=mfWapWyIqX5dLd37tsSruDGdVACdKSyEgu+qHatAIIebotStGtezb0J0kR0njEcDdomv9N
	6JhXtoibG8DYOCSpBLjbSI4ddc4QxbDoltB3dIGSNgl1NfNX6tcMDuD2O1I61wIt98sZM6
	rz73PJwPg1PEW05vbAZJ/zv4K+MHw4SCZN6pb33t0WKYMMziB5TvJSmvYxlF74yXKLQk4c
	Ky2lBg1l/T1DRk84cN9B1ayq5cRi0aZmABlagrScipjqpanqREWQG+86EajEC6B7+Voy6N
	epO+2nfmNHT6k+hRHGGY+syC0ZhrTHuKCoEiaet/iVRFdQ2q+e8PpeOopGk0ng==
Date: Tue, 17 Dec 2024 09:42:19 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Jindong  Yue <jindong.yue@nxp.com>, Benjamin Gaignard 
 <benjamin.gaignard@collabora.com>, Paul Elder 
 <paul.elder@ideasonboard.com>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: imx8m-blk-ctrl: WARNING, no release() function
Message-ID: <20241217094219.788cad88@booty>
In-Reply-To: <PAXPR04MB8459AB53B142CB43782757D988042@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241212141003.GA44219@francesco-nb>
	<PAXPR04MB8459AB53B142CB43782757D988042@PAXPR04MB8459.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Peng,

On Tue, 17 Dec 2024 01:39:09 +0000
Peng Fan <peng.fan@nxp.com> wrote:

> > Subject: imx8m-blk-ctrl: WARNING, no release() function  
> 
> Please try this patch.
> https://lore.kernel.org/all/20241206112731.98244-1-peng.fan@oss.nxp.com/

I cherry-picked the two patches from linux-next:

  e1a875703470 ("pmdomain: imx-gpcv2: Suppress bind attrs")
  afb2a86f002b ("pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs")

but I still have the same warnings:

[    5.427038] Device 'mediablk-mipi-csi2-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    6.464219] Device 'mediablk-mipi-dsi-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    6.752903] Device 'mediablk-mipi-csi2-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    7.303529] Device 'mediablk-mipi-dsi-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    8.006575] Device 'mediablk-mipi-csi2-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[    8.598453] Device 'mediablk-mipi-dsi-1' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.

This is with 6.13-rc3 on a imx8mp.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

