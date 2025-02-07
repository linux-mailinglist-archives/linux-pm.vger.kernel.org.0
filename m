Return-Path: <linux-pm+bounces-21556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F4CA2C9EB
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB3416675E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD351885B4;
	Fri,  7 Feb 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Mme29LFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61CA17C224;
	Fri,  7 Feb 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948526; cv=none; b=j/X8MX5TFMiZmfmYquIS13sfPGSYeGuTmoN0bnfpV5OnN8N3ocAy7qHq0nOH453M8KK7GILjnH4H25Ak2cfFAdrrbGuXAOjW4VCdg7274fKkaXTpScGQO6BHwj9rp34YopPs1SOjySPeEA0Uxx16ePrBVxxQzEf+c8J1l0IDbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948526; c=relaxed/simple;
	bh=OsBYe3e2+k5OLr2baFH1D/E1EGyz6GPlLRt8B0Dayhs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CJ0Dq0tOa0wffV6HeoPoN0IG9vdVkngnD6tvqnT+dw+PNdN+pW6pKN03Ttc3bny6RNLiJK58C+s5fccTkuSbGWEEKjntxVZtSL4OZ5lwYYX1qZRJWt+usvmLRBArC2bLSuw/7TD8XojbVMJ2x1GglUCN1nVCBBrcXy9GQvzAfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Mme29LFF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1738948522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9sJgZkwObZZZ/WV0HjnziR3OT4ESIIcpDukzt2Zb4s=;
	b=Mme29LFFtloTAst8s+o3ggTPvUtlDtIDaHNR4Ti+CdP8H4fDOMgUQEFHtPReb4j4HU65w2
	RYlzX9uZKgnJkc6CDP5htfsDwwlbFVD/D8XOX9Hd21Gqza6iHpkqjL/ir+H1VEX+OzIad1
	bihpS+mAHXlaA4hORWckcP2yXtfX9NVlivPzKOHcAkbZo5KT9//J1DDDk2t5aJLv84vaAe
	Cy7jdZPSSvyOI++KZXMB1YM9S9njI4GSZhbxR9ohSMw7DJ+LnezliWZ+Dj78pux/JGfbz4
	2NeSnNAexum0rP1+jqyuneuVQlxKWUQ+jvf0SVXxQgwfllFfo2GRSaXduMKAZw==
Date: Fri, 07 Feb 2025 18:15:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/rockchip: add missing rk3328 mapping
 entry
In-Reply-To: <20250207164740.14475-1-twoerner@gmail.com>
References: <20250207164740.14475-1-twoerner@gmail.com>
Message-ID: <fc3c4542d5cc4d95f74692140e5ea8b5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Trevor,

On 2025-02-07 17:47, Trevor Woerner wrote:
> The mapping table for the rk3328 is missing the entry for -25°C which 
> is
> found in the TRM[1] §9.5.2 "Temperature-to-code mapping".
> 
> NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
>       4096-<code in table>. Whereas the table in the TRM gives the code
>       "3774" for -25°C, the kernel uses 4096-3774=322.
> 
> Link:
> https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Thanks for the patch.  I think this should also include a Fixes tag
and be submitted for inclusion into stable kernels.

> ---
>  drivers/thermal/rockchip_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c
> index f551df48eef9..a8ad85feb68f 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -386,6 +386,7 @@ static const struct tsadc_table rk3328_code_table[] 
> = {
>  	{296, -40000},
>  	{304, -35000},
>  	{313, -30000},
> +	{322, -25000},
>  	{331, -20000},
>  	{340, -15000},
>  	{349, -10000},

