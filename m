Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B912208E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLQAzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 19:55:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:18906 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfLQAzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 19:55:52 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191217005549epoutp047feaeedc9f8b2ab64bee3434a5c14961~hAo0Gkvis2981329813epoutp04K
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 00:55:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191217005549epoutp047feaeedc9f8b2ab64bee3434a5c14961~hAo0Gkvis2981329813epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576544149;
        bh=oFf0YYzg3Q++/l5wAcm1gQIa8Dip0K8klEz+CMiY2uU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oVj4QtwTxOP7dZj7FfYVzNaSv/P3KE1FxZ+K0+g2uCrNdPOhoNhgDRnVofxMsf8gj
         KPSzQpPPtc/tw8pYE37mPT3x8FwU6pagHNlcHvWO4TAOVU/H/tqFxxcVKVxFbRr50f
         l1QCpVeTkmD9sqm7jzJvnAyH9HVpaJiUSr20/RTc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191217005548epcas1p3502dd60c4de05b0d074be784667f1190~hAozER2VM0323703237epcas1p3r;
        Tue, 17 Dec 2019 00:55:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47cKSb0Kw5zMqYkV; Tue, 17 Dec
        2019 00:55:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.55.52419.E8728FD5; Tue, 17 Dec 2019 09:55:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191217005542epcas1p1f47ed6dca37b3d2ab75e104422a56e10~hAoto31vY2788827888epcas1p1m;
        Tue, 17 Dec 2019 00:55:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191217005542epsmtrp1d5cc432890e46bd7569132726f3ae08f~hAotnqVIa2513225132epsmtrp1U;
        Tue, 17 Dec 2019 00:55:42 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-ae-5df8278e2135
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.E2.10238.E8728FD5; Tue, 17 Dec 2019 09:55:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191217005541epsmtip22dd3f67a2dff10d4a9e7442998571c76~hAotJX7Cb1453214532epsmtip2k;
        Tue, 17 Dec 2019 00:55:41 +0000 (GMT)
Subject: Re: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <60fe19c6-6e73-4133-ed7e-a13a875589c0@samsung.com>
Date:   Tue, 17 Dec 2019 10:02:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH8+u9vb0Qq9duyG/NMso1zIiBcVcYv7mxLBHNTTYTcNH4SMNu
        4A4IfdkLyJxhbKETmrG5YGno3DqDGGB10oc8HKQROhdQgW7hETochKmgGzh5iNWpLbdL+t/n
        nN/3nJPv+eWQmOJLmZIs1ZfzJj2npYl4vGvw+fS0c89taDJG6xBa+24YoM9v3QBo1fo1hubv
        BgHqbi5EDv+IFLk8QRzZ+t0E6rD24mh0tFOGfjh9X4baZh5KkXt+QoosoXYMrTT4AWqdDEjQ
        RNsFKVrpnAcoMPwyCp5qI9DVkW8IdGnViiFzv1+GLAOPCPTvhAtHC95E1NoygSHXGntwO2u1
        tAHWedkJ2OUps4y9WBPA2SvuCtbdUU+wdyb6CNbz2UnWtdQjYc8/ymBDgwnsOW8HYFfcO/Lk
        b5ftL+G5It6k4vWFhqJSfXEOfehIwUsFWXsymDRmL8qmVXpOx+fQuYfz0l4p1Yb3QasqOW1F
        OJXHCQK968B+k6GinFeVGITyHJo3FmmNe43pAqcTKvTF6YUG3YtMRsburLDwaFlJ0BMijJd3
        Vn3V4JHWgNkdFhBHQioTroc8uAXEkwqqB8Dl/xplYvAHgF84QtKISkGtAzg3WPm4YqT7ASaK
        +gG0d/mjwTKAAXc7iKi2UPlwtP6GLMJbqbdg3/XbeIQx6nsSXv/JEGGCSoW+hSkiwk9RyXB8
        Y36zVk4dgIPma1iEcSoFNvd/LIlwAvUGHOqqjWqehkPN9zZ7xlEaaL41IxH7p8Ofh+3RWYlw
        +p4jmk+C3Q8+wUQHXhLO2qpFzoVz6/8QIm+Bv970ykRWwsXzZ6J8ArYP+YmISUjVAej1jUnF
        BzX0tTZKRE6GvX9fAuKwJ+HS2tmwhgzn5bDujEKUPAtvz85E5dtgy4f1xEeAtsfYscdYsMdY
        sMdYuALwDvAMbxR0xbzAGNWx3+0Gm8eSmt0DOkcODwCKBPQTcmPlnxqFlKsUjusGACQxequ8
        RxVOyYu44+/zJkOBqULLCwMgK7zuC5gyodAQPj19eQGTtVutVqNMZk8Ww9CJcnIjoFFQxVw5
        X8bzRt70uE5CxilrgPFgvHPfMdXJQ85rJ5IWbO8xL9SM+zQlTgUt/5TtXT36Zne1Mv+X3OR9
        k6cDOfdT3h1uakkONny7WPhX01T+2u+21/Os47aW7Y3TntqrjpRq39LDudfSdk5WVTnMP4aO
        BXR3bn6QNA0Wz1pq+7L1p7bNj93NHFO9+ptradeRQJNJ8w6NCyUck4qZBO5/i1gcsEIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03SXUhTUQAHcM7ux67L0W0mHi20VrayslaGp9LqoeC+JEUWFEhd2m1Gbo5d
        Z9lLGhg4UCta5qzU1DKzcnflR2WZc0VGUyetjyVJM1BRo6bWLCWvFvj2O//z/8N5OBSmuEJE
        UMf1GZxRz6YpSRle71BGrS1Q/UpZ31IUjMZetwN00+0EaNTyCEO+z16AGoqPotI2F4Fsdi+O
        ipoFEtVYmnDU0VEnRW/ODklRdc93Agk+D4HME7cx5M9vA6jqXZcEeaovEMhf5wOoq30X8uZU
        k+iO6zmJro1aMJTb3CZF5tZJEk15bDjqfxCGqio8GLKNMTsWMxZzNWBqr9cC5tv7XClTkt2F
        M2WCiRFq8kjmk+cJydgrzzC2kUYJUzi5nplwhDIFD2oA4xci98gPyRI0XNrxTM64btsRWarX
        PkEarq849TDfTmSD3kgzCKIgHQddDcOYaAX9GMAf4ztn83B4ucs5nVPTDoEOBz9bGQbQdv+Y
        6BB6L+zIc0pFL6QPwpcDo4QZyCiM7qRgp9UvFQ8KelACS4QPpNgi6Rj4rP/9jOfTS+HbXz4g
        Wk5vg47cezOPwOloWNx8SSI6lD4Amyp9ktnOAviquA8XHUSnwFx3z0yO0WvgOX/5P4fBj32l
        /xwFG4avYudBiHXO3DpnYp0zsc6ZlAG8BoRzBl6n1fFqg1rPnYzlWR1v0mtjj6brBDDzX2JW
        NYLuysOtgKaAMlgOM36mKAg2k8/StQJIYcqF8sYl05Fcw2ad5ozph42mNI5vBYsoXBkm/6p/
        cVBBa9kM7gTHGTjj/1sJFRSRDbbUC727IzWBAK0cWalYfrbEcsOZLKQvGIuOfssGfsfddRet
        rlNp9yXvf0rGaAfNiu3LcrwV3eMuFQhNf8Go/CasNJDkjf/THL95w9DFRF/8x6tZ5RpOPTlp
        admUF7/WNbg3obDbrV6eOM/mVkXfuhkaQQxMtXzZGpy0sUIzpcT5VFYdgxl59i9b/dZvKwMA
        AA==
X-CMS-MailID: 20191217005542epcas1p1f47ed6dca37b3d2ab75e104422a56e10
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9
References: <cover.1573761527.git.leonard.crestez@nxp.com>
        <CGME20191114201049epcas5p370853a1d78584bf00d8493ce20320bf9@epcas5p3.samsung.com>
        <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
        <4d45cd39-24df-1714-0a27-5019c1367063@samsung.com>
        <VI1PR04MB7023F511BAE7D1EDF971CC48EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/17/19 12:00 AM, Leonard Crestez wrote:
> On 13.12.2019 06:22, Chanwoo Choi wrote:
>> Hi,
>>
>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>> There is no single device which can represent the imx interconnect.
>>> Instead of adding a virtual one just make the main &noc act as the
>>> global interconnect provider.
>>>
>>> The imx interconnect provider driver will scale the NOC and DDRC based
>>> on bandwidth request. More scalable nodes can be added in the future,
>>> for example for audio/display/vpu/gpu NICs.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   drivers/devfreq/imx-devfreq.c | 37 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>>> index 620b344e87aa..585d340c0f6e 100644
>>> --- a/drivers/devfreq/imx-devfreq.c
>>> +++ b/drivers/devfreq/imx-devfreq.c
>>> @@ -15,10 +15,11 @@
>>>   struct imx_devfreq {
>>>   	struct devfreq_dev_profile profile;
>>>   	struct devfreq *devfreq;
>>>   	struct clk *clk;
>>>   	struct devfreq_passive_data passive_data;
>>> +	struct platform_device *icc_pdev;
>>>   };
>>>   
>>>   static int imx_devfreq_target(struct device *dev,
>>>   			      unsigned long *freq, u32 flags)
>>>   {
>>> @@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct device *dev,
>>>   	return 0;
>>>   }
>>>   
>>>   static void imx_devfreq_exit(struct device *dev)
>>>   {
>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>> +
>>>   	dev_pm_opp_of_remove_table(dev);
>>> +	platform_device_unregister(priv->icc_pdev);
>>> +}
>>> +
>>> +/* imx_devfreq_init_icc() - register matching icc provider if required */
>>> +static int imx_devfreq_init_icc(struct device *dev)
>>> +{
>>> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
>>> +	const char *icc_driver_name;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))
>>> +		return 0;
>>
>> It is not proper to check the enable state of CONFIG_INTERCONNECT_IMX configuration
>> on device driver. Why don't you add the 'select CONFIG_INTERCONNECT_IMX' on Kconfig?
> 
> Because it's optional.
> 
> You can disable interconnect support and just tweak frequencies using 
> the devfreq sysfs API. But indeed would only really be useful for debugging.

Even if it's optional, I don't prefer to use 'IS_ENABLED' macro.

Generally, add or delete the property or value at DT file
to either enable or disable the some feature provided by device driver
instead of checking the configuration.

If user adds the property/value related to interconnect
and imx-bus.c configuration is enabled, the behavior
related to interconnect on imx-bus.c doesn't work. It make some confusion.

The imx-bus.c have to add the 'select CONFIG_INTERCONNECT_IMX'
and hand over the right which use the interconnect feature or not, to user.

If there are any requirement to add the additional property
to check whether interconnect feature will be used or not,
you can add the extra property. But, I think that it is enough
to check the '#interconnect-cells'.

In result, I think that it is right to decide the usage of feature
of device driver by user on Devicetree.

> 
>>> +	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
>>> +		return 0;
>>> +
>>> +	icc_driver_name = of_device_get_match_data(dev);
>>> +	if (!icc_driver_name)
>>> +		return 0;
>>> +
>>> +	priv->icc_pdev = platform_device_register_data(
>>> +			dev, icc_driver_name, 0, NULL, 0);
>>> +	if (IS_ERR(priv->icc_pdev)) {
>>> +		dev_err(dev, "failed to register icc provider %s: %ld\n",
>>> +				icc_driver_name, PTR_ERR(priv->devfreq));
>>> +		return PTR_ERR(priv->devfreq);
>>> +	}
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   static int imx_devfreq_probe(struct platform_device *pdev)
>>>   {
>>>   	struct device *dev = &pdev->dev;
>>> @@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_device *pdev)
>>>   		ret = PTR_ERR(priv->devfreq);
>>>   		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>>   		goto err;
>>>   	}
>>>   
>>> +	ret = imx_devfreq_init_icc(dev);
>>> +	if (ret)
>>> +		goto err;
>>> +
>>>   	return 0;
>>>   
>>>   err:
>>>   	dev_pm_opp_of_remove_table(dev);
>>>   	return ret;
>>>   }
>>>   
>>>   static const struct of_device_id imx_devfreq_of_match[] = {
>>> +	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
>>> +	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
>>> +	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
>>>   	{ .compatible = "fsl,imx8m-noc", },
>>>   	{ .compatible = "fsl,imx8m-nic", },
>>>   	{ /* sentinel */ },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
