Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE919552137
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbiFTPhP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiFTPhO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 11:37:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155515FCB
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:37:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ej4so11706138edb.7
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rKs1d2vkDI5mFyd8YnUM+5H6GgVUPfSlSckLrJWjud0=;
        b=Fe0GSqhWe9eTXTVLLz1n+pRkr2nN92iFMO7IwVlrQHb/n/O/S229BToHeicXgTpXrM
         eygUfXKrjLon1dYoUNSbRTbTpgM/8iO0Vaqqn80XyNkobgCurWUdijJ9I3TmwlcLhSK8
         p9/y8SRcZNR+gToKm10R+b+IfZtkT5yOU9Av0x2LHDTEZyYXv4ChSygmuEBB439/pSgz
         3Xfh4ZCnTOMxcjaMJaeTAeGCq0BQkNDV2uSUlHefUwuy+VN+mG8q6IdJowrkClZClx1p
         c9R5GQzzBYFXaQAxGIR0Ix37NvTIMmIgqq5BMnVc6ICSg2vVUwdJERJ1WRGDKDQ7Ss+g
         Dl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rKs1d2vkDI5mFyd8YnUM+5H6GgVUPfSlSckLrJWjud0=;
        b=fajFmgzcXH0Biy1Orvi9fsfpSA7sUCUjV9b3bCe5ozrivOgc+0bm2E7ZWUcXea5rnc
         UAMy5oLs+QDk9eEKXLbtMJcdPwYslGA15NZkQ/CCVvNOtqiZdtM+I3AkWzncOSQxjfaQ
         QwxC5evP58/+w75qffU2N1GLC7IhR3k1Tl/q0Ve6g9GQt2C+eg5yr14HzoJWN45b7JPu
         Md7uAf6OXIV38RBi8YaM+XvjIwB+Btvg+q/9wSq6p4Ites8+O0N0nWUk31UsoN3WAZoJ
         J5Foxz3mIrF4tgAvr+yODBxCTM3iIn5jmNJDLxmB2GeQBeltYikL9YyLjcAwu0lnJqvM
         PgqQ==
X-Gm-Message-State: AJIora9JxfURJpXI4EunxeLEpzKFAaXo5hZMpugwEI1AYJP04AVaiaCG
        YFjfyntWOAISQsZIFhZLlh0=
X-Google-Smtp-Source: AGRyM1u7dzuQLXUIjf1pmLPwxSZm4QUtECpkliEB6ppHXLJKZEp7qDfMTWogqsG1j7JjDb+67VdLbA==
X-Received: by 2002:a05:6402:2548:b0:42d:dd95:5bfe with SMTP id l8-20020a056402254800b0042ddd955bfemr30193903edb.285.1655739431915;
        Mon, 20 Jun 2022 08:37:11 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b006fe0abb00f0sm6126653eje.209.2022.06.20.08.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:37:10 -0700 (PDT)
Message-ID: <fd8d057c-8531-f7df-55e2-023b8757e867@gmail.com>
Date:   Mon, 20 Jun 2022 17:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] PM / devfreq: mediatek: Fix possible dereference of null
 pointer
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org,
        dan.carpenter@oracle.com, johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220617133330.6510-1-matthias.bgg@kernel.org>
 <25da54a7-3fc1-39c2-ed93-0ad72ce54e11@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <25da54a7-3fc1-39c2-ed93-0ad72ce54e11@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20/06/2022 16:21, AngeloGioacchino Del Regno wrote:
> Il 17/06/22 15:33, matthias.bgg@kernel.org ha scritto:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> We dereference the driver data before checking of it's valid.
>> This patch fixes this, by accessing the PLL data struct after cheching
>> the pointer
>>
> 
> Hello Matthias,
> 
> honestly, I don't think that this commit is right: mtk_ccifreq_target() is the
> devfreq_dev_profile's .target() callback!
> 
> Checking mtk_ccifreq_probe(), we are setting drvdata long before adding the
> devfreq device so, actually, it's impossible for dev_get_drvdata(dev) to return
> NULL, or whatever invalid pointer.
> 
> This means that the right thing to do in mtk_ccifreq_target() is to simply remove
> the `drv` NULL check, as this can never happen! :-)
> 

Yes you are right. Probe will error out if drv can't be allocated or cci_clk 
isn't present. I'll send a new patch.

Thanks,
Matthias

> Cheers,
> Angelo
> 
>> Fixes: 07dc787be231 ("Add linux-next specific files for 20220617")
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/mtk-cci-devfreq.c 
>> b/drivers/devfreq/mtk-cci-devfreq.c
>> index 71abb3fbd042..77522f16c878 100644
>> --- a/drivers/devfreq/mtk-cci-devfreq.c
>> +++ b/drivers/devfreq/mtk-cci-devfreq.c
>> @@ -127,7 +127,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned 
>> long *freq,
>>                     u32 flags)
>>   {
>>       struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
>> -    struct clk *cci_pll = clk_get_parent(drv->cci_clk);
>> +    struct clk *cci_pll;
>>       struct dev_pm_opp *opp;
>>       unsigned long opp_rate;
>>       int voltage, pre_voltage, inter_voltage, target_voltage, ret;
>> @@ -138,6 +138,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned 
>> long *freq,
>>       if (drv->pre_freq == *freq)
>>           return 0;
>> +    cci_pll = clk_get_parent(drv->cci_clk);
>>       inter_voltage = drv->inter_voltage;
>>       opp_rate = *freq;
>>
> 
> 
