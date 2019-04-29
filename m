Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A2CDE0D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfD2IhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 04:37:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbfD2IhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 04:37:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so6212916wrs.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agVhEcGJdzb8562le7X/E/t0SK2Qx5M+g8VydHvaGpw=;
        b=lq16odbprAohUmfTfhpjj8gwQRF2zrgU+73q9yPr0yG1qXQSw9Y7XOZsEOUnZYLB8n
         bvjiUbNiaOHWyCSsvx+cjQO9j6VVI1/sDo3QurO40SfgaqzS8+ASyI+HnSsquqyfFDS0
         RMO350H6EJk48pioJ1cXZgOyGcdJ4urzFvWywO30B6hjh+IAaUDlrlsqpYCvYpdnHF0q
         BTtbRhipt48ijn6jptwQOEraWz8ywX0GQ48qehCgr7x7gmm4N2rJJmLrbTM4KZ/D5Bbj
         4viIXdZwwnzpDOa0o2YYeQjbIJJyFokSGwUp0AhdA1++XCkQaajIy8Zam2AYpt6VzrxF
         9CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agVhEcGJdzb8562le7X/E/t0SK2Qx5M+g8VydHvaGpw=;
        b=GraX1d521gm7AtIQc3FCk2wAO15Kgzma32PxuaqrdKbLIF8LWOgQnuTgP8YrY9nZnl
         2uEWYTvfxXcdEK+EsX6EcFJ1JYn4fQ1FmJ63j34yXkTVQBk30Lna88BGEQ3UZecdgqM9
         ryMYSjTndB50jInQz8Mt4fGPo3sr6cYlsS0beQag8erGnWRVCzVWwxSfEDmpXMscKS2v
         38FRqkn6R31hFcFPd/1DlR1qYe8IDrQKV1yTbLYKBharFIBVe41H/JkcMdMF1zeVc8ih
         Ugs5SYRC2KfNMwWUUXPtwXMHc8r8ECm1abixG31bG6NW/HI5wu9WUkPkHsDxNSkQP2Dh
         aAiw==
X-Gm-Message-State: APjAAAVzYrPZAQN59FwrXl4LVSALHLTSrfCNOuXYpTAXehH739V/1qtg
        HIm8yGg47t54XyO4Q/AWUc84MQ==
X-Google-Smtp-Source: APXvYqzOyqpOYA4BkuCjFmiDaYK22kcc5UFlaSUyptCSLjIeOdwpilmAXSobxLWvkP1nEd/Rgw7HDQ==
X-Received: by 2002:a05:6000:1108:: with SMTP id z8mr4892366wrw.317.1556527029587;
        Mon, 29 Apr 2019 01:37:09 -0700 (PDT)
Received: from [192.168.0.41] (129.201.95.92.rev.sfr.net. [92.95.201.129])
        by smtp.googlemail.com with ESMTPSA id y70sm7766358wmc.8.2019.04.29.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 01:37:09 -0700 (PDT)
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
 <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a7b26683-0514-fd58-f5b1-d9128e490b84@linaro.org>
Date:   Mon, 29 Apr 2019 10:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/04/2019 07:43, Viresh Kumar wrote:
> On 28-04-19, 11:51, Daniel Lezcano wrote:
>> The copyright format does not conform to the format requested by
>> Linaro: https://wiki.linaro.org/Copyright
>>
>> Fix it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Viresh Kumar <viresh.kumar@linaro.org>
> 
> What exactly have I done here ? :)

Argh!

Thanks for spotting it.


>> ---
>>  drivers/thermal/cpu_cooling.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index ee8419a6390c..42aeb9087cab 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -2,9 +2,11 @@
>>   *  linux/drivers/thermal/cpu_cooling.c
>>   *
>>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
>> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>>   *
>> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
>> + *  Copyright (C) 2012-2018 Linaro Limited.
>> + *
>> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
>> + *		Viresh Kumar <viresh.kumar@linaro.org>
>>   *
>>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   *  This program is free software; you can redistribute it and/or modify
>> -- 
>> 2.17.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

