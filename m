Return-Path: <linux-pm+bounces-11912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC0947887
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116341F228AA
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4415573F;
	Mon,  5 Aug 2024 09:36:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197714C5AF;
	Mon,  5 Aug 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850615; cv=none; b=gFbyYoyevAa4x0KMlFIzHtroHb8ekyirJu8pouodDpYhMcjO7bQ33kcYNwL4sy9iM4FnaiCF1Fo7N1RDrUHdo7ItJY/9SLgw2PtYbxROdFiNxLr/0kqfC332CYrdRyHfOvQKnoTOXDL9je0J8X60W3mTufm3c1xVbqaZnpmPIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850615; c=relaxed/simple;
	bh=gECcuOqnDC7px2rdOd0P3fnei3HB2ODtLOJFm1LB/ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8rj15DVRs1ekoNf9QEnO7S1DjPG9mhMLDLoY6HO/0ksglq8gnhhLNzthcSgOfTV5U8XMZV8esnDiWtUjw8yNBGyu09R69oubaZzx9ItnCpRkPL4xNJCQNPm5UT+EpfoNhytHQ1aV5oe/V4Ru5KKHqvQOYiviYmcFFL5mouRooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sau8v-0000TX-UA; Mon, 05 Aug 2024 11:36:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 3/3] soc: rockchip: power-domain: Add power domain support for
 rk3576
Date: Mon, 05 Aug 2024 11:36:40 +0200
Message-ID: <12859392.hYdu0Ggh8K@diego>
In-Reply-To: <20240802151647.294307-4-detlev.casanova@collabora.com>
References:
 <20240802151647.294307-1-detlev.casanova@collabora.com>
 <20240802151647.294307-4-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Freitag, 2. August 2024, 17:15:00 CEST schrieb Detlev Casanova:
> From: Finley Xiao <finley.xiao@rock-chips.com>

with the power-domains now living somewhere else, the patch will need
a different subject I think.

> 
> This driver is modified to support RK3576 SoCs and lists the power domains.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>



> @@ -552,7 +574,10 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  			/* if powering up, leave idle mode */
>  			rockchip_pmu_set_idle_request(pd, false);
>  
> -			rockchip_pmu_restore_qos(pd);
> +			if (pd->info->delay_us)
> +				udelay(pd->info->delay_us);
> +			else
> +				rockchip_pmu_restore_qos(pd);

the whole delay thing needs its own patch please. I.e. you're changing
the inner workings of the driver here by not handling the qos settings
and just waiting for a specific time.

So I expect a lot more explanation on why that is the case and needed
instead of it just happening when adding the soc-specific pieces.

Does the rk3576 not have those qos settings and if so, why is there a delay
necessary.


This is not meant to disallow it, just that it needs its own commit with its
own descriptive commit message :-)


Heiko



