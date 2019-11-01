Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5280ECA4B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfKAVak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 17:30:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38060 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKAVak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 17:30:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so11206707ljc.5;
        Fri, 01 Nov 2019 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUMbanYAR2JSQFXtbmagULus+WfywDZrwLUh3k9jtsA=;
        b=umMn3Y+u4IeNaoKlgUdMAZNW66GDjoo8446drYodCdBa7ZmGnsoygSzfiBCEk5EW/K
         Z3YKyGO/huuIQ9ZWYK2xKSadEzoEz9Uoq7veWo+T9lhlHL4OPQAagL35zEgPhPXEmuNn
         8Ctc8Rk1yMl2pYgBY9qd/muTcdrZx398dbczT6YURP2tjHGOkz5NSth7TRQtvML4n0Nr
         mC2kFGS+OgZK5WDZEH+LGa2TsZhVVIIdReVjom9QVzRdK8sVCZzN1T3xlSJn4pjvUHGT
         iPNGWA84KW3Vpy1na6bJ6ViB9Djz1yPCa08StTgz4dqXy1Xhk5dg+11uPBxqRCQW8Q4z
         djpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUMbanYAR2JSQFXtbmagULus+WfywDZrwLUh3k9jtsA=;
        b=hcgLJgQeJ5jUwjGjogzL0bvMV0f4JkWeG5shOJwk0+Vo88lhbC+n3WT4qVlp8mH0pS
         i4X10CoAMiRC2KYWBWMtnqNx8z0QtKkrzBTOc89/JVbRs3ieK8YMNXeAS/1gvNyUMlmO
         OQl4Ls2YiC8DlTFvATJvGbq9kbKF7lMiG3pW6mLnsb+/XpLMk04YTBq9ICOC1VqQ8ueV
         4aZ/GX56OO9vOk97H0sht1C5bS/4xkW179TDpNPsZx9thrJzkvJQEY4jPjHmSv0LJA6+
         /NlB5WNcLWRZgdz++C9YoFgucIvP2DqKP2cD/vE4gx08vzehF3hqXoPYURio3RKvNWC/
         BbzA==
X-Gm-Message-State: APjAAAVGGdn6gA2HNCCi/XxBC9odsxoZ7w5OKAzdopJ+vsUuutyxfkH6
        bJGZ5WQn/dTI+zHMBJ86Bot/ACme
X-Google-Smtp-Source: APXvYqyQg7FVoTK+7F7aVQMbDzmR4UztW5orQfSKGemWQwF3ydiJE5F9YDtBNjdUEqfNel0WXXx4yw==
X-Received: by 2002:a2e:161b:: with SMTP id w27mr9594995ljd.183.1572643837562;
        Fri, 01 Nov 2019 14:30:37 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id r21sm2805638ljn.65.2019.11.01.14.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 14:30:36 -0700 (PDT)
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
 <72636eb3-5354-eea3-3a51-4975a04186b2@gmail.com>
 <53ee8bd3-5c53-f0aa-175c-7fa3024d0af5@gmail.com>
 <20191028140443.GA27141@pdeschrijver-desktop.Nvidia.com>
 <40de641f-c38e-51ee-ae27-c5db468c45b5@gmail.com>
 <20191101123359.GG27141@pdeschrijver-desktop.Nvidia.com>
 <a72463cd-cc16-691c-3c82-54ebb618ec32@gmail.com>
Message-ID: <9c25ea71-ebe9-d9c2-0dff-6b2752e27131@gmail.com>
Date:   Sat, 2 Nov 2019 00:30:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a72463cd-cc16-691c-3c82-54ebb618ec32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2019 16:22, Dmitry Osipenko пишет:
> 01.11.2019 15:33, Peter De Schrijver пишет:
>> On Tue, Oct 29, 2019 at 03:47:56AM +0300, Dmitry Osipenko wrote:
>> ..
>>
>>>>>>> It would be useful to switch the power state terminology to the one used
>>>>>>> for later chips:
>>>>>>>
>>>>>>> LP0 becomes SC7
>>>>>>> LP1 becomes C1
>>>>>>> LP2 becomes CC7
>>>>>>>
>>>>>>> Meaning of these states is as follows
>>>>>>>
>>>>>>> C is a core state:
>>>>>>>
>>>>>>> C1 clock gating
>>>>>>> C2 not defined
>>>>>>> C3 not defined
>>>>>>> C4 not defined
>>>>>>> C5 not defined
>>>>>>> C6 not defined for ARM cores
>>>>>>> C7 power-gating
>>>>>>>
>>>>>>> CC is a CPU cluster C state:
>>>>>>>
>>>>>>> CC1 cluster clock gated
>>>>>>> CC2 not defined
>>>>>>> CC3 fmax@Vmin: not used prior to Tegra186
>>>>>>> CC4: cluster retention: no longer supported
>>>>>>> CC5: not defined
>>>>>>> CC6: cluster power gating
>>>>>>> CC7: cluster rail gating
>>>>>>>
>>>>>>> SC is a System C state:
>>>>>>>
>>>>>>> SC1: not defined
>>>>>>> SC2: not defined
>>>>>>> SC3: not defined
>>>>>>> SC4: not defined
>>>>>>> SC5: not defined
>>>>>>> SC6: not defined
>>>>>>> SC7: VDD_SOC off
>>>>>>
>>>>>> Hello Peter,
>>>>>>
>>>>>> But new "drivers/cpuidle/cpuidle-tegra.c" uses exactly that terminology,
>>>>>> please see "cpuidle: Refactor and move NVIDIA Tegra20 driver into
>>>>>> drivers/cpuidle/" and further patches. Am I missing something? Or do you
>>>>>> want the renaming to be a separate patch?
>>>>>>
>>>>>
>>>>> Or maybe you're suggesting to change the names everywhere and not only
>>>>> in the cpuidle driver? Please clarify :)
>>>>
>>>> At least some of the variable and function names still say lp2?
>>>
>>> The cpuidle driver uses LP2 terminology for everything that comes from
>>> the external arch / firmware includes. But it says CC6 for everything
>>> that is internal to the driver. So yes, there is a bit of new/old
>>> terminology mixing in the code.
>>>
>>> The arch code / PMC driver / TF firmware are all saying LP2. The LP2
>>> naming is also a part of the device-tree binding.
>>>
>>> It will be a lot of mess to rename the mach-tegra/pm.c code. I guess
>>> eventually it could be moved to drivers/soc/, so maybe it will be better
>>> to postpone the renaming until then?
>>
>> Or maybe add a comment somewhere indicating:
>>
>> LP2 = CC6
>> LP1 = C1
>> LP0 = SC7
>>
>> TF predates the new naming, so that may make some sense.
> 
> Today it should make more sense just to add an explicit comment to the
> cpuidle driver that clarifies the new naming (IMHO). I'll prepare v7
> with that change.
> 
> Maybe later on, once more code will be consolidated in
> drivers/soc/tegra/, it will become useful to duplicate the clarification
> there as well.
> 
> Please let me know if you disagree or think that something better could
> be done.

BTW, LP3 = C1.

I don't think that the new terminology has equivalent to LP1 (CPU
cluster power gating + DRAM in self-refresh).
