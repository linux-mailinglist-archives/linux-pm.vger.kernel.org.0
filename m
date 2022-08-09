Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D503658DB3B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Aug 2022 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiHIPhv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Aug 2022 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244940AbiHIPh0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2022 11:37:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5835597
        for <linux-pm@vger.kernel.org>; Tue,  9 Aug 2022 08:37:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j15so14767719wrr.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=A8f8AXcn46eg5Xdy6reWOlVNk4yWLMkAOY5qgsZS1Hw=;
        b=PeZW1Ndo+Vc+0qgJ9v55bzTY0riGk25YGWF0pHiZTyBtsqOLlPi3xMplbKC1pnC//d
         3o6a3NhhhaXMxFIV5JEYTVXk2H5zKbmXKI4J7B0bN/sD38OnaQqu0Y7m5T34KVyglWrZ
         tkoIGhTRVNeY6Yjvi0KVjeIdAJhom1FZudfbtsEJ7RxGn6KXw2usTRyeRop2kVXkhdmm
         IvTZkA4h5We6V0MiIiaFQ+gwJzE7UzzfyY9lA/3O3gO1gJaUQ33Dx7LdxtOXgi0wariK
         ngPY1AF09FYppz8zXqYfnRjZtILEWRHuObNdBJXk9yh8ZazbDpbRSOX5nrXjfVl741n5
         6YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A8f8AXcn46eg5Xdy6reWOlVNk4yWLMkAOY5qgsZS1Hw=;
        b=7QoBSK69lyhXjfcBIKPre8AHiINKMVcsNFkepq6HTmcKptIjfSBisMWcQJ+B/Zwsvy
         BAE6K1YLq5n/sWruRqPrjvTWOfJ3rs0rkje+KNvb2jgIEC4LtPsGYUVD9hi0Cd7WnQ0J
         NUbTB7MYDmOrg6hVcxt/jg8PxnTkalios8jwtAWNHj+L55mMjeI7uYH6D4Z212ak9m1c
         71fh5OxIbjJ6s7ndkPH+HSTyyM83r9dfoVC7XTW0sHJ2IB6n7Qr1hsDZ/V2BoqZkPodn
         GPB5lNzjpHTE7FwDWKezGYlQJE0oMGhRzX9CZ69n4hKmu8WJrNCB7jsVWWIdFUvtzh9p
         l1iQ==
X-Gm-Message-State: ACgBeo2LXVpBEhYMvxTUNKnYg1GhCpSQHHV2oHwGXBWeCLz4dviGKr5C
        HEwDB82UrapfVWTrpO826EGt0g==
X-Google-Smtp-Source: AA6agR5UZ842ZznQyZ71kFFKy889anCdQIM3c3LWzRaSKSzAuiF1OnSmf1qsEywAmE/gS2A4+nkrYA==
X-Received: by 2002:a5d:59af:0:b0:220:6daf:5f64 with SMTP id p15-20020a5d59af000000b002206daf5f64mr14805476wrr.192.1660059441332;
        Tue, 09 Aug 2022 08:37:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm12936540wrh.82.2022.08.09.08.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:37:20 -0700 (PDT)
Message-ID: <53d33f48-1774-3a0e-a84e-a8027679ea5a@linaro.org>
Date:   Tue, 9 Aug 2022 17:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Walle <michael@walle.cc>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <20220808102610.GA1969424@roeck-us.net>
 <829788a5-3da4-8638-a587-9e80e2fd3fea@linaro.org>
 <6318d099-268b-1bbe-fed8-4f4b356e90cb@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6318d099-268b-1bbe-fed8-4f4b356e90cb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/08/2022 16:32, Guenter Roeck wrote:
> On 8/9/22 01:53, Daniel Lezcano wrote:
>> Hi Guenter,
>>
>> On 08/08/2022 12:26, Guenter Roeck wrote:
>>
>> [ ... ]
>>
>>>> But I guess even if that is fixed, the driver will not probe due to the
>>>> missing trip points? Are they now mandatory? Does it mean we'd need to
>>>> update our device trees? But that will then mean older devices trees
>>>> don't work anymore.
>>>
>>> It would also mean that all hwmon drivers registering a thermal zone 
>>> sensor
>>> would fail to register unless such a thermal zone actually exists. 
>>
>> Probably missing something but if the thermal zone is not described, 
>> the hwmon driver won't initialize. And except if I'm wrong, that was 
>> already the case before these changes, no?
>>
> 
> In the hwmon source (you point to it below):
> 
>          if (IS_ERR(tzd)) {
>                  if (PTR_ERR(tzd) != -ENODEV)
>                          return PTR_ERR(tzd);
>                  dev_info(dev, "temp%d_input not attached to any thermal 
> zone\n",
>                           index + 1);
>                  devm_kfree(dev, tdata);
>                  return 0;
>          }
> 
> That contradicts "if the thermal zone is not described, the hwmon driver 
> won't initialize".
> Now I must be missing something, since you mention that yourself below, 
> and your new patch
> series fixes the problem, at least AFAICS. Confused.

Sorry for not being clear. Let me try to explain it differently.

The function hwmon_thermal_add_sensor() is calling:


Without "[PATCH v5 00/33] New thermal OF code":
-----------------------------------------------

   devm_thermal_zone_of_sensor_register(dev, index, ...);

If there is no thermal zone description or the 'dev' does not belong to 
any thermal zone then -ENODEV is returned -> OK and the hwmon thermal 
zone is _not_ created



With "[PATCH v5 00/33] New thermal OF code":
--------------------------------------------

  devm_thermal_of_zone_register(dev, index, ...);

If there is no thermal zone description or the 'dev' does not belong to 
any thermal zone then *-EINVAL* is returned -> NOK, error message, and 
hwmon thermal zone is _not_ created



With "[PATCH v5 00/33] New thermal OF code" + fixes:
----------------------------------------------------

  devm_thermal_of_zone_register(dev, index, ...);

If there is no thermal zone description or the 'dev' does not belong to 
any thermal zone then *-ENODEV* is returned -> OK and the hwmon thermal 
zone is _not_ created


Quoting your initial message:

"It would also mean that all hwmon drivers registering a thermal zone 
sensor would fail to register unless such a thermal zone actually 
exists. This would make the whole concept of having the hwmon core 
register thermal zone sensors impossible [...]"

The thermal zone must be described if the OF registering function 
variant is used. Except I'm wrong that was already the case before the 
changes.

Otherwise, nothing prevents a hwmon to register itself with the core 
code, that will create the thermal zone.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
