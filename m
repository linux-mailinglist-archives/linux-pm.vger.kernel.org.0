Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638E5BE9D1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 02:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfIZAwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 20:52:10 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38739 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfIZAwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 20:52:10 -0400
Received: by mail-wm1-f42.google.com with SMTP id 3so612896wmi.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FvNRQJcUhQfb2TIItBf4xHXSQ6Xkvyd6ZTlhyF5NWeQ=;
        b=P5n6VFgEsBU3C33m3U5ePbfRt9N0X0QYiE60KZ/0etVH12pdBiFuyPjMZEnvGNi7xf
         If9sF3h2xnEkgMlDec+44RMYzYZbzS88zF74HdkiMoOwYhgOzn6ZBE181cka4l68MmTC
         dS88AEsMhSqXDizIBx9KJQODvL9VL76h7WnXz0siKbMV0Zjll66BSlIUQprEQovS5VnC
         Ji5lQkGNt0tbIk6/VZZsyJsKTxLwwpUADlnk6+DaZuVEIPo8g2kwN6sdnnjlIXCAFCyC
         eYPlCTaQqD/b2KTsbVh+pagfLk8Hk84HFg1wSjj19g2jHwZL4tz8CcOomKfhPBXn4sra
         ZpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FvNRQJcUhQfb2TIItBf4xHXSQ6Xkvyd6ZTlhyF5NWeQ=;
        b=bnqu8P9rLS3836Ph0vRs2vFqm428T2rvcPDjhKM4d2Fmm/qQc3K5JuYB5sp8Q6Bcgk
         NF3blD0lnPfSU9A6aR5lOfXkhbBT/415DrKr/KB8H76jq+LLjbAWPg9AQTrF/FaruUx2
         5wFiu5NVzzZq8IAHHxp1Whn93ibJ//7FtuCM/bnJnQeUSrPjxODPmlT5CnrmDa5HQIlv
         hJ96Oh/SQW6sx6oVoYDyrLWuN89khlQ9FKZtK1xHtRjipNBk3n8o6SsesWmLqvihzZcd
         yJ4szH8BHRKi7f1Z8oaFVWQcihYWP6YxOLS46yPa4rxggXIb2znJI7gLrNeKMfNfwhHR
         QF5g==
X-Gm-Message-State: APjAAAWLS/hAPGIPlESF517HyfgiN/6ooBrUsRlrAeDG+8osHp8kuTH/
        D+x/jqT8TWn6gsNY9LbsfqOnlw==
X-Google-Smtp-Source: APXvYqwTvDLFfwa+WG+kHvYk5mX9GHxxyDW3nuWeKegy2SyW1HJ/G/bLbMu4QtMEhTiQtO1nVeJ1DA==
X-Received: by 2002:a1c:a94b:: with SMTP id s72mr644250wme.9.1569459127464;
        Wed, 25 Sep 2019 17:52:07 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d10sm637986wma.42.2019.09.25.17.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 17:52:06 -0700 (PDT)
Subject: Re: [RFCv4 0/7] interconnect: Add imx support via devfreq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
 <VI1PR04MB702373BE28E4404C7F2CE75FEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <02d3fe6a-53a6-3290-deab-d79e940978ff@linaro.org>
 <VI1PR04MB7023ADED2210DFCB81E588CFEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABtChHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+iQI+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH7kCDQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AYkCJQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <a1f04769-9547-58e6-2bd0-5b6a5864fbf0@linaro.org>
Date:   Wed, 25 Sep 2019 17:51:58 -0700
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023ADED2210DFCB81E588CFEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/25/19 15:52, Leonard Crestez wrote:
> On 25.09.2019 05:38, Georgi Djakov wrote:
>> Hi Leonard,
>>
>> On 9/16/19 05:34, Leonard Crestez wrote:
>>> On 23.08.2019 17:37, Leonard Crestez wrote:
>>>> This series add imx support for interconnect via devfreq: the ICC
>>>> framework is used to aggregate requests from devices and then those are
>>>> converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.
>>>>   
>>>> Since there is no single devicetree node that can represent the "interconnect"
>>>> new API is added to allow individual devfreq nodes to act as parsing proxies
>>>> all mapping to a single soc-level icc provider. This is still RFC
>>>> because of this
>>>
>>> Any comments? I made a lot of changes relative to previous versions,
>>> most of them solely to avoid adding a virtual node in DT bindings.
>>>
>>> The only current interconnect provider implementation is for qcom and it
>>> uses a firmware node as the provider node (with #interconnect-cells).
>>> However there is no obvious equivalent of that for imx and many other SOCs.
>>
>> Not sure if it will help, but have you seen the qcs404 interconnect driver?
>> There is also mt8183 interconnect provider driver on LKML.
> 
> Yes, but only yesterday. The qcs404 driver involves multiple DT devices 
> so it seems closer to imx.
> 
> As far as I understand from reading qcs404 source:
> 
> * There is no struct device representing the entire graph.
> * There are multiple NOCs and each registers itself as a separate 
> interconnect provider.
> * Each NOC registers multiple icc_nodes of various sorts:
>    * Device masters and slaves
>    * Some nodes representing NoC ports?

Well, all nodes are representing ports.

>    * Multiple internal nodes
> * There is single per-SOC master list of QNOCs in the qcs404 driver.
> * The QNOCs can reference each other between multiple providers.
> * Each NOC registers an icc_provider and a subset of the graph.
> * The multiple NoC inside a chip are distinguished by compat strings. 
> This seems strange, aren't they really different instantiations of the 
> same IP with small config changes?

No, they are different IPs - ahb, axi or custom based.

> This design is still quite odd, what would make sense to me is to 
> register the "interconnect graph" once and then provide multiple 
> "interconnect scalers" which handle the aggregated requests for certain 
> specific nodes.
> 
>>> On imx there are multiple pieces of scalable fabric which can be defined
>>> in DT as devfreq devices and it sort of makes sense to add
>>> #interconnect-cells to those. However when it comes to describing the
>>> SOC interconnect graph it's much more convenient to have a single
>>> per-SOC platform driver.
>>
>> Is all the NoC configuration done only by ATF? Are there any NoC related memory
>> mapped registers?
> 
> Registers are memory-mapped and visible to the A-cores but should only 
> be accessed through secure transactions. This means that configuration 
> needs be done by ATF in EL3 (we don't support running linux in secure 
> world on imx8m). There is no "remote processor" managing this on imx8m.

Can we create some noc DT node with it's memory mapped address and make
it an interconnect provider? Sounds to me like a more correct representation
of the hardware?
Other option would be to bless some PSCI DT node (for example) to be a
provider.

> 
> On older imx6/7 chips we actually have two out-of-tree implementations 
> of bus freq switching code: An older one in Linux (used when running in 
> secure world) and a different one in optee for running Linux in 
> non-secure world.
> 
> NoC registers can be used to control some "transaction priority" bits 
> but I don't want to expose that part right now.

This is very similar to some of the Qcom hardware.

> What determines bandwidth versus power consumption is the NoC clk rate 
> and clocks are managed by Linux directly.

So you will need to describe these clocks in the interconnect provider
DT node like on qcs404.

> DVFS on the RAM controller (DDRC) is also important. That component is 
> only a bus slave and frequency switching requires a complex sequence 
> inside ATF.

Makes sense.

Thanks,
Georgi
