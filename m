Return-Path: <linux-pm+bounces-39828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F92ACD87B9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 09:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7413F3012749
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918E2E8B74;
	Tue, 23 Dec 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sXISMZcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AA21FF48;
	Tue, 23 Dec 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479746; cv=none; b=iq1uWTs7Lg3LQ52n4tywWYdEIlm9CsV5BRDviPf+4nb61aauX68c2/HlgOSlB83x5TMv+BfKUZn+8brWgA3WAe7Ys5dfwvt3KYEI8HpoRcqh4USRjScBTw+NGy98I6l4157C+SmdS9V8HWrO4+8388fY/4B1Mb0w904YYiGgE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479746; c=relaxed/simple;
	bh=iXx4yvAuZTLKwklfdVLS+WaGb0jRKKsK9ULbN0x1/NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ae7cQkgFiT9xbcotufgl4QCAm4KB4PGQi4WgYAtJinpq8xj6T90/1TIu1o0kDBbIpa9y6AhemZItclLka+XFLqyQmP+N+Eev7lb2/PIXHa+/x/ZJ0haatxd1L45IPxEnNwTaykbB9spjhqqBuXyYxkkWat1EBvKwZCWHhFXn8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sXISMZcr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1766479745; x=1798015745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iXx4yvAuZTLKwklfdVLS+WaGb0jRKKsK9ULbN0x1/NI=;
  b=sXISMZcrpPAeGVcpDYQcApCwZ8F3IvUi/5Rda/breYlQ3a234YU/prXM
   EkLFV7eh5bMrtSV2ovEMiOLbyGV4Am3ylR66wnzixD11qfZIhN8FCYONx
   le8HNZiOHnOW5sSqFKuJQ6nwmeftgc+JxoQ8JBf/09SUhNV6JxbzSmOyI
   t12i2SRPkQei1BI3CEZC7f+4XvcAhrVxFsbC9C3U9/0O2X+RZD5XLQsgs
   vtYVflTHn+1Ku8Ri32X4MPn/0ZZSs3t6Z/jSV2tOBcvUBXKDJl/8hUbzx
   L8Sdbxxc7RCAdiagYX0QJr4dJQJMIKYzgnfEYm4zaHtHIDJmkj5NJjLC0
   g==;
X-CSE-ConnectionGUID: eOuFkUwmRLWM+tb2ngwfPg==
X-CSE-MsgGUID: c/xq9xBFTaSrVqAEFLfpKg==
X-IronPort-AV: E=Sophos;i="6.21,170,1763449200"; 
   d="scan'208";a="50260349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 01:48:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 23 Dec 2025 01:48:29 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 23 Dec 2025 01:48:27 -0700
Message-ID: <bbd3cd9d-3a81-4f7d-9220-02d9df03d78a@microchip.com>
Date: Tue, 23 Dec 2025 09:48:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/23] net: cadence: macb: Discard pm_runtime_put()
 return value
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <2706413.Lt9SDvczpP@rafael.j.wysocki>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <2706413.Lt9SDvczpP@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 22/12/2025 at 21:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Passing pm_runtime_put() return value to the callers is not particularly
> useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel is
> configured with CONFIG_PM unset.
> 
> Accordingly, update at91ether_close() to simply discard the return
> value of pm_runtime_put() and always return success to the caller.
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Ok to take whichever route you choose, with a preference in staying with 
the other patches of the batch.

Thanks, regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb_main.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4837,7 +4837,9 @@ static int at91ether_close(struct net_de
> 
>          at91ether_stop(lp);
> 
> -       return pm_runtime_put(&lp->pdev->dev);
> +       pm_runtime_put(&lp->pdev->dev);
> +
> +       return 0;
>   }
> 
>   /* Transmit packet */
> 
> 
> 


