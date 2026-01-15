Return-Path: <linux-pm+bounces-40952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CED28921
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 22:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4211B300D334
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAB1FBC8E;
	Thu, 15 Jan 2026 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACPWfmPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58AEED8;
	Thu, 15 Jan 2026 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510837; cv=none; b=AcqqQz5hn9ixbFZcPqvX3rsdEcqqx1cY2JWZCCT5MzoEYWa1UDk4agRPFVIZs9PHzsxOFpbS9TiIbeXy4XmM3Z7tK0u9sCEX8Z8Ln8lhRmH01pMedLgc8cckdJkWd4iPyikL8Pf2yp9ebdHatjR81PuUFhYcz2X1GFKjuHlAfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510837; c=relaxed/simple;
	bh=DykiV8OWIGZBqj5EbF75NN1M9XHMbeDKlJ0/Mh6XJ7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTJuTg5regwjAS114ZGC7LUGqbMXftqaEO8eTZ1QR7BtPI1cDYML+IYKVO4RKbJwf+TIEooAE+wFMBPhs6a/cjpSfr/7dTJcafFQX6DSIUmGSvMnwp+XtZyTU7K5+PVDf4ydqOJxZjrGAd3f8DYdo1KQP7LvLH6b0qM2C6+L8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACPWfmPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659BFC116D0;
	Thu, 15 Jan 2026 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768510837;
	bh=DykiV8OWIGZBqj5EbF75NN1M9XHMbeDKlJ0/Mh6XJ7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ACPWfmPbEgahCgAzAGCzEtKriOasnghvP7Zt5xB74K+zymKMYmEBJKKQeqnC0/L0V
	 WWLdAu28hiNXXQYVnhA3mRtaktnX2ldstmms5z1sPg6ekeQOMKb2k/LzCrbAwp4zas
	 n90v6kuMXR/bnXuFagW23WaVi8nx0vMxQq7ssJv3dKwVCzW6sKBvHPGgjE72vRhdo9
	 ht49jMDgwzEMfywZTg7/Xxz7ze9mKGWU1cMFVxt/Vs74SW8PkuXc8WwKhrMoMDG1l1
	 MEf/c/3nFhHYiU2hVsPD+gCQiNtpUJEaChBAX1ym93lAvFMLAbfTYp3j4ZLaz+rQEP
	 qdoC1AElh2idA==
Message-ID: <af3204c0-0492-4555-9a75-3716fa264ecd@kernel.org>
Date: Thu, 15 Jan 2026 22:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] power: supply: Add macsmc-power driver for Apple
 Silicon
To: michael.reeves077@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Hector Martin <marcan@marcan.st>, Lee Jones <lee@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Sebastian Reichel <sre@kernel.org>
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
 <20260115-b4-macsmc-power-v3-1-c236e09874be@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260115-b4-macsmc-power-v3-1-c236e09874be@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 1/15/26 08:08, Michael Reeves via B4 Relay wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> This driver provides battery and AC status monitoring for Apple Silicon
> Macs via the SMC (System Management Controller). It supports
> reporting capacity, voltage, current, and charging status.
>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>   MAINTAINERS                         |   1 +
>   drivers/power/supply/Kconfig        |  11 +
>   drivers/power/supply/Makefile       |   1 +
>   drivers/power/supply/macsmc-power.c | 834 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 847 insertions(+)
[...]
> +
> +static int macsmc_power_event(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct macsmc_power *power = container_of(nb, struct macsmc_power, nb);
> +
> +	/*
> +	 * SMC Event IDs are reverse-engineered.

Any chance you meant something else here? The event IDs aren't special, 
everything here is reverse-engineered ;)
No need to change this imho unless there's another reason for a v4 though:

Reviewed-by: Sven Peter <sven@kernel.org>


Sven

