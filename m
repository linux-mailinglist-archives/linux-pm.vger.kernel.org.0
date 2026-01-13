Return-Path: <linux-pm+bounces-40731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D169AD18AD2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC67D301A628
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE638BDD7;
	Tue, 13 Jan 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1c6VxYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429E2BCF6C;
	Tue, 13 Jan 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306854; cv=none; b=QBdgVTnF4uMpoEq001y1ATcJTY8SGJKBwYZYgLVyU184Wi4Fm8nhlVIR1PlDNoso1hLZ7ZBW+DLu5K4ihIc2bGSNGonfyEw3KZCqZQT5B2NBcPziQvtrO7eDsJF92rRUAvB579+Q+RkQzrh38gvArWNGB6xbXWVyM4WOsfeU6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306854; c=relaxed/simple;
	bh=uN66kPtEzqYLKuiXmvgrJrjnA4XtsNWaNAKycUAnaHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btfeOKGJRft57AqpVfy3oZq8C0/aysE5ruAP2GR9OTQEJtcdp9YFcyKTiS8nAfA+D6mhA1O+QPfVOKOlqoRplyPFTZ5T5CmQ593DkSWlh1uDTe4xt/vjjvM+C4wSgVppIHQC3FXIqXUe+9+CjVZT6SK1cX1vIavudtLUostReBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1c6VxYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C0DC116C6;
	Tue, 13 Jan 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768306854;
	bh=uN66kPtEzqYLKuiXmvgrJrjnA4XtsNWaNAKycUAnaHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1c6VxYoVeXm4ht83Y/YkhrlIGLdnl0tdou479gE2jEgKmabSIqpYpBKFeazU5Z0s
	 KOHm8ePiEYK3Xi7QpnZKg/tI14CWmQyMbc2WL7pd0TExtw5Fe+UtrliKx64AxzG4Y4
	 MlKoD+WyVoxliE7DJje/OqacPCwbj+Y2v0CJ8s1XvJiHVtIrkFszHegRhjGrlzIU6A
	 JF7aUn7bW9kP53VBXcKdyplbrFKtzP33p30iykq8HbQ3gals2hfSyK0kRlqZoxDW5h
	 bqfIWZoXkX/soLfrs0bO/l6w08fXCRsPJshp9wu9ro4SLxo6KHMSsJlr6apf49l8wL
	 fjlEu6cg8/2+g==
Date: Tue, 13 Jan 2026 12:20:49 +0000
From: Lee Jones <lee@kernel.org>
To: michael.reeves077@gmail.com
Cc: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 0/2] Add Apple Silicon SMC power driver
Message-ID: <20260113122049.GH1902656@google.com>
References: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109-b4-macsmc-power-v2-0-93818f1e7d62@gmail.com>

On Fri, 09 Jan 2026, Michael Reeves via B4 Relay wrote:

> This series adds a power supply driver for the Apple SMC found on
> Apple Silicon devices. This allows the kernel to report AC status,
> battery charging status, and power metrics, and modify the charging
> behaviour.
> 
> The first patch adds the driver itself, and the second patch wires it
> up to the MFD core.
> 
> The driver is based on an original out-of-tree implementation by
> Hector Martin. It has been refactored for upstream inclusion, 
> including support for newer SMC firmwares, devices without batteries,
> dynamic property detection and improved state management.
> 
> Tested on: Apple M3 (MacBook Air, J613)
> 
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
> Changes in v2:
> - Added Reviewed-by: Neal Gompa <neal@gompa.dev> to all patches.
> - Fixed Makefile alignment by using tabs for the macsmc-power entry.
> - Upgraded physical battery exhaustion log level to EMERG.
> - Downgraded software-triggered orderly poweroff log level to CRIT.
> - Added check for CHIS key to skip AC registration on desktop models.
> - Link to v1: https://lore.kernel.org/r/20260105-b4-macsmc-power-v1-0-62954c42a555@gmail.com
> 
> ---
> Michael Reeves (2):
>       power: supply: Add macsmc-power driver for Apple Silicon
>       mfd: macsmc: Wire up Apple SMC power driver
> 
>  MAINTAINERS                         |   1 +
>  drivers/mfd/macsmc.c                |   1 +
>  drivers/power/supply/Kconfig        |  11 +
>  drivers/power/supply/Makefile       |   1 +
>  drivers/power/supply/macsmc-power.c | 883 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 897 insertions(+)

Let me know when the Power driver has been merged and I'll take the MFD part.

-- 
Lee Jones [李琼斯]

