Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A551DFD44
	for <lists+linux-pm@lfdr.de>; Sun, 24 May 2020 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgEXFFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 May 2020 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgEXFFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 May 2020 01:05:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EBEC061A0E
        for <linux-pm@vger.kernel.org>; Sat, 23 May 2020 22:05:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so3709384wml.1
        for <linux-pm@vger.kernel.org>; Sat, 23 May 2020 22:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yOIx32DzV9Yk/O3q4NLhph8Gyjxz3HGsJqmaZP5BXsg=;
        b=h0X98o+dRzjFWkvGg+RVmrUh81Ek8j36zAZtYtaLmx/I5qzSvxxpXToFKCvDnAmiwt
         4a8QEoW1hYjKF7mQxdP//+r98T0Saps4B16lcvA/xxDRC4tmjNyrddvVD21yllEM4WPX
         SA9Mh/jDUtVXRs8uN54riWl0nZGpRNVlApCSIXVIwlhmkGkRRN+zSxSSxHqHVANheISQ
         J42Wjgo0n/l6BipOl8pqdgbkAiglrtQso5igL+bn5ZS2Z1QYMNt9ZsLIemb6cZXoEMNc
         7QBoiRd2LMPeZmy+iu+2ZlnE6AKP4D87/XyLuRLPlN1K1KiXfEZX1iaEcHbtOUuvLYAi
         yrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yOIx32DzV9Yk/O3q4NLhph8Gyjxz3HGsJqmaZP5BXsg=;
        b=avKkC8RR0Yu/0QsUJsIWOt9RHokmzJE8XjpRljGKF80cnBljfEdl5iGwlz5scOnTYf
         TfgBsUF9tgOD4xv+qTY6+5Pw7tCPTEqT543UV9xd4qU31Kxs/CM1FGV9XjSjxo7wmzvD
         v0LXJLRqg3ON4KWPodCDl6XNDrSjd8LzysnQqSscCRe1AOEbXxzoq1xhWNPWekJ0sF4B
         1b8ntsdjdh4keqixVlR8MzPISJKQs7/emiH6k74/SIXtA0ZC3m0/OkjjCMCRnhnbWzpf
         8oZS+si6VtTSjRyFIfD4A3XbS1jQIuO7yvdTU+sY4kRdUrvOHeZpAFg3kCVCDzC8v5w/
         QSyg==
X-Gm-Message-State: AOAM532lN4AA012lzrRcEmgDBCgNywu/cM13HEq/jNcov4JvuLDfbeBK
        WEaIc5sTzaGwFMpNeFIMFf7wZw==
X-Google-Smtp-Source: ABdhPJy5BIy2yzNSXBycuVdf4capa9hemit9Tyinx3iO/bYzMEVC0j8+1ysL4G44A6HziAp/xv3PTw==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr21596506wmn.68.1590296738569;
        Sat, 23 May 2020 22:05:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c871:e070:f68d:a4f7? ([2a01:e34:ed2f:f020:c871:e070:f68d:a4f7])
        by smtp.googlemail.com with ESMTPSA id h1sm14766532wme.42.2020.05.23.22.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 22:05:37 -0700 (PDT)
Subject: Re: [PATCH V3] thermal: imx: Add missing of_node_put()
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1588128570-12917-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB391639FE30CD00F3371A0763F5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e824c7a9-91ba-b44c-8e3f-f6dc39d6ec0e@linaro.org>
Date:   Sun, 24 May 2020 07:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB391639FE30CD00F3371A0763F5B20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/05/2020 05:26, Anson Huang wrote:
> Gentle ping...

It is applied, sorry for not letting you know.

>> Subject: [PATCH V3] thermal: imx: Add missing of_node_put()
>>
>> After finishing using cpu node got from of_get_cpu_node(), of_node_put()
>> needs to be called, the cpufreq policy also needs to be put unconditionally.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> Changes since V2:
>> 	- call cpufreq_cpu_put() unconditionally after cooling register done.
>> ---
>>  drivers/thermal/imx_thermal.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>> index e761c9b..8764cb5 100644
>> --- a/drivers/thermal/imx_thermal.c
>> +++ b/drivers/thermal/imx_thermal.c
>> @@ -649,7 +649,7 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>> static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>> {
>>  	struct device_node *np;
>> -	int ret;
>> +	int ret = 0;
>>
>>  	data->policy = cpufreq_cpu_get(0);
>>  	if (!data->policy) {
>> @@ -661,20 +661,19 @@ static int
>> imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>>
>>  	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
>>  		data->cdev = cpufreq_cooling_register(data->policy);
>> -		if (IS_ERR(data->cdev)) {
>> +		if (IS_ERR(data->cdev))
>>  			ret = PTR_ERR(data->cdev);
>> -			cpufreq_cpu_put(data->policy);
>> -			return ret;
>> -		}
>>  	}
>>
>> -	return 0;
>> +	cpufreq_cpu_put(data->policy);
>> +	of_node_put(np);
>> +
>> +	return ret;
>>  }
>>
>>  static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data
>> *data)  {
>>  	cpufreq_cooling_unregister(data->cdev);
>> -	cpufreq_cpu_put(data->policy);
>>  }
>>
>>  #else
>> --
>> 2.7.4
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
