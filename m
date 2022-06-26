Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4855B31D
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jun 2022 19:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiFZRdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jun 2022 13:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFZRdO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2022 13:33:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC06572
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 10:33:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s1so9928698wra.9
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2022 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LVyzL8mphbtENNv7Ak5Yb4fzhkW9NpbRag7uI4Hacxc=;
        b=CixvAORRF/ukN2FEZzF3AXwjYn0QSsLkd38tK+4yJetZJEOD2q8BWdl+K7blkYG7QX
         PEpxd9kqTN2VWUXcz4YD/IK4r7df6FMK1XmJ0tM6GJBIgNOaTzoUXLdb0Hle84111G9o
         PEcdOK/tcVBUK/beyvIgVjBuqREmne+JuyFWCO/FfnY/agQm+R8Qf8mdpKl+YSiiVc6D
         warzD6uHfDCskO3OxQ41n/NxKpV0jX6Lm3HwMpdQWZangXskbf0W6LW/iOMuDxXv5+n9
         tur8NsPqRiFwF1WgpEzx5KFrcp5JtHOeGJzYbiubnZrrT7cSPNOvq+v99yOHeGHnva84
         muQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LVyzL8mphbtENNv7Ak5Yb4fzhkW9NpbRag7uI4Hacxc=;
        b=Ew4aHsP54ctJd373GZEl6c/apW0NxvDG3cUPt/tsrwn/2Fb/uWREe6HNeDcEI2uv2Y
         mornBP8LgKM8MA+DwvbG8iVxUCqhkn9HdhIBx1fcT0FAm9c01aVvNXa/kv52OZumCD5o
         4rgSGVn+oioITNWuz/vD4ImZNKO4mRVU4pvbYBC/qdu8JoweWhuyvyh7L4OYLNjX+3CX
         z2DePfdKbHQD7JkHModWklD5nAcjHyroRhD6pDfIxSAnzh61GFQ/g13NHf2qmF4/4JJR
         6OO2LYr0L7PizpAE3UzhFa22I9Y/srqSejEEUGnxt6a96fQRxXzQ5S/w7w1uaVFLCFFX
         qJow==
X-Gm-Message-State: AJIora8H3lYQs6x9cOoeEPHL1NcYvkiHR3D+5bauO6iyA3lK3v1PUWJE
        7IM9jaTe/dE6HZoq7w5p+CUefQ==
X-Google-Smtp-Source: AGRyM1sT+QzEds/eFmu00keheN6WbaWKP57czuiPSPRTt3/jN3GsXQ0byLphmAqRpiPIai9t45cykg==
X-Received: by 2002:a5d:6ac4:0:b0:21b:a724:1711 with SMTP id u4-20020a5d6ac4000000b0021ba7241711mr8495754wrw.80.1656264790204;
        Sun, 26 Jun 2022 10:33:10 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c11-20020a05600c0acb00b00397342e3830sm11310979wmr.0.2022.06.26.10.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 10:33:09 -0700 (PDT)
Message-ID: <43b1c2fd-b746-84eb-c82b-23f1bd39242e@linaro.org>
Date:   Sun, 26 Jun 2022 19:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 01/14] thermal/core: Change thermal_zone_ops to
 thermal_sensor_ops
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>, Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Antoine Tenart <atenart@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>,
        "open list:CXGB4 ETHERNET DRIVER (CXGB4)" <netdev@vger.kernel.org>,
        "open list:INTEL WIRELESS WIFI LINK (iwlwifi)" 
        <linux-wireless@vger.kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
 <20220507125443.2766939-2-daniel.lezcano@linexp.org>
 <CAJZ5v0ik_JQ4Awtw7iR68W4-9ZL8FRDsDd-kWmL-n09fgg3reg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ik_JQ4Awtw7iR68W4-9ZL8FRDsDd-kWmL-n09fgg3reg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

sorry for the delay, I was OoO.

On 17/05/2022 17:42, Rafael J. Wysocki wrote:
> On Sat, May 7, 2022 at 2:55 PM Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
>>
>> A thermal zone is software abstraction of a sensor associated with
>> properties and cooling devices if any.
>>
>> The fact that we have thermal_zone and thermal_zone_ops mixed is
>> confusing and does not clearly identify the different components
>> entering in the thermal management process. A thermal zone appears to
>> be a sensor while it is not.
> 
> Well, the majority of the operations in thermal_zone_ops don't apply
> to thermal sensors.  For example, ->set_trips(), ->get_trip_type(),
> ->get_trip_temp().

The set_trips is necessary to set the sensor interrupt to fire when the 
trip temperature is crossed the way up or down.

>> In order to set the scene for multiple thermal sensors aggregated into
>> a single thermal zone. Rename the thermal_zone_ops to
>> thermal_sensor_ops, that will appear clearyl the thermal zone is not a
>> sensor but an abstraction of one [or multiple] sensor(s).
> 
> So I'm not convinced that the renaming mentioned above is particularly
> clean either.
> 
> IMV the way to go would be to split the thermal sensor operations,
> like ->get_temp(), out of thermal_zone_ops.

Probably, we should first replace all the calls to ops->get_temp with a 
function. Then create the ops for the sensor:

  - get_trend
  - get_temp
  - set_trips
  - bind / unbind

> But then it is not clear what a thermal zone with multiple sensors in
> it really means.  I guess it would require an aggregation function to
> combine the thermal sensors in it that would produce an effective
> temperature to check against the trip points.

Yes, that is why the above ops->get_temp should be wrapped into a 
function which can evolve to an aggregation function.

> Honestly, I don't think that setting a separate set of trips for each
> sensor in a thermal zone would make a lot of sense.

I agree the set_trips is for the interrupt mode only.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
