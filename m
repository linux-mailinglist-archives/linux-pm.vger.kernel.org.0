Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1621D2CD8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfJJOvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 10:51:09 -0400
Received: from node.akkea.ca ([192.155.83.177]:47770 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfJJOvJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Oct 2019 10:51:09 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 10:51:08 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 42F134E2006;
        Thu, 10 Oct 2019 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1570718631; bh=pkpN0A8tLJiGtntWCFC/Mdnu/U6hh2MqjevHKRahXRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=kR5t1qCBgCpdpRin9kB/c7n9OAjYz+EbxYUQFHc3wv/tct3aCI4d7JgAbBmoPwFIR
         2pvyez5dbUNXRcEH2NM0dNkvZWQ5OyejhtcX6r+0ktXhWdCwqulGJSLz8NDG6V5h/N
         fiEeUWs7C69+491852fU8OdkfLHxI6C9p9EnW+c8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I1udzDgiyWrE; Thu, 10 Oct 2019 14:43:49 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id D63094E2003;
        Thu, 10 Oct 2019 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1570718629; bh=pkpN0A8tLJiGtntWCFC/Mdnu/U6hh2MqjevHKRahXRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=K3MeygXbWK5E881TEz4s9vDh5f2yb5HOKb5azunAilr0TjZ6SkSxM/jQYFUyN7tRf
         Bp88NaKREXIeplXo2sKn/wiBMBNZSuiG3Bd4XHtcRq3LEHZGNel4zbUmialxT3Ew18
         ZfA5TrTc+AaeBE4f4L/S6syypxhyD976LfYSZmz4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Oct 2019 07:43:49 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Artur_=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Martin Kepplinger <martink@posteo.de>
Subject: Re: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
In-Reply-To: <be41481b-5184-7878-b25e-41b7a1e1b2d5@posteo.de>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <cf265add1502a75c4d6e6261ab1570c665e82c83.1565088423.git.leonard.crestez@nxp.com>
 <a2e09a9b-574f-8410-423e-0b0d8ea5c2ab@posteo.de>
 <VI1PR04MB7023E441FEE0D9288CAC0F44EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <be41481b-5184-7878-b25e-41b7a1e1b2d5@posteo.de>
Message-ID: <7c1452f3d8c13aeadcabf7807049092c@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 2019-08-21 07:26, Martin Kepplinger wrote:
> On 21.08.19 16:21, Leonard Crestez wrote:
>> On 21.08.2019 17:03, Martin Kepplinger wrote:
>>> On 06.08.19 12:55, Leonard Crestez wrote:
>>>> This adds a platform driver for the i.MX8MM SoC.
>>>> 
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>>> ---
>>>>   drivers/interconnect/imx/Kconfig          |   4 +
>>>>   drivers/interconnect/imx/Makefile         |   1 +
>>>>   drivers/interconnect/imx/imx8mm.c         | 114 
>>>> ++++++++++++++++++++++
>>>>   include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++
>>>>   4 files changed, 168 insertions(+)
>>>>   create mode 100644 drivers/interconnect/imx/imx8mm.c
>>>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>>> 
>>> Do you plan to add such a driver for imx8mq too?
>> 
>> Yes! The topology is different (serving different IP blocks) but no
>> functional code changes are required between 8mm 8mn 8mq.
>> 
>> I already wrote the code and tested it but didn't post because I want 
>> to
>> get the core parts in first. I periodically push my "full"
>> work-in-progress to github:
>> 
>> https://github.com/cdleonard/linux/commits/next_imx8mm_busfreq
>> 
>> You need out-of-tree ATF changes or devfreq probe will fail:
>> 
>> https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq
>> 
> 
> Thanks for the update, that's good to hear. I'll get back to you when I
> come around to test this and wish you good progress until then :)
> 

I've taken up this work while Martin is on leave.

I've integrated your u-boot and ATF on our board and I have a couple of 
questions. Our board is running imx8mq B0 (Rev 2.0) silicon.

It looks like this line limits the training frequencies to 800 MHz and 
166 MHz

https://source.puri.sm/Librem5/uboot-imx/blob/busfreq/board/purism/librem5_devkit/lpddr4_timing_b0.c#L1365

Does 100 MHz and 25 MHz not work on B0 ?

I added the ddrc_and noc opp as well as the 166MHz opp

https://source.puri.sm/angus.ainslie/linux-next/blob/busfreq/arch/arm64/boot/dts/freescale/imx8mq.dtsi#L214

I also added the interconnects ( do we need them on imx8mq ? )

https://source.puri.sm/angus.ainslie/linux-next/blob/busfreq/arch/arm64/boot/dts/freescale/imx8mq.dtsi#L990

I had to add a hack as the PM QoS was limiting the bus speed to 399MHz , 
if you have any ideas why that would be appreciated.

https://source.puri.sm/angus.ainslie/linux-next/blob/busfreq/drivers/devfreq/devfreq.c#L143

The driver is probing

[   12.136537] bus: 'platform': driver_probe_device: matched device 
3d400000.dram-controller with driver imx-ddrc-devfrq
[   12.147259] bus: 'platform': really_probe: probing driver 
imx-ddrc-devfreq with device 3d400000.dram-controller
[   12.157382] imx-ddrc-devfreq 3d400000.dram-controller: no pinctrl 
handle
[   12.164197] arm_smcc rate 0 800000000
[   12.167880] arm_smcc rate 1 166750000
[   12.171778] of: _opp_add_static_v2: turbo:0 rate:25000000 uv:0 
uvmin:0 uvmax:0 latency:0
[   12.179994] of: _opp_add_static_v2: turbo:0 rate:100000000 uv:0 
uvmin:0 uvmax:0 latency:0
[   12.188311] of: _opp_add_static_v2: turbo:0 rate:166750000 uv:0 
uvmin:0 uvmax:0 latency:0
[   12.196606] of: _opp_add_static_v2: turbo:0 rate:800000000 uv:0 
uvmin:0 uvmax:0 latency:0
[   12.204930] imx-ddrc-devfreq 3d400000.dram-controller: events from 
pmu imx8_ddr0
[   12.212403] Added freq 0 25000000
[   12.215742] Added freq 1 100000000
[   12.219177] Added freq 2 166750000
[   12.222648] Added freq 3 800000000
[   12.226105] device: 'devfreq0': device_add
[   12.230287] PM: Adding info for No Bus:devfreq0
[   12.234864] driver: 'imx-ddrc-devfreq': driver_bound: bound to device 
'3d400000.dram-controller'
[   12.243699] bus: 'platform': really_probe: bound device 
3d400000.dram-controller to driver imx-ddrc-devfreq

Add seems to run correctly until it tries to adjust the clock to 166MHz

[   19.555482] ddrc checking rate 800000000 166750000
[   19.555489] ddrc checking rate 166750000 166750000
[   19.560442] bus: 'usb-serial': really_probe: bound device ttyUSB0 to 
driver option1
[   19.568751] imx-ddrc-devfreq 3d400000.dram-controller: ddrc about to 
change freq 800000000 to 166750000

And the board hangs there. Any ideas on how to get past this ?

Thanks
Angus

>                         martin
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
