Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC564B18F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLMIxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiLMIxE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 03:53:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2CE237
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 00:53:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so7374856wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAZbVpH+4rlZi5jp+kZXBoZAg3Wr125V9u1eOjrijNs=;
        b=dI7ljjcMK7ppjpuQMGhQno0DFJX85cS6wsgD+jqktJ44Q91SvGKrwvDK1xrBkmFQgz
         yqo+lJgshbdVciztFOcFhef0vKiUnc9ghNLiV1lFDSgkZpVf6XBs9MSZLFPORQE8/26i
         x8BG8OSnicpImJ4qmvhPZMGcBtJJ1s30anH5y4N0v6SzSp56q09Feq7Vzbd9QJeVdTGO
         PIBCYIoitKq+caSG4BfPZjOSls+G5q/soE2oZYbzVOvY0I/YlV10NUXWdNJdwZICa5Td
         R7UFSh5aawZS2dmPXZISZE4vb5FZAM2Jgp22aZ0fr1Ui75epQuiwbpFZ19CPTh2x+2Ti
         HIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAZbVpH+4rlZi5jp+kZXBoZAg3Wr125V9u1eOjrijNs=;
        b=GDGqg/iS1mmNv6gijNVcJ+rmBnAboMVTbZGIvDAheChC4w5kx845axgE556VbTeUha
         2n6lRcNSsIByQ2ocaiCDANKRPiYrNYioP0Ab3E4t2IxOnKgGLwsR3K05wTlo48IGZ77O
         FVOFelWoN9sILRUPfRWhHPTQIqNv5vSzw2kCNY1iOjGZ0NHVesl/r5UVeEefLcDLBBdi
         4cy9e/kVXVd3/lebEW27jjpdbvHZdx6K34IXt6gLdo/soaDOufeqmECLqMBNeM/j7QtS
         cFyiRQ8lZ1IW3vckqQJMpDwpUYuGlB1PQsepuLAKytDT9H5CmdHq9pSm4wrb1QMPbQbw
         hAtw==
X-Gm-Message-State: ANoB5pmhCvyOQUe4eJ+UTIBUnqULwRNoXQstwk9tn3/0xopXiILylAhf
        6mFaoWV4YMHo1rjt9fbwGj5Cfg==
X-Google-Smtp-Source: AA0mqf4bCUfebiAdk23yk5k3St4jfXWJOatciul/DpE4cBadw1VXiZb9fPX4Svlj4Vxj3S3Gq3Jn3w==
X-Received: by 2002:a7b:ca49:0:b0:3c6:e63d:b8a2 with SMTP id m9-20020a7bca49000000b003c6e63db8a2mr14756675wml.17.1670921581350;
        Tue, 13 Dec 2022 00:53:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c19d100b003b4fe03c881sm13298706wmq.48.2022.12.13.00.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 00:53:01 -0800 (PST)
Message-ID: <e05db3d7-350c-6e41-7651-c39670743c7e@linaro.org>
Date:   Tue, 13 Dec 2022 09:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
 <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
 <20221213075440.x42flkgll4ousizy@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221213075440.x42flkgll4ousizy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/12/2022 08:54, Marco Felsch wrote:
> Hi Daniel,
> 
> On 22-12-13, Daniel Lezcano wrote:
>> On 12/12/2022 23:02, Uwe Kleine-König wrote:
>>> A remove callback just returning 0 is equivalent to no remove callback
>>> at all. So drop the useless function.
>>
>> AFAIU, without the remove callback the module can not be unloaded, no?
> 
> This should be unrelated according:
> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L1419

Indeed :)

>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>    drivers/thermal/imx_sc_thermal.c | 6 ------
>>>    1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
>>> index 5d92b70a5d53..4df925e3a80b 100644
>>> --- a/drivers/thermal/imx_sc_thermal.c
>>> +++ b/drivers/thermal/imx_sc_thermal.c
>>> @@ -127,11 +127,6 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
>>>    	return 0;
>>>    }
>>> -static int imx_sc_thermal_remove(struct platform_device *pdev)
>>> -{
>>> -	return 0;
>>> -}
>>> -
>>>    static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
>>>    static const struct of_device_id imx_sc_thermal_table[] = {
>>> @@ -142,7 +137,6 @@ MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
>>>    static struct platform_driver imx_sc_thermal_driver = {
>>>    		.probe = imx_sc_thermal_probe,
>>> -		.remove	= imx_sc_thermal_remove,
>>>    		.driver = {
>>>    			.name = "imx-sc-thermal",
>>>    			.of_match_table = imx_sc_thermal_table,
>>>
>>> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>>
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

