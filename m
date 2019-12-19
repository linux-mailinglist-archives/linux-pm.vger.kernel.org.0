Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC1125BCD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfLSHBB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 02:01:01 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40178 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLSHBB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 02:01:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191219070055epoutp0192e926933c721895e1a122ccf41e9f08~hs6KUI4S62254722547epoutp013
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 07:00:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191219070055epoutp0192e926933c721895e1a122ccf41e9f08~hs6KUI4S62254722547epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576738855;
        bh=HIx0u+GLXonWEc/D1pKl4F+ZxaTvHjTPdoJKv96bCa0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BPS/9j/HJon1aa4ru6/FSaroYr5q/IEuZ6AKRoCkxak5HGGurhHx/+dq5FeOE9men
         cicJIeeD72EJxzq5SC5HWl7KE3hzsRQJJhhwEldyWneV6M5U4BgaNTAAVOpJb0Ba+w
         Lee4CXIhXMj7vavI2M2wtbhaIuYdqUCzOwUNljK4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191219070054epcas1p23f66ba706d4aa80676379cd0a2d68bc4~hs6JYCQdI1363413634epcas1p2_;
        Thu, 19 Dec 2019 07:00:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47djSx14r2zMqYks; Thu, 19 Dec
        2019 07:00:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.00.51241.1202BFD5; Thu, 19 Dec 2019 16:00:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191219070048epcas1p264460bc8c34f18a5e262e0fb8db6eae4~hs6D_DLAk1363813638epcas1p2k;
        Thu, 19 Dec 2019 07:00:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219070048epsmtrp1e3820584949126728b0e537e67473b23~hs6DsA3WJ1429414294epsmtrp1f;
        Thu, 19 Dec 2019 07:00:48 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-e8-5dfb20217743
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.F1.10238.0202BFD5; Thu, 19 Dec 2019 16:00:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219070047epsmtip146a9180cc7de48b98459108ec9e81f3e~hs6DKp8pg0831108311epsmtip1O;
        Thu, 19 Dec 2019 07:00:47 +0000 (GMT)
Subject: Re: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect
 device
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
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
Message-ID: <80e1f031-b48e-c8e4-336f-1e4a643e2ff3@samsung.com>
Date:   Thu, 19 Dec 2019 16:07:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023B782510853FE0FDDEFEEEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="euc-kr"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wbZRjHfXvX6zGtnGXIa6OzPbMlI2Frx4ovCxDNGLlszWQadWqa7lJO
        yugve2URNRF/bEDVTWLIWBFHtqGlEm1LBSZgHRQpU6kwKbBuatKBUxam8kPsnLHlWMJ/n+d5
        vs/PNy+JyTolcrLC4uDsFtZEExvwrsGtOTlKxS2danpGjJa+vQjQx+NDAC02fomh+M8xgLpP
        GVDD1I84Oh0aFSNfZwxHJ/v9BPI0nsdRJOKVoO/fvCFB7qt/ipE/HhUjZ6IdQwvvhQBqmxwT
        oai7QYwWvHGAxi7uQbE33AT6dPQCgVoWGzF0tD8kQc6B2wT6L+rD0fVAFmo7G8WQb4l57CGm
        0ekGTMdHHYC5OXVUwjTXjOFMq7+K8XvqCeZKtI9gOs+9zvjme0TMidsqJjGYyRwPeACz4N9U
        Kn2+ssDIsWWcXcFZDNayCkt5Ib3vKf1uvSZPpc5R56NHaYWFNXOFdLG2NKekwpQ8Cq04wpqq
        kq5Slufp7UUFdmuVg1MYrbyjkOZsZSZbvm0bz5r5Kkv5NoPVvEutUu3QJIWHKo2Tn3XjtksF
        Lwedk6AGhLc7QRoJqZ2wKfIh4QQbSBnVA6D3j6/XjL8ATITHRYKxDOBEVwC7k9IZOQOEQD+A
        w65aTDBuAhjuHZekVBnUARipH0oySW6kXoPhz19KuTHqOxL2zlhTTFDZMHh9ikhxOqWEEytx
        kGIpVQS95xJYKhWnNsMbsdW+mdQzcKTr7TXJfXDk1DU8xWmUDjbVDIqF8tlwceUrQuAsePna
        aZHAD8O3vmheHRNSfSR0ti6vjgapYtgyv3aKDPj7cEAisBz+duLYGr8K20dChJBbB2Ag+INY
        COTCYNsHIoGV8PytFiA0uxfOL70rFupLYd0xmSB5BF765eqa/AF4traeeB/QrnXruNat4Fq3
        gmvdCq0A94D7ORtvLud4tU2z/rX9YPXDZOf3gG9GtQOAIgF9j3RlT0InE7NH+GrzAIAkRm+U
        xur+0cmkZWz1K5zdqrdXmTh+AGiS127A5JkGa/L7WRx6tWZHbm4u2qnO06jVdJaUXBnTyahy
        1sFVcpyNs9/JE5Fp8hrQpwtJvKGsXu38Ju3C4f3eg5G7DjqkvX8/eDjmnv33p1+fiOdpdzGu
        vXubdzcMTRRNKx5f9lcPL9YxmVsM+tLnaoOXPyGnZ7bOzvmalvZ1779SHO5+sced8aR8i1F9
        d/jCC+kelaSjPuP4yTkltlmqI01MybPpyrlDxbPvlJfgT7fTOG9k1dmYnWf/B2BNrNRGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XbOzs600WkaflYuG0Ul5Y2ML7KowDiEXX9UBsuGHVRyc+yo
        ZUSu1MyVtx9WTnJWWrYi3DQvmYi7ZBo5b01p3WiaWiu1KZli1hyB/x7e93l4/7wkJizjriAT
        5SmMUi5NEhNeeJ1JLNocGDgrCa37wENTrzoAut9jAWiy+BmGHB/tANWXxKGigT4cac2dXKSv
        sePoZrOBQLriRhxZrdU89Pqyk4eq3k9wkcFh4yL1zEMMufLMAFX2d3OQraqIi1zVDoC6O6KQ
        /VIVgR51thLo9mQxhrKbzTykNs4R6I9Nj6ORWj9Uec+GIf0UvSuALlZXAfpx2WNAjw1k8+hS
        VTdOlxtSaYMul6Df2Z4TdE1FBq3/0cChC+ZC6RnTcjq/Vgdol0F0SHDCK/I0k5SYxihDdp7y
        Suh/Uo8reiPPtaj7gQq8DFEDPgmpLbDGeheogRcppJoAbB+pJTwLf3ij24KpAfmPfaDJxHqc
        7wCqGoY5bseHOgytuRaem32pC9CpGyXcEkZ1kbBL4+J5iutcOP4gE7gtggqCLSMDCxeWUmvg
        m2nHwlxA7YTVFTML13BqHXTaMfd4OXUUNlY4OB5lGWwvGcTdzKck8JbKxHUzRm2AI6oswsN+
        8O2gluPh1TDzaSlWCHw0i3LNokSzKNEsSsoBrgP+jIKVxcvYMEWYnDkbzEplbKo8PjguWWYA
        C18TtLEB9FbEGgFFAvESwXTUjETIlaax6TIjgCQm9hXYr/6WCAWnpennGWVyrDI1iWGNYCWJ
        i/0EQ/IXMUIqXprCnGEYBaP8v+WQ/BUqsO3A6NqhVsXXCWd+uGi6Tlf6EMenwpPGIkLCQ+ZE
        fZZCvt+OnIzjItnFhHmL+EjOLNlibirQCg5KTjo728Z9OZIrvyyDxujPYF/sp56IzlWVkUsS
        rNs7tIpved4x41+1+5uubV2pT88Y/Hlnd691z6Zjw/Nf2gKivRP7/NfvdWWJcTZBGhaEKVnp
        Xz/ESN8xAwAA
X-CMS-MailID: 20191219070048epcas1p264460bc8c34f18a5e262e0fb8db6eae4
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
        <60fe19c6-6e73-4133-ed7e-a13a875589c0@samsung.com>
        <VI1PR04MB7023DAC69C8B4B7CF144F29EEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <CAGTfZH1omr9jqRv9JX+X253YardFx_B26Hm-cT8UNF2J7eC_og@mail.gmail.com>
        <VI1PR04MB7023B782510853FE0FDDEFEEEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/19/19 2:13 AM, Leonard Crestez wrote:
> On 18.12.2019 13:06, Chanwoo Choi wrote:
>> 2019년 12월 18일 (수) 오후 7:14, Leonard Crestez <leonard.crestez@nxp.com>님이 작성:
>>> On 17.12.2019 02:55, Chanwoo Choi wrote:
>>>> On 12/17/19 12:00 AM, Leonard Crestez wrote:
>>>>> On 13.12.2019 06:22, Chanwoo Choi wrote:
>>>>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>>>>>> There is no single device which can represent the imx interconnect.
>>>>>>> Instead of adding a virtual one just make the main &noc act as the
>>>>>>> global interconnect provider.
>>>>>>>
>>>>>>> The imx interconnect provider driver will scale the NOC and DDRC based
>>>>>>> on bandwidth request. More scalable nodes can be added in the future,
>>>>>>> for example for audio/display/vpu/gpu NICs.
>>>>>>>
>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>>>> ---
>>>>>>>     drivers/devfreq/imx-devfreq.c | 37 +++++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 37 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
>>>>>>> index 620b344e87aa..585d340c0f6e 100644
>>>>>>> --- a/drivers/devfreq/imx-devfreq.c
>>>>>>> +++ b/drivers/devfreq/imx-devfreq.c
>>>>>>> @@ -15,10 +15,11 @@
>>>>>>>     struct imx_devfreq {
>>>>>>>             struct devfreq_dev_profile profile;
>>>>>>>             struct devfreq *devfreq;
>>>>>>>             struct clk *clk;
>>>>>>>             struct devfreq_passive_data passive_data;
>>>>>>> +  struct platform_device *icc_pdev;
>>>>>>>     };
>>>>>>>
>>>>>>>     static int imx_devfreq_target(struct device *dev,
>>>>>>>                                   unsigned long *freq, u32 flags)
>>>>>>>     {
>>>>>>> @@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct device *dev,
>>>>>>>             return 0;
>>>>>>>     }
>>>>>>>
>>>>>>>     static void imx_devfreq_exit(struct device *dev)
>>>>>>>     {
>>>>>>> +  struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>>             dev_pm_opp_of_remove_table(dev);
>>>>>>> +  platform_device_unregister(priv->icc_pdev);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/* imx_devfreq_init_icc() - register matching icc provider if required */
>>>>>>> +static int imx_devfreq_init_icc(struct device *dev)
>>>>>>> +{
>>>>>>> +  struct imx_devfreq *priv = dev_get_drvdata(dev);
>>>>>>> +  const char *icc_driver_name;
>>>>>>> +
>>>>>>> +  if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))
>>>>>>> +          return 0;
>>>>>>
>>>>>> It is not proper to check the enable state of CONFIG_INTERCONNECT_IMX configuration
>>>>>> on device driver. Why don't you add the 'select CONFIG_INTERCONNECT_IMX' on Kconfig?
>>>>>
>>>>> Because it's optional.
>>>>>
>>>>> You can disable interconnect support and just tweak frequencies using
>>>>> the devfreq sysfs API. But indeed would only really be useful for debugging.
>>>>
>>>> Even if it's optional, I don't prefer to use 'IS_ENABLED' macro.
>>>>
>>>> Generally, add or delete the property or value at DT file
>>>> to either enable or disable the some feature provided by device driver
>>>> instead of checking the configuration.
>>>>
>>>> If user adds the property/value related to interconnect
>>>> and imx-bus.c configuration is enabled, the behavior
>>>> related to interconnect on imx-bus.c doesn't work. It make some confusion.
>>>
>>> Maybe I could print a warning if #interconnect-cells is present but
>>> CONFIG_INTERCONNECT_IMX is off?
>>
>> Actually, user might think that if imx-bus.c is enabled
>> , CONFIG_INTERCONNECT_MIX is enabled.
>> Because, the dt binding document of imx-bus.c will
>> contain the property for interconnect.
>>
>> If device driver support the various feature,
>> the device driver have to enable all configuration
>> in order to support the features for user.
> 
> 
>>> An explicit select in Kconfig seems like a pointless limitation but in
>>> practice it would almost never be useful to build one without the other.
>>
>> This patch is for the some CONFIG_INTERCONNECT_IMX driver.
>> I don't understand why is not meaningful to select CONFIG_INTERCONNECT_IMX
>> in Kconfig?
> 
> One issue is that the interconnect graph is described per-soc and there 
> are per-soc config options while imx-bus applies to all. So the "if" 
> condition is not sufficient either; if the per-soc interconnect driver 
> is omitted then the platform device will be added but no driver will be 
> ever be found.
> 
> There are ways around this: for example all of imx interconnect could be 
> built as a single module. But I think it's reasonable for devices to be 
> partially functional if some config options are missing and heavy config 
> customization sometimes requires a bit of debugging.
> 
> There are various issues when building the current series as "m" but I 
> can solve them and post a final patch which sets all the relevant 
> options on "m" in arm64 defconfig. The it will all "just work" out of 
> the box.

Sorry. Actually, I don't understand the relationship perfectly
between imx-bus and imx-interconnect. As you mentioned, I'll
expect the your solution on next version.

> 
>>>> The imx-bus.c have to add the 'select CONFIG_INTERCONNECT_IMX'
>>>> and hand over the right which use the interconnect feature or not, to user.
>>>>
>>>> If there are any requirement to add the additional property
>>>> to check whether interconnect feature will be used or not,
>>>> you can add the extra property. But, I think that it is enough
>>>> to check the '#interconnect-cells'.
>>>>
>>>> In result, I think that it is right to decide the usage of feature
>>>> of device driver by user on Devicetree.
>>>>
>>>>>
>>>>>>> +  if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
>>>>>>> +          return 0;
>>>>>>> +
>>>>>>> +  icc_driver_name = of_device_get_match_data(dev);
>>>>>>> +  if (!icc_driver_name)
>>>>>>> +          return 0;
>>>>>>> +
>>>>>>> +  priv->icc_pdev = platform_device_register_data(
>>>>>>> +                  dev, icc_driver_name, 0, NULL, 0);
>>>>>>> +  if (IS_ERR(priv->icc_pdev)) {
>>>>>>> +          dev_err(dev, "failed to register icc provider %s: %ld\n",
>>>>>>> +                          icc_driver_name, PTR_ERR(priv->devfreq));
>>>>>>> +          return PTR_ERR(priv->devfreq);
>>>>>>> +  }
>>>>>>> +
>>>>>>> +  return 0;
>>>>>>>     }
>>>>>>>
>>>>>>>     static int imx_devfreq_probe(struct platform_device *pdev)
>>>>>>>     {
>>>>>>>             struct device *dev = &pdev->dev;
>>>>>>> @@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_device *pdev)
>>>>>>>                     ret = PTR_ERR(priv->devfreq);
>>>>>>>                     dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>>>>>>                     goto err;
>>>>>>>             }
>>>>>>>
>>>>>>> +  ret = imx_devfreq_init_icc(dev);
>>>>>>> +  if (ret)
>>>>>>> +          goto err;
>>>>>>> +
>>>>>>>             return 0;
>>>>>>>
>>>>>>>     err:
>>>>>>>             dev_pm_opp_of_remove_table(dev);
>>>>>>>             return ret;
>>>>>>>     }
>>>>>>>
>>>>>>>     static const struct of_device_id imx_devfreq_of_match[] = {
>>>>>>> +  { .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
>>>>>>> +  { .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
>>>>>>> +  { .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
>>>>>>>             { .compatible = "fsl,imx8m-noc", },
>>>>>>>             { .compatible = "fsl,imx8m-nic", },
>>>>>>>             { /* sentinel */ },
>>>>>>>     };
>>>>>>>     MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
