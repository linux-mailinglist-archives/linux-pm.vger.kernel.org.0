Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F346075C5D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 02:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGZA7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 20:59:04 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61334 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfGZA7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 20:59:03 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190726005858epoutp0193c1b398cc5d1231c4915b8a2d6f70fe~0zydfCeT03164931649epoutp01_
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 00:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190726005858epoutp0193c1b398cc5d1231c4915b8a2d6f70fe~0zydfCeT03164931649epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564102738;
        bh=xy+qO0Ne2KMLwzaQJVPFqzSei7gTjsn/OjgcYFbr+wo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=losr1A4UDs+rvDGGNqc/WteYvROZvSzswrAJ7yjmzZQ00iluwz4L3ENP/jTWOTu6t
         TTYymBr9VYlq+T9xyD4VCtXqO+DmPayWtQYPYCbapNMGR1UbA5J19MWfVVzMcIQ25j
         fdSACtY1ikZVUfyjUX3fyY37MUjRKRCOV/72f9cw=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190726005857epcas1p36f36dcae8d642fa703d13a0e94b45904~0zyc1qWPS2573825738epcas1p3K;
        Fri, 26 Jul 2019 00:58:57 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45vrLl307kzMqYkj; Fri, 26 Jul
        2019 00:58:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.E9.04066.F405A3D5; Fri, 26 Jul 2019 09:58:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190726005854epcas1p115956b9a20f1aaeeb2e7deeed5ef4a7a~0zyaBNDjt0308703087epcas1p1B;
        Fri, 26 Jul 2019 00:58:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190726005854epsmtrp1f2e211a2538df8228d22afdd386f1778~0zyaAEMQx0740907409epsmtrp1i;
        Fri, 26 Jul 2019 00:58:54 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-5a-5d3a504f81cc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.51.03706.E405A3D5; Fri, 26 Jul 2019 09:58:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726005854epsmtip2ca33772f79931990a6fc4d51f3b3a78c~0zyZr0vtj1793417934epsmtip2M;
        Fri, 26 Jul 2019 00:58:54 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] devfreq: exynos-bus: convert to use
 dev_pm_opp_set_rate()
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>,
        cwchoi00@gmail.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <605a07ce-1b2c-c19c-87ae-23a576951263@samsung.com>
Date:   Fri, 26 Jul 2019 10:02:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4f62d397-0f62-f81d-8b76-b73c6fbee93d@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJsWRmVeSWpSXmKPExsWy7bCmvq5/gFWswectIhYbZ6xntXh2VNti
        /pFzrBZ9+/4zWvQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2i8+9RxgtZpzfx2Sx9shddoul
        1y8yWdxuXMFm8ebHWSaL1r1H2C3+XdvIYrH5wTE2ByGPNfPWMHrsnHWX3WPTqk42j81L6j0O
        vtvD5NG3ZRWjx/Eb25k8Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCdcfbpOeaC12kVqx/fZW5gPOPTxcjJISFgIvH8QC9zFyMX
        h5DADkaJ5mvbGSGcT4wSjWfXsoBUCQl8Y5S4sZEXpmPSyQdMEEV7GSVOzX7CBuG8Z5SY+v8U
        M0iVsEC4RPviTlYQW0TAU+LZs9fsIEXMAitYJS58+cgIkmAT0JLY/+IGG4jNL6AocfXHY6A4
        BwevgJ3E7UNlIGEWAVWJ65v62UFsUYEIiU8PDoPN5BUQlDg58wnYdZwC7hJzrk4AizMLiEvc
        ejKfCcKWl2jeOhvsNwmBW+wS9w+1MkK84CJx6/UqFghbWOLV8S3sELaUxMv+Nii7WmLlySNs
        EM0djBJb9l9ghUgYS+xfOpkJ5FBmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBE
        ibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkWN7EyM4
        mWuZ72DccM7nEKMAB6MSD++F5ZaxQqyJZcWVuYcYJTiYlUR4t+4ACvGmJFZWpRblxxeV5qQW
        H2I0BYb2RGYp0eR8YKbJK4k3NDUyNja2MDE0MzU0VBLnXfjDIlZIID2xJDU7NbUgtQimj4mD
        U6qBMXOLeP5ll4BNUmZHLx3mv6N4Nur0+h/3HJ/NOiSesfXf7P95NfedHV20TRhNZxeKxH99
        KfBt7urLLw/+71z9/pRU0/zAm3EFSo843DxaJztH+kv6n2XgX3W4c93ErLarPezOF4xM1s9V
        6r58p/f/KeU9Mx5Gvp4m//2umhRv4ocFbx4I13zJmKjEUpyRaKjFXFScCAATXqME/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCSvK5fgFWswd1ruhYbZ6xntXh2VNti
        /pFzrBZ9+/4zWvQ/fs1scf78BnaLs01v2C02Pb7GanF51xw2i8+9RxgtZpzfx2Sx9shddoul
        1y8yWdxuXMFm8ebHWSaL1r1H2C3+XdvIYrH5wTE2ByGPNfPWMHrsnHWX3WPTqk42j81L6j0O
        vtvD5NG3ZRWjx/Eb25k8Pm+SC+CI4rJJSc3JLEst0rdL4Mo4+/Qcc8HrtIrVj+8yNzCe8eli
        5OSQEDCRmHTyAVMXIxeHkMBuRomzl2+zQCQkJaZdPMrcxcgBZAtLHD5cDFHzllHi994zzCA1
        wgLhEu2LO1lBbBEBT4lnz16zgxQxC6xhlWjacIENouMks0TfqZeMIFVsAloS+1/cYAOx+QUU
        Ja7+eMwIsoFXwE7i9qEykDCLgKrE9U397CC2qECExOEds8BaeQUEJU7OfAJ2HKeAu8ScqxPA
        FjMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxguNaS3MH4+Ul8YcYBTgYlXh4NVZZxgqxJpYVV+YeYpTg
        YFYS4d26AyjEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QD
        4yQNk8ted6UEI7W+fk0612w7vUvYT3O5xvKDVarr9kR1dplwld7ebeX18ldmtOK+2t8N6hyH
        XVOvbjsSkzx3gr7iNNHpB/fn9kvcWPyH2UB4f02yeW7aHOmo8pjsDx2vTmsXry6OeZjEvT/l
        SUrbNqPtjm/XGFzgc7Lq0T4RuIDpW33gN3ZnJZbijERDLeai4kQAQD+EMecCAAA=
X-CMS-MailID: 20190726005854epcas1p115956b9a20f1aaeeb2e7deeed5ef4a7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e
References: <20190719150535.15501-1-k.konieczny@partner.samsung.com>
        <CGME20190719150555eucas1p197adc3c58e45c53137fd70cadbfae60e@eucas1p1.samsung.com>
        <20190719150535.15501-4-k.konieczny@partner.samsung.com>
        <beb2455b-7f9e-35df-d524-01f4f51a1c62@samsung.com>
        <ed80b6e3-5b40-18ce-ca1e-65520edf516e@partner.samsung.com>
        <CAGTfZH1OaYpTheQxWQs7Fs4qcJEGtXQHESLg0CJSsL=dmROpQw@mail.gmail.com>
        <4f62d397-0f62-f81d-8b76-b73c6fbee93d@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 26. 오전 12:15, Kamil Konieczny wrote:
> Hi,
> 
> On 25.07.2019 16:53, Chanwoo Choi wrote:
>> 2019년 7월 25일 (목) 오후 11:19, Kamil Konieczny
>> <k.konieczny@partner.samsung.com>님이 작성:
>>>
>>> Hi Chanwoo,
>>>
>>> On 25.07.2019 12:17, Chanwoo Choi wrote:
>>>> Hi Kamil,
>>>>
>>>> Looks good to me. But, I have some comment. Please check them.
>>>
>>> Thank you for review, please see answers below.
>>>
>>>> After this patch, exynos_bus_target is perfectly same with
>>>> exynos_bus_passive_target. The exynos_bus_passive_target() could be removed.
>>>
>>> Ok, I will make it in separate patch to simplify review process.
>>
>> I think you can just modify this patch without any separate patch.
> 
> Do you want me to send v5 with patch 5 squashed in patch 3 ?

Yes. In result, it made two functions same by this patch
So, I think that can combine them without separate patch.

>  
>>>> On 19. 7. 20. 오전 12:05, k.konieczny@partner.samsung.com wrote:
>>>>> Reuse opp core code for setting bus clock and voltage. As a side
>>>>> effect this allow useage of coupled regulators feature (required
>>>>
>>>> s/useage/usage ?
>>>
>>> Good catch, I will change it.
>>>
>>>>> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
>>>>> uses regulator_set_voltage_triplet() for setting regulator voltage
>>>>> while the old code used regulator_set_voltage_tol() with fixed
>>>>> tolerance. This patch also removes no longer needed parsing of DT
>>>>> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses
>>>>> it).
>>>>>
>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>> ---
>>>>>  drivers/devfreq/exynos-bus.c | 143 +++++++++--------------------------
>>>>>  1 file changed, 37 insertions(+), 106 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>> index f391044aa39d..c2147b0912a0 100644
>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>> @@ -25,7 +25,6 @@
>>>>>  #include <linux/slab.h>
>>>>>
>>>>>  #define DEFAULT_SATURATION_RATIO    40
>>>>> -#define DEFAULT_VOLTAGE_TOLERANCE   2
>>>>>
>>>>>  struct exynos_bus {
>>>>>      struct device *dev;
>>>>> @@ -37,9 +36,9 @@ struct exynos_bus {
>>>>>
>>>>>      unsigned long curr_freq;
>>>>>
>>>>> -    struct regulator *regulator;
>>>>> +    struct opp_table *opp_table;
>>>>> +
>>>>>      struct clk *clk;
>>>>> -    unsigned int voltage_tolerance;
>>>>>      unsigned int ratio;
>>>>>  };
>>>>>
>>>>> @@ -99,56 +98,23 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>>>>>  {
>>>>>      struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>      struct dev_pm_opp *new_opp;
>>>>> -    unsigned long old_freq, new_freq, new_volt, tol;
>>>>>      int ret = 0;
>>>>>
>>>>> -    /* Get new opp-bus instance according to new bus clock */
>>>>> +    /* Get correct frequency for bus. */
>>>>>      new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>      if (IS_ERR(new_opp)) {
>>>>>              dev_err(dev, "failed to get recommended opp instance\n");
>>>>>              return PTR_ERR(new_opp);
>>>>>      }
>>>>>
>>>>> -    new_freq = dev_pm_opp_get_freq(new_opp);
>>>>> -    new_volt = dev_pm_opp_get_voltage(new_opp);
>>>>>      dev_pm_opp_put(new_opp);
>>>>>
>>>>> -    old_freq = bus->curr_freq;
>>>>> -
>>>>> -    if (old_freq == new_freq)
>>>>> -            return 0;
>>>>> -    tol = new_volt * bus->voltage_tolerance / 100;
>>>>> -
>>>>>      /* Change voltage and frequency according to new OPP level */
>>>>>      mutex_lock(&bus->lock);
>>>>> +    ret = dev_pm_opp_set_rate(dev, *freq);
>>>>> +    if (!ret)
>>>>> +            bus->curr_freq = *freq;
>>>>>
>>>>> -    if (old_freq < new_freq) {
>>>>> -            ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>> -            if (ret < 0) {
>>>>> -                    dev_err(bus->dev, "failed to set voltage\n");
>>>>> -                    goto out;
>>>>> -            }
>>>>> -    }
>>>>> -
>>>>> -    ret = clk_set_rate(bus->clk, new_freq);
>>>>> -    if (ret < 0) {
>>>>> -            dev_err(dev, "failed to change clock of bus\n");
>>>>> -            clk_set_rate(bus->clk, old_freq);
>>>>> -            goto out;
>>>>> -    }
>>>>> -
>>>>> -    if (old_freq > new_freq) {
>>>>> -            ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
>>>>> -            if (ret < 0) {
>>>>> -                    dev_err(bus->dev, "failed to set voltage\n");
>>>>> -                    goto out;
>>>>> -            }
>>>>> -    }
>>>>> -    bus->curr_freq = new_freq;
>>>>> -
>>>>> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>> -                    old_freq, new_freq, clk_get_rate(bus->clk));
>>>>> -out:
>>>>>      mutex_unlock(&bus->lock);
>>>>>
>>>>>      return ret;
>>>>> @@ -195,8 +161,8 @@ static void exynos_bus_exit(struct device *dev)
>>>>>              dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>>>>
>>>>>      clk_disable_unprepare(bus->clk);
>>>>> -    if (bus->regulator)
>>>>> -            regulator_disable(bus->regulator);
>>>>> +    if (bus->opp_table)
>>>>> +            dev_pm_opp_put_regulators(bus->opp_table);
>>>>>
>>>>>      dev_pm_opp_of_remove_table(dev);
>>>>>  }
>>>>> @@ -209,39 +175,23 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
>>>>>  {
>>>>>      struct exynos_bus *bus = dev_get_drvdata(dev);
>>>>>      struct dev_pm_opp *new_opp;
>>>>> -    unsigned long old_freq, new_freq;
>>>>> -    int ret = 0;
>>>>> +    int ret;
>>>>>
>>>>> -    /* Get new opp-bus instance according to new bus clock */
>>>>> +    /* Get correct frequency for bus. */
>>>>>      new_opp = devfreq_recommended_opp(dev, freq, flags);
>>>>>      if (IS_ERR(new_opp)) {
>>>>>              dev_err(dev, "failed to get recommended opp instance\n");
>>>>>              return PTR_ERR(new_opp);
>>>>>      }
>>>>>
>>>>> -    new_freq = dev_pm_opp_get_freq(new_opp);
>>>>>      dev_pm_opp_put(new_opp);
>>>>>
>>>>> -    old_freq = bus->curr_freq;
>>>>> -
>>>>> -    if (old_freq == new_freq)
>>>>> -            return 0;
>>>>> -
>>>>>      /* Change the frequency according to new OPP level */
>>>>>      mutex_lock(&bus->lock);
>>>>> +    ret = dev_pm_opp_set_rate(dev, *freq);
>>>>> +    if (!ret)
>>>>> +            bus->curr_freq = *freq;
>>>>>
>>>>> -    ret = clk_set_rate(bus->clk, new_freq);
>>>>> -    if (ret < 0) {
>>>>> -            dev_err(dev, "failed to set the clock of bus\n");
>>>>> -            goto out;
>>>>> -    }
>>>>> -
>>>>> -    *freq = new_freq;
>>>>> -    bus->curr_freq = new_freq;
>>>>> -
>>>>> -    dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
>>>>> -                    old_freq, new_freq, clk_get_rate(bus->clk));
>>>>> -out:
>>>>>      mutex_unlock(&bus->lock);
>>>>>
>>>>>      return ret;
>>>>> @@ -259,20 +209,9 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>                                      struct exynos_bus *bus)
>>>>>  {
>>>>>      struct device *dev = bus->dev;
>>>>> -    int i, ret, count, size;
>>>>> -
>>>>> -    /* Get the regulator to provide each bus with the power */
>>>>> -    bus->regulator = devm_regulator_get(dev, "vdd");
>>>>> -    if (IS_ERR(bus->regulator)) {
>>>>> -            dev_err(dev, "failed to get VDD regulator\n");
>>>>> -            return PTR_ERR(bus->regulator);
>>>>> -    }
>>>>> -
>>>>> -    ret = regulator_enable(bus->regulator);
>>>>> -    if (ret < 0) {
>>>>> -            dev_err(dev, "failed to enable VDD regulator\n");
>>>>> -            return ret;
>>>>> -    }
>>>>> +    struct opp_table *opp_table;
>>>>> +    const char *vdd = "vdd";
>>>>> +    int i, count, size;
>>>>>
>>>>>      /*
>>>>>       * Get the devfreq-event devices to get the current utilization of
>>>>> @@ -281,26 +220,29 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>      count = devfreq_event_get_edev_count(dev);
>>>>>      if (count < 0) {
>>>>>              dev_err(dev, "failed to get the count of devfreq-event dev\n");
>>>>> -            ret = count;
>>>>> -            goto err_regulator;
>>>>> +            return count;
>>>>>      }
>>>>> -    bus->edev_count = count;
>>>>>
>>>>> +    bus->edev_count = count;
>>>>>      size = sizeof(*bus->edev) * count;
>>>>>      bus->edev = devm_kzalloc(dev, size, GFP_KERNEL);
>>>>> -    if (!bus->edev) {
>>>>> -            ret = -ENOMEM;
>>>>> -            goto err_regulator;
>>>>> -    }
>>>>> +    if (!bus->edev)
>>>>> +            return -ENOMEM;
>>>>>
>>>>>      for (i = 0; i < count; i++) {
>>>>>              bus->edev[i] = devfreq_event_get_edev_by_phandle(dev, i);
>>>>> -            if (IS_ERR(bus->edev[i])) {
>>>>> -                    ret = -EPROBE_DEFER;
>>>>> -                    goto err_regulator;
>>>>> -            }
>>>>> +            if (IS_ERR(bus->edev[i]))
>>>>> +                    return -EPROBE_DEFER;
>>>>> +    }
>>>>> +
>>>>> +    opp_table = dev_pm_opp_set_regulators(dev, &vdd, 1);
>>>>> +    if (IS_ERR(opp_table)) {
>>>>> +            i = PTR_ERR(opp_table);
>>>>> +            dev_err(dev, "failed to set regulators %d\n", i);
>>>>> +            return i;
>>>>
>>>> Maybe, you just used the 'i' defined variable instead of adding
>>>> new variable. But, I think that you better to add new variable
>>>> like 'err' for the readability. Or, jut use the 'PTR_ERR(opp_table)'
>>>> directly without any additional variable.
>>>
>>> I will remove not related changes, so here I will reuse 'ret' variable.
>>>
>>>>>      }
>>>>>
>>>>> +    bus->opp_table = opp_table;
>>>>
>>>> Add blank line.
>>>
>>> OK
>>>
>>>>>      /*
>>>>>       * Optionally, Get the saturation ratio according to Exynos SoC
>>>>>       * When measuring the utilization of each AXI bus with devfreq-event
>>>>> @@ -314,16 +256,7 @@ static int exynos_bus_parent_parse_of(struct device_node *np,
>>>>>      if (of_property_read_u32(np, "exynos,saturation-ratio", &bus->ratio))
>>>>>              bus->ratio = DEFAULT_SATURATION_RATIO;
>>>>>
>>>>> -    if (of_property_read_u32(np, "exynos,voltage-tolerance",
>>>>> -                                    &bus->voltage_tolerance))
>>>>> -            bus->voltage_tolerance = DEFAULT_VOLTAGE_TOLERANCE;
>>>>> -
>>>>>      return 0;
>>>>> -
>>>>> -err_regulator:
>>>>> -    regulator_disable(bus->regulator);
>>>>> -
>>>>> -    return ret;
>>>>>  }
>>>>>
>>>>>  static int exynos_bus_parse_of(struct exynos_bus *bus)
>>>>> @@ -414,12 +347,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>
>>>>>      /* Parse the device-tree to get the resource information */
>>>>>      ret = exynos_bus_parse_of(bus);
>>>>> -    if (ret < 0) {
>>>>> -            if (!passive)
>>>>> -                    regulator_disable(bus->regulator);
>>>>> -
>>>>> -            return ret;
>>>>> -    }
>>>>> +    if (ret < 0)
>>>>> +            goto err_reg;
>>>>>
>>>>>      if (passive)
>>>>>              goto passive;
>>>>> @@ -512,10 +441,12 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>>>
>>>>>  err:
>>>>>      clk_disable_unprepare(bus->clk);
>>>>> -    if (!passive)
>>>>> -            regulator_disable(bus->regulator);
>>>>> -
>>>>>      dev_pm_opp_of_remove_table(dev);
>>>>
>>>> This function removes the 'opp_table'. But, the below code
>>>> uses the 'opp_table' variable by dev_pm_opp_put_regulators().
>>>>
>>>> To disable the regulator, you have to call dev_pm_opp_of_remove_table(dev)
>>>> after dev_pm_opp_put_regulators(bus->opp_table).
>>>
>>> Regulators should be set before dev_pm_opp_add_table(), so exit sequence
>>> should be in reverse order,
>>>
>>> init order:
>>>
>>> exynos_bus_parent_parse_of()
>>>         dev_pm_opp_set_regulators()
>>> exynos_bus_parse_of()
>>>         clk_prepare_enable()
>>>         dev_pm_opp_of_add_table()
>>>
>>> exit or error order:
>>>
>>> dev_pm_opp_of_remove_table()
>>> clk_disable_unprepare()
>>> if (bus->opp_table)
>>>         dev_pm_opp_put_regulators(bus->opp_table);
>>
>> dev_pm_opp_of_remove_table() have to be called at the end of exit sequence
>> after disabling clock and put regulators. Because dev_pm_opp_of_remove_table()
>> frees the 'opp_table' pointer of device.
>>
>> clk_disable_unprepare()
>> if (bus->opp_table)
>>           dev_pm_opp_put_regulators(bus->opp_table);
>> dev_pm_opp_of_remove_table()
> 
> The table is reference counted so it will be freed after count go to zero.

You're right. I checked it with OPP code.

> 
>>> I will send v4 soon.
>>>
>>>>> +err_reg:
>>>>> +    if (bus->opp_table) {
>>>>> +            dev_pm_opp_put_regulators(bus->opp_table);
>>>>> +            bus->opp_table = NULL;
>>>>> +    }
>>>>>
>>>>>      return ret;
>>>>>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
