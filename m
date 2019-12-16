Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE1DE120299
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLPKaa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 05:30:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:62771 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfLPKaa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 05:30:30 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191216103027epoutp030a2d619bf6931182e3c67f8f01206749~g01PvxWZE3206732067epoutp03c
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 10:30:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191216103027epoutp030a2d619bf6931182e3c67f8f01206749~g01PvxWZE3206732067epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576492227;
        bh=1X4Yyyd+hec7zltkrP9QoT/WFWYnJTDb2OtOT5G1ke8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d32fwD22phj6Le1r4EwdDVuYApP5wz7dhafD9jvsQVTtDOYguE8Szl42exDDXOp/K
         Col2XDl7fzLqBjPb0AciMsggmGxdY76Q58oSF4OArcWE0/bFWJREE6ycbSNvzZj7ZL
         pNqToPEnoiJJAqQQEJ/7+T4dYG5MTcMhc8ZQksJk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191216103026epcas1p167284321344d76e47d3179393772908d~g01PA6oJI1241512415epcas1p18;
        Mon, 16 Dec 2019 10:30:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47byG80nWNzMqYlp; Mon, 16 Dec
        2019 10:30:24 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.CA.48498.0CC57FD5; Mon, 16 Dec 2019 19:30:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216103023epcas1p42a5584c54fe5f3eb45af8a55a0d23f0e~g01MmGBkc1983919839epcas1p4r;
        Mon, 16 Dec 2019 10:30:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216103023epsmtrp1ce21dd9b732e64193def05e620be1851~g01Mg7qvx2567825678epsmtrp1P;
        Mon, 16 Dec 2019 10:30:23 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-aa-5df75cc04340
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.FA.06569.FBC57FD5; Mon, 16 Dec 2019 19:30:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191216103023epsmtip15f889e0989f6513eb4d040c151e9f785~g01MRBDM61327513275epsmtip1T;
        Mon, 16 Dec 2019 10:30:23 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: Clean up code
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a249bf89-f628-015c-fde5-b9ecb894695f@samsung.com>
Date:   Mon, 16 Dec 2019 19:36:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191216101948.526-1-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmvu6BmO+xBv1nmC3uz2tltNg4Yz2r
        xaT7E1gs+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3GFWwW
        Mya/ZHPg9di0qpPNY/OSeo++LasYPT5vkgtgicq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQndG09jtTwRLNin/tB1kbGKcpdDFyckgImEis
        m/mUvYuRi0NIYAejxLs1D6CcT4wSPxasYIZwvjFKnHy5lg2m5eXyWYwQib2MEi2nJrOCJIQE
        3jNK7G6NBbGFBcwljk77ygpSJCJwgFFiZccxsFHMIM7yHedZQKrYBLQk9r+4ATaWX0BR4uqP
        x4wgNq+AncSLucuZQGwWAVWJSbdB7uDkEBUIkzi5rQWqRlDi5MwnYHM4BSwkDjdtAJvDLCAu
        cevJfCYIW16ieetssMUSApPZJWaca2eH+MFF4u7zlVC2sMSr41ugbCmJl/1tUHa1xMqTR9gg
        mjsYJbbsv8AKkTCW2L90MtAGDqANmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFeiY42IYgS
        ZYnLD+4yQdiSEovbO9kmMCrNQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYbFhghx/cmRnDi
        1TLbwbjonM8hRgEORiUe3pcZ32KFWBPLiitzDzFKcDArifDuUPgeK8SbklhZlVqUH19UmpNa
        fIjRFBjaE5mlRJPzgVkhryTe0NTI2NjYwsTQzNTQUEmcl+PHxVghgfTEktTs1NSC1CKYPiYO
        TqkGRlMthQ+Ks3fd6LEuZFqcKH7WwqPtgky04eR7CotmBZ1pvT0rufOb7KGk9SxXXKaaSZ0V
        mTtR8PYJtuLbXP2f5tyQv83E4zLbdiPHxb8rQrkiar9MCL3Aub/CdnuWZeWZgvtvtLzuPmSL
        uJIhceHL194Zmnsn8P0Wj/0y/YhR2BuPlVuFGv8/V1BiKc5INNRiLipOBAD8DGPQ0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSnO7+mO+xBs+fyVjcn9fKaLFxxnpW
        i0n3J7BY9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        Zkx+yebA67FpVSebx+Yl9R59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CV0bT2O1PBEs2Kf+0H
        WRsYpyl0MXJySAiYSLxcPouxi5GLQ0hgN6PE4w3fGSESkhLTLh5l7mLkALKFJQ4fLoaoecso
        cWj1HhaQGmEBc4mj076ygiREBA4wSsy59YAdJMEM4qw6HgzR0c0oMX3/LrAEm4CWxP4XN9hA
        bH4BRYmrPx6DbeMVsJN4MXc5E4jNIqAqMen2CmYQW1QgTGLnksdMEDWCEidnPgHbzClgIXG4
        aQMbxDJ1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFu
        em6xYYFRXmq5XnFibnFpXrpecn7uJkZwBGpp7WA8cSL+EKMAB6MSD69D9rdYIdbEsuLK3EOM
        EhzMSiK8OxS+xwrxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLg
        lAJGzvMda64tum/5tWNaY/ll5qk18+VmVwf/Pnli8v2JztG3/wRGH9++8IVeAfNXsQkRcTM6
        7vPrzNC4UbH1s3vC104T3q0y7nmae0ReHP/kcCtH9aItl+ynXiYFg7+3P6/RznFmO1PVvMNE
        IVH+16ylC8K3dJ07ohHSpnFBx8lg8ttL2jUT/vsvV2Ipzkg01GIuKk4EAA1Mbcm8AgAA
X-CMS-MailID: 20191216103023epcas1p42a5584c54fe5f3eb45af8a55a0d23f0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191216102003eucas1p280d2bb32bc439a52353536dca87246f0
References: <CGME20191216102003eucas1p280d2bb32bc439a52353536dca87246f0@eucas1p2.samsung.com>
        <20191216101948.526-1-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

If possible, you better to write the more correct patch title
because 'Clean up code' is too comprehensive.

And please add 'PM / devfreq: ...' prefix for the devfreq patch.
When you check the merged patches of driver/devfreq/,
you can know the this prefix for patch title was used.

On 12/16/19 7:19 PM, Artur Świgoń wrote:
> This patch improves code readability by changing the following construct:
> 
>>    if (cond)
>>        goto passive;
>>    foo();
>>    goto out;
>> passive:
>>    bar();
>> out:
> 
> into this:
> 
>>    if (cond)
>>        bar();
>>    else
>>        foo();

When you add the example, please remove '>' char.

> 
> as well as eliminating a few more goto statements and fixing header
> includes.

And better to write what to fix the header including.

> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 54 +++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 19d9f9f8ced2..7f5917d59072 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -15,11 +15,10 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/slab.h>
>  
>  #define DEFAULT_SATURATION_RATIO	40
>  
> @@ -301,10 +300,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	profile->exit = exynos_bus_exit;
>  
>  	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> -	if (!ondemand_data) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (!ondemand_data)
> +		return -ENOMEM;
> +
>  	ondemand_data->upthreshold = 40;
>  	ondemand_data->downdifferential = 5;
>  
> @@ -314,15 +312,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  						ondemand_data);
>  	if (IS_ERR(bus->devfreq)) {
>  		dev_err(dev, "failed to add devfreq device\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> +		return PTR_ERR(bus->devfreq);
>  	}
>  
>  	/* Register opp_notifier to catch the change of OPP  */
>  	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register opp notifier\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	/*
> @@ -332,17 +329,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	ret = exynos_bus_enable_edev(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to enable devfreq-event devices\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	ret = exynos_bus_set_event(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		goto err;
> +		return ret;
>  	}
>  
> -err:
> -	return ret;
> +	return 0;
>  }
>  
>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> @@ -351,7 +347,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	struct device *dev = bus->dev;
>  	struct devfreq_passive_data *passive_data;
>  	struct devfreq *parent_devfreq;
> -	int ret = 0;
>  
>  	/* Initialize the struct profile and governor data for passive device */
>  	profile->target = exynos_bus_target;
> @@ -359,16 +354,13 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  
>  	/* Get the instance of parent devfreq device */
>  	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
> -	if (IS_ERR(parent_devfreq)) {
> -		ret = -EPROBE_DEFER;
> -		goto err;
> -	}
> +	if (IS_ERR(parent_devfreq))
> +		return -EPROBE_DEFER;
>  
>  	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
> -	if (!passive_data) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (!passive_data)
> +		return -ENOMEM;
> +
>  	passive_data->parent = parent_devfreq;
>  
>  	/* Add devfreq device for exynos bus with passive governor */
> @@ -377,12 +369,10 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	if (IS_ERR(bus->devfreq)) {
>  		dev_err(dev,
>  			"failed to add devfreq dev with passive governor\n");
> -		ret = PTR_ERR(bus->devfreq);
> -		goto err;
> +		return PTR_ERR(bus->devfreq);
>  	}
>  
> -err:
> -	return ret;
> +	return 0;
>  }
>  
>  static int exynos_bus_probe(struct platform_device *pdev)
> @@ -427,19 +417,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err_reg;
>  
>  	if (passive)
> -		goto passive;
> -
> -	ret = exynos_bus_profile_init(bus, profile);
> -	if (ret < 0)
> -		goto err;
> +		ret = exynos_bus_profile_init_passive(bus, profile);
> +	else
> +		ret = exynos_bus_profile_init(bus, profile);
>  
> -	goto out;
> -passive:
> -	ret = exynos_bus_profile_init_passive(bus, profile);
>  	if (ret < 0)
>  		goto err;
>  
> -out:
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
