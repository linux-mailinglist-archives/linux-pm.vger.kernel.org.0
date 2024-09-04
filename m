Return-Path: <linux-pm+bounces-13601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D196C294
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD4C1F2662F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1991DCB10;
	Wed,  4 Sep 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+b1gPIC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E24205D;
	Wed,  4 Sep 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464107; cv=none; b=c4zkD4Ye23bLSjLTF3TrofoA/KvldsR5eZKzWEPgM1H67hCmDbvOoRwd7j3vWXuGDwyEqnvL3Le9xUdFew8cFl8k/bKe5DJwbXxPfdeKFDPMnCwCYxJP5N1FSWLCauJ8pNPz9wwemB2yBvfOtegyvNazqH9VhxPJqq7OISv5fMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464107; c=relaxed/simple;
	bh=1pU96qvam6HwqeVggBD6DXU4s+pa2KDtJzjUDxKCWkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im3DvH2XME7c/xeip+mE3KvLkFNspjF1HNTKP/Ws2mApOSuwCBuweVqFvpBwEKI1TRUNCuTCt7vPQP2r1GGAu5fYkU1kx/XIX3JS45c2OkAuVujwkKrTBmdm56pzmKYs2ptkDrUcyMSi2NSUGxB6CwmGqCsf7EQ+HT49ISu6y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+b1gPIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E42C4CEC2;
	Wed,  4 Sep 2024 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725464107;
	bh=1pU96qvam6HwqeVggBD6DXU4s+pa2KDtJzjUDxKCWkI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+b1gPICqzI27a6sfvvmoYmwsF4p8TYxziKf3j+JjmH5HmgQEM0jcz+JLuaBkQnhF
	 gcOBLmEAcc3kxdrwSiQsfmfGjGCQ3e+4SEH+lJCp1cJ/BCxkrW2hUWnjK+KXv55IMs
	 jdF7S8K/ZbyzsAJmhp5nN1Ks/tE91q5m9S+qZ3iKSFRZaf8TnFhN6CXwwTAyimK7w5
	 DqdXqPNh5WkwqUAPudFFw805EQNKGnuzW4yc5XIAlM6WNKhzA7LjVDKXtte09EN/aH
	 VB33wupdXUZyQvpXyz/tnxRdF4ySOIbSHMBmPY7ixdgEOgvpCrTZibIePd+s4HCpQA
	 rGMBmNVSs8W/Q==
Message-ID: <d127ba13-cd92-438c-8bf7-f1656a9eadd9@kernel.org>
Date: Thu, 5 Sep 2024 00:35:03 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devfreq: imx-bus: Use of_property_present()
To: "Rob Herring (Arm)" <robh@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240731191312.1710417-11-robh@kernel.org>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20240731191312.1710417-11-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

24. 8. 1. 04:12에 Rob Herring (Arm) 이(가) 쓴 글:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/devfreq/imx-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 86850b7dea09..49798f542d68 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -59,7 +59,7 @@ static int imx_bus_init_icc(struct device *dev)
>  	struct imx_bus *priv = dev_get_drvdata(dev);
>  	const char *icc_driver_name;
>  
> -	if (!of_get_property(dev->of_node, "#interconnect-cells", NULL))
> +	if (!of_property_present(dev->of_node, "#interconnect-cells"))
>  		return 0;
>  	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
>  		dev_warn(dev, "imx interconnect drivers disabled\n");

I'm sorry for late reply. 
Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


