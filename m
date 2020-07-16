Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624E02229CA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGPRYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 13:24:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45EBC061755;
        Thu, 16 Jul 2020 10:24:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so8829090ljp.6;
        Thu, 16 Jul 2020 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TfS7LyRCXVJhAiKAI60mtJsvFYqMMExakCfeA+dafDM=;
        b=eM8ekbItJW22+el3tFcXdtmsEzXxaWo+v6DoYGR+lHLcxpMrIw6BSmqbLFZuvBQCnP
         ihgIeMTx/RwwePD4TZPTuLJNnVniE6M2JA6JRs/Z5LSiyLgsXgK5r1fMatkB7XlxtiMo
         3z+nQWADtsOAq0xfUHYY01jMmos2tG4alSasWCmc8GgvtDVvANIO2YSojigeralZrqtb
         Q1mocK8zXSulFDuw07bNDAHVtmzcBS5Uh0UNN85JGqqIIpNgNmOE6hQKo7DyvZJgM/kt
         ENCUDy7STEgc/m8gghs+h2tiDOA4dRIQ1TjyZ9oAJwNTMp5kLMlreM8ptAYX4PROIWy6
         paLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TfS7LyRCXVJhAiKAI60mtJsvFYqMMExakCfeA+dafDM=;
        b=Nnt0e1QcJRzeevhyt86k1JJsXSxALfypUn4SlbzJoxskir6YBfL9iaA4CIZDRdY//e
         xdfC32mEZfWfoR2sMMGsa1oe6N7eeH4uRphY12uGmrZ5ImRWQHhX9Hm1zopOUV9/Yc94
         gjrXzQ+AhbnUSzLQkeZMMYhf0Ga1yZHU7PrPG1Y2YcYcYvwLE7KJOZFp2CmBLeytHx23
         yoBFD8BcqNdgkYbfU8Q48d8SL31dgu/xXiYnQa1iJSiwQieVdVE8VCmCSxZ8u/6lhX2p
         WvhZKFId8UPkTK7AB3C0Kuav6ijfXXno0EONikaqbDg3Q/6B9ULRGa8dJF0tbFRxYzZF
         ruXA==
X-Gm-Message-State: AOAM531fAGpqMKiXUrdslEWz0Ck+pT3DWHOOz5s7k1xzNyvBrzOS87V7
        rQbSJF1jyEmVXTHTIYPuadE=
X-Google-Smtp-Source: ABdhPJyBMa6/+CjZyZQ5I2muOOpdMwm+gbfhNF3ZsDHyDvdDeGLecmbLcuuKS3MxkhnDxlIVqNNcxw==
X-Received: by 2002:a2e:8157:: with SMTP id t23mr2533932ljg.417.1594920280350;
        Thu, 16 Jul 2020 10:24:40 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id u26sm1556349lfq.72.2020.07.16.10.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 10:24:39 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] dt-bindings: battery: Add temperature properties
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
 <20200607144113.10202-3-digetx@gmail.com> <20200713234604.GA935472@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b84d818-11d3-05b9-fc45-29a0cb490edd@gmail.com>
Date:   Thu, 16 Jul 2020 20:24:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713234604.GA935472@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.07.2020 02:46, Rob Herring пишет:
> On Sun, Jun 07, 2020 at 05:41:06PM +0300, Dmitry Osipenko wrote:
>> Document generic battery temperature properties.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt       | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> 
> This is close to being converted to schema:
> 
> https://lore.kernel.org/linux-pm/20200707212914.31540-1-r-rivera-matos@ti.com/

Thanks! I'll keep an eye on this patch.

>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 5e29595edd74..e0c35eff9d3f 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -45,6 +45,16 @@ Optional Properties:
>>     and corresponding battery internal resistance percent, which is used to look
>>     up the resistance percent according to current temperature to get a accurate
>>     batterty internal resistance in different temperatures.
>> + - temperature-ambient-min-alert-celsius: Alert when ambient temperature of a
>> +   battery is lower than threshold value.
>> + - temperature-ambient-max-alert-celsius: Alert when ambient temperature of a
>> +   battery is higher than threshold value.
>> + - temperature-min-alert-celsius: Alert when battery temperature is lower
>> +   than threshold value.
>> + - temperature-max-alert-celsius: Alert when battery temperature is higher
>> +   than threshold value.
>> + - temperature-min-celsius: minimum temperature at which battery can operate
>> + - temperature-max-celsius: maximum temperature at which battery can operate
> 
> Perhaps 'temperature' is redundant since we have units.
> 
> Perhaps do <min max> properties given specifying only min or max is 
> probably not valid?

Thank you for the suggestions, I'll consider them for the v3!
