Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16573189DE5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 15:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCROch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 10:32:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33170 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCROcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 10:32:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so2458602wmg.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/AqYEBJlxxSIUhP7Fb3EYs8euQ0IQa4iZ/5Ean5NZA=;
        b=ps4olijsIxBTOMnK9J0mEsNfI2xpPb1RMdPKAMZz20yBygtp68oa1KwvNr4lIeOkZe
         i8RNqT20LFQpppOSwZ8t/0Nlc+Ls7PEJJ+xiKBshJPZhQeTB/y8XhAUXBHpFc3ZFJ0Gi
         aGU1Ez/O/U12yRW1Fe4WGgBbupoXZOXDkNpvi1Y2ku6a9q3ZrvqsIFrX/H1hdvSGkT6L
         BSdJ5lXHoUObu65u1fkAH6lAH5mvCXXvdJk4q4djTkacnmAcnb9ZFzIaJCbecEdUmSwq
         Z/W7/I443wb5IF2JJUVuDnVejGTNwJ0Z3Z6WY9GaZz5fBNxdJIh7OuP9eFaiojxc4lQ0
         2+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W/AqYEBJlxxSIUhP7Fb3EYs8euQ0IQa4iZ/5Ean5NZA=;
        b=rf63j5mYtc0RussT9L5TRZxLO+U0mMYgkhJduhgKRwsFVO0VtwM9dCP6wrEtXM8JhA
         kjHLwvL405B3ZYAnVXVYt/hlgk/1nUNPov5TVhg+cxIplpwfl9Wjyq1Fi9R/CLsa9a1l
         PRanu/UYRrx1ZjCvPA4OIntIGBpZ5yycrSbRQtBUjb3CU3Rel1H5yCVNSn4YwdNAwWnO
         CWyGqC+EnIJ8YOlB5IsJUbi9l3xnnT59erkfT5RZY/duV6MjwM7Bxcusj50RYTQ9p8ND
         pE9MrQRTy0W26OYa+jIdRkNDhS7qWbbLz1d4jAzc2WH9Yh3it6O/WHnYHsCmVO6C4m5v
         rDhQ==
X-Gm-Message-State: ANhLgQ1FVspu8BljVByd2v44p08J7r3szABl5HynnKxYbMc9JJajWYN8
        LZMt0vmBb9kfPXjOD8BksPg4lQ==
X-Google-Smtp-Source: ADFU+vtETcWR1Hg4rft7Egc78CH2ZKJBXHfxsq7L4KNzMnMA18nT1bdNpoMnGiTHRTrpWwWXZfIx9Q==
X-Received: by 2002:a1c:b154:: with SMTP id a81mr5540441wmf.175.1584541953024;
        Wed, 18 Mar 2020 07:32:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bd37:618d:f415:31ea? ([2a01:e34:ed2f:f020:bd37:618d:f415:31ea])
        by smtp.googlemail.com with ESMTPSA id y12sm3940550wmi.48.2020.03.18.07.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 07:32:31 -0700 (PDT)
Subject: Re: [PATCH RFC] cpuidle: consolidate calls to time capture
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@kernel.org
References: <20200316210843.11678-1-daniel.lezcano@linaro.org>
 <2605374.f08NWHE4iP@kreacher>
 <669fe03f-0d65-8ca9-53dc-1323e0397c53@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93da445f-ebfd-4d2e-c8b4-cd81e54892c0@linaro.org>
Date:   Wed, 18 Mar 2020 15:32:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <669fe03f-0d65-8ca9-53dc-1323e0397c53@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/2020 12:04, Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> On 18/03/2020 11:17, Rafael J. Wysocki wrote:
>> On Monday, March 16, 2020 10:08:43 PM CET Daniel Lezcano wrote:
>>> A few years ago, we changed the code in cpuidle to replace ktime_get()
>>> by a local_clock() to get rid of potential seq lock in the path and an
>>> extra latency.
>>>
>>> Meanwhile, the code evolved and we are getting the time in some other
>>> places like the power domain governor and in the future break even
>>> deadline proposal.
>>
>> Hmm?
>>
>> Have any patches been posted for that?
> 
> https://lkml.org/lkml/2020/3/11/1113
> 
> https://lkml.org/lkml/2020/3/13/466
> 
> but there is no consensus yet if that has a benefit or not.
> 
>>> Unfortunately, as the time must be compared across the CPU, we have no
>>> other option than using the ktime_get() again. Hopefully, we can
>>> factor out all the calls to local_clock() and ktime_get() into a
>>> single one when the CPU is entering idle as the value will be reuse in
>>> different places.
>>
>> So there are cases in which it is not necessary to synchronize the time
>> between CPUs and those would take the overhead unnecessarily.
>>
>> This change looks premature to me at least.
> 
> The idea is to call one time ktime_get() when entering idle and store
> the result in the struct cpuidle_device, so we have the information when
> we entered idle.
> 
> Moreover, ktime_get() is called in do_idle() via:
> 
> tick_nohz_idle_enter()
>   tick_nohz_start_idle()
>     ts->idle_entrytime = ktime_get();
> 
> This is called at the first loop level. The idle loop is exiting and
> re-entering again without passing through tick_nohz_idle_enter() in the
> second loop level in case of interrupt processing, thus the
> idle_entrytime is not updated and the return of
> tick_nohz_get_sleep_length() will be greater than what is expected.
> 
> May be we can consider ktime_get_mono_fast_ns() which is lockless with a
> particular care of the non-monotonic aspect if needed. Given the
> description at [1] the time jump could a few nanoseconds in case of NMI.
> 
> The local_clock() can no be inspected across CPUs, the gap is too big
> and continues to increase during system lifetime.

I took the opportunity to measure the duration to a call to ktime_get,
ktime_get_mono_fast_ns and local_clock.

The result is an average of 10000 measurements and an average of 1000
run of those.

The duration is measured with local_clock(), ktime_get() and
ktime_get_mono_fast_ns()

Measurement with local_clock():
-------------------------------

ktime_get():
N	min	max	sum	mean	stddev
1000	71	168	109052	109.052	13.0278

ktime_get_mono_fast_ns():
N	min	max	sum	mean	stddev
1000	66	153	101135	101.135	11.9262

local_clock():
N	min	max	sum	mean	stddev
1000	70	163	106896	106.896	12.8575


Measurement with ktime_get():
-----------------------------

ktime_get():
N	min	max	sum	mean	stddev
1000	71	124	100465	100.465	10.0272

ktime_get_mono_fast_ns():
N	min	max	sum	mean	stddev
1000	67	124	94451	94.451	9.67218

local_clock():
N	min	max	sum	mean	stddev
1000	71	123	99765	99.765	10.0508


Measurement with ktime_get_mono_fast_ns():
------------------------------------------

ktime_get():
N	min	max	sum	mean	stddev
1000	67	116	87562	87.562	4.38399

ktime_get_mono_fast_ns():
N	min	max	sum	mean	stddev
1000	62	104	81017	81.017	4.12453

local_clock():
N	min	max	sum	mean	stddev
1000	65	110	85919	85.919	4.24859



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

