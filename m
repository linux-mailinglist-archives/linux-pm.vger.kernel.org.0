Return-Path: <linux-pm+bounces-13234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1969660CE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B181C240F6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60654192D6C;
	Fri, 30 Aug 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oNRzYtg9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D218CC1E
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017533; cv=none; b=hqm3uPthduHGffZvFLsIqBfJiqSdTQQAPBjRUSYzeD00EOydKPEWABb5kqTFN8h+TqYNzNpiffB3J8LUS1cj4sNr1vVSYmwzanXTTlRTmksJjKBbzybllKHshSHG5wdD9Cjg3DC3wKHgER5Liex2kgToD2EeIlD+Mq/Ca7GjIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017533; c=relaxed/simple;
	bh=TfrqS+eEJC4hvAjbeCZHqAZjGPqiFyQI8yt6hFcSBPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvbIw/R84Y3JBp8jheDWwWaKHgNGNeTp3+FmugcYp9aDD6JokyQrW/hLVz7a6sbeY8qFy2cAFwURTJQUhm/ygcE69CC2LTrFmUHXOQQyZijTeHXoOPJ082NlAsd1D5wjr7I7Y3md8D26mndTLgD3szWgvRlfDX0nDdJQzQhg6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oNRzYtg9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso14494025e9.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725017529; x=1725622329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSAdrIdIlTZrcDnp23HrKjtj5P2NCbxTQsvhsi+KTpM=;
        b=oNRzYtg9L7I0fm1Je+kshl1tjmCeL0TM0IZt0B1IClTv80MwL1TRLuMoOtC+qfOX44
         1hDQU7Q0C+pJx8UwuquvkLYgDMMuw0beqTobZ7WV1zXfenyWCPdMmXJqpT92qB9+MfvM
         hVxM0DsJ4hk/vA+LM9BSN5GuiiTmR17aWjN+8AD+oTI5epPQjcQrAJ0nwrTvNHSqQzC5
         EPeyB0scKxlL0rO6CFWNAxmTIEz40XZyBAzyj5u6cc4QTVt6FJFvJcWvUd92DK7rAagH
         44e7NUFjbLBN1ZOgCZUbAPxjxBdeXFU5lF9NBCk0UPzLsVYgWMeRjtZbdjrHoXprfcG9
         xnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725017529; x=1725622329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSAdrIdIlTZrcDnp23HrKjtj5P2NCbxTQsvhsi+KTpM=;
        b=ADjziwvKjerCaXGkw1LodfYIJAyQYYrqktgIPvKqyAQG6emGV6oyduT7W2NTlPZmDl
         tJnM9D5FkLnt0tx/pdHZ+7JSX9/Yjzy+2es8vGxLjKxDA45EeQ5lYIxIcqQ9cnkRAxmB
         6zc71ScIrxIrmTktU7PALebP5oiYyMTeoRA5XRdDAA8VDS31+2Y2swyVoHh+neA1rtzJ
         +e1LToGuV+Rdzuizqu0/HM07s10prH0MJriI3v0kYMEMLrX3/94nPv38vuEypEJZh5aj
         UK4DCS4dqPpSZ370DozfH6k8yCxhV9XRo3L6t9mksFG8acoL622i6vIeyTeKr3tv2/3r
         KkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvbbmteNPgnBC56i00k9lLU9u1lNhXQ71aht3jXh/B01EfG4UmFvZLcngMnr94zJl4XeamoQmcnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAETLOyrwIqXUGE6N7N9huPJ2mOn2H1G0W3Rn4gO9JTaZ0Jwmf
	N+aV56nkUta5D7VkPMdsjfg4jWXjMrUecLaIkvWxBIQ86jkvSqMmHoksnY8GKEc=
X-Google-Smtp-Source: AGHT+IGCHErgOXx4yyX533NrAWENK9/do0M6Sx35yhBOeVo9fVW0bDEo+wGDIbFLyg6RNTrJOm6ilA==
X-Received: by 2002:a05:600c:5110:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-42bb02591d1mr38716245e9.14.1725017528752;
        Fri, 30 Aug 2024 04:32:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb2dcsm43774765e9.1.2024.08.30.04.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 04:32:08 -0700 (PDT)
Message-ID: <fa9b3449-ea3e-4482-b7eb-96999445cea5@tuxon.dev>
Date: Fri, 30 Aug 2024 14:32:06 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com,
 sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <CAPDyKFrVS2vpsJqTvjKCJ7ADqXc4D4k2eeCBsaK4T+=pXDnKUA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAPDyKFrVS2vpsJqTvjKCJ7ADqXc4D4k2eeCBsaK4T+=pXDnKUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.08.2024 13:14, Ulf Hansson wrote:
> On Fri, 30 Aug 2024 at 10:22, claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>>
>> Hi, Ulf,
>>
>> On 29.08.2024 18:26, Ulf Hansson wrote:
>>> On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Hi,
>>>>
>>>> Series adds initial USB support for the Renesas RZ/G3S SoC.
>>>>
>>>> Series is split as follows:
>>>>
>>>> - patch 01/16           - add clock reset and power domain support for USB
>>>> - patch 02-04/16        - add reset control support for a USB signal
>>>>                           that need to be controlled before/after
>>>>                           the power to USB area is turned on/off.
>>>>
>>>>                           Philipp, Ulf, Geert, all,
>>>>
>>>>                           I detailed my approach for this in patch
>>>>                           04/16, please have a look and let me know
>>>>                           your input.
>>>
>>> I have looked briefly. Your suggested approach may work, but I have a
>>> few thoughts, see below.
>>>
>>> If I understand correctly, it is the consumer driver for the device
>>> that is attached to the USB power domain that becomes responsible for
>>> asserting/de-asserting this new signal. Right?
>>
>> Right!
>>
>>>
>>> In this regard, please note that the consumer driver doesn't really
>>> know when the power domain really gets powered-on/off. Calling
>>> pm_runtime_get|put*() is dealing with the reference counting. For
>>> example, a call to pm_runtime_get*() just makes sure that the PM
>>> domain gets-or-remains powered-on. Could this be a problem from the
>>> reset-signal point of view?
>>
>> It should be safe. From the HW manual I understand the hardware block is
>> something like the following:
>>
>>
>>                   USB area
>>          +-------------------------+
>>          |                         |
>>          | PHY --->USB controller  |
>> SYSC --> |  ^                      |
>>          |  |                      |
>>          | PHY reset               |
>>          +-------------------------+
>>
>> Where:
>> - SYSC is the system controller that controls the new signal for which
>>   I'm requesting opinions in this series
>> - PHY reset: is the block controlling the PHYs
>> - PHY: is the block controlling the USB PHYs
>> - USB controller: is the USB controller
>>
>> Currently, I passed the SYSC signal handling to the PHY reset driver; w/o
>> PHY reset the rest of the USB logic cannot work (neither PHY block nor USB
>> controller).
>>
>> Currently, the PHY reset driver call pm_runtime_resume_and_get() in probe
>> and pm_runtime_put() in remove. The struct reset_control_ops::{assert,
>> deassert} only set specific bits in registers (no pm_runtime* calls).
> 
> Thanks for clarifying!
> 
> For my understanding, in what register range do these bits belong? Is
> it the USB logic or in the PM domain logic, or something else.

The PHY reset block is an individual hardware block with its own address
space, clocks and reset signals.

The PHY block may reside in the same address space with USB controller but
it can provide PHY support for an external USB controller, something like:

+--------------------------+
|  PHY ---> USB controller |
|   |                      |
+---|----------------------+
   \/
+---------------+
| USB controller|
+---------------+

Because of this the PHY block is modeled in Linux as a standalone driver.

And SYSC is an individual HW block with its own address space. This is
where it resides the control of the signal for which I'm asking for directions.

> 
>>
>> The PHY driver is taking its PHY reset in probe and release it in remove().
>> With this approach the newly introduced SYSC signal will be
>> de-asserted/asserted only in the PHY reset probe/remove (either if it is
>> handled though PM domain or reset control signal).
>>
>> If the SYSC signal would be passed to all the blocks in the USB area (and
>> it would be handled though PM domains) it should be no problem either,
>> AFAICT, because of reference counting the pm_runtime_get|put*() is taking
>> care of. As the PHY reset is the root node the in the devices node tree for
>> USB the reference counting should work, too (I may miss something though,
>> please correct me if I'm wrong).
>>
>> If the SYSC signal would be handled though a reset control driver (as
>> proposed in this series) and we want to pass this reference to all the
>> blocks in the USB area then we can request the reset signal as shared and,
>> AFAIK, this is also reference counted. The devices node tree should help
>> with the order, too, if I'm not wrong.
> 
> Reference counting a reset signal sounds a bit weird to me, but I
> guess it can work. :-)
> 
> To sum up from my side;
> 
> As long as it's fine that we may end up asserting/de-asserting the
> reset-signal, without actually knowing if the PM domain is getting
> turn-on/off, 

With my understanding of it, that should not happen, at least not with the
current implementation of the drivers involved in this.

> then using a reset-control like what you propose seems
> okay to me.

I would prefer this option, too.

> 
> If not, there are two other options that can be considered I think.
> *) Using the genpd on/off notifiers, to really allow the consumer
> driver of the reset-control to know when the PM domain gets turned
> on/off.
> **) Move the entire reset handling into the PM domain provider, as it
> obviously knows when the domain is getting turned on/off.

This option is what I've explored, tested on my side.

I explored it in 2 ways:

1/ SYSC modeled as an individual PM domain provider (this is more
   appropriate to how HW manual described the hardware) with this the PHY
   reset DT node would have to get 2 PM domains handlers (one for the
   current PM domain provider and the other one for SYSC):

+               phyrst: usbphy-ctrl@11e00000 {
+                       compatible = "renesas,r9a08g045-usbphy-ctrl";
+                       reg = <0 0x11e00000 0 0x10000>;
+                       clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>;
+                       resets = <&cpg R9A08G045_USB_PRESETN>;
+                       power-domain-names = "cpg", "sysc";
+                       power-domains = <&cpg R9A08G045_PD_USB_PHY>, <&sysc
R9A08G045_SYSC_PD_USB>;
+                       #reset-cells = <1>;
+                       status = "disabled";
+
+                       usb0_vbus_otg: regulator-vbus {
+                               regulator-name = "vbus";
+                       };
+               };
+

and the PHY reset driver will get bulky with powering on/off both of these,
at least with my current implementation, something like (and the following
code is in probe()):

+       if (priv->set_power) {
+               priv->cpg_genpd_dev = dev_pm_domain_attach_by_name(dev, "cpg");
+               if (IS_ERR(priv->cpg_genpd_dev)) {
+                       dev_err_probe(dev, error, "Failed to attach CPG PM
domain!");
+                       error = PTR_ERR(priv->cpg_genpd_dev);
+                       goto err_pm_runtime_put;
+               }
+
+               priv->sysc_genpd_dev = dev_pm_domain_attach_by_name(dev,
"sysc");
+               if (IS_ERR(priv->sysc_genpd_dev)) {
+                       dev_err_probe(dev, error, "Failed to attach sysc PM
domain!");
+                       error = PTR_ERR(priv->sysc_genpd_dev);
+                       goto err_genpd_cpg_detach;
+               }
+
+               priv->cpg_genpd_dl = device_link_add(dev, priv->cpg_genpd_dev,
+                                                    DL_FLAG_PM_RUNTIME |
+                                                    DL_FLAG_STATELESS);
+               if (!priv->cpg_genpd_dl) {
+                       dev_err_probe(dev, -ENOMEM, "Failed to add CPG
genpd device link!");
+                       goto err_genpd_sysc_detach;
+               }
+
+               priv->sysc_genpd_dl = device_link_add(dev,
priv->sysc_genpd_dev,
+                                                     DL_FLAG_PM_RUNTIME |
+                                                     DL_FLAG_STATELESS);
+               if (!priv->sysc_genpd_dl) {
+                       dev_err_probe(dev, -ENOMEM, "Failed to add sysc
genpd device link!");
+                       goto err_genpd_cpg_dl_del;
+               }
+
+
+               error = pm_runtime_resume_and_get(priv->cpg_genpd_dev);
+               if (error) {
+                       dev_err_probe(dev, error, "Failed to runtime resume
cpg PM domain!");
+                       goto err_genpd_sysc_dl_del;
+               }
+
+               error = pm_runtime_resume_and_get(priv->sysc_genpd_dev);
+               if (error) {
+                       dev_err_probe(dev, error, "Failed to runtime resume
sysc PM domain!");
+                       goto err_genpd_cpg_off;
+               }
+       }
+

2/ SYSC being a PM domain provider parent of the CPG (current PM domain
   provider). With this the phy reset node is like proposed in this series
   (powered by CPG PM domain):

+               phyrst: usbphy-ctrl@11e00000 {
+                       compatible = "renesas,r9a08g045-usbphy-ctrl",
+                                    "renesas,rzg2l-usbphy-ctrl";
+                       reg = <0 0x11e00000 0 0x10000>;
+                       clocks = <&cpg CPG_MOD R9A08G045_USB_PCLK>;
+                       resets = <&cpg R9A08G045_USB_PRESETN>;
+                       power-domains = <&cpg R9A08G045_PD_USB_PHY>;
+                       #reset-cells = <1>;
+                       status = "disabled";
+
+                       usb0_vbus_otg: regulator-vbus {
+                               regulator-name = "vbus";
+                       };
+               };

And the USB SYSC PM domain is parent for all USB PM domains provided by CPG
(3 in this case). With this there should be some glue code b/w CPG (code in
drivers/clk/renesas/{rzg2l-cpg.c, r9a08g045-cpg.c}) and SYSC drivers (I
have something ugly locally, haven't tried to detach CPG code from SYSC
code at the moment).


> 
> Thanks again for your explanations!

Thank you, also, for looking into this,
Claudiu Beznea

> 
> Kind regards
> Uffe

