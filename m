Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD14611C2A1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 02:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLLBqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 20:46:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52556 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLLBqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 20:46:13 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191212014610epoutp011f07ab950222ebc2e2d1b0660e1bada7~ffGWSKy4j0458304583epoutp01S
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 01:46:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191212014610epoutp011f07ab950222ebc2e2d1b0660e1bada7~ffGWSKy4j0458304583epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576115170;
        bh=Y+nUEVrvjvB4DwJ+teW7r5InmUSkqPPV4kbsqylmtf4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uscqWLRSwkzkwBTCiZRdev2IoeV50KR7l9PjVTyi8xH1/OaxzpXFGGtw15kPhRIle
         wMDM/2jPnZqLHdYu69ZCsvNfQdCRqvpLFf5zoc78uipChIXxjr7oBwlEIJAT7KuShG
         H4f4JrX+/YV0OgeLEPDQHpS1e80F3EEZCZyXxpVs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191212014609epcas1p1e43b6a2391966c2d30eef1e6cace6962~ffGVif-4G0732107321epcas1p1Q;
        Thu, 12 Dec 2019 01:46:09 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47YGq26fkrzMqYlx; Thu, 12 Dec
        2019 01:46:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.67.48019.EDB91FD5; Thu, 12 Dec 2019 10:46:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191212014605epcas1p42a0b58fc4828dd209dcbc3915b6ae59d~ffGR-Trmw0342203422epcas1p43;
        Thu, 12 Dec 2019 01:46:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191212014605epsmtrp2882f4a0f7543000b487fbb4d12e38743~ffGR_fyLK1885318853epsmtrp2P;
        Thu, 12 Dec 2019 01:46:05 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-cc-5df19bdef27a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.89.06569.DDB91FD5; Thu, 12 Dec 2019 10:46:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191212014605epsmtip16eedcad2bccb2c9a8bde04041dd7b2a8~ffGRoCjHE1539315393epsmtip1I;
        Thu, 12 Dec 2019 01:46:05 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] devfreq: exynos-bus: Clean up code
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        kgene@kernel.org, krzk@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, k.konieczny@samsung.com,
        leonard.crestez@nxp.com, rostedt@goodmis.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <852f742c-1f7b-0981-4409-d2d50ee86301@samsung.com>
Date:   Thu, 12 Dec 2019 10:52:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <32cd66aca8d9435bed69732771a7716db883f5a0.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmvu692R9jDaYeNbW4P6+V0WLjjPWs
        FpPuT2CxWPBpBqtF/+PXzBbnz29gtzjb9IbdYsXdj6wWmx5fY7W4vGsOm8Xn3iOMFjPO72Oy
        WHvkLrvF7cYVbBb7Oh4wWcyY/JLNQcCjZd8tdo9NqzrZPDYvqffY+G4Hk0ffllWMHp83yQWw
        RWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdraRQ
        lphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzI
        zti8U63go2vFlUMbGRsYH5l3MXJySAiYSLyfcYexi5GLQ0hgB6NE49tJTBDOJ0aJrQ9ms0M4
        3xgluvZdZYVpeT5tMzNEYi+jxPu5r6Gq3jNKvOp7xQJSJSxgJ7FswQ6wWSICBxglDqxvBnOY
        BTqZJDq7d4NVsQloSex/cYMNxOYXUJS4+uMx0CkcHLxA3c1PhUDCLAKqEi3LPoKViAqESZzc
        1sIIYvMKCEqcnPkEbAyngKfEhrnzwM5jFhCXuPVkPhOELS/RvHU22KkSArvYJd5O2w31g4vE
        mmUzmSFsYYlXx7ewQ9hSEp/f7WWDsKslVp48wgbR3MEosWX/BahmY4n9SyczgRzKLKApsX6X
        PkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2TbQKj0iwk78xC8sIs
        JC/MQli2gJFlFaNYakFxbnpqsWGBCXJ0b2IEJ2otix2Me875HGIU4GBU4uF9IP0xVog1say4
        MvcQowQHs5II7/G2d7FCvCmJlVWpRfnxRaU5qcWHGE2BoT2RWUo0OR+YRfJK4g1NjYyNjS1M
        DM1MDQ2VxHk5flyMFRJITyxJzU5NLUgtgulj4uCUamDc/PO/4OdTguqZauJ6v9Zx3riarXb8
        Vc3bK1VvFlvYtx5L+XKzIOT6pcce/ZJHC32+VtcemikYonc+KCrv5fmpEjoP/7ZcEjPu/RCZ
        rj6303Td9bw+Dlf7zgterhO6jv4/sojnmL/wVs2Nf7O2xxfk+ZzcWre1SJRNtPmm57U09ahT
        O5UmFC9VYinOSDTUYi4qTgQAVX3kvOoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO7d2R9jDRqWKVjcn9fKaLFxxnpW
        i0n3J7BYLPg0g9Wi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ
        rD1yl93iduMKNot9HQ+YLGZMfsnmIODRsu8Wu8emVZ1sHpuX1HtsfLeDyaNvyypGj8+b5ALY
        orhsUlJzMstSi/TtErgyNu9UK/joWnHl0EbGBsZH5l2MnBwSAiYSz6dtZu5i5OIQEtjNKPFz
        UjcLREJSYtrFo0AJDiBbWOLw4WKImreMEgvvzWYHqREWsJNYtmAHE0hCROAAo8TmnbPBHGaB
        TiaJXx/Ws0G0bGSS2Nu/GGwsm4CWxP4XN9hAbH4BRYmrPx4zgqzgBRrV/FQIJMwioCrRsuwj
        WImoQJjEziWPmUBsXgFBiZMzn4CN4RTwlNgwdx4riM0soC7xZ94lZghbXOLWk/lMELa8RPPW
        2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5Y
        La0djCdOxB9iFOBgVOLh7ZD8GCvEmlhWXJl7iFGCg1lJhPd427tYId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYzLnab+e7DvSW7P1p55v7R13L2v936r
        m6fd6Vvxf9G3puXvNe79YJD+XLkx/2HULcN3T6rl0v6yVVZNbCo+q6b7tlogyTpsX+TN0jIl
        l122ERnuszkYP7faiHS8yrNa7nVF0yfaJtpsw5YTO1yEXcyFYi1cO9775HVFrTOrW7v/utbJ
        5mnVZ5RYijMSDbWYi4oTAU07MqHUAgAA
X-CMS-MailID: 20191212014605epcas1p42a0b58fc4828dd209dcbc3915b6ae59d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2
References: <20191209104902.11904-1-a.swigon@samsung.com>
        <CGME20191209105034eucas1p277be9a40363fec76b4241d28e71e40d2@eucas1p2.samsung.com>
        <20191209104902.11904-5-a.swigon@samsung.com>
        <ab5cd151-0f9f-929e-fcbe-e7fe7b6c8645@samsung.com>
        <32cd66aca8d9435bed69732771a7716db883f5a0.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/11/19 11:39 PM, Artur Świgoń wrote:
> Hi,
> 
> On Tue, 2019-12-10 at 13:20 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> This patch contains the clean-up code related to 'goto' style.
>> Please merge the the clean-up code of 'goto' to one patch with patch3/patch4.
>> - patch3 related to 'goto' clean-up code
>> - patch4 related to remaining clean-up code. 
>>
>> And I added the comment below. Please check them.
> 
> OK, I can merge these patches. Please also see my comments below regarding
> the issues you highlighted: kzalloc vs. kcalloc, fitting in 80 columns and
> changing repeated expressions to variables.
> 
>>
>> On 12/9/19 7:49 PM, Artur Świgoń wrote:
>>> This patch adds minor improvements to the exynos-bus driver, including
>>> cleaning up header includes, variables, and return paths.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 56 +++++++++++++++---------------------
>>>  1 file changed, 23 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 0b557df63666..3eb6a043284a 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -15,11 +15,10 @@
>>>  #include <linux/device.h>
>>>  #include <linux/export.h>
>>>  #include <linux/module.h>
>>> -#include <linux/of_device.h>
>>> +#include <linux/of.h>
>>>  #include <linux/pm_opp.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/regulator/consumer.h>
>>> -#include <linux/slab.h>
>>>  
>>>  #define DEFAULT_SATURATION_RATIO	40
>>>  
>>> @@ -178,7 +177,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  	struct device *dev = bus->dev;
>>>  	struct opp_table *opp_table;
>>>  	const char *vdd = "vdd";
>>> -	int i, ret, count, size;
>>> +	int i, ret, count;
>>>  
>>>  	opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>  	if (IS_ERR(opp_table)) {
>>> @@ -201,8 +200,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  	}
>>>  	bus->edev_count = count;
>>>  
>>> -	size = sizeof(*bus->edev) * count;
>>> -	bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>> +	bus->edev = devm_kcalloc(dev, count, sizeof(*bus->edev), GFP_KERNEL);
>>
>> ditto.
>> It depends on personal style. Don't change it because we cannot
>> modify them at the all device driver. If is not wrong,
>> just keep the original code.
> 
> Of course, this is a matter of style, but I think that Coccinelle reports
> such code, compare with e.g., https://protect2.fireeye.com/url?k=9d96be53-c05a72f6-9d97351c-0cc47a30d446-615469bafe78ddb7&u=https://lkml.org/lkml/2019/5/8/927

OK. If it is result from Coccinelle reports, you need to add
the 'Coccinelle reports' in the patch description.

When you send v2, you can contain this clean-up
with 'Coccinelle reports'. If there are reasonable reason,
always I'll agree.

> 
> Anyway, I can drop it since the purpose of this patchset as a whole was to
> untangle all the goto's and I agree this is kind of unrelated.
> 
>>
>>>  	if (!bus->edev) {
>>>  		ret = -ENOMEM;
>>>  		goto err_regulator;
>>> @@ -301,10 +299,9 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>  	profile->exit = exynos_bus_exit;
>>>  
>>>  	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
>>> -	if (!ondemand_data) {
>>> -		ret = -ENOMEM;
>>> -		goto err;
>>> -	}
>>> +	if (!ondemand_data)
>>> +		return -ENOMEM;
>>> +
>>>  	ondemand_data->upthreshold = 40;
>>>  	ondemand_data->downdifferential = 5;
>>>  
>>> @@ -314,15 +311,14 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>  						ondemand_data);
>>>  	if (IS_ERR(bus->devfreq)) {
>>>  		dev_err(dev, "failed to add devfreq device\n");
>>> -		ret = PTR_ERR(bus->devfreq);
>>> -		goto err;
>>> +		return PTR_ERR(bus->devfreq);
>>>  	}
>>>  
>>>  	/* Register opp_notifier to catch the change of OPP  */
>>>  	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "failed to register opp notifier\n");
>>> -		goto err;
>>> +		return ret;
>>>  	}
>>>  
>>>  	/*
>>> @@ -332,17 +328,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>>  	ret = exynos_bus_enable_edev(bus);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "failed to enable devfreq-event devices\n");
>>> -		goto err;
>>> +		return ret;
>>>  	}
>>>  
>>>  	ret = exynos_bus_set_event(bus);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
>>> -		goto err;
>>> +		return ret;
>>>  	}
>>>  
>>> -err:
>>> -	return ret;
>>> +	return 0;
>>>  }
>>>  
>>>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>> @@ -351,7 +346,6 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>  	struct device *dev = bus->dev;
>>>  	struct devfreq_passive_data *passive_data;
>>>  	struct devfreq *parent_devfreq;
>>> -	int ret = 0;
>>>  
>>>  	/* Initialize the struct profile and governor data for passive device */
>>>  	profile->target = exynos_bus_target;
>>> @@ -359,30 +353,26 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>  
>>>  	/* Get the instance of parent devfreq device */
>>>  	parent_devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>>> -	if (IS_ERR(parent_devfreq)) {
>>> -		ret = -EPROBE_DEFER;
>>> -		goto err;
>>> -	}
>>> +	if (IS_ERR(parent_devfreq))
>>> +		return -EPROBE_DEFER;
>>>  
>>>  	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
>>> -	if (!passive_data) {
>>> -		ret = -ENOMEM;
>>> -		goto err;
>>> -	}
>>> +	if (!passive_data)
>>> +		return -ENOMEM;
>>> +
>>>  	passive_data->parent = parent_devfreq;
>>>  
>>>  	/* Add devfreq device for exynos bus with passive governor */
>>> -	bus->devfreq = devm_devfreq_add_device(dev, profile, DEVFREQ_GOV_PASSIVE,
>>> +	bus->devfreq = devm_devfreq_add_device(dev, profile,
>>> +						DEVFREQ_GOV_PASSIVE,
>>
>> It is not clean-up. It depends on personal style. Don't change it
>> because we cannot modify them at the all device driver. If is not wrong,
>> just keep the original code.
> 
> I wanted to make the code fit in 80 columns (issue reported by
> scripts/checkpatch.pl). For the reasons stated in my previous comment,
> I am happy to drop this change if you don't like it.

ditto. Please mention the reason from checkpatch.pl on patch4 description.

> 
>>
>>>  						passive_data);
>>>  	if (IS_ERR(bus->devfreq)) {
>>>  		dev_err(dev,
>>>  			"failed to add devfreq dev with passive governor\n");
>>> -		ret = PTR_ERR(bus->devfreq);
>>> -		goto err;
>>> +		return PTR_ERR(bus->devfreq);
>>>  	}
>>>  
>>> -err:
>>> -	return ret;
>>> +	return 0;
>>>  }
>>>  
>>>  static int exynos_bus_probe(struct platform_device *pdev)
>>> @@ -400,18 +390,18 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
>>> +	bus = devm_kzalloc(dev, sizeof(*bus), GFP_KERNEL);
>>
>> ditto.
>> It depends on personal style. Don't change it because we cannot
>> modify them at the all device driver. If is not wrong,
>> just keep the original code.
> 
> Please note that there exists this variable in exynos_bus_probe():
> 
> struct device *dev = &pdev->dev;
> 
> but the expression '&pdev->dev' is reused twice more ('dev' itself
> is also used). Is there any reason for such inconsistency?

Frankly, it is not any reason. Mabye, we could find same thing like thin
in the linux kernel. As you commented, we better to keep the only one
style without any specific reason.

But, in my experience, these minor issues will happen continuously
in linux kernel. I think tha it is not much valuable to change
the these minor issues except for result rom checkpatch.pl/Coccinelle script.
I think that sometimes it make the difficult to keep the patch history.

If there are any special reason, In my case, just keep the origin code
for the patch history.

> 
>>
>>>  	if (!bus)
>>>  		return -ENOMEM;
>>>  	mutex_init(&bus->lock);
>>> -	bus->dev = &pdev->dev;
>>> +	bus->dev = dev;
>>
>> ditto.
>> It depends on personal style. Don't change it because we cannot
>> modify them at the all device driver. If is not wrong,
>> just keep the original code.
> 
> (See above)
> 
>>
>>>  	platform_set_drvdata(pdev, bus);
>>>  
>>>  	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
>>>  	if (!profile)
>>>  		return -ENOMEM;
>>>  
>>> -	node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>> +	node = of_parse_phandle(np, "devfreq", 0);
>>>  	if (node) {
>>>  		of_node_put(node);
>>>  		passive = true;
>>>
>>
> 
> Best regards,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
