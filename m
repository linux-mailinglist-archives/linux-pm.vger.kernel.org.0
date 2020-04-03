Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7019D019
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 08:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgDCGPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 02:15:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:60303 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbgDCGPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 02:15:05 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200403061500epoutp02f7d60f5b0cab8212660c6be5bd108219~COqVBrVLB2624726247epoutp02z
        for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2020 06:15:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200403061500epoutp02f7d60f5b0cab8212660c6be5bd108219~COqVBrVLB2624726247epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585894500;
        bh=3ClS9acp6q4A7vSCobCxmpD58P6iw05fT1PXVOUXNpE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HB3X0QWnzllBfreljuSH4F1aFqrqVXJ+yPvSZpX5EINlGYH403F0N+6k5CRPd7w1U
         QwYBljRRAE3Y0FWGzH+13Mk93690UcP3Pw+w9nqnSYbRIOAYcc/4YVNxLphQnan412
         gfNjFto+TpIk99uS8+b8OxSlCfYanDRQRqpRzk2Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200403061459epcas1p3624caee3ae23f5387ce976b3fe4c3916~COqUUIHPs1573415734epcas1p3o;
        Fri,  3 Apr 2020 06:14:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48tqR50NkjzMqYl0; Fri,  3 Apr
        2020 06:14:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.42.04744.064D68E5; Fri,  3 Apr 2020 15:14:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200403061456epcas1p34bfc5d92890a2d68e009662276bff257~COqRhd-241108111081epcas1p32;
        Fri,  3 Apr 2020 06:14:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200403061456epsmtrp23d7e3a32eb30ebd9dc8a9c485871a724~COqRfnGgZ2943229432epsmtrp2X;
        Fri,  3 Apr 2020 06:14:56 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-3c-5e86d460e99f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.E8.04158.064D68E5; Fri,  3 Apr 2020 15:14:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200403061455epsmtip276c35d9d898edb60afdce60699cb0798~COqRComKY1491614916epsmtip2I;
        Fri,  3 Apr 2020 06:14:55 +0000 (GMT)
Subject: Re: [PATCH 2/8] PM / devfreq: Add generic imx bus scaling driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kepplinger <martink@posteo.de>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1e4de7a9-fbc5-b441-3032-5200d301583d@samsung.com>
Date:   Fri, 3 Apr 2020 15:23:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB69417B0BC486AE67957522ADEEC60@VI1PR04MB6941.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHd3pvby9mddcK44y5CVe/rAnQAoXDAkQHmrvhlmZb+LBE8I5e
        KaNv9FIH25KVKQwapxBXGXUgDOtoNRvUIi+BdELNAm4oe6ls6DDBIJkC01I2dSxruTXh2+95
        nv9zzvk/Jw+JyfolCWS5oYozG1gdTWzCL469lJJ84Jf6YsXfoRw0214HUOjKBEBnf7oM0Ip9
        CENzszMA9beWotP+STHqvTCDo5YRD4Hc9kEcXb3aI0E/fnJPgrpv3hcjz1xAjGyPXBgKfuYH
        yHl9SoQC3c1iFOyZA2hqYg+aqe0m0LnJSwRqW7FjqG7EL0G20TUC/RfoxdGCNx45uwIY6g0x
        u15g7LZuwJxvPw+Y5ek6CXPKOoUzHR4L43E3EsyNwDDBXDjzMdO7NCBijq8pmEdjccwxrxsw
        Qc+Lauk7FTlajtVw5kTOUGrUlBvKcunCt0ryS1SZCmWyMhtl0YkGVs/l0gX71Ml7y3XhodCJ
        h1idJZxSszxPp+blmI2WKi5Ra+SrcmnOpNGZsk0pPKvnLYaylFKj/mWlQpGmCgsPVGgdzgcS
        k/fN6q/HAmIrqC2wgRgSUhlw6K8zwAY2kTJqAMA/Tt4VCcEDAK8s+nAhWAXQesMledLitS9L
        hMIIgE2/9UeDZQB/6O8EEdVW6lW4cuzLdY6lquHRYCcREWHUAgn/XXhIRAoEJYe+hel1foZK
        gr/+M7feIKXyoH3xO3GEcWon/HbVv66Jo4rg+MUjUc0WON56G49wDLUf3hsfxCKMUSlwfsKB
        CxwPf799WiTwdni47xQWeQSkhkn4ePArkeCnALofXgYCb4V/fu+N+kyAwaURQuAPoWvcTwjN
        DQB6fdfEQiEd+pwnogclwcHHbUC4bTNcCh0Na8hwXgob6mWCZAf8+dbNqPw52PVpI9EEaMcG
        P44NHhwbPDg2eOgAuBs8y5l4fRnHK00ZG3/cA9aXRo4GwPDkvlFAkYB+WvrUpbpimZg9xNfo
        RwEkMTpWuvuLcEqqYWs+4MzGErNFx/GjQBWedzOWEFdqDK+goapEqUpLT09HGcpMlVJJx0vt
        13XFMqqMreIqOM7EmZ/0iciYBCtomx+ueD6pKfa1rL7KvKaTx+PVZ3dRliMtd3taD+6tmb8/
        //a12ULttp2c2pVV+W5hS1GzfLHo/U7RR6nlm3dXNqS+ke/ask3j7thR7yOn76Dsc7FJB6sz
        5K+8Rx62i8nXQ/l7tncVfbN/tR1nLWufD+Wn1vY1nlAYuPY0Z6bvzi0rjfNaVinHzDz7P9u/
        VHhKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTUQDHO7uPXcXVbb5OiolLhIalVsJBQy0KbtCHMggMUse8qeTm2vXR
        ikiNCS5c9WFZ21IjLVvmY67SXuo2S4sUy5ZoIjiVCpflVErKcrPAbz/O//c758uhMGE1EULl
        ygtYpVySJyJ98Yc2Ufi2zKHy9FhjbRAar1YDtPD6FUC33/YANK97jCHn+ChAj65LUY29n0Ct
        baM4qnpmJpFJ14GjgYEWPnpTNsNHDWPfCWR2OgikWbqLIXelHaD6D4M85Gi4QiB3ixOgwVf7
        0WhpA4nu9XeT6Ma8DkPqZ3Y+0lh/k2jZ0YqjT5ZgVH/LgaHWBSYljNFpGgDTWN0ImNlhNZ8x
        lAziTK25kDGbKkjmo+MpybTVnWdav7bzmEu/Y5klWyCjtZgA4zZvPiQ45rs7i83LLWKVMUmZ
        vjn6+jm+wpJ6+o7NQZSA0n0a4ENBehe06Gb5GuBLCeknANp/dpKrwyZ4dbAH0wBqhf2hzcat
        Oi4ATX1W4HH86QNwXmv0cgB9GqqrjIRHwugZCnZ9qcA8g5Cew+BUd4KHSVoMOz8Nex/YQEfA
        9z+c3lhAJ0Gdq4vwME5HwuZFu9cJpI/Cjjonb9XZCPuuT+Ie9qGPw5m+Du/9GB0Ny903easc
        DEcma/5xOLzwwIBdBv76Nbl+TaJfk+jXJLUAN4FNrIKTZcu4OMUOOVu8nZPIuEJ59nZpvswM
        vL9GLG4Hvb0ZVkBTQOQnWNetThcSkiJOJbMCSGGiAMGeaytHgiyJ6gyrzM9QFuaxnBWEUrgo
        WBCe/yJNSGdLCtiTLKtglf9XHuUTUgKCmm4/iRlKUKWFNBoXd7rYs5E38ZTepunOgGLgkvi5
        tKmTm2cTtyRrS34tTR8OQ/HDR1TO5/1Xz8mTtc0XFREy01DkS+msYbksdMS4t3FKOvr52ruq
        5JoWIupgz9KkxR2YUnkivuzy0KkcQ7ThaFSfIHfrffGfMYFzYn3it4lEEc7lSOLEmJKT/AUR
        uKEZMQMAAA==
X-CMS-MailID: 20200403061456epcas1p34bfc5d92890a2d68e009662276bff257
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200326021637epcas1p26d84c256cf05a97ae1c90bb16ea6fa5d
References: <cover.1585188174.git.leonard.crestez@nxp.com>
        <CGME20200326021637epcas1p26d84c256cf05a97ae1c90bb16ea6fa5d@epcas1p2.samsung.com>
        <e32290a36b31fbe922cc8ed48c33e89a5eb08804.1585188174.git.leonard.crestez@nxp.com>
        <781911a0-6139-8e41-cd96-da40fad685fc@samsung.com>
        <VI1PR04MB694183137034565F350E8587EEC90@VI1PR04MB6941.eurprd04.prod.outlook.com>
        <8b1623d9-fb71-836f-776e-2dffdbcc27b3@samsung.com>
        <VI1PR04MB69417B0BC486AE67957522ADEEC60@VI1PR04MB6941.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/2/20 6:53 PM, Leonard Crestez wrote:
> On 2020-04-02 1:48 AM, Chanwoo Choi wrote:
>> On 4/1/20 11:20 PM, Leonard Crestez wrote:
>>> On 2020-04-01 1:55 AM, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> Looks good to me. I added the comments.
>>>> But, it need to add the dt binding documentation for this device.
>>>
>>> DT bindings were included:
>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11458981%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C7381d117a4d1468cd2c608d7d68ecfac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637213781167514099&amp;sdata=Qu8x14cXnuxlwOT2SlUOf%2FLgCVWbnJRKA4TBjMIWQeA%3D&amp;reserved=0
>>
>> The dt-binding document for this driver is required under
>> Documentation/devicetree/binding/devfreq.
> 
> Bindings for imx8m-ddrc were at one point posted for 
> devicetree/bindings/devfreq but Rob Herring suggested to move them under 
> "memory-controller" instead and I expect same logic makes sense here. 
> Link to previous discussion:
> 
> https://patchwork.kernel.org/patch/11221919/
> 
> DT bindings should try to describe "hardware" rather than "drivers" and 
> an "interconnect" is a class of hardware while "devfreq" isn't.
> 
> Not only that but the main noc has properties parsed by interconnect driver.

OK. Thanks for reply.

> 
>> It is difficult to catch where is the dt-binding document
>> for this driver for who don't know the detailed history
>> of this driver. I don't said that add the duplicate documentation
>> But, at least the some document have to point out the reference.
> 
> What I usually do to find information about a device is grep for the 
> compat string in the entire tree.
> 
>>>> The old email of Artur ¦wigoñ is not used. On next time,
>>>> use following the new email address Because when I reply the mail,
>>>> always show the fail message from thunderbird due to the Artur's old email.
>>>> <a.swigon@partnet.samsung.com> -> <a.swigon@samsung.com>
>>>
>>> Yeah, I received multiple bounces because of this.
>>>
>>>> On 3/26/20 11:16 AM, Leonard Crestez wrote:
>>>>> Add initial support for dynamic frequency switching on pieces of the imx
>>>>> interconnect fabric.
>>>>>
>>>>> All this driver does is set a clk rate based on an opp table, it does
>>>>> not map register areas.
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>> ---
>>>>>    drivers/devfreq/Kconfig   |   9 +++
>>>>>    drivers/devfreq/Makefile  |   1 +
>>>>>    drivers/devfreq/imx-bus.c | 142 ++++++++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 152 insertions(+)
>>>>>    create mode 100644 drivers/devfreq/imx-bus.c
>>>>>
>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>> index 0b1df12e0f21..44d26192ddc4 100644
>>>>> --- a/drivers/devfreq/Kconfig
>>>>> +++ b/drivers/devfreq/Kconfig
>>>>> @@ -99,10 +99,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>>>>>    	select DEVFREQ_GOV_USERSPACE
>>>>>    	help
>>>>>    	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>>>>    	  adjusting DRAM frequency.
>>>>>    
>>>>> +config ARM_IMX_BUS_DEVFREQ
>>>>> +	tristate "i.MX Generic Bus DEVFREQ Driver"
>>>>> +	depends on ARCH_MXC || COMPILE_TEST
>>>>> +	select DEVFREQ_GOV_PASSIVE
>>>>> +	select DEVFREQ_GOV_USERSPACE
>>>>
>>>> Maybe, you would update it by using passive governor?
>>>> But, in this version, it doesn't handle the any passive governor.
>>>
>>> dropped
>>>
>>>>> +	help
>>>>> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
>>>>> +	  allows adjusting NIC/NOC frequency.
>>>>> +
>>>>>    config ARM_TEGRA_DEVFREQ
>>>>>    	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>>>    	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>>>>    		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>>>>    		ARCH_TEGRA_210_SOC || \
>>>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>>>> index 3eb4d5e6635c..3ca1ad0ecb97 100644
>>>>> --- a/drivers/devfreq/Makefile
>>>>> +++ b/drivers/devfreq/Makefile
>>>>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>>>>>    obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>>>>    obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>>>    
>>>>>    # DEVFREQ Drivers
>>>>>    obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>>>> +obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>>>>
>>>> The ARM_IMX_BUS_DEVFREQ config is under ARM_IMX8M_DDRC_DEVFREQ
>>>> and imx-bus.o is over imx8m-ddrc.o. Need to edit the sequence.
>>>
>>> Reordered kconfig to match. 8M_DDRC sorts before _BUS alphabetically but
>>> it's pettier this way, and matches tegra.
>>>
>>>>>    obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>>>>>    obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>>>    obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>>>>    obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>>>    
>>>>> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
>>>>> new file mode 100644
>>>>> index 000000000000..285e0f1ae6b1
>>>>> --- /dev/null
>>>>> +++ b/drivers/devfreq/imx-bus.c
>>>>> @@ -0,0 +1,142 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright 2019 NXP
>>>>> + */
>>>>> +
>>>>> +#include <linux/clk.h>
>>>>> +#include <linux/devfreq.h>
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/pm_opp.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +struct imx_bus {
>>>>> +	struct devfreq_dev_profile profile;
>>>>> +	struct devfreq *devfreq;
>>>>> +	struct clk *clk;
>>>>> +	struct devfreq_passive_data passive_data;
>>>>
>>>> This patch doesn't touch the passive_data.
>>>
>>> dropped
>>>
>>>>> +};
>>>>> +
>>>>> +static int imx_bus_target(struct device *dev,
>>>>> +		unsigned long *freq, u32 flags)
>>>>> +{
>>>>> +	struct imx_bus *priv = dev_get_drvdata(dev);
>>>>> +	struct dev_pm_opp *new_opp;
>>>>> +	unsigned long new_freq;
>>>>> +	int ret;
>>>>> +
>>>>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>> +	if (IS_ERR(new_opp)) {
>>>>> +		ret = PTR_ERR(new_opp);
>>>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +	new_freq = dev_pm_opp_get_freq(new_opp);
>>>>
>>>> It doesn't need. Because the new frequency is stored to 'freq'
>>>> by calling devfreq_recommended_opp().
>>>
>>> fixed
>>>
>>>>> +	dev_pm_opp_put(new_opp);
>>>>> +
>>>>> +	return clk_set_rate(priv->clk, new_freq);
>>>>
>>>> nitpick. you can use dev_pm_opp_set_rate(). But, I'm not forcing to use it.
>>>
>>> Switched to dev_pm_opp_set_rate.
>>>
>>> It might be interesting to add regulators control later, on some chips
>>> the main NOC can run at different voltages.
>>>
>>>>
>>>>> +}
>>>>> +
>>>>> +static int imx_bus_get_cur_freq(struct device *dev, unsigned long *freq)
>>>>> +{
>>>>> +	struct imx_bus *priv = dev_get_drvdata(dev);
>>>>> +
>>>>> +	*freq = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int imx_bus_get_dev_status(struct device *dev,
>>>>> +		struct devfreq_dev_status *stat)
>>>>> +{
>>>>> +	struct imx_bus *priv = dev_get_drvdata(dev);
>>>>> +
>>>>> +	stat->busy_time = 0;
>>>>> +	stat->total_time = 0;
>>>>> +	stat->current_frequency = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void imx_bus_exit(struct device *dev)
>>>>> +{
>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>> +}
>>>>> +
>>>>> +static int imx_bus_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct imx_bus *priv;
>>>>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>>>>> +	int ret;
>>>>> +
>>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>>> +	if (!priv)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	/*
>>>>> +	 * Fetch the clock to adjust but don't explictly enable.
>>>>
>>>> Need to fix typo.
>>>> s/explictly/explicitly
>>>
>>> fixed
>>>
>>>>> +	 *
>>>>> +	 * For imx bus clock clk_set_rate is safe no matter if the clock is on
>>>>> +	 * or off and some peripheral side-buses might be off unless enabled by
>>>>> +	 * drivers for devices on those specific buses.
>>>>> +	 *
>>>>> +	 * Rate adjustment on a disabled bus clock just takes effect later.
>>>>> +	 */
>>>>> +	priv->clk = devm_clk_get(dev, NULL);
>>>>> +	if (IS_ERR(priv->clk)) {
>>>>> +		ret = PTR_ERR(priv->clk);
>>>>> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>> +	platform_set_drvdata(pdev, priv);
>>>>> +
>>>>> +	ret = dev_pm_opp_of_add_table(dev);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(dev, "failed to get OPP table\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	priv->profile.polling_ms = 1000;
>>>>> +	priv->profile.target = imx_bus_target;
>>>>> +	priv->profile.get_dev_status = imx_bus_get_dev_status;
>>>>> +	priv->profile.exit = imx_bus_exit;
>>>>> +	priv->profile.get_cur_freq = imx_bus_get_cur_freq;
>>>>> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
>>>>> +
>>>>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>>>>> +						gov, NULL);
>>>>> +	if (IS_ERR(priv->devfreq)) {
>>>>> +		ret = PTR_ERR(priv->devfreq);
>>>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>>>> +		goto err;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +
>>>>> +err:
>>>>> +	dev_pm_opp_of_remove_table(dev);
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id imx_bus_of_match[] = {
>>>>> +	{ .compatible = "fsl,imx8m-noc", },
>>>>> +	{ .compatible = "fsl,imx8m-nic", },
>>>>> +	{ /* sentinel */ },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, imx_bus_of_match);
>>>>> +
>>>>> +static struct platform_driver imx_bus_platdrv = {
>>>>> +	.probe		= imx_bus_probe,
>>>>> +	.driver = {
>>>>> +		.name	= "imx-bus-devfreq",
>>>>> +		.of_match_table = of_match_ptr(imx_bus_of_match),
>>>>> +	},
>>>>> +};
>>>>> +module_platform_driver(imx_bus_platdrv);
>>>>> +
>>>>> +MODULE_DESCRIPTION("Generic i.MX bus frequency scaling driver");
>>>>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
