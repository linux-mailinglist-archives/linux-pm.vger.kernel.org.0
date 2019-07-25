Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2B75256
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfGYPPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 11:15:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60772 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbfGYPPy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 11:15:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190725151551euoutp0194f3672b8f5a23d2cea129e93fa62559~0r1U973CK1991619916euoutp019
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 15:15:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190725151551euoutp0194f3672b8f5a23d2cea129e93fa62559~0r1U973CK1991619916euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564067751;
        bh=agewonXrWwhUtSxSzdJEA96UwZdMKX8h25eDIpRixpY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IrRWQG9Que18m81jBN/zhTmZv5KsVV/i+nV3wZzoQ5m+PHyrrpTiPmSJBesi4tBrF
         3KOPG6ZZm/uwyM4Bgxh9IS1yKo0G02u5UxlAiCcsQcfc/tW3lzAtxUGpzDUTHgb//G
         HBJn3Vpimsq1Er2COy2YY7F7TNfTAoI89gkraBC0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190725151550eucas1p222573bce7c0681fb4325cef64de50d78~0r1UMPTRp0329203292eucas1p2i;
        Thu, 25 Jul 2019 15:15:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.15.04325.5A7C93D5; Thu, 25
        Jul 2019 16:15:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725151549eucas1p19905f65c96d190e25d8e6ab1a9384d6a~0r1TTP00W1182111821eucas1p1Q;
        Thu, 25 Jul 2019 15:15:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190725151549eusmtrp2364226c69972dc591d61e89a3ce8be8c~0r1TFB4Ze0673606736eusmtrp2h;
        Thu, 25 Jul 2019 15:15:49 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-fa-5d39c7a57551
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.F9.04140.5A7C93D5; Thu, 25
        Jul 2019 16:15:49 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190725151548eusmtip105bff170fec204f620580b172a620d70~0r1SWBaq12193221932eusmtip1U;
        Thu, 25 Jul 2019 15:15:48 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     cwchoi00@gmail.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <4f62d397-0f62-f81d-8b76-b73c6fbee93d@partner.samsung.com>
Date:   Thu, 25 Jul 2019 17:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH1OaYpTheQxWQs7Fs4qcJEGtXQHESLg0CJSsL=dmROpQw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGubN0hkrxUhdOwCVpolER1KjxooS4EOwDicuLK8ogE0CgklYE
        5UFARCURlwTBSkCCWyqKVCibgmKlCrKlIKhgUFATkQcFgsomw0Dk7Tv/Wf77J5en1d9YNz5c
        d1zU64RIjULJWGr+NHjesXkHru5wJIWZBSxpG/jGkq8vPUiOtYEll7p7adLY+Igj9Uk/OGLu
        fssSe3mWgvRftCKS2VhJkQfWTo7cbmumyIfEewry43c9Rc4+tXJk7G0hQx531Sg2q7X52flI
        W2bs5LRm0wWF9vGt09q0IhPS2tpLKG2/edFObr/SJ0SMDD8h6lf5BinDLhckUtEPguM+vUxg
        E1CdNhU58oDXQXpCGpWKlLwa30NgMg1OFQMILEMNU0U/gsKsNG56pTarnZVYje8iuJ4cLXMf
        gswSkHgO3gPn8i5MzszF86HkWg+SDtG4iYW+R1UKqaHAG+BzyRtKYhX2h+bniZPM4CVwy57M
        SDwP74VfXS9YecYFXl/vmdQd8S7I+5uCJKaxK7zvyaFkXgxnim/QkhngKzxkvBuZMOMnCj8Y
        zfeTA8yB77aiqTALYLxM3gUcC19ypZDSbjKCrnM/GbmxCV7YmlnpDo2XQ0H5KlneAm0VNiSf
        d4b2Phf5Cc5w1ZJBy7IKzqeo5WlPyB5/w8rsDqnjD9nLSGOcEcw4I4xxRhjjf9+biDEhVzHG
        EBUqGtbqxFgvgxBliNGFeh05FmVGE9+vbsw2WIoqR4KrEeaRxkm1zOQdqGaFE4aTUdUIeFoz
        V1VcOiGpQoSTp0T9scP6mEjRUI3ceUbjqop36DqgxqHCcTFCFKNF/XSX4h3dEhDj2fIuyVPH
        c60dAf17nFrzY6OZ9Utzq+w5QrZ4qHfgSZOHxSfwYFxpeeKG2H3p9tltm+/rA5/VL4jAyz8m
        D78K6LVvtTZ5v99urAh77VzO7Q5oEfxXbskN7cCllucOOeaybb7dDhtrg0aDRgZVPiELL+6I
        dx8+OpSqrO1snVV7UMMYwoQ1K2i9QfgHqsX5I3oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7pLj1vGGhzfz22xccZ6VovrX56z
        Wjw7qm0x/8g5Vov+x6+ZLc6f38BucbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLN78OMtk0br3CLvFv2sbWSw2PzjG5iDksWbeGkaPnbPusntsWtXJ5rF5Sb1H
        35ZVjB7Hb2xn8vi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEvY8L6RqaCtUkVD482sDYwnvboYuTkkBAwkTg15wZrFyMXh5DAUkaJe8/O
        MEMkpCUaT69mgrCFJf5c62IDsYUEXjNKnO2qBbGFBcIl2hd3soLYIgJiEtunPWEEGcQscIVV
        4tDJTmaIqT3MEiverQCrYhMwl3i0/QzYVF4BN4mLBxvBbBYBVYkll1tYQGxRgQiJwztmMULU
        CEqcnPkELM4pECix+FcbWJxZQF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArNQtI+C0nLLCQt
        s5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREY9duO/dyyg7HrXfAhRgEORiUe3gvL
        LWOFWBPLiitzDzFKcDArifBu3QEU4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgQsoriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC4kI/DOL7JKkzI4N7r7df2
        cQTXneH9c3jZtPa+jGO/V7C/Wi+tpS7Sz/n3RmS/etitE6euHJ0kdIrFne39zssWJQFaNZef
        nVxnMX3CVsm+U05fD2tWPC18zbnRpOqVbeDKa3M/hVzZuNHg1/lFDq8j39nEFNx5HBWc3qce
        wu1k0Ln86he2t46PlFiKMxINtZiLihMBlC7u7BADAAA=
X-CMS-MailID: 20190725151549eucas1p19905f65c96d190e25d8e6ab1a9384d6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
        <20190719150535.15501-4-k.konieczny@partner.samsung.com>
        <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
        <ed80b6e3-5b40-18ce-ca1e-65520edf516e@partner.samsung.com>
        <CAGTfZH1OaYpTheQxWQs7Fs4qcJEGtXQHESLg0CJSsL=dmROpQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 25.07.2019 16:53, Chanwoo Choi wrote:
> 2019년 7월 25일 (목) 오후 11:19, Kamil Konieczny
> <k.konieczny@partner.samsung.com>님이 작성:
>>
>> Hi Chanwoo,
>>
>> On 25.07.2019 12:17, Chanwoo Choi wrote:
>>> Hi Kamil,
>>>
>>> Looks good to me. But, I have some comment. Please check them.
>>
>> Thank you for review, please see answers below.
>>
>>> After this patch, exynos_bus_target is perfectly same with
>>> exynos_bus_passive_target. The exynos_bus_passive_target() could be removed.
>>
>> Ok, I will make it in separate patch to simplify review process.
> 
> I think you can just modify this patch without any separate patch.

Do you want me to send v5 with patch 5 squashed in patch 3 ?
 
>>> On 19. 7. 20. 오전 12:05, k.konieczny@partner.samsung.com wrote:
>>>> Reuse opp core code for setting bus clock and voltage. As a side
>>>> effect this allow useage of coupled regulators feature (required
>>>
>>> s/useage/usage ?
>>
>> Good catch, I will change it.
>>
>>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>>> while the old code used regulator_set_voltage_tol() with fixed
>>>> tolerance. This patch also removes no longer needed parsing of DT
>>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>>> it).
>>>>
>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>> ---
>>>>  drivers/devfreq/exynos-bus.c | 143 +++++++++--------------------------
>>>>  1 file changed, 37 insertions(+), 106 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>> index f391044aa39d..c2147b0912a0 100644
>>>> --- a/drivers/devfreq/exynos-bus.c
>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>> @@ -25,7 +25,6 @@
>>>>  #include <linux/slab.h>
>>>>
>>>>  #define DEFAULT_SATURATION_RATIO    40
>>>> -#define DEFAULT_VOLTAGE_TOLERANCE   2
>>>>
>>>>  struct exynos_bus {
>>>>      struct device *dev;
>>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>>
>>>>      unsigned long curr_freq;
>>>>
>>>> -    struct regulator *regulator;
>>>> +    struct opp_table *opp_table;
>>>> +
>>>>      struct clk *clk;
>>>> -    unsigned int voltage_tolerance;
>>>>      unsigned int ratio;
>>>>  };
>>>>
>>>> @@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>>  {
>>>>      struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>      struct dev_pm_opp *new_opp;
>>>> -    unsigned long old_freq, new_freq, new_volt, tol;
>>>>      int ret = 0;
>>>>
>>>> -    /* Get new opp-bus instance according to new bus clock */
>>>> +    /* Get correct frequency for bus. */
>>>>      new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>      if (IS_ERR(new_opp)) {
>>>>              dev_err(dev, "failed to get recommended opp instance\n");
>>>>              return PTR_ERR(new_opp);
>>>>      }
>>>>
>>>> -    new_freq = dev_pm_opp_get_freq(new_opp);
>>>> -    new_volt = dev_pm_opp_get_voltage(new_opp);
>>>>      dev_pm_opp_put(new_opp);
>>>>
>>>> -    old_freq = bus->curr_freq;
>>>> -
>>>> -    if (old_freq == new_freq)
>>>> -            return 0;
>>>> -    tol = new_volt * bus->voltage_tolerance / 100;
>>>> -
>>>>      /* Change voltage and frequency according to new OPP level */
>>>>      mutex_lock(&bus->lock);
>>>> +    ret = dev_pm_opp_set_rate(dev, *freq);
>>>> +    if (!ret)
>>>> +            bus->curr_freq = *freq;
>>>>
>>>> -    if (old_freq < new_freq) {
>>>> -            ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>> -            if (ret < 0) {
>>>> -                    dev_err(bus->dev, "failed to set voltage\n");
>>>> -                    goto out;
>>>> -            }
>>>> -    }
>>>> -
>>>> -    ret = clk_set_rate(bus->clk, new_freq);
>>>> -    if (ret < 0) {
>>>> -            dev_err(dev, "failed to change clock of bus\n");
>>>> -            clk_set_rate(bus->clk, old_freq);
>>>> -            goto out;
>>>> -    }
>>>> -
>>>> -    if (old_freq > new_freq) {
>>>> -            ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>> -            if (ret < 0) {
>>>> -                    dev_err(bus->dev, "failed to set voltage\n");
>>>> -                    goto out;
>>>> -            }
>>>> -    }
>>>> -    bus->curr_freq = new_freq;
>>>> -
>>>> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>> -                    old_freq, new_freq, clk_get_rate(bus->clk));
>>>> -out:
>>>>      mutex_unlock(&bus->lock);
>>>>
>>>>      return ret;
>>>> @@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
>>>>              dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>>
>>>>      clk_disable_unprepare(bus->clk);
>>>> -    if (bus->regulator)
>>>> -            regulator_disable(bus->regulator);
>>>> +    if (bus->opp_table)
>>>> +            dev_pm_opp_put_regulators(bus->opp_table);
>>>>
>>>>      dev_pm_opp_of_remove_table(dev);
>>>>  }
>>>> @@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>>  {
>>>>      struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>      struct dev_pm_opp *new_opp;
>>>> -    unsigned long old_freq, new_freq;
>>>> -    int ret = 0;
>>>> +    int ret;
>>>>
>>>> -    /* Get new opp-bus instance according to new bus clock */
>>>> +    /* Get correct frequency for bus. */
>>>>      new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>      if (IS_ERR(new_opp)) {
>>>>              dev_err(dev, "failed to get recommended opp instance\n");
>>>>              return PTR_ERR(new_opp);
>>>>      }
>>>>
>>>> -    new_freq = dev_pm_opp_get_freq(new_opp);
>>>>      dev_pm_opp_put(new_opp);
>>>>
>>>> -    old_freq = bus->curr_freq;
>>>> -
>>>> -    if (old_freq == new_freq)
>>>> -            return 0;
>>>> -
>>>>      /* Change the frequency according to new OPP level */
>>>>      mutex_lock(&bus->lock);
>>>> +    ret = dev_pm_opp_set_rate(dev, *freq);
>>>> +    if (!ret)
>>>> +            bus->curr_freq = *freq;
>>>>
>>>> -    ret = clk_set_rate(bus->clk, new_freq);
>>>> -    if (ret < 0) {
>>>> -            dev_err(dev, "failed to set the clock of bus\n");
>>>> -            goto out;
>>>> -    }
>>>> -
>>>> -    *freq = new_freq;
>>>> -    bus->curr_freq = new_freq;
>>>> -
>>>> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>> -                    old_freq, new_freq, clk_get_rate(bus->clk));
>>>> -out:
>>>>      mutex_unlock(&bus->lock);
>>>>
>>>>      return ret;
>>>> @@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>                                      struct exynos_bus *bus)
>>>>  {
>>>>      struct device *dev = bus->dev;
>>>> -    int i, ret, count, size;
>>>> -
>>>> -    /* Get the regulator to provide each bus with the power */
>>>> -    bus->regulator = devm_regulator_get(dev, "vdd");
>>>> -    if (IS_ERR(bus->regulator)) {
>>>> -            dev_err(dev, "failed to get VDD regulator\n");
>>>> -            return PTR_ERR(bus->regulator);
>>>> -    }
>>>> -
>>>> -    ret = regulator_enable(bus->regulator);
>>>> -    if (ret < 0) {
>>>> -            dev_err(dev, "failed to enable VDD regulator\n");
>>>> -            return ret;
>>>> -    }
>>>> +    struct opp_table *opp_table;
>>>> +    const char *vdd = "vdd";
>>>> +    int i, count, size;
>>>>
>>>>      /*
>>>>       * Get the devfreq-event devices to get the current utilization of
>>>> @@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>      count = devfreq_event_get_edev_count(dev);
>>>>      if (count < 0) {
>>>>              dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>>> -            ret = count;
>>>> -            goto err_regulator;
>>>> +            return count;
>>>>      }
>>>> -    bus->edev_count = count;
>>>>
>>>> +    bus->edev_count = count;
>>>>      size = sizeof(*bus->edev) * count;
>>>>      bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>>> -    if (!bus->edev) {
>>>> -            ret = -ENOMEM;
>>>> -            goto err_regulator;
>>>> -    }
>>>> +    if (!bus->edev)
>>>> +            return -ENOMEM;
>>>>
>>>>      for (i = 0; i < count; i++) {
>>>>              bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>>> -            if (IS_ERR(bus->edev[i])) {
>>>> -                    ret = -EPROBE_DEFER;
>>>> -                    goto err_regulator;
>>>> -            }
>>>> +            if (IS_ERR(bus->edev[i]))
>>>> +                    return -EPROBE_DEFER;
>>>> +    }
>>>> +
>>>> +    opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>> +    if (IS_ERR(opp_table)) {
>>>> +            i = PTR_ERR(opp_table);
>>>> +            dev_err(dev, "failed to set regulators %d\n", i);
>>>> +            return i;
>>>
>>> Maybe, you just used the 'i' defined variable instead of adding
>>> new variable. But, I think that you better to add new variable
>>> like 'err' for the readability. Or, jut use the 'PTR_ERR(opp_table)'
>>> directly without any additional variable.
>>
>> I will remove not related changes, so here I will reuse 'ret' variable.
>>
>>>>      }
>>>>
>>>> +    bus->opp_table = opp_table;
>>>
>>> Add blank line.
>>
>> OK
>>
>>>>      /*
>>>>       * Optionally, Get the saturation ratio according to Exynos SoC
>>>>       * When measuring the utilization of each AXI bus with devfreq-event
>>>> @@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>      if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>>              bus->ratio = DEFAULT_SATURATION_RATIO;
>>>>
>>>> -    if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>>> -                                    &bus->voltage_tolerance))
>>>> -            bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>>> -
>>>>      return 0;
>>>> -
>>>> -err_regulator:
>>>> -    regulator_disable(bus->regulator);
>>>> -
>>>> -    return ret;
>>>>  }
>>>>
>>>>  static int exynos_bus_parse_of(struct exynos_bus *bus)
>>>> @@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>
>>>>      /* Parse the device-tree to get the resource information */
>>>>      ret = exynos_bus_parse_of(bus);
>>>> -    if (ret < 0) {
>>>> -            if (!passive)
>>>> -                    regulator_disable(bus->regulator);
>>>> -
>>>> -            return ret;
>>>> -    }
>>>> +    if (ret < 0)
>>>> +            goto err_reg;
>>>>
>>>>      if (passive)
>>>>              goto passive;
>>>> @@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>
>>>>  err:
>>>>      clk_disable_unprepare(bus->clk);
>>>> -    if (!passive)
>>>> -            regulator_disable(bus->regulator);
>>>> -
>>>>      dev_pm_opp_of_remove_table(dev);
>>>
>>> This function removes the 'opp_table'. But, the below code
>>> uses the 'opp_table' variable by dev_pm_opp_put_regulators().
>>>
>>> To disable the regulator, you have to call dev_pm_opp_of_remove_table(dev)
>>> after dev_pm_opp_put_regulators(bus->opp_table).
>>
>> Regulators should be set before dev_pm_opp_add_table(), so exit sequence
>> should be in reverse order,
>>
>> init order:
>>
>> exynos_bus_parent_parse_of()
>>         dev_pm_opp_set_regulators()
>> exynos_bus_parse_of()
>>         clk_prepare_enable()
>>         dev_pm_opp_of_add_table()
>>
>> exit or error order:
>>
>> dev_pm_opp_of_remove_table()
>> clk_disable_unprepare()
>> if (bus->opp_table)
>>         dev_pm_opp_put_regulators(bus->opp_table);
> 
> dev_pm_opp_of_remove_table() have to be called at the end of exit sequence
> after disabling clock and put regulators. Because dev_pm_opp_of_remove_table()
> frees the 'opp_table' pointer of device.
> 
> clk_disable_unprepare()
> if (bus->opp_table)
>           dev_pm_opp_put_regulators(bus->opp_table);
> dev_pm_opp_of_remove_table()

The table is reference counted so it will be freed after count go to zero.

>> I will send v4 soon.
>>
>>>> +err_reg:
>>>> +    if (bus->opp_table) {
>>>> +            dev_pm_opp_put_regulators(bus->opp_table);
>>>> +            bus->opp_table = NULL;
>>>> +    }
>>>>
>>>>      return ret;
>>>>  }

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

