Return-Path: <linux-pm+bounces-38350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56320C7884D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 339004E9972
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A87340279;
	Fri, 21 Nov 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="c13HocQP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539394C97;
	Fri, 21 Nov 2025 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721054; cv=pass; b=brtPPcxb39inNrQNFWVj53ltWwNWzVSSRFqFPgWC9Dm02i93bY1G0ai2fCtohyUwtszc3SC6Za9vLd3oFFZksjUtId8IValHULwlZEYassN+fxsHXLtYaS0Tpf7hxuvxtIqE5JT0FKV2XTCzuSBT4V1KN7ncTtSaPICPTWl9ru0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721054; c=relaxed/simple;
	bh=cJNg9CMO2XzFOYNsXRbWPJs+C/51bgw0S6GQMq+gZ9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLn43WA2E7OzngRj+dHBoq4k56MzCCYCdaffhWm3iSz4oji5WJ1aF3yRuC80IvVv0yjo95l2zMAaCgnTaHGJgxjLpp7HUqCBT4v/fFrdAdr+dM9rs1c780tpkvuRsPfk2c9ek/xUaZY1ZGIfSImoLl/+qliiKMttWffZmik1q08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=c13HocQP; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763721012; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Seii7yGgiAK8YqQd3A1uljT0JIy/Rn1UVCro8gYHBzeklgaoSJaCMu7uOlMHUgPEAhdXAhmjmlNsPRCTMhn7cpq97vpdfkT1BHJRmpTjNbm0oUj8FwmIEvqt+ZmA5Ytgxpc8/bAGyoq0/A2YJyOkPqWJYhTZqiEu4yux09mM/kg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763721012; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gn3wOGMh35VRAyLK1z47rfPXxroKNFJ6qRR7lUA5vuc=; 
	b=HFwMQKJpirHsE9HjQ/VIVGncO0FhTLIjc0JjMJfsDtKZ0TqCEbW480JVdpP0uL846XjpYMKjE2OzilpF/3oE4JGaQZujwLrpowTBeBhOrWubk0hUjSL04XlYAzvLcL5XSZ4RSqdPsZsq7Bq6mWOmX61Hxti+4M/zuqNzWInjOrw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763721012;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gn3wOGMh35VRAyLK1z47rfPXxroKNFJ6qRR7lUA5vuc=;
	b=c13HocQPgKuWgTuCJ2uA0XulrvwGkyEwubh0Q4UmVk0K7Z1djTilCdbbxC3s+llP
	PkzpvWfpHABOipyA778yBgcZv5fYSpzmFaFhoovo+i9b7hgKTOZx19rbnti5xDa6KAN
	QrNsdOGJBtc9CRESwezDzB+MPvrIDI9/1aMDs8Ic=
Received: by mx.zohomail.com with SMTPS id 1763721011318865.399722972453;
	Fri, 21 Nov 2025 02:30:11 -0800 (PST)
Message-ID: <ec5adaa8-078f-4c6b-94af-c75b1fe3ec84@collabora.com>
Date: Fri, 21 Nov 2025 11:30:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk
 mask for 8mq vpu
To: ming.qian@oss.nxp.com, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 p.zabel@pengutronix.de, sebastian.fricke@collabora.com, shawnguo@kernel.org,
 ulf.hansson@linaro.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
 peng.fan@nxp.com, eagle.zhou@nxp.com, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20251121081911.1682-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 21/11/2025 à 09:19, ming.qian@oss.nxp.com a écrit :
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> The ADB in the VPUMIX domain has no separate reset and clock
> enable bits, but is ungated and reset together with the VPUs.
> So we can't reset G1 or G2 separately, it may led to the system hang.
> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
> Let imx8mq_vpu_power_notifier() do really vpu reset.
>
> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

Thanks for the patch.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 5c83e5599f1e..1f07ff041295 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
>   		.clk_names = (const char *[]){ "g1", },
>   		.num_clks = 1,
>   		.gpc_name = "g1",
> -		.rst_mask = BIT(1),
> -		.clk_mask = BIT(1),
>   	},
>   	[IMX8MQ_VPUBLK_PD_G2] = {
>   		.name = "vpublk-g2",
>   		.clk_names = (const char *[]){ "g2", },
>   		.num_clks = 1,
>   		.gpc_name = "g2",
> -		.rst_mask = BIT(0),
> -		.clk_mask = BIT(0),
>   	},
>   };
>   

