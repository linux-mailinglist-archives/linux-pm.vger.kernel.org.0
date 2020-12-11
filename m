Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2292D7762
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394842AbgLKODx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 09:03:53 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:49598 "EHLO
        5.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406130AbgLKODn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 09:03:43 -0500
X-Greylist: delayed 8910 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 09:03:42 EST
Received: from player738.ha.ovh.net (unknown [10.108.20.107])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id B96C52A2A5E
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 12:34:30 +0100 (CET)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player738.ha.ovh.net (Postfix) with ESMTPSA id 6968B192F2835;
        Fri, 11 Dec 2020 11:34:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002455e66b5-f0f1-47e4-b964-e90a4cfbea73,
                    DDBB76C1C8392C31EFBEE9FEDF413D15A2A340D3) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Subject: Re: [PATCH V2 2/2] reset: brcm-pmb: add driver for Broadcom's PMB
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pm@vger.kernel.org
References: <20201119125600.8559-1-zajec5@gmail.com>
 <20201119125600.8559-3-zajec5@gmail.com>
 <d5162eae806f21f583c6dbdf7bb79384a3d9d5cf.camel@pengutronix.de>
 <4eeb0a1c-75e4-94ad-8fbb-aeb347aea5d0@gmail.com>
 <3a42f4638ce6b2916eea07adf5822b06e2d1ca02.camel@pengutronix.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <6d4554fd-04ba-65f5-6715-988d2517350e@milecki.pl>
Date:   Fri, 11 Dec 2020 12:34:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3a42f4638ce6b2916eea07adf5822b06e2d1ca02.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6432829120779947569
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeduheejheffudefhffghfegjeejleetkeevueelveegkefhhfffieehleelgfevnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09.12.2020 12:24, Philipp Zabel wrote:
> On Tue, 2020-12-08 at 12:20 -0800, Florian Fainelli wrote:
>> On 12/8/20 3:02 AM, Philipp Zabel wrote:
>>> Hi Rafał,
>>>
>>> On Thu, 2020-11-19 at 13:56 +0100, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> PMB can be found on BCM4908 and many other chipsets (e.g. BCM63138).
>>>> It's needed to power on and off SoC blocks like PCIe, SATA, USB.
>>>
>>> This sentence, the register names, and
>>> the brcm_pmb_power_on/off_device/zone functions below make me worry that
>>> this should be a power domain controller (pm_genpd in drivers/soc)
>>> instead.
>>> Does PM in PMB stand for power management by chance?
>>
>> It does, PMB stands for Power Management Bus.
>>
>>> If this actually cuts power to the USB and PCIe cores instead of just
>>> controlling reset lines, it would be better to implement this
>>> differently.
>>
>> What is tricky is this is a combined reset/clock/power zones controller.
>> You rarely turn off/assert one of those without also turning
>> off/asserting the others.
> 
> It is common to have power management controllers also control clocks
> and resets.
> If the PMB controlled clocks and resets are only required for the power
> on/off sequences, you should be able to move the current .(de)assert
> implementations into a generic_pm_domain's .power_on and .power_off
> methods.

Thanks for your comments Philipp! I just took a look at generic PM domains.
While I accept you know better that this hw support should be implemented
using generic PM domains, I'm not sure how to correctly proceed with that.

***

One great thing about reset controllers is that they have:
1. xlate function retuning int
2. (de)assert functions taking unsigned long id argument

That fits PMB hardware design very nicely as I can specify in DT:
1. Type of device to reset
2. ID of device to reset

Basically: I can use:
#reset-cells = <2>;
and then sth like:
resets = <&pmb BRCM_PMB_USB 17>;

***

In the struct generic_pm_domain we have "power_off" and "power_on" that take
no extra arguments however. Also its xlate has to return a single "struct
generic_pm_domain".

Please note that PMB can support for up 256 devices.

If I try to use generic PM domains to handle PMB hw in the same way I'll hit
two problems:

1. I'll have to register 256 "struct generic_pm_domain"s.
2. I won't have a clean way of passing device type (xlate limitation).

I can try to workaround the later just like in case of "ti,sci-pm-domain"
which uses #power-domain-cells = <2>. It seems hacky though as its "xlate"
handler stores args[1] in internal struct and hopes no another xlate call
will get executed before "power_on" or "power_off" call.

***

So I guess my real option is to store info about SoC devices in the PM
driver and create one "struct generic_pm_domain" for each known device only.

Then have something like:
#define BRCM_PMB_HOST_USB		0x01
#define BRCM_PMB_HOST_USB2		0x02
#define BRCM_PMB_HOST_USB3		0x03
#define BRCM_PMB_PCIE0			0x04
#define BRCM_PMB_PCIE1			0x05
#define BRCM_PMB_PCIE2			0x06

And finally:
power-domains = <&pmb0 BRCM_PMB_HOST_USB>;
power-domains = <&pmb0 BRCM_PMB_PCIE0>;
power-domains = <&pmb0 BRCM_PMB_PCIE1>;

What do you think about it? Is it the way to go?
