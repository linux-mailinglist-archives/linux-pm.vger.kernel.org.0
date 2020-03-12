Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65374182FA7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCLL4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 07:56:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52941 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLL4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 07:56:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so5782228wmo.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJDNkkMyLt++MfdE5QeVh3NFRRpIPEAcEdxBqUZos50=;
        b=xXDxDK6K7pQfhlQCDH3+o4d1FUuXvdvhP9UNBUpOBIRcMjDY8VAWK6tmjTCb0Ret0Y
         ZRbRgAB8iqebfQwvLM4y6YE3TGDqrd+z1YpoYQvoXz9N4mEAYM+fK0fNJOgkzMTfFA7a
         LdoHJfvbhta1YDdjBOfsp5vuPdrxlxZ0/MGBmlDWjN8SbBj350FFyQuaV+No0oOnBmES
         Po32DfaW8HYX90leCS7n5s7xshLVd3GDNAgBWkcWb/M+5Z2gAbGshc+m1TD08LZUMxTn
         OJ6uICHKITesdt2082Owu2qdzcpkW4nXfBpRuCvcAO0VlFLsRDYzR8ne/AYYVRfkYTkC
         uhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rJDNkkMyLt++MfdE5QeVh3NFRRpIPEAcEdxBqUZos50=;
        b=Oy5WAAbfICDJJ1bMKcau6mdpC/ut1xm0tqRErMXfLRTg4E9CL2BRvQbuxe2Z3rxF/Q
         CB0r1ZSX6j4Rlw33GvoykkkNX4+XaNStTgFZommjNgzacc0rULZ5P/PQBuvos3DUYbYf
         YC449sfug+RkBQ5Pb1K6zMFsrAY8QqNJItO/g5MHBmO0FuptHdEvuCqJh+AT+jeJbWsA
         jAUa7rciuH9BGXWBvtwyjIA9LW2/p1r/Wni1zWlqcuU4LwP3m3NLxgNQlKAqR8hruZ+r
         vX58WY1tEMSQymmgI7HCJdJ9owI/p/I4LcsYAHV6y42aPEng750FsGqQQZkI+j38HEt2
         I4Yw==
X-Gm-Message-State: ANhLgQ2xB9ZxGe2/gTp+lw1+sqspEQitFVOQxEDsJksKBkc9qbTSWB+d
        DGzF/6QH2f2kES0h2lUofzSaaw==
X-Google-Smtp-Source: ADFU+vuzPrEVi/rhEsv9TKRmP5aW5jSY602qVUSZDPO0D9y9+9vxyIdnLl0Zh97fA10d8OVZJVB2Tg==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr4026270wmd.132.1584014200594;
        Thu, 12 Mar 2020 04:56:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f? ([2a01:e34:ed2f:f020:3880:fdc2:ef6b:879f])
        by smtp.googlemail.com with ESMTPSA id s2sm11865196wmj.15.2020.03.12.04.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:56:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
 <c4c2d976-4fe6-bdf3-e110-90d1600566a3@linaro.org>
 <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <831cd71d-04dc-834f-fa28-6091a186dce3@linaro.org>
Date:   Thu, 12 Mar 2020 12:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916BF7EF180809EC374CC7CF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2020 12:47, Anson Huang wrote:
> Hi, Daniel
> 
>> Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
>> handle all cleanups
>>
>> On 11/03/2020 06:07, Anson Huang wrote:
>>> Use devm_add_action_or_reset() to handle all cleanups of failure in
>>> .probe and .remove, then .remove callback can be dropped.
>>
>> Is this change compatible with the tristate?
> 
> I think so, any concern need me to double confirm?

TBH, I discovered the function with your patch. My concern is if the
callback is called when unloading the module.


>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>>  drivers/thermal/qoriq_thermal.c | 35
>>> ++++++++++++++---------------------
>>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index 874bc46..67a8d84 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -228,6 +228,14 @@ static const struct regmap_access_table
>> qoriq_rd_table = {
>>>  	.n_yes_ranges	= ARRAY_SIZE(qoriq_yes_ranges),
>>>  };
>>>
>>> +static void qoriq_tmu_action(void *p) {
>>> +	struct qoriq_tmu_data *data = p;
>>> +
>>> +	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>>> +	clk_disable_unprepare(data->clk);
>>> +}
>>> +
>>>  static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>>  	int ret;
>>> @@ -278,6 +286,10 @@ static int qoriq_tmu_probe(struct platform_device
>> *pdev)
>>>  		return ret;
>>>  	}
>>>
>>> +	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>  	/* version register offset at: 0xbf8 on both v1 and v2 */
>>>  	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
>>>  	if (ret) {
>>> @@ -290,35 +302,17 @@ static int qoriq_tmu_probe(struct
>>> platform_device *pdev)
>>>
>>>  	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
>>>  	if (ret < 0)
>>> -		goto err;
>>> +		return ret;
>>>
>>>  	ret = qoriq_tmu_register_tmu_zone(dev, data);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "Failed to register sensors\n");
>>> -		ret = -ENODEV;
>>> -		goto err;
>>> +		return ret;
>>>  	}
>>>
>>>  	platform_set_drvdata(pdev, data);
>>>
>>>  	return 0;
>>> -
>>> -err:
>>> -	clk_disable_unprepare(data->clk);
>>> -
>>> -	return ret;
>>> -}
>>> -
>>> -static int qoriq_tmu_remove(struct platform_device *pdev) -{
>>> -	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>>> -
>>> -	/* Disable monitoring */
>>> -	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
>>> -
>>> -	clk_disable_unprepare(data->clk);
>>> -
>>> -	return 0;
>>>  }
>>>
>>>  static int __maybe_unused qoriq_tmu_suspend(struct device *dev) @@
>>> -365,7 +359,6 @@ static struct platform_driver qoriq_tmu = {
>>>  		.of_match_table	= qoriq_tmu_match,
>>>  	},
>>>  	.probe	= qoriq_tmu_probe,
>>> -	.remove	= qoriq_tmu_remove,
>>>  };
>>>  module_platform_driver(qoriq_tmu);
>>>
>>>
>>
>>
>> --
>>
>> <https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
>> linaro.org%2F&amp;data=02%7C01%7CAnson.Huang%40nxp.com%7C37ea3
>> 145642b47b4df7208d7c677e57d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
>> C0%7C0%7C637196090558448813&amp;sdata=%2FCfH8GPxd57CDlau1pMcq
>> LH7GjGIh%2Fu%2Bfq7teGsS8KM%3D&amp;reserved=0> Linaro.org │ Open
>> source software for ARM SoCs
>>
>> Follow Linaro:
>> <https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
>> facebook.com%2Fpages%2FLinaro&amp;data=02%7C01%7CAnson.Huang%4
>> 0nxp.com%7C37ea3145642b47b4df7208d7c677e57d%7C686ea1d3bc2b4c6fa
>> 92cd99c5c301635%7C0%7C0%7C637196090558448813&amp;sdata=KBUWpT
>> 4quqo08r8YhbMVk%2Fyf2jIT1CKgc5i3jI9gCwo%3D&amp;reserved=0>
>> Facebook |
>> <https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Ftwitte
>> r.com%2F%23!%2Flinaroorg&amp;data=02%7C01%7CAnson.Huang%40nxp.c
>> om%7C37ea3145642b47b4df7208d7c677e57d%7C686ea1d3bc2b4c6fa92cd9
>> 9c5c301635%7C0%7C0%7C637196090558448813&amp;sdata=%2FEgeRMWd
>> qbbaOMl2Tfb%2BtLmfttqN1WcFbl9%2B5tXtOic%3D&amp;reserved=0>
>> Twitter |
>> <https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
>> linaro.org%2Flinaro-
>> blog%2F&amp;data=02%7C01%7CAnson.Huang%40nxp.com%7C37ea314564
>> 2b47b4df7208d7c677e57d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>> C0%7C637196090558448813&amp;sdata=SXZow%2F0B%2BIgpfOfAUIG1NsR
>> mcHp868ve%2Ffkejg3ZDvE%3D&amp;reserved=0> Blog
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

