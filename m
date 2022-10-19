Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA46050D2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJSTyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJSTyE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 15:54:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F191D5E3E
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 12:53:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bp11so30860058wrb.9
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sx1by9sS3WllgEDdiIvi4CitdudmqXXcs4v2OCLQoCI=;
        b=Xz+VexDTooFBNPesSbWDIKwKu6HbGLIxZaGZkTvdxp/nxRec9+4GxacKHW8vq2LoYc
         odf7jo0zXpK8cDVq/Ia2PJWuMO4eBuZweByYKMRRE2/V19TZGGBeFCPf4qiFwHgESFBJ
         YqhiVtn/YzeHwQjJ6OMGBpdtf+n4WttzA+vkFaDMgDrBU8fueISFxLpdcAMychyEwIxl
         k+3Cv3Q6sD/QU7D1VgsINpLhceh5g8NMPxXB3g93UAzYGjkZ/FMq9DVQXYmdvlM4vGsT
         Kwf/Vb+K0b+jMcJEnNb86ZAmI1g3nKJZ63ke+elfmxsr14stGNMY4aVBS9zKd3Yh/vss
         RlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sx1by9sS3WllgEDdiIvi4CitdudmqXXcs4v2OCLQoCI=;
        b=Z89869GHwxYSh0jSPU6JqyaHXxqZuAnM6aoegQ7XSIntVRswLzu4cOLP4PLCcsjjBb
         NXm8bYHs38CVMFTSLUYtuI0ad2PPuWNrEtbaLarDYV3ta/pJCxp2v/2q+D21aZy0t1Xu
         irGYrsQFOFj1QUqwhzuV3Vf2nwcpXQfp62FLHXDSdLtbl/zEjQtvCNIOg2Yy2xrfiFtB
         EQJY+77l/CuYqXUu3zA/eD1npInj4DPXnzR90IqwZ6ZNT2J+z7wN6nVgN/tM4Y/za2Vr
         3gLdFugaRabZY0VPmYdFwyW3kHQrHqAG8J0K2vguKL6m3ZSYnxYepylCFVgrQCbjm2AV
         zvYg==
X-Gm-Message-State: ACrzQf1p9vrvsNRREB55BLWaKLiHnkH1BNoLhxSKEQqHf+tL3EEH1fz1
        gL0RxQNBIlULbC9AlRSAo92Rbw==
X-Google-Smtp-Source: AMsMyM4jhaoT4cfJPLz3UMLk82gGa65407mNFt1eFbJo+oztzpIas6jFZp/VDlurB9//4GLmtAgl9g==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr6613472wri.36.1666209234173;
        Wed, 19 Oct 2022 12:53:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9368:960c:f98f:35b5? ([2a05:6e02:1041:c10:9368:960c:f98f:35b5])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b003c6f1732f65sm298418wmo.38.2022.10.19.12.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:53:53 -0700 (PDT)
Message-ID: <6650b077-1900-a6e6-755e-a84282e5fd13@linexp.org>
Date:   Wed, 19 Oct 2022 21:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 01/33] thermal/of: Rework the thermal device tree
 initialization
Content-Language: en-US
To:     Ido Schimmel <idosch@idosch.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Amit Kucheria <amitk@kernel.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-2-daniel.lezcano@linexp.org>
 <Y05/8JUU+3kLCZvb@shredder>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <Y05/8JUU+3kLCZvb@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ido,

On 18/10/2022 12:29, Ido Schimmel wrote:
> On Fri, Aug 05, 2022 at 12:43:17AM +0200, Daniel Lezcano wrote:
>> +struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
>> +						     const struct thermal_zone_device_ops *ops)
>> +{
>> +	struct thermal_zone_device *tz;
>> +	struct thermal_trip *trips;
>> +	struct thermal_zone_params *tzp;
>> +	struct thermal_zone_device_ops *of_ops;
>> +	struct device_node *np;
>> +	int delay, pdelay;
>> +	int ntrips, mask;
>> +	int ret;
>> +
>> +	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
>> +	if (!of_ops)
>> +		return ERR_PTR(-ENOMEM);
>> +	
>> +	np = of_thermal_zone_find(sensor, id);
>> +	if (IS_ERR(np)) {
>> +		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
>> +		return ERR_CAST(np);
>> +	}
>> +
>> +	trips = thermal_of_trips_init(np, &ntrips);
>> +	if (IS_ERR(trips)) {
>> +		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> +		return ERR_CAST(trips);
>> +	}
>> +
>> +	ret = thermal_of_monitor_init(np, &delay, &pdelay);
>> +	if (ret) {
>> +		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
>> +		goto out_kfree_trips;
>> +	}
>> +
>> +	tzp = thermal_of_parameters_init(np);
>> +	if (IS_ERR(tzp)) {
>> +		ret = PTR_ERR(tzp);
>> +		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
>> +		goto out_kfree_trips;
>> +	}
>> +
>> +	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
>> +	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
>> +	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
>> +	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
>> +	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
>> +	of_ops->bind = thermal_of_bind;
>> +	of_ops->unbind = thermal_of_unbind;
>> +
>> +	mask = GENMASK_ULL((ntrips) - 1, 0);
>> +
>> +	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>> +						     mask, data, of_ops, tzp,
>> +						     pdelay, delay);
>> +	if (IS_ERR(tz)) {
>> +		ret = PTR_ERR(tz);
>> +		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
>> +		goto out_kfree_tzp;
>> +	}
>> +
>> +	ret = thermal_zone_device_enable(tz);
>> +	if (ret) {
>> +		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
>> +		       tz->type, tz->id, ret);
>> +		thermal_of_zone_unregister(tz);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return tz;
>> +
>> +out_kfree_tzp:
>> +	kfree(tzp);
>> +out_kfree_trips:
>> +	kfree(trips);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_of_zone_register);
> 
> Daniel, I started seeing these memory leaks [1] since commit
> 613ed3f67609 ("hwmon: pm_bus: core: Switch to new of thermal API").
> Seems to be fixed by the following patch [2].
> 
> Do you already have a patch for this issue or should I submit it?

Thanks for reporting the issue. If you can submit it, that would be great



