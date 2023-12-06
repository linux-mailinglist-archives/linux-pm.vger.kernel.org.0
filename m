Return-Path: <linux-pm+bounces-739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3AC806DCD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6531F214F9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69531735;
	Wed,  6 Dec 2023 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQ0e4z7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B396DC
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 03:23:25 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d855efb920so3994091a34.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 03:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861805; x=1702466605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/j4dwh96VzGQ8anKzs9YBEU+yUbdjOy5tIQQmATZk=;
        b=mQ0e4z7Kso7Y43jx/mFxMIDy2s8o83ghqUJjrfLKkQCDvF0yJOASWgO0tusRDS7fWh
         ob10N6yfe5+eLoUMCgXiatPJwevWhyiCn7/3Ux7clQcJqaW+aRYLBbXh2ylLd19twi7O
         95jggKE/16VuCqvXa/Xc6lCn0xy/+NpEIwlfzIFD2fHhGrh57ZuhyLA3KN80dwyr9bCn
         /JQiUhaFh2Slf6ja9I6LqT3c4vfJMb4omJs3y8Jwgh/sv3WQAHNZ9n2wlupLRAulhHDO
         eQE6gPi2u2CwGMe29vGrXCwgT5yJVMNXpLPClwXtKv/l8UrWXQfM5XWAqPNABu76ZvPx
         tROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861805; x=1702466605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc/j4dwh96VzGQ8anKzs9YBEU+yUbdjOy5tIQQmATZk=;
        b=IvITfJ7vka7Gm8jblS0ObKo3IRYUNsqhZDD42PmNstSb/veZUPNPyrn+qK8rFXElHI
         vk0al/jHmh6hdgPAWCmkXeTEwxjbUnoj/W8AUwPVhLHYOvIwcV1yhpMUASvFlefKrGHs
         bO3lQbk1cCw+/g4Uoey9sG2IeIfNmXMzQAVzVAoayTabUyg01A/VIZKdjK79XF2XF3od
         PnQKnwMTj8VvLnE+gq/qzLdX4iAXgtHjwA/3+HDkgAaElXtjbTS91rgCP+ngx7j8cPL2
         wBK+5ViX/O/MvZ/AJ5JaOjDTi7+kqJA8GpofpSUyodlgN5VhWfhZdq/jMR8FVL2wHOVE
         B2WQ==
X-Gm-Message-State: AOJu0YziRQdV35NBnRzSLKXyAUgvCZVxBb9Reipzyt8UC+GFA+IWvgzB
	HokHQNJH7B3iqaTKvZeNhiEGVg==
X-Google-Smtp-Source: AGHT+IFypa6DOFa5uILnS7PtVoW/1rEUDn7jw8FitbcH8Pzb/m4OTVkIQOec7RBpbnRRa0JsZ2sHKA==
X-Received: by 2002:a05:6870:d8c6:b0:1fa:dd7c:94b7 with SMTP id of6-20020a056870d8c600b001fadd7c94b7mr776492oac.46.1701861804704;
        Wed, 06 Dec 2023 03:23:24 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n15-20020a638f0f000000b005c6801efa0fsm5437555pgd.28.2023.12.06.03.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:23:24 -0800 (PST)
Message-ID: <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org>
Date: Wed, 6 Dec 2023 12:23:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND
 asynchronously
Content-Language: en-US
To: Radu Solea <radusolea@google.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org>
 <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Radu,

On 06/12/2023 02:20, Radu Solea wrote:
> On Wed, Nov 29, 2023 at 4:20 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/11/2023 00:40, Radu Solea wrote:
>>> Some thermal zones are bus connected and slow to resume, thus
>>> delaying actions which depend on completion of PM_POST_SUSPEND.
>>> Add optional execution path to resume thermal zones on the system
>>> unbounded workqueue.
>>>
>>> Signed-off-by: Radu Solea <radusolea@google.com>
>>> ---
>>
>> This async change may have a lot of hidden implications.
>>
>> Could you elaborate more the issue and how the async will fix the problem?
>>
>> If you have a platform being slow to resume, can you provide numbers
>> with and without this option?
>>
>> Thanks
>>     -- D.
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
> 
> In multicore systems PM_POST_SUSPEND is executed on a single core.
> Any work done in the notification chain delays all subsequent actions
> in the chain with respect to system time, including the completion of
> the write() to /sys/power/state.
> I didn't include numbers from my system since they are likely
> irrelevant for other systems out there. The particular number I'm
> chasing is ~50ms.
> This comes from having on-board peripherals as thermal zones, they
> execute async and significantly slower than the main core, add a/d
> conversions and bus delays to that and it's easy to see those numbers.
> Making the entire sequence synchronous to itself and async to
> PM_POST_SUSPEND isn't that much of a change, it allows the sequence to
> run on any core with spare cycles delayed with whatever the system
> unbounded queue load is at the time.
> (on my target system) I've seen consistent time gains (those same
> 50ms) to PM_POST_SUSPEND completion with this sequence actually
> completing before the chain finishes, this will vary from integration
> to integration.

Sorry but I don't see how you can have a gain of 50ms by doing the 
restore asynchronously.

Can you give a more detailed description of the hardware? How many 
thermal zones?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


