Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6649DAE37
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394465AbfJQNZp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 09:25:45 -0400
Received: from node.akkea.ca ([192.155.83.177]:56576 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387959AbfJQNZp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 09:25:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id DDAD44E2006;
        Thu, 17 Oct 2019 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1571318743; bh=KjeLtDoEYvbOzR07sFeZuTr8GwGBgyeghcrN/lZU9iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=CfiSKgqQr9/win4mF7hYLN8FIHd8BuiZRiQdvt56zb51/o2dBqokVFBwgmVsQ9NWm
         FjfYLPAqjNyex1bhmJ6EWOuuZewKLVb5YtdtyT8+3sMzeYL8JtjiovrCzowIvH60ES
         38voadsVUr3SwMiLPz6kMB0zM8+BfMF2cbLd6SGc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OhLmPYxqCrP7; Thu, 17 Oct 2019 13:25:43 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 586654E2003;
        Thu, 17 Oct 2019 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1571318743; bh=KjeLtDoEYvbOzR07sFeZuTr8GwGBgyeghcrN/lZU9iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=CfiSKgqQr9/win4mF7hYLN8FIHd8BuiZRiQdvt56zb51/o2dBqokVFBwgmVsQ9NWm
         FjfYLPAqjNyex1bhmJ6EWOuuZewKLVb5YtdtyT8+3sMzeYL8JtjiovrCzowIvH60ES
         38voadsVUr3SwMiLPz6kMB0zM8+BfMF2cbLd6SGc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Oct 2019 06:25:43 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Artur_=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
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
        Martin Kepplinger <martink@posteo.de>,
        linux-pm-owner@vger.kernel.org
Subject: Re: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
In-Reply-To: <VI1PR04MB7023A7ECF8FD6BFA1D8E0F26EE920@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <cf265add1502a75c4d6e6261ab1570c665e82c83.1565088423.git.leonard.crestez@nxp.com>
 <a2e09a9b-574f-8410-423e-0b0d8ea5c2ab@posteo.de>
 <VI1PR04MB7023E441FEE0D9288CAC0F44EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <be41481b-5184-7878-b25e-41b7a1e1b2d5@posteo.de>
 <7c1452f3d8c13aeadcabf7807049092c@akkea.ca>
 <VI1PR04MB70231CD1535CBCB699F045D4EE930@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <68e456574e2072740f41fac8c9c2377b@akkea.ca>
 <VI1PR04MB7023A7ECF8FD6BFA1D8E0F26EE920@VI1PR04MB7023.eurprd04.prod.outlook.com>
Message-ID: <7ebdff997bbaa1193aae082465908fc8@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-10-16 07:54, Leonard Crestez wrote:
> On 16.10.2019 17:09, Angus Ainslie wrote:
>> On 2019-10-15 07:05, Leonard Crestez wrote:
>>> On 10.10.2019 17:43, Angus Ainslie wrote:
>>>> 
>>>> I've integrated your u-boot and ATF on our board and I have a couple
>>>> of questions. Our board is running imx8mq B0 (Rev 2.0) silicon.
>>>> 
>>>> It looks like this line limits the training frequencies to 800 MHz 
>>>> and
>>>> 166 MHz
>>> 
>>> Yes! This is due to a hardware errata which was solved in B1: DRAM 
>>> pll
>>> can't be disabled. This means that instead of 25/100/800 freqs are
>>> 166/800, and this requires code changes.
>>> 
>>>> Does 100 MHz and 25 MHz not work on B0 ?
>>> 
>>> No, lower rates require dram clk from a composite slice 
>>> (dram_alt_root)
>>> 
>>>> I added the ddrc_and noc opp as well as the 166MHz opp
>>>> 
>>>> I also added the interconnects ( do we need them on imx8mq ? )
>>> 
>>> The interconnect stuff is not required to switch dram frequency, it's
>>> for device to make minimum bandwidth requests. It an additional 
>>> feature
>>> on top.
>>> 
>>> As a hack I configured FEC to do so but a saner example would be to
>>> request bandwidth based on display resolution and color depth.
>>> 
>>>> I had to add a hack as the PM QoS was limiting the bus speed to 
>>>> 399MHz,
>>>> if you have any ideas why that would be appreciated.
>>> 
>>> You probably need to set ethernet down (which is awkward) or better
>>> just drop the interconnect properties and test using the devfreq 
>>> userspace
>>> governor.
>>> 
>>>> The driver is probing
>>>> 
>>>> [   12.136537] bus: 'platform': driver_probe_device: matched device
>>>> 3d400000.dram-controller with driver imx-ddrc-devfrq
>>>> [   12.147259] bus: 'platform': really_probe: probing driver
>>>> imx-ddrc-devfreq with device 3d400000.dram-controller
>>>> [   12.157382] imx-ddrc-devfreq 3d400000.dram-controller: no pinctrl
>>>> handle
>>>> [   12.164197] arm_smcc rate 0 800000000
>>>> [   12.167880] arm_smcc rate 1 166750000
>>>> [   12.171778] of: _opp_add_static_v2: turbo:0 rate:25000000 uv:0
>>>> uvmin:0 uvmax:0 latency:0
>>>> [   12.179994] of: _opp_add_static_v2: turbo:0 rate:100000000 uv:0
>>>> uvmin:0 uvmax:0 latency:0
>>>> [   12.188311] of: _opp_add_static_v2: turbo:0 rate:166750000 uv:0
>>>> uvmin:0 uvmax:0 latency:0
>>>> [   12.196606] of: _opp_add_static_v2: turbo:0 rate:800000000 uv:0
>>>> uvmin:0 uvmax:0 latency:0
>>>> [   12.204930] imx-ddrc-devfreq 3d400000.dram-controller: events 
>>>> from
>>>> pmu imx8_ddr0
>>>> [   12.212403] Added freq 0 25000000
>>>> [   12.215742] Added freq 1 100000000
>>>> [   12.219177] Added freq 2 166750000
>>>> [   12.222648] Added freq 3 800000000
>>>> [   12.226105] device: 'devfreq0': device_add
>>>> [   12.230287] PM: Adding info for No Bus:devfreq0
>>>> [   12.234864] driver: 'imx-ddrc-devfreq': driver_bound: bound to
>>>> device
>>>> '3d400000.dram-controller'
>>>> [   12.243699] bus: 'platform': really_probe: bound device
>>>> 3d400000.dram-controller to driver imx-ddrc-devfreq
>>>> 
>>>> Add seems to run correctly until it tries to adjust the clock to
>>>> 166MHz
>>>> 
>>>> [   19.555482] ddrc checking rate 800000000 166750000
>>>> [   19.555489] ddrc checking rate 166750000 166750000
>>>> [   19.560442] bus: 'usb-serial': really_probe: bound device ttyUSB0
>>>> to
>>>> driver option1
>>>> [   19.568751] imx-ddrc-devfreq 3d400000.dram-controller: ddrc about
>>>> to
>>>> change freq 800000000 to 166750000
>>>> 
>>>> And the board hangs there. Any ideas on how to get past this ?
>>> 
>>> Please try this ATF patch:
>> 
>> Ok applied this to the tree we're using
>> 
>>> I tested switching on imx8mq-evk with B0 SoC but a few additional
>>> changes are required in kernel to support switching between rates 
>>> which
>>> are both backed by PLL:
>>> 
>>> * Mark the PLL CLK_GET_RATE_NOCACHE
>> 
>> Is this what you meant ?
>> 
>> diff --git a/drivers/clk/imx/clk-imx8mq.c 
>> b/drivers/clk/imx/clk-imx8mq.c
>> index 2813884f69c1..e5f50cf8a264 100644
>> --- a/drivers/clk/imx/clk-imx8mq.c
>> +++ b/drivers/clk/imx/clk-imx8mq.c
>> @@ -345,7 +345,7 @@ static int imx8mq_clocks_probe(struct
>> platform_device *pdev)
>>           clks[IMX8MQ_SYS1_PLL_OUT] = imx_clk_sccg_pll("sys1_pll_out",
>> sys1_pll_out_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 
>> 0x30,
>> CLK_IS_CRITICAL);
>>           clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_sccg_pll("sys2_pll_out",
>> sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 
>> 0x3c,
>> CLK_IS_CRITICAL);
>>           clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_sccg_pll("sys3_pll_out",
>> sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 
>> 0x48,
>> CLK_IS_CRITICAL);
>> -       clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_sccg_pll("dram_pll_out",
>> dram_pll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 
>> 0x60,
>> CLK_IS_CRITICAL);
>> +       clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_sccg_pll("dram_pll_out",
>> dram_pll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 
>> 0x60,
>> CLK_IS_CRITICAL|CLK_GET_RATE_NOCACHE);
> 
> Yes.
> 
>>> * Set the rate to 166935483 exactly (to match clk_get_rate)
>> 
>> Okay I hacked that in
>> 
>> diff --git a/drivers/devfreq/imx-ddrc.c b/drivers/devfreq/imx-ddrc.c
>> index 4eed6f50bb8d..a832768a865f 100644
>> --- a/drivers/devfreq/imx-ddrc.c
>> +++ b/drivers/devfreq/imx-ddrc.c
>> @@ -436,6 +436,10 @@ static int imx_ddrc_init_freq_info(struct device
>> *dev)
>>                           return -ENODEV;
>>                   }
>> 
>> +               /* B0 hack */
>> +               if ( freq->rate == 166750000 )
>> +                       freq->rate = 166935483;
>> +inserting
>>                   pr_err( "arm_smcc rate %d %lu\n", index, freq->rate 
>> );
>>           }
> 
> A nicer solution would be to keep imx_ddrc_freq.rate in MT/s as 
> reported
> by firmware and divide by 25000 in imx_ddrc_find_freq instead.
> 
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -211,7 +211,7 @@
>>                           opp-hz = /bits/ 64 <100000000>;
>>                   };
>>                   opp-166M {
>> -                       opp-hz = /bits/ 64 <166750000>;
>> +                       opp-hz = /bits/ 64 <166935483>;
>>                   };
>>                   opp-800M {
>>                           opp-hz = /bits/ 64 <800000000>;
> 
> Yes, this is the precise clock rate in Hz.
> 
>>> * Make the rounding in imx-ddrc more generous.
>> 
>> Sorry I don't understand what you mean by this
> 
> I meant to make imx_ddrc_find_freq find 667 MT/s for an OPP of 
> 166935483:
> 
>          /*
>           * Firmware reports values in MT/s, so we round-down from Hz
>           * Rounding is extra generous to ensure a match.
>           */
>          rate = DIV_ROUND_CLOSEST(rate, 250000);
>          for (i = 0; i < priv->freq_count; ++i) {
>                  struct imx_ddrc_freq *freq = &priv->freq_table[i];
>                  if (freq->rate == rate ||
>                                  freq->rate + 1 == rate ||
>                                  freq->rate - 1 == rate)
>                          return freq;
>          }
> 
> But your B0 hack above should also work.
> 

Thanks with those additions the driver is working on imx8mq B0.

There is a small adjustment to the code above because you're scaling the 
rate you also need to scale the matching rate.

--- a/drivers/devfreq/imx-ddrc.c
+++ b/drivers/devfreq/imx-ddrc.c
@@ -106,9 +106,17 @@ static struct imx_ddrc_freq 
*imx_ddrc_find_freq(struct imx_ddrc *priv,
  {
         int i;

+       /*
+       * Firmware reports values in MT/s, so we round-down from Hz
+       * Rounding is extra generous to ensure a match.
+       */
+       rate = DIV_ROUND_CLOSEST(rate, 250000);
         for (i = 0; i < priv->freq_count; ++i) {
-               if (priv->freq_table[i].rate == rate)
+               struct imx_ddrc_freq *freq = &priv->freq_table[i];
+               unsigned long match_rate = 
DIV_ROUND_CLOSEST(freq->rate,250000);
+               if (match_rate + 1 >= rate &&
+                   match_rate - 1 <= rate)
                         return &priv->freq_table[i];
         }

Cheers
Angus

>> Adding the other changes the board no longer hangs when trying to 
>> change
>> frequencies but it also doesn't seem to actually change the frequency.
>> 
>> [    3.076426] ddrc checking rate 800000000 166935483
>> [    3.081290] ddrc checking rate 166935483 166935483
>> [    3.086225] imx-ddrc-devfreq 3d400000.dram-controller: ddrc about 
>> to
>> change freq 800000000 to 166935483
>> [    3.086891] imx-ddrc-devfreq 3d400000.dram-controller: ddrc changed
>> freq 800000000 to 166935483
>> 
>> root@pureos:~# cat /sys/class/devfreq/devfreq0/cur_freq
>> 800000000
>> root@pureos:~# cat /sys/class/devfreq/devfreq0/target_freq
>> 166935483
> 
> The target_freq value is from clk_get_rate(dram_core) but it is
> dram_core's parent which gets updated. It seems that a clk mux ignores
> CLK_GET_RATE_NOCACHE on the parent.
> 
> An update can be forced by adding `clk_get_rate(new_dram_core_parent);`
> at the end of imx_ddrc_set_freq.
> 
> You should also be able to check by looking at clk_summary or
> /sys/kernel/debug/clk/dram_core_clk/clk_rate
> /sys/kernel/debug/clk/dram_pll_out/clk_rate
> 
> --
> Regards,
> Leonard
