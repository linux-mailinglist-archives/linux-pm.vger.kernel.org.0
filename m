Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59B2A1EFB
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKAPXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKAPXe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:23:34 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E24C0617A6;
        Sun,  1 Nov 2020 07:23:33 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id k25so12226682lji.9;
        Sun, 01 Nov 2020 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJWXSV/byzpJ/dAkzSzpKv1rnP3tZ95JumBWaAzgzVg=;
        b=dpBXaXhAye4AWtxNEU3nOqfpMAPeRpRWW1Tq0vRsTxGXBIlfA8RcBVx8XJbgPhwyb/
         EE+fbcVeOhDL1N7EFXRtu+Y4g+nI0hdZHyoDHsrT8mTj3RVyR3q7wbFKTo48t85Y9rS4
         4/SYK54PJtZyaSyyNMsJ7ftkmXRy5TIBZ/rGClDrolOczWxfDeicXrvFmJPx4z7jvCop
         lu0QvvjIFdhEcOqUPqPo6+GcY0EwEDlB4SbTCFymaMHR/stKQKbhjsqx/iWEHz319hX7
         lLmwP2IRHe+fLs2jhD4nIGHinFhT5rdC3dj2FwZVHJJX3XgnwTw2MsEnxMljvxzJ+QeW
         JhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJWXSV/byzpJ/dAkzSzpKv1rnP3tZ95JumBWaAzgzVg=;
        b=uEAwECiESJzv8ccyPVSUHFRL99oqqWR5CPJo0Gw4fUtq+9M364XApbN+7Qy0ZONrKw
         MH5GYukPT74dg2/84/V2mihrqxGmjdAJwUYyAJzYmNO7hlT0rWRtES3ALk2WKg6mrfxp
         UuRoMBMISs7JvKyFzsXyodG51WqmK7Zi4db89SAdHkeFz6HAJK50QpWCJnw/LLbB/sst
         4kjM5bW+wHEyvDvXexI3fNTup06d6yG86vOrFN8F8NVRmqSBWDbvTVJoCQr0J84IJmL9
         ZUVr/QOqvnRxJcrGSHmBWt1/HTGnjxYstevyGy2aBViyQj3PcQKNF/BxKYj6oY8szNpi
         yQaA==
X-Gm-Message-State: AOAM533sSmo8bIk9Nt79uEKi0p5NxhBVS5Men1FjKUMCdBcsPFnFsJAy
        24eQsxeMAktQNTVygwDs1GnR07TY7iU=
X-Google-Smtp-Source: ABdhPJxCwsQlLUEFvF+PCd4/pydRuDnXNRIL971/glUN01Nke41XdCmtnxxMDqozuQVO6vhbZQb5DQ==
X-Received: by 2002:a2e:9a43:: with SMTP id k3mr5306932ljj.69.1604244211796;
        Sun, 01 Nov 2020 07:23:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id x13sm93101lfr.26.2020.11.01.07.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 07:23:31 -0800 (PST)
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     cwchoi00@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com>
Date:   Sun, 1 Nov 2020 18:23:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 17:39, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> This patch moves ACTMON driver away from generating OPP table by itself,
>> transitioning it to use the table which comes from device-tree. This
>> change breaks compatibility with older device-trees in order to bring
>> support for the interconnect framework to the driver. This is a mandatory
>> change which needs to be done in order to implement interconnect-based
>> memory DVFS. Users of legacy device-trees will get a message telling that
>> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
>> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
...
>>  static int tegra_devfreq_get_dev_status(struct device *dev,
>> @@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>         stat->private_data = tegra;
>>
>>         /* The below are to be used by the other governors */
>> -       stat->current_frequency = cur_freq;
>> +       stat->current_frequency = cur_freq * KHZ;
> 
> I can't find any change related to the frequency unit on this patch.
> Do you fix the previous bug of the frequency unit?

Previously, OPP entries that were generated by the driver used KHz
units. Now, OPP entries are coming from a device-tree and they have Hz
units. This driver operates with KHz internally, hence we need to
convert the units now.

>>
>>         actmon_dev = &tegra->devices[MCALL];
>>
>> @@ -705,7 +693,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>>                 target_freq = max(target_freq, dev->target_freq);
>>         }
>>
>> -       *freq = target_freq;
>> +       *freq = target_freq * KHZ;
> 
> ditto.
> 
>>
>>         return 0;
>>  }
>> @@ -773,13 +761,22 @@ static struct devfreq_governor tegra_devfreq_governor = {
>>
>>  static int tegra_devfreq_probe(struct platform_device *pdev)
>>  {
>> +       u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
>>         struct tegra_devfreq_device *dev;
>>         struct tegra_devfreq *tegra;
>> +       struct opp_table *opp_table;
>>         struct devfreq *devfreq;
>>         unsigned int i;
>>         long rate;
>>         int err;
>>
>> +       /* legacy device-trees don't have OPP table and must be updated */
>> +       if (!device_property_present(&pdev->dev, "operating-points-v2")) {
>> +               dev_err(&pdev->dev, "OPP table not found, cannot continue\n");
>> +               dev_err(&pdev->dev, "please update your device tree\n");
>> +               return -ENODEV;
>> +       }
> 
> As you mentioned, it breaks the old dtb. I have no objection to improving
> the driver. Instead, you need confirmation from the Devicetree maintainer.

Older DTBs will continue to work, but devfreq driver won't. We already
did this for other Tegra drivers before (CPUFREQ driver for example) and
Rob Herring confirmed that there is no problem here.

> And,
> I recommend that you use dev_pm_opp_of_get_opp_desc_node(&pdev->dev)
> to check whether a device contains opp-table or not.

I'm not sure what are the benefits, this will make code less
expressive/readable and we will need to add extra of_node_put(), which
device_property_present() handles for us.

Could you please give the rationale?

>> +
>>         tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>         if (!tegra)
>>                 return -ENOMEM;
>> @@ -821,11 +818,29 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>                 return err;
>>         }
>>
>> +       tegra->opp_table = dev_pm_opp_get_opp_table(&pdev->dev);
>> +       if (IS_ERR(tegra->opp_table))
>> +               return dev_err_probe(&pdev->dev, PTR_ERR(tegra->opp_table),
>> +                                    "Failed to prepare OPP table\n");
> 
> As I knew, each device can contain the opp_table on devicetree.
> It means that opp_table has not depended to another device driver.
> Did you see this exception case with EPROBE_DEFER error?

OPP core will try to grab the clock reference for the table and it may
cause EPROBE_DEFER. Although, it shouldn't happen here because we have
devm_clk_get() before the get_opp_table(), hence seems the deferred
probe indeed shouldn't happen in this case.
