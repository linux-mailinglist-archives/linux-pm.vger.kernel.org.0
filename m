Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3E78323
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG2BtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 21:49:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26719 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfG2BtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 21:49:11 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190729014907epoutp014836ac846f0fee048818aa13a838f226~1vaGP3NMX0565805658epoutp01c
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 01:49:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190729014907epoutp014836ac846f0fee048818aa13a838f226~1vaGP3NMX0565805658epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564364947;
        bh=LYQT/aJmqOB1NVY+PGAAx8++bl4Rzk2QhGnaFiXjoGc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pkeEnVO3HS2L0rLa/sHluWb+BHIhgCWAU/Ua6rZi3EQ2gN+Fhmm7uRody7s8YOuqK
         frIbQKX/pc92ZHBjcbf/Fu5FhsCk2BiZHVxEK0mOoK0fYZCnov0S+ItIJJYOrfq8wL
         cCuln0URUzAvOkfKDprAS5P3GUqwONltpEb2NJjg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190729014906epcas1p2f6ced780f101f05df371a443a78f89a4~1vaFk0dco2570325703epcas1p2h;
        Mon, 29 Jul 2019 01:49:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45xjKC4SVBzMqYlv; Mon, 29 Jul
        2019 01:49:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.2D.04160.F805E3D5; Mon, 29 Jul 2019 10:49:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190729014903epcas1p4a15b281036825821c7e54fb451110685~1vaCapI7N0857608576epcas1p4I;
        Mon, 29 Jul 2019 01:49:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190729014903epsmtrp29faa07d088f937fa02e323c14281240d~1vaCZmN690974409744epsmtrp2Y;
        Mon, 29 Jul 2019 01:49:03 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-b9-5d3e508f7ec5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.35.03706.E805E3D5; Mon, 29 Jul 2019 10:49:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190729014902epsmtip28955903e6c85ec2f21eb67e396e7cda3~1vaCKbqm40191601916epsmtip2E;
        Mon, 29 Jul 2019 01:49:02 +0000 (GMT)
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        m.szyprowski@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5a82bf8a-d925-ba54-a26f-98b64bedc6e1@samsung.com>
Date:   Mon, 29 Jul 2019 10:52:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723122016.30279-10-a.swigon@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmnm5/gF2swe2VChaHjm1lt5h/5Byr
        xZWv79kspu/dxGYx6f4EFovz5zewW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7BZ
        zJj8ks2B12PTqk42jzvX9rB53O8+zuSxeUm9x8F3e5g8+rasYvT4vEkugD0q2yYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG3x/9zAUn/Sr+
        PTVsYPxj18XIySEhYCLx8MYeli5GLg4hgR2MEvPP74JyPjFKvD4/Fcr5xigx4ekO9i5GDrCW
        bbOEQLqFBPYySkyfXw1R855RYsaaDawgCWGBJIkFjy6C2SIC7UwSzRsdQIqYBSYySjw//p8J
        JMEmoCWx/8UNNhCbX0BR4uqPx4wgNq+AncS6nY/AalgEVCUe7z/KAmKLCkRIfHpwmBWiRlDi
        5MwnYHFOAWeJBe3bwOqZBcQlbj2ZD2XLSzRvnc0MslhCYB27xInTr5khnnaRuLTwJguELSzx
        6vgWdghbSuLzu71sEHa1xMqTR9ggmjsYJbbsv8AKkTCW2L90MhMoKJgFNCXW79KHCCtK7Pw9
        lxFiMZ/Eu689rJDQ4pXoaBOCKFGWuPzgLhOELSmxuL2TbQKj0iwk78xC8sIsJC/MQli2gJFl
        FaNYakFxbnpqsWGBCXJkb2IEJ2Qtix2Me875HGIU4GBU4uF1uGkbK8SaWFZcmXuIUYKDWUmE
        d4uSdawQb0piZVVqUX58UWlOavEhRlNgaE9klhJNzgdmi7ySeENTI2NjYwsTQzNTQ0Mlcd6F
        PyxihQTSE0tSs1NTC1KLYPqYODilGhiF3zjVlie6n3K9rXzi8nTDRS0T4184puzbd1YtpPfv
        1MdXPz2OTvS5plHx30ajdt7G1pjDTXqhm+PLy7dH/BJO3K72aVUtK/9DLYsytru2LJwVRn8L
        PGf+m3jjyNYjNy+oxXhZLxS7vGZxZbCO1++7hxdMFoycGx3XseWGxaug3/GbZG9NPGiixFKc
        kWioxVxUnAgArk5x394DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSvG5fgF2sQeM3K4tDx7ayW8w/co7V
        4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        Zkx+yebA67FpVSebx51re9g87ncfZ/LYvKTe4+C7PUwefVtWMXp83iQXwB7FZZOSmpNZllqk
        b5fAlfH3Rz9zwUm/in9PDRsY/9h1MXJwSAiYSGybJdTFyMUhJLCbUeLVgpusXYycQHFJiWkX
        jzJD1AhLHD5cDFHzllHi2+55TCA1wgJJEgseXWQFSYgItDNJdLduZQRxmAUmMko8PryWGaLl
        HKPE1d/rWUBa2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTWLfzEdhYFgFVicf7j4LViwpESBze
        MQuqRlDi5MwnYHFOAWeJBe3bwOqZBdQl/sy7xAxhi0vcejIfKi4v0bx1NvMERuFZSNpnIWmZ
        haRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNTS3MH4+Ul8YcYBTgY
        lXh4HW7axgqxJpYVV+YeYpTgYFYS4d2iZB0rxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFI
        IYH0xJLU7NTUgtQimCwTB6dUA+Ma+U+SJ5Lv6gsJVV3/wF2eJbZww4sgzqb/W8VsV0aYRxX3
        W4R0zWLzvDWJm/fTlhiT2Q1fJVXvztl1/VImy72bf/tvNRxYt6P63dpZOsraIYsDd0g3CqqG
        x3P8m+HR0nNd9sNK1jMqKw5tqXm3upz1T6vrb1aXaYlxB64kXvzFZX/qeUE8M4sSS3FGoqEW
        c1FxIgAKGzhWygIAAA==
X-CMS-MailID: 20190729014903epcas1p4a15b281036825821c7e54fb451110685
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 23. 오후 9:20, Artur Świgoń wrote:
> This patch adds interconnect functionality to the exynos-bus devfreq
> driver.
> 
> The SoC topology is a graph (or, more specifically, a tree) and most of its
> edges are taken from the devfreq parent-child hierarchy (cf.
> Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
> patch adds missing edges to the DT (under the name 'parent'). Due to
> unspecified relative probing order, -EPROBE_DEFER may be propagated to
> guarantee that a child is probed before its parent.
> 
> Each bus is now an interconnect provider and an interconnect node as well
> (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> itself as a node. Node IDs are not hardcoded but rather assigned at
> runtime, in probing order (subject to the above-mentioned exception
> regarding relative order). This approach allows for using this driver with
> various Exynos SoCs.
> 
> The devfreq target() callback provided by exynos-bus now selects either the
> frequency calculated by the devfreq governor or the frequency requested via
> the interconnect API for the given node, whichever is higher.

Basically, I agree to support the QoS requirement between devices.
But, I think that need to consider the multiple cases.


1. When changing the devfreq governor by user,
For example of the connection between bus_dmc/leftbus/display on patch8,
there are possible multiple cases with various devfreq governor
which is changed on the runtime by user through sysfs interface.

If users changes the devfreq governor as following:
Before,
- bus_dmc (simple_ondemand, available frequency 100/200/300/400 MHz)
--> bus_leftbus(simple_ondemand, available frequency 100/200/300/400 MHz)
----> bus_display(passive)

After changed governor of bus_dmc,
if the min_freq by interconnect requirement is 400Mhz,
- bus_dmc (powersave) : min_freq and max_freq and cur_freq is 100MHz
--> bus_leftbus(simple_ondemand) : cur_freq is 400Mhz
----> bus_display(passive)

The final frequency is 400MHz of bus_dmc
even if the min_freq/max_freq/cur_freq is 100MHz.
It cannot show the correct min_freq/max_freq through
devfreq sysfs interface.


2. When disabling the some frequency by devfreq-thermal throttling,
This patch checks the min_freq of interconnect requirement
in the exynos_bus_target() and exynos_bus_passive_target().
Also, it cannot show the correct min_freq/max_freq through
devfreq sysfs interface.

For example of bus_dmc bus,
- The available frequencies are 100MHz, 200MHz, 300MHz, 400MHz
- Disable 400MHz by devfreq-thermal throttling 
- min_freq is 100MHz
- max_freq is 300MHz
- min_freq of interconnect is 400MHz

In result, the final frequency is 400MHz by exynos_bus_target()
There are no problem for working. But, the user cannot know
reason why cur_freq is 400MHz even if max_freq is 300MHz.

Basically, update_devfreq() considers the all constraints
of min_freq/max_freq to decide the proper target frequency.


3.
I think that the exynos_bus_passive_target() is used for devfreq device
using 'passive' governor. The frequency already depends on the parent device.

If already the parent devfreq device like bus_leftbus consider
the minimum frequency of QoS requirement like interconnect,
it is not necessary. The next frequency of devfreq device
with 'passive' governor, it will apply the QoS requirement
without any additional code.

> 
> Please note that it is not an error when CONFIG_INTERCONNECT is 'n', in
> which case all interconnect API functions are no-op.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 145 +++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 412511ca7703..12fb7c84ae50 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -14,6 +14,7 @@
>  #include <linux/devfreq-event.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/interconnect-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pm_opp.h>
> @@ -23,6 +24,8 @@
>  #define DEFAULT_SATURATION_RATIO	40
>  #define DEFAULT_VOLTAGE_TOLERANCE	2
>  
> +#define icc_units_to_hz(x) ((x) * 1000UL / 8)
> +
>  struct exynos_bus {
>  	struct device *dev;
>  
> @@ -31,12 +34,17 @@ struct exynos_bus {
>  	unsigned int edev_count;
>  	struct mutex lock;
>  
> +	unsigned long min_freq;
>  	unsigned long curr_freq;
>  
>  	struct regulator *regulator;
>  	struct clk *clk;
>  	unsigned int voltage_tolerance;
>  	unsigned int ratio;
> +
> +	/* One provider per bus, one node per provider */
> +	struct icc_provider provider;
> +	struct icc_node *node;
>  };
>  
>  /*
> @@ -61,6 +69,13 @@ exynos_bus_ops_edev(enable_edev);
>  exynos_bus_ops_edev(disable_edev);
>  exynos_bus_ops_edev(set_event);
>  
> +static int exynos_bus_next_id(void)
> +{
> +	static int exynos_bus_node_id;
> +
> +	return exynos_bus_node_id++;
> +}
> +
>  static int exynos_bus_get_event(struct exynos_bus *bus,
>  				struct devfreq_event_data *edata)
>  {
> @@ -98,6 +113,8 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>  	unsigned long old_freq, new_freq, new_volt, tol;
>  	int ret = 0;
>  
> +	*freq = max(*freq, bus->min_freq);
> +
>  	/* Get new opp-bus instance according to new bus clock */
>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
> @@ -208,6 +225,8 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>  	unsigned long old_freq, new_freq;
>  	int ret = 0;
>  
> +	*freq = max(*freq, bus->min_freq);
> +
>  	/* Get new opp-bus instance according to new bus clock */
>  	new_opp = devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(new_opp)) {
> @@ -251,6 +270,35 @@ static void exynos_bus_passive_exit(struct device *dev)
>  	clk_disable_unprepare(bus->clk);
>  }
>  
> +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> +
> +	src_bus->min_freq = icc_units_to_hz(src->peak_bw);
> +	dst_bus->min_freq = icc_units_to_hz(dst->peak_bw);
> +
> +	return 0;
> +}
> +
> +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_peak = *agg_avg = peak_bw;
> +
> +	return 0;
> +}
> +
> +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
> +					     void *data)
> +{
> +	struct exynos_bus *bus = data;
> +
> +	if (spec->np != bus->dev->of_node)
> +		return ERR_PTR(-EINVAL);
> +
> +	return bus->node;
> +}
> +
>  static int exynos_bus_parent_parse_of(struct device_node *np,
>  					struct exynos_bus *bus)
>  {
> @@ -469,6 +517,95 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	return ret;
>  }
>  
> +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> +{
> +	struct device_node *np = bus->dev->of_node;
> +	struct devfreq *parent_devfreq;
> +	struct icc_node *parent_node = NULL;
> +	struct of_phandle_args args;
> +	int ret = 0;
> +
> +	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
> +	if (!IS_ERR(parent_devfreq)) {
> +		struct exynos_bus *parent_bus;
> +
> +		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
> +		parent_node = parent_bus->node;
> +	} else {
> +		/* Look for parent in DT */
> +		int num = of_count_phandle_with_args(np, "parent",
> +						     "#interconnect-cells");
> +		if (num != 1)
> +			goto out;
> +
> +		ret = of_parse_phandle_with_args(np, "parent",
> +						 "#interconnect-cells",
> +						 0, &args);
> +		if (ret < 0)
> +			goto out;
> +
> +		of_node_put(args.np);
> +
> +		parent_node = of_icc_get_from_provider(&args);
> +		if (IS_ERR(parent_node)) {
> +			/* May be -EPROBE_DEFER */
> +			ret = PTR_ERR(parent_node);
> +			goto out;
> +		}
> +	}
> +
> +	ret = icc_link_create(bus->node, parent_node->id);
> +
> +out:
> +	return ret;
> +}
> +
> +static int exynos_bus_icc_init(struct exynos_bus *bus)
> +{
> +	struct device *dev = bus->dev;
> +	struct icc_provider *provider = &bus->provider;
> +	struct icc_node *node;
> +	int id, ret;
> +
> +	/* Initialize the interconnect provider */
> +	provider->set = exynos_bus_icc_set;
> +	provider->aggregate = exynos_bus_icc_aggregate;
> +	provider->xlate = exynos_bus_icc_xlate;
> +	provider->dev = dev;
> +	provider->data = bus;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret < 0)
> +		goto out;
> +
> +	id = exynos_bus_next_id();
> +	node = icc_node_create(id);
> +	if (IS_ERR(node)) {
> +		ret = PTR_ERR(node);
> +		goto err_node;
> +	}
> +
> +	bus->node = node;
> +	node->name = dev->of_node->name;
> +	node->data = bus;
> +	icc_node_add(node, provider);
> +
> +	ret = exynos_bus_icc_connect(bus);
> +	if (ret < 0)
> +		goto err_connect;
> +
> +out:
> +	return ret;
> +
> +err_connect:
> +	icc_node_del(node);
> +	icc_node_destroy(id);
> +err_node:
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
> +
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -517,6 +654,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  			goto err;
>  	}
>  
> +	/*
> +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
> +	 * that CONFIG_INTERCONNECT is disabled.
> +	 */
> +	ret = exynos_bus_icc_init(bus);
> +	if (ret < 0 && ret != -ENOTSUPP)
> +		goto err;
> +
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
