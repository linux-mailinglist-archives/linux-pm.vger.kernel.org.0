Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808812576F5
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgHaJyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHaJyl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 05:54:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A2C061573;
        Mon, 31 Aug 2020 02:54:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so5882570ljn.11;
        Mon, 31 Aug 2020 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TSm8Xir2qHLM4KnvUNa9QAiKGDLz5dH6Zq6NNkg0IXQ=;
        b=kurhuhNueqi6Go7ZBSzHHlC2VATfsEJ18kcOG0TtB7QnuhDk2JAqZNyWAev7TBzYkz
         CiP5BBA5nDhYGxWPvdTHEM3NhEE76P/YLA+6sVzE9ptTSR4lvQ6U9Fz3VCaIPnv32BAL
         FZ6kHKgDbxvcOlstFWUomxLz9Gs2BNXfsfP9Gg6Z0voNpQrkTh1RmAnL5VAwZthtO2fg
         I1B/orxzR62QrpHX62BXGDknIrnk2A7vD1sCjZnI8chUENqi6RoZGQ8FvyKNJPYkZ+bb
         OKa9i4zJ4xkwbKdT3lpLqL/M4W2gl+hmPOVXCmvkZ8ZiSG9OYoJIcawMs5XiuHyCSFjy
         7Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TSm8Xir2qHLM4KnvUNa9QAiKGDLz5dH6Zq6NNkg0IXQ=;
        b=SnN6pldGoJQInx/m1zeGmteApodgzbnlZJmK2f5pYudoBhyVOdvKvoFg5N5sdS4S5S
         D6dsnbGmgY4ooudUKVMW/uocyfaW70OwF9D6Fhw53GrvqTRp+h2OTlvuArTqcg6Lo8vz
         AZmhBvGagNx3BG8kLa6zUqcTzVae0P4hmRYF8SJNVFOwGlA5Di12RkqW606ie/revFGw
         20/myo5p31UNvdfJoCQdnPNAg66jIsz5Vn9IJXW7lPjwuCFKijKEXUjnSUhM8TrSktZK
         uUOGyf9DEAcs1pvdPnsvbR1hdy2Q05LAKhQhTsQLaBgutc7C4CKQbvXZtXju4gk3IBbI
         PVxA==
X-Gm-Message-State: AOAM5333RUoiFysFOzYMo0KGwZH15LB0KdqOXgTW3trd1BSiNIzey+Z5
        6C1Jx9rtFr2IIaTtg33URT8oxyTUPKM=
X-Google-Smtp-Source: ABdhPJy8KZjk72a5eEDT0IuSYdmnLR/C/55LTP2RBCq87JBLCuN6xfMUdvGBtMMHsODr7dV4jftXMg==
X-Received: by 2002:a2e:b4f4:: with SMTP id s20mr251794ljm.339.1598867660906;
        Mon, 31 Aug 2020 02:54:20 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id f20sm1863068lfk.70.2020.08.31.02.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 02:54:20 -0700 (PDT)
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
 <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
Date:   Mon, 31 Aug 2020 12:54:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.08.2020 11:41, Viresh Kumar пишет:
> On 31-08-20, 10:54, Dmitry Osipenko wrote:
>> 31.08.2020 07:39, Viresh Kumar пишет:
>> ...
>>>>> Dmitry, I think there is further scope of simplifying stuff here by
>>>>> using the opp-microvolt-<name> property and corresponding
>>>>> dev_pm_opp_set_prop_name() call.
>>>
>>> Any inputs on this Dmitry ?
>>
>> Could you please give an example?
> 
> There are many users of it in the kernel. grep for "opp-microvolt-" in
> the DT files and you will see.
> 
> The use of this property is to specific multiple microvolt properties
> to the same frequency without a need to create separate nodes for them
> all. The right microvolt property will be selected based on the call
> made to dev_pm_opp_set_prop_name(), search for that too in kernel.
> 

It's not clear to me how it could be applicable to the Tegra CPU OPP
because Tegra depends on a combination of SPEEDO + PROCESS versions.

It's not like all voltages are the same for all OPPs that have the same
PROCESS ID, otherwise it indeed would be nice to have
"opp-microvolt-process0", but unfortunately this variant is not suitable
for Tegra because some freqs have different voltages using the same
PROCESS ID and the same applies to the SPEEDO ID.
