Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E353A40CC92
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhIOScw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOScv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 14:32:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD2C061574;
        Wed, 15 Sep 2021 11:31:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so2739614pjv.3;
        Wed, 15 Sep 2021 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=08DeS9EiRSwxDI4M4feIzMG6iv/hhxkj2trxtcVNueQ=;
        b=Isi3v0awJAXImI6JZWmC2kzZ2bkcEcvasEWWr1Uwi7NiCeP1wfXBbJyVpuoNNsT83w
         9G3l42sCUrp77DZ8jyzZ66n3ectwAAYzhrpHdrta/QUXVwpVvOvpBD+ex10WXp3547D5
         dYzYd+llFo3ThINzmwFJjHDKFJ8ZT1gVZA85RaEgFQig0FG+hncm7Ds2IGHfQfXyzKry
         hL7+FVZ68T7LQZ0PkhY5CNGH46poBUWWUMfD7Xn1ZtqIBkZFxdlmLd6HKN78ivbF8Sbd
         AjvhNQ4yjsQ00LoIP3uwA25RKdcMFKevf1GwgqNKMTJplhV5+rnPgl13Iy9CtTeb/T+O
         mEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=08DeS9EiRSwxDI4M4feIzMG6iv/hhxkj2trxtcVNueQ=;
        b=wSj7ozeKkv3JwozN0N04h5F/DSrrHfxR8jGp7Ov+qmIeEleweX1Nf3VLg68FZXAOlG
         m4RVnHrIKCsao2ggektZgf51z4zg8iwwhV8EUHK2rUBBzEgD3txKbmNR8/pg5s9V2I1c
         x2FKaneENuug52pu5buLcOKYW+jpQDkVTCuC+2CF9yM9UUsp1Jn6JCNuiWF2/DWYwZB9
         ltnvYXyppzoe0v+tUQQhNy9WmFiuzuu8Zku5V3fz/OIU3UnsKRqorrPTMdtxYAwm3/GQ
         luhd86/qXLrV4Jml258eHwTgE6ZA0TyjYTXtD4rlSSAWd8Tum96gUbEamwxDxqsHn7er
         or3g==
X-Gm-Message-State: AOAM530unkEbjcZjbYWlTPgxpIk1J049yajOO0FX03Vbi48B+27SOYGf
        sHpjhVdMsJtwcSqmm5fvm29+TNCb3AH1gg==
X-Google-Smtp-Source: ABdhPJy5KgIo85Vx7NQj8y/nMacZJHdmDudSZt0KB1Xp/n7LV+TMPprGRN6sVBeMfcqm6mepY5u9hg==
X-Received: by 2002:a17:90b:1c0c:: with SMTP id oc12mr7891665pjb.45.1631730691859;
        Wed, 15 Sep 2021 11:31:31 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id s192sm657273pgc.23.2021.09.15.11.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:31:31 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PM / devfreq: tegra30: Check whether
 clk_round_rate() returns zero rate
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210912184458.17995-1-digetx@gmail.com>
 <20210912184458.17995-5-digetx@gmail.com>
 <9fa66405-883a-3653-eb5d-3cd7eee07a0a@gmail.com>
Message-ID: <e9233eeb-6780-b390-dffa-8de9315effa3@gmail.com>
Date:   Thu, 16 Sep 2021 03:31:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9fa66405-883a-3653-eb5d-3cd7eee07a0a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 15. 오후 12:51, Chanwoo Choi wrote:
> Hi,
> 
> On 21. 9. 13. 오전 3:44, Dmitry Osipenko wrote:
>> EMC clock is always-on and can't be zero. Check whether clk_round_rate()
>> returns zero rate and error out if it does. It can return zero if clock
>> tree isn't initialized properly.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/devfreq/tegra30-devfreq.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c 
>> b/drivers/devfreq/tegra30-devfreq.c
>> index d83fdc2713ed..65ecf17a36f4 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -891,9 +891,9 @@ static int tegra_devfreq_probe(struct 
>> platform_device *pdev)
>>           return err;
>>       rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>> -    if (rate < 0) {
>> +    if (rate <= 0) {
>>           dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>> -        return rate;
>> +        return rate ?: -EINVAL;

If rate is 0, It doesn't return and fall-through? even if print the 
error message. 'return rate ?: -EINVAL;' style is strange for me
because it doesn't specify the 'return value' when rate is true.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
