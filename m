Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556976B6AC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQGeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:34:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63428 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQGeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:34:25 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190717063422epoutp04ffcd850c9dd3b5642982384471322068~yHjvMeg8N1012610126epoutp04G
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 06:34:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190717063422epoutp04ffcd850c9dd3b5642982384471322068~yHjvMeg8N1012610126epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563345262;
        bh=JH91yOtS+jffgxTTFHGvw6ei+DdsN9zJJgohcmSBYac=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ghw6opmMfKXxmk6IuAPNpKUABd2hDsPjQFDnPWvGJB3u6CIzlb/yPkj3OS9x53TWR
         aP1xQDwS0pBQyrpzMmG3ikC0PS91IzqqcQrSnJkizBeIfg5IHKlDFydi9VYJ48IhoL
         FvB2VVlCu7kkfeIs+w2XWr73w280ZnEdH1vPLBLY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190717063422epcas1p203192e207e6f33e7ff96ee2fd29038cb~yHjuzgLBD1459914599epcas1p2a;
        Wed, 17 Jul 2019 06:34:22 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45pSCw1dFbzMqYlv; Wed, 17 Jul
        2019 06:34:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.F0.04160.C61CE2D5; Wed, 17 Jul 2019 15:34:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190717063419epcas1p48c8037c7214623b761c270bfefbf88d9~yHjsS0z900625506255epcas1p4j;
        Wed, 17 Jul 2019 06:34:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717063419epsmtrp2e0bd7419f210c5a1549631ecea66561e~yHjsSCCD81019710197epsmtrp2q;
        Wed, 17 Jul 2019 06:34:19 +0000 (GMT)
X-AuditID: b6c32a38-b4bff70000001040-71-5d2ec16cd0af
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.8F.03638.B61CE2D5; Wed, 17 Jul 2019 15:34:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190717063419epsmtip1ccf829f1c4c3d555a71411df1e7224d9~yHjsGweoS1162611626epsmtip1R;
        Wed, 17 Jul 2019 06:34:19 +0000 (GMT)
Subject: Re: [PATCH v4 02/24] PM / devfreq: tegra30: Keep interrupt disabled
 while governor is stopped
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ca339b7f-1141-4c68-1c07-2ac818422bbc@samsung.com>
Date:   Wed, 17 Jul 2019 15:37:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6c517d04-cf99-f907-e74d-9fba99405a53@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut7vdTW11nVnHBaW3B7lwetXVNVoUhg16IJX0AFkXvW3qXuxu
        Pek5y7QMrShaZWVF5QPTXOmyJGeJhiVZUMoiSCjK7GGaVli73iL/+853vvP4fr8jwxSVuFKW
        ZXGwdgtjIvFg8S1ftDrGdF+dHrevejxd/uUNonPdpWK6fX+vlO70nsXp/sJmROd/c+N0975r
        OD3sLRHTRyuf4ouDdHX+y0hX7/ZLdYWuPlx3tLYM6fprpqVKNuYsNLJMJmuPZC0Z1swsi0FL
        Ll+jT9Zr5sVRMVQSPZ+MtDBmVksuXZEak5JlCixERm5hTM4AlcpwHBm7aKHd6nSwkUYr59CS
        rC3TZEuyqTnGzDktBnWG1byAiouL1wSEm3KMVd3PpLZccltFXoNoL2qdWoBkMiAS4XdbSAEK
        limIOgRVpT0SIfiK4GRTkagABQWCQQRdD7N5zBecOjEoFUR3EeSe6MaF4BOCX0U+Ca8KI4zg
        H/IhPjGJGEGQP+zC+QRGbABfffloW5xQQeO7F6P8RCIKng+9QfxOcmIR3CsN5mkxMQvuvS1B
        PA4n1kNbc4mYx3IiFFpP94ziIEILt199lgrtp0BXz3mRgKeDy3MG43cAwiWFw0PtEsHzUvhQ
        rBbchMH7llqpgJXQ33cXF/BOuN7ajAu1hxDUNnZIhEQCNF45LuL7YEQ0VHljBToK6n+eQ8Lc
        CdA3cOTvKDkcOqgQJDOg87VfJOAIuJSXjxch0j3GjXuMA/cYB+7/wy4gcRmazNo4s4HlKFvi
        2L+uQaOnqqLrUMPjFU2IkCFyvFzni0lXSJgt3HZzEwIZRk6Sawfmpivkmcz2Hazdqrc7TSzX
        hDSBxy7GlOEZ1sDhWxx6ShOfkJBAJ1LzNBRFTpGX/IpOVxAGxsHmsKyNtf+rE8mClHuRkwrd
        /9GQtMSStzq6Fzt9pmLbjxHP7q3Z9MvBcTrbk86Q5LWP0g6E71J+LfS03lS1fCz6UXwkq3p1
        RHes52DB1Ybvq1Quj3Ekajp2zHT+bVlGx/vN7uGelWm1+nU47Q35kpcyc7Z32R0uoottDv2W
        PMe/Z8IOqSLlRvuDi2FJFbc3kGLOyFAqzM4xfwB/p6KpwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG72Qb1YgzVN6harPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ629fYS9oUapY076HqYHxpHQXIyeHhICJxPQp
        39i7GLk4hAR2M0rsazzJDJGQlJh28SiQzQFkC0scPlwMEhYSeMsocbZdCMQWFsiQuPvjMCNI
        r4hAE5PEpt4L7CAJZoFIiZ65W9gghs5mknjQ1MoEkmAT0JLY/+IGG4jNL6AocfXHY0aQBbwC
        dhL7FnGBhFkEVCX2PZ/HCGKLCkRITLq2kwXE5hUQlDg58wmYzSlgK7H93geoXeoSf+ZdYoaw
        xSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjOAI09LawXjiRPwhRgEORiUeXo/DurFCrIllxZW5hxglOJiVRHhtv2rHCvGm
        JFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamDMWFW659QLs6dv
        dGuMqmXqttf+y9xc8NNN3Mv+89dGRd34E8xK+2UmMNnvW7xHrko/SWhbf9X8b0fnH5l82i2X
        dZd2HcuZVQu9d0+YvXdtcrlw4yGD/f2/Jm8WsVhyPmlVDu+MTwyeMSa3/SX5mYyezf2s9PbS
        6SkrDGLOHblcWPUr5PpCxf40JZbijERDLeai4kQAPr+/sawCAAA=
X-CMS-MailID: 20190717063419epcas1p48c8037c7214623b761c270bfefbf88d9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223724epcas4p2d82cecc2969fecddca67192417843418
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223724epcas4p2d82cecc2969fecddca67192417843418@epcas4p2.samsung.com>
        <20190707223303.6755-3-digetx@gmail.com>
        <f691a845-18f3-a6fb-302c-a8a3fc13e5bf@samsung.com>
        <6c517d04-cf99-f907-e74d-9fba99405a53@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 16. 오후 10:03, Dmitry Osipenko wrote:
> 16.07.2019 14:47, Chanwoo Choi пишет:
>> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>>> There is no real need to keep interrupt always-enabled, will be nicer
>>> to keep it disabled while governor is inactive.
>>>
>>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 43 ++++++++++++++++---------------
>>>  1 file changed, 22 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>> index a27300f40b0b..5e2b133babdd 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/devfreq.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/io.h>
>>> +#include <linux/irq.h>
>>>  #include <linux/module.h>
>>>  #include <linux/mod_devicetable.h>
>>>  #include <linux/platform_device.h>
>>> @@ -416,8 +417,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>>>  {
>>>  	unsigned int i;
>>>  
>>> -	disable_irq(tegra->irq);
>>> -
>>>  	actmon_writel(tegra, ACTMON_SAMPLING_PERIOD - 1,
>>>  		      ACTMON_GLB_PERIOD_CTRL);
>>>  
>>> @@ -442,8 +441,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>>  	}
>>>  
>>>  	actmon_write_barrier(tegra);
>>> -
>>> -	enable_irq(tegra->irq);
>>>  }
>>>  
>>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>> @@ -552,6 +549,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>>>  {
>>>  	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>>>  
>>> +	/*
>>> +	 * Couple device with the governor early as it is needed at
>>> +	 * the moment of governor's start (used by ISR).
>>> +	 */
>>> +	tegra->devfreq = devfreq;
>>
>> I'm not sure it is necessary. Almost devfreq device get
>> the devfreq instance on probe timing through devfreq_add_device directly.
> 
> This is necessary because this assignment is for the "governor" and not
> the "device". Governor is started during of devfreq_add_device(), hence
> there is no better way to assign device to the driver's governor.

OK. I understand.

But, I have a question. Is it working before this patch?
How can you test it on that tegra->devfreq is NULL?

> 
>>> +
>>>  	switch (event) {
>>>  	case DEVFREQ_GOV_START:
>>>  		devfreq_monitor_start(devfreq);
>>> @@ -586,10 +589,11 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>>  
>>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  {
>>> -	struct tegra_devfreq *tegra;
>>>  	struct tegra_devfreq_device *dev;
>>> -	unsigned int i;
>>> +	struct tegra_devfreq *tegra;
>>> +	struct devfreq *devfreq;
>>>  	unsigned long rate;
>>> +	unsigned int i;
>>>  	int err;
>>>  
>>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>> @@ -625,6 +629,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	}
>>>  	tegra->irq = err;
>>>  
>>> +	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
>>> +
>>> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
>>> +					actmon_thread_isr, IRQF_ONESHOT,
>>> +					"tegra-devfreq", tegra);
>>> +	if (err) {
>>> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>>  	reset_control_assert(tegra->reset);
>>>  
>>>  	err = clk_prepare_enable(tegra->clock);
>>> @@ -672,28 +686,15 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  	}
>>>  
>>>  	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
>>> -	tegra->devfreq = devfreq_add_device(&pdev->dev,
>>> -					    &tegra_devfreq_profile,
>>> -					    "tegra_actmon",
>>> -					    NULL);
>>> +	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>>> +				     "tegra_actmon", NULL);
>>>  	if (IS_ERR(tegra->devfreq)) {
>>
>> Have to check 'devfreq' instead of 'tegra->devfreq'.
>> Did you test it? It might be failed because 'tegra->devfreq is NULL.
> 
> That's a good catch! Thank you very much.
> 
>>>  		err = PTR_ERR(tegra->devfreq);
>>
>> ditto.
> 
> Ok
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
