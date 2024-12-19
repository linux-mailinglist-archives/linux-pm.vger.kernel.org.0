Return-Path: <linux-pm+bounces-19504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F49F773A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFCA17A2698
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951221CA01;
	Thu, 19 Dec 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kzMFVmRV"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0A218ADB
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596786; cv=none; b=RRRjdx1N3U+uh/Q3ZDkDPEeOqv6gXe5raCrGJKaQtH4plooPnmtesULi2D8DmMnS037/g5MNyLZpjrAcxY8BZeCz9jpsusY2s2OIZD4psbD+4DLdOZn1voUYDm2kNc7de7PNaS47kDm6bpwJ44AfxNtPd1IYxSDc4Oatns9ootg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596786; c=relaxed/simple;
	bh=Cl01RPJOttck3gvyGkE5Tpf1jMwwXKE85I7QwAN8JX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp94LUx1xhRb0twaXFkro/QFvwUtbVT1fDvh3Pd/2Qcs0DGQycm3ClLSqU5KT/Mai2KCCuDqzRGtyJT3DvzRidQy4igUnJ7s0PK/9d8YDlbIZJHXkcG9nmh6wq3wAqpeevtdsC9iVWl5nTbKrl+lfa0M8GGAe/+gRyYoqRZVNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kzMFVmRV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F40B460002;
	Thu, 19 Dec 2024 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734596781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JftywA7reBjvEdVfRGDtGssvyudTSPbbDpwATH5r7RI=;
	b=kzMFVmRVkM6XnKX9NgE+qrhzFhaktOTxKHRWUVvzXkdcEc8PRvFRL4zYwKjiNzZAF9hXWs
	XbS8Bsh6HTmRdPMoCutJwaKCJS+GL49MSeqqerKC67lHdLndwizuV+H4I3tXENq3t5rbCo
	vs/Yb0FuyYQCBZzzQM/lQZxVUd3xX6U3zttGwkokFsxW6wmd0F1A26h/agQaINpDZhcqJE
	G4mYTZk2alYrShXKDFycl2t7Dr9yDcMRRK+YwwFVlgC6H8G0aJDTrHxtlyH8jjmW39a5P5
	d4zo0DhUpW2pNSXVo7lWbCiZAUJUzqwcH5tvPWNfNFcxmHGCyW7kblyytAqOnQ==
Date: Thu, 19 Dec 2024 09:26:19 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
 kernel@pengutronix.de, patchwork-lst@pengutronix.de, Peng Fan
 <peng.fan@nxp.com>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH] pmdomain: core: add dummy release function to genpd
 device
Message-ID: <20241219092619.18f3fa1c@booty>
In-Reply-To: <20241218184433.1930532-1-l.stach@pengutronix.de>
References: <20241218184433.1930532-1-l.stach@pengutronix.de>
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

Hello Lucas,

On Wed, 18 Dec 2024 19:44:33 +0100
Lucas Stach <l.stach@pengutronix.de> wrote:

> The genpd device, which is really only used as a handle to lookup
> OPP, but not even registered to the device core otherwise and thus
> lifetime linked to the genpd struct it is contained in, is missing
> a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
> missing put_device()") the device will be cleaned up going through
> the driver core device_release() function, which will warn when no
> release callback is present for the device. Add a dummy release
> function to shut up the warning.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for the very quick response!

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

