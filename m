Return-Path: <linux-pm+bounces-7667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86608C0360
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD31C24318
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CE8627B;
	Wed,  8 May 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gWvQOHvt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89E1E529;
	Wed,  8 May 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190064; cv=none; b=ZyHwdkWZYOYXbO4ly7huoXvFDNf260L+N19b3PMj8P+kk1bLHaGHHmAQK30rVa1EoG3o/oESS650bLL6ZFqEAka01XzuqSSzclsJVQKK39KE9duK0ixi8+f2W1/9Wi/v91JZUih85uKI+ZSItoicJnVZA8By/M9iaIUVDi9r8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190064; c=relaxed/simple;
	bh=+U1RLFKF/zn7hMLbbVtxwTGlZgQo/cGDB0xuxsC+IbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzIcQSmfvPd9RJFr3Knp4Hzmix33QFdhEQDzdSmN8C0MIT4DeV13b0rz/AI5gXBkpcqhYs54iIMAyhFbjFZqe5psN3JsQj6XW8Yz53G3laNSRfqNHyWj5vJMjNs3VMOLZTTw7WjoePtSRNqhi8z5Bf1QzWqTJU/ohqvXdHi2nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gWvQOHvt; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 94CBC2027A;
	Wed,  8 May 2024 19:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715190053;
	bh=rOCYAYk/4JwmzqnbBL/qv10PJF5H7DRT2QaXA8QKZKA=; h=From:To:Subject;
	b=gWvQOHvtFnCkkls7PJZAYF+0R/A9QYWTqFX07pcxlLCgjeEawofMOJp8lazlWcYfh
	 G1y7AM8De7TyqCsDvlZGz1/tx0JxvOnqQhcBl1JovI36BTXGgcUxUfZrphW4URn+fS
	 1Xw5altysHgPsjIsag5coRiK4eUV0MMwMCmPrfeOFVC6E2m0ApAjH13dLTfftpJ4gf
	 j6J+oz/sMi2P3gNsP1pTlxNFxDgddY/eUQogWmX2Xb6tko+A9eF39MGvOc1zhP0KvE
	 FZbjaGdv3gX90hh87gUwHb17jPM7VBAjhJzEucq/zK9FnaXwtRNhMGZTxLJvcy1bA8
	 iXDj8dL4NYZFA==
Date: Wed, 8 May 2024 19:40:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>, Adam Ford <aford173@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
Message-ID: <20240508174048.GA5257@francesco-nb>
References: <20240418155151.355133-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418155151.355133-1-ivitro@gmail.com>

On Thu, Apr 18, 2024 at 04:51:51PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> During the probe, the genpd power_dev is added to the dpm_list after
> blk_ctrl due to its parent/child relationship. Making the blk_ctrl
> suspend after and resume before the genpd power_dev.
> 
> As a consequence, the system hangs when resuming the VPU due to the
> power domain dependency.
> 
> To ensure the proper suspend/resume order, add a device link betweem
> blk_ctrl and genpd power_dev. It guarantees genpd power_dev is suspended
> after and resumed before blk-ctrl.
> 

Cc: Adam Ford

Francesco


