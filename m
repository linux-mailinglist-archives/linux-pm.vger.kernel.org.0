Return-Path: <linux-pm+bounces-37740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0940C471B9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC95A3B8603
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374E3126D3;
	Mon, 10 Nov 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fqaK0G2U"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE48228CBC;
	Mon, 10 Nov 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783872; cv=none; b=tz8CDxOGp/kyPFqLC0A4YG+7LgFDGOGA141tESGz4ccfK2X+6cKKPUFvW/sZWF9GjHo2wY86L+8ZXxEoU28TpbEZ55Xk6EbZ8LWGG/Y+Y/eTwEHN1dVLe8tvBCxXFP/xdf++7ET/PL0HLwaGPYSr6Bems/EmB2KQbzzO6qoW3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783872; c=relaxed/simple;
	bh=48QFvVDn/gQXwmUmio9XPnllOgtcyyXloU9GmXy3GXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LVahrcXrN4H1IioAgXAz8aTuqd7QdqUIInRoLVkmQ89upAVx5GqQEZubW93hTwX1SreSNJQfien89cZ6cBPqqN5YBVEEIw/dqTVCx22sZbsbe5FWyXjZtLMMiDScvokoN4wdvSeUgr/ZGmnW4AZ3EDV8JslaZWQ2qGZcg8/CnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fqaK0G2U; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762783871; x=1794319871;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=48QFvVDn/gQXwmUmio9XPnllOgtcyyXloU9GmXy3GXQ=;
  b=fqaK0G2UuX2xilf+tgALA4wwHmLX2BJVjU9Cgrnf49Jfrhwg/vCwKqds
   Oq4ZG4kgnKjEBWM13ip1XXF29R8TJlo3yGqxp9YUrEnPfllFLkpS4hs0D
   ffXxx3ThOx/wtcSttt2NxiiW0R3ZINvncu+u0ITrTPilJYJZKYUtBk5hT
   HS1oAUOWac689eAA2JHftXAl8NFZ7z3AdUyOFfzhZetpBHsrbeu9fIxvy
   ENVVzf0Dn1e7JaA0kcvyrJYXbRSTgAfSIxyvoMr1kgLgR95NUWS94R5Na
   3exCpgiKT7XlGQ5lfBz5/skC0bjkxXd1L6djneJHO9mTLXmdFF4UOhQdH
   g==;
X-CSE-ConnectionGUID: 7jHQAg5DRaCcnmeaPG7SRg==
X-CSE-MsgGUID: cZ/bQKkfRpi6h9O940oGMw==
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="280277302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:11:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 10 Nov 2025 07:10:29 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Nov 2025 07:10:23 -0700
Message-ID: <e7ddaff8-0d8a-4d79-a2b1-97aaac524a83@microchip.com>
Date: Mon, 10 Nov 2025 15:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] irqchip/atmel-aic: Simplify with
 of_machine_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yangtao Li
	<tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de
 Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-arm-msm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-8-d780ea1780c2@linaro.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-8-d780ea1780c2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2025 at 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Krzysztof, best regards,
   Nicolas

> ---
> 
> Depends on the first OF patch.
> ---
>   drivers/irqchip/irq-atmel-aic-common.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
> index 3cad30a40c19..e68853815c7a 100644
> --- a/drivers/irqchip/irq-atmel-aic-common.c
> +++ b/drivers/irqchip/irq-atmel-aic-common.c
> @@ -187,20 +187,11 @@ void __init aic_common_rtt_irq_fixup(void)
> 
>   static void __init aic_common_irq_fixup(const struct of_device_id *matches)
>   {
> -       struct device_node *root = of_find_node_by_path("/");
> -       const struct of_device_id *match;
> +       void (*fixup)(void);
> 
> -       if (!root)
> -               return;
> -
> -       match = of_match_node(matches, root);
> -
> -       if (match) {
> -               void (*fixup)(void) = match->data;
> +       fixup = of_machine_get_match_data(matches);
> +       if (fixup)
>                  fixup();
> -       }
> -
> -       of_node_put(root);
>   }
> 
>   struct irq_domain *__init aic_common_of_init(struct device_node *node,
> 
> --
> 2.48.1
> 


