Return-Path: <linux-pm+bounces-21768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5171A30115
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBBA7A24CF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AE1C3C14;
	Tue, 11 Feb 2025 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FChz8yT/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F234CF5;
	Tue, 11 Feb 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238038; cv=none; b=b5tGaLGiTklkyrl8NtOhcs5sF+F7iAVA/K+KDnh5tCrEo7knwzlZDDJQmwVbIozDNq+Ml9DqqxeuyjcsHB6DTqsqiec/M8mquJpVgQdb/3SzpSGw7kEXDO+POKClvyaKn4lxHlfbgT6SRJjpfSZyAZeeM3HSpsHvG1q8VMQXBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238038; c=relaxed/simple;
	bh=7Nm1gW9SBC848if3tPgYD+lvEF9LgkfI3EQ1+O1q+tg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Vl+nphF3fz9PyC5ApQYYXpEU40nPZI031NxrGwId2zFyIAmMtYFwmbnJ0seFF2VI+SqxiRxrqLNItAnY87E+Ve2nTcppKZsY6aj6pm22UZhnjQbfIi3DeS3+PQXrkgtaCKF9YDQaN7sH2+3q2QKPQuv6tCBYCV2TEBXcm/whTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FChz8yT/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1739238034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59d5DCmTv0tcVe/lLttR0UbGP6r3tAFEV70fpHz4iEE=;
	b=FChz8yT/sCzvZpcb9Y6uCUI5b+dSKm4yzDwWaNUwL9UXG8DeR2W2gsIOeAINStfcmoKgSX
	sfiX2wotwRPsz2j/DBMOamYY7oJQ2XK2yjuyDZvMqWDetYoXnKhAnGWCJDrsfHAtHXAgAJ
	jtZbsFW5Rwl4gnTM6vTrDv5azgAVpKLYeFpJpnmaSKhiT5uFSNfFvMnGOPQ9je2r8rtGS2
	/3DcwHEaqDSM38lnwWxYhLivzGeB5r9NnmJjZPeWA8mYdr5isFJkCtYsULAQiwIRssE1M5
	mjjY6t+F/C3yAq7TdoghYKQZyS0OudDiNquHZdKQl6vvHLTP+1uJkxUENyFXFA==
Date: Tue, 11 Feb 2025 02:40:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Trevor Woerner <twoerner@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, Caesar
 Wang <wxt@rock-chips.com>, Rocky Hao <rocky.hao@rock-chips.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rockchip: add missing rk3328 mapping
 entry
In-Reply-To: <20250207175048.35959-1-twoerner@gmail.com>
References: <20250207175048.35959-1-twoerner@gmail.com>
Message-ID: <5f9cf65221690452d7e842ee98535192@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Trevor,

On 2025-02-07 18:50, Trevor Woerner wrote:
> The mapping table for the rk3328 is missing the entry for -25C which is
> found in the TRM section 9.5.2 "Temperature-to-code mapping".
> 
> NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
>       4096-<code in table>. Whereas the table in the TRM gives the code
>       "3774" for -25C, the kernel uses 4096-3774=322.

After going through the RK3308 and RK3328 TRMs, as well as through the
downstream kernel code, it seems we may have some troubles at our hands.
Let me explain, please.

To sum it up, part 1 of the RK3308 TRM v1.1 says on page 538 that the
equation for the output when tsadc_q_sel equals 1 is (4096 - tsadc_q),
while part 1 of the RK3328 TRM v1.2 says that the output equation is
(1024 - tsadc_q) in that case.

The downstream kernel code, however, treats the RK3308 and RK3328
tables and their values as being the same.  It even mentions 1024 as
the "offset" value in a comment block for the rk_tsadcv3_control()
function, just like the upstream code does, which is obviously wrong
"offset" value when correlated with the table on page 544 of part 1
of the RK3308 TRM v1.1.

With all this in mind, it's obvious that more work is needed to make
it clear where's the actual mistake (it could be that the TRM is wrong),
which I'll volunteer for as part of the SoC binning project.  In the
meantime, this patch looks fine as-is to me, by offering what's a clear
improvement to the current state of the upstream code, so please feel
free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

However, it would be good to include some additional notes into the
patch description in the v3, which would briefly sum up the above-
described issues and discrepancies, for future reference.

> Link:
> https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
> Cc: stable@vger.kernel.org
> Fixes: eda519d5f73e ("thermal: rockchip: Support the RK3328 SOC in
> thermal driver")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v2:
> - remove non-ascii characters in commit message
> - remove dangling [1] reference in commit message
> - include "Fixes:"
> - add request for stable backport
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

