Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FA1BC504
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgD1QVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgD1QVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 12:21:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF3C03C1AC
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 09:21:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so3483340wmj.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fERhQCFbA1t0MEIr8ZhWDmlAK+fHKSgex2wUsZhxFgk=;
        b=x2n5C6htlEepTx46I33KAMm+/Ay5DK1JlstSPpuv0vT9pNtIwpXJJ0DWhccmVrCT2x
         TaxZ4ufh7GWGLYEF+3fU8oR/ZI2HSJdE3eFyAHn8+PP2Bua5xR8a0E1wuMnKXelWZeQ9
         AJj+mFOvFGdMqWTlMWNnBq01/NPNwWvsp93xBhzQGMYR/A3ZVLMd4OuR+xaHLWkLkS+V
         DROTSaV1buAnhH2Ce1k0cOafU+OHclTZ6o8S/7gctvNiW8gTVyj+ovD7xoZradrDjqSz
         Rirs8YaqTbWmCH8+atjDietmvANP89431v0X+Lw++Z5h/s69qYtBBF/9zX0CpYQQwcOW
         +irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fERhQCFbA1t0MEIr8ZhWDmlAK+fHKSgex2wUsZhxFgk=;
        b=nFhQae6S0L9v3B0crE9AWHTEDMLyEGYBweDTWKVTnTgc3WhLzWpH11LYP9T9My9R+p
         SIaQLivNIEauxdKZf8REalQoAm2QsB9xnVaZZLcji1MMEsXMvgRkHISUBmHudD6K44NX
         PkIHQj+F4ZVWUqQtF64wtqJJFub9OwCBemuEnXhyl36AIS22bLakICO3+ZK+1XdE0hID
         zbgYGIRE8RQO50vYjZ1P3hwiZqqoAKsAjUejG+YdvTepVleXPeiheGDQT3bs2b3fuIKt
         dcEXYzIGOQxbhqF0rdzGG2qzuYKMiv/eLdYFsrhI0A5CVnNatYlH7EJDW7Ry61V/MOIS
         3KMg==
X-Gm-Message-State: AGi0PuZKNbiqwzJxUuyegculvtPL79qZ6tHrEbr7qD2NTcqeVJ43V1CT
        7egI4I02FGoGMvM8APsGxLA52Q==
X-Google-Smtp-Source: APiQypLBHsMhfilMqf41XSA2l2AaDXx34Od8XK/mZ14uwBdu5OFLkp+xI5HDA9tdQwZCHwaE11N6bg==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr5360974wmd.65.1588090874315;
        Tue, 28 Apr 2020 09:21:14 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id v16sm3862308wml.30.2020.04.28.09.21.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 09:21:13 -0700 (PDT)
Subject: Re: [PATCH v7 4/7] OPP: Add support for parsing interconnect
 bandwidth
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-5-georgi.djakov@linaro.org>
 <20200424192025.GA4525@google.com>
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
Message-ID: <c490e24c-381a-fcdd-45a0-742f664366a4@linaro.org>
Date:   Tue, 28 Apr 2020 19:21:11 +0300
MIME-Version: 1.0
In-Reply-To: <20200424192025.GA4525@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

On 4/24/20 22:20, Matthias Kaehlcke wrote:
> Hi,
> 
> On Fri, Apr 24, 2020 at 06:54:01PM +0300, Georgi Djakov wrote:
>> The OPP bindings now support bandwidth values, so add support to parse it
>> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
>> is part of the dev_pm_opp.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>> v7:
>> * Addressed some review comments from Viresh and Sibi.
>> * Various other changes.
>>
>> v2: https://lore.kernel.org/linux-arm-msm/20190423132823.7915-4-georgi.djakov@linaro.org/
>>
>>  drivers/opp/Kconfig    |   1 +
>>  drivers/opp/core.c     |  16 +++++-
>>  drivers/opp/of.c       | 119 ++++++++++++++++++++++++++++++++++++++++-
>>  drivers/opp/opp.h      |   9 ++++
>>  include/linux/pm_opp.h |  12 +++++
>>  5 files changed, 153 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
>> index 35dfc7e80f92..230d2b84436c 100644
>> --- a/drivers/opp/Kconfig
>> +++ b/drivers/opp/Kconfig
>> @@ -2,6 +2,7 @@
>>  config PM_OPP
>>  	bool
>>  	select SRCU
>> +	depends on INTERCONNECT || !INTERCONNECT
> 
> huh?

Yeah, PM_OPP can be built-in only, but interconnect can be a module and in this
case i expect the linker to complain.

> 
>>  	---help---
>>  	  SOCs have a standard set of tuples consisting of frequency and
>>  	  voltage pairs that the device will support per voltage domain. This
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index c9c1bbe6ae27..8e86811eb7b2 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -985,6 +985,12 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>>  				ret);
>>  	}
>>  
>> +	/* Find interconnect path(s) for the device */
>> +	ret = _of_find_paths(opp_table, dev);
>> +	if (ret)
>> +		dev_dbg(dev, "%s: Error finding interconnect paths: %d\n",
>> +			__func__, ret);
> 
> why dev_dbg and not dev_warn?

Will make it dev_warn. Thanks!

>> +
>>  	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
>>  	INIT_LIST_HEAD(&opp_table->opp_list);
>>  	kref_init(&opp_table->kref);
>> @@ -1229,19 +1235,22 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
>>  struct dev_pm_opp *_opp_allocate(struct opp_table *table)
>>  {
>>  	struct dev_pm_opp *opp;
>> -	int count, supply_size;
>> +	int count, supply_size, icc_size;
>>  
>>  	/* Allocate space for at least one supply */
>>  	count = table->regulator_count > 0 ? table->regulator_count : 1;
>>  	supply_size = sizeof(*opp->supplies) * count;
>> +	icc_size = sizeof(*opp->bandwidth) * table->path_count;
>>  
>>  	/* allocate new OPP node and supplies structures */
>> -	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
>> +	opp = kzalloc(sizeof(*opp) + supply_size + icc_size, GFP_KERNEL);
>> +
>>  	if (!opp)
>>  		return NULL;
>>  
>>  	/* Put the supplies at the end of the OPP structure as an empty array */
>>  	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
>> +	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + 1);
> 
> IIUC this needs to be:
> 
> 	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp->supplies + count);
> 
> maybe s/count/supply_count/

Right, thank you!

> 
>>  	INIT_LIST_HEAD(&opp->node);
>>  
>>  	return opp;
>> @@ -1276,6 +1285,9 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
>>  {
>>  	if (opp1->rate != opp2->rate)
>>  		return opp1->rate < opp2->rate ? -1 : 1;
>> +	if (opp1->bandwidth && opp2->bandwidth &&
>> +	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
>> +		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
>>  	if (opp1->level != opp2->level)
>>  		return opp1->level < opp2->level ? -1 : 1;
>>  	return 0;
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index e33169c7e045..978e445b0cdb 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -332,6 +332,59 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
>>  	return ret;
>>  }
>>  
>> +int _of_find_paths(struct opp_table *opp_table, struct device *dev)
> 
> nit: _of_find_icc_paths() to be more concise?

Ok!

> 
>> +{
>> +	struct device_node *np;
>> +	int ret, i, count, num_paths;
>> +
>> +	np = of_node_get(dev->of_node);
>> +	if (!np)
>> +		return 0;
>> +
>> +	count = of_count_phandle_with_args(np, "interconnects",
>> +					   "#interconnect-cells");
>> +	of_node_put(np);
>> +	if (count < 0)
>> +		return 0;
>> +
>> +	/* two phandles when #interconnect-cells = <1> */
>> +	if (count % 2) {
>> +		dev_err(dev, "%s: Invalid interconnects values\n",
>> +			__func__);
> 
> nit: no need for separate line

Ok!

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	num_paths = count / 2;
>> +	opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
>> +				   GFP_KERNEL);
> 
> Add kfree(opp_table->paths) to _opp_table_kref_release() ?

Yes, sure.

>> +	if (!opp_table->paths)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_paths; i++) {
>> +		opp_table->paths[i] = of_icc_get_by_index(dev, i);
>> +		if (IS_ERR(opp_table->paths[i])) {
>> +			ret = PTR_ERR(opp_table->paths[i]);
>> +			if (ret != -EPROBE_DEFER) {
>> +				dev_err(dev, "%s: Unable to get path%d: %d\n",
>> +					__func__, i, ret);
>> +			}
> 
> nit: curly braces not needed

Ok!

[..]
>> +		for (i = 0; i < count; i++)
>> +			new_opp->bandwidth[i].peak = kBps_to_icc(peak_bw[i]);
>> +
>> +		found = true;
> 
> 		kfree(peak_bw);
> 
> or re-arrange the kfree()'s below to be in the common code path
> 
>> +	}
>> +
>> +	avg = of_find_property(np, "opp-avg-kBps", NULL);
>> +	if (peak && avg) {
>> +		count = avg->length / sizeof(u32);
>> +		avg_bw = kmalloc_array(count, sizeof(*avg_bw), GFP_KERNEL);
>> +		if (!avg_bw) {
>> +			ret = -ENOMEM;
>> +			goto free_peak_bw;
>> +		}
>> +
>> +		ret = of_property_read_u32_array(np, "opp-avg-kBps", avg_bw,
>> +						 count);
>> +		if (ret) {
>> +			pr_err("%s: Error parsing opp-avg-kBps: %d\n",
>> +			       __func__, ret);
>> +			goto free_avg_bw;
>> +		}
>> +
>> +		for (i = 0; i < count; i++)
>> +			new_opp->bandwidth[i].avg = kBps_to_icc(avg_bw[i]);
> 
> 		kfree(avg_bw);
> 
>> +	}
> 
> nit: the two code blocks for peak and average bandwidth are mostly redundant.
> If it weren't for the assignment of 'new_opp->bandwidth[i].avg' vs
> 'new_opp->bandwidth[i].peak' the above could easily be outsourced into a
> helper function. With some pointer hacks you could still do this, but not
> sure if it's worth the effort.

Yeah, i didn't really like this part. I'll see if i can improve it a bit.

Thanks a lot for reviewing!

BR,
Georgi
