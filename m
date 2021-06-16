Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7836A3A9818
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 12:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPKv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhFPKv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 06:51:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF92C061574;
        Wed, 16 Jun 2021 03:49:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q20so3603547lfo.2;
        Wed, 16 Jun 2021 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mGdoH7aBBtCdhYfLcQjLr73AllgTibDxP6UFUA4o5J4=;
        b=OBtmDL1IeCF0SFh/JX41cE2Yey03CHwqXvmZ3v/8T9Q3wiR1bBno4ts5RK6zLJtpOP
         aimf4sJOraWmiSnP6+z6G72/ucNITK4HkeHFwDDgW7FufCZGtDuv0OvDgRgHAr20StO0
         S2Ot8A4Z7a3bkC6gmb00zlNZ1V0ixGdOywU3D97JciVoP5tXlIV/BJigPNewM/vpOA6b
         TKoCw3ZVxyk3QTsejWF5u5Rx+EBSTMd+B2NOCheahQsShOoH/m4lgSjbxpgm2vFyQZxO
         F0WS2qZFv8bAZmXkxr3Z5mjP5hIiIEdO80EKE3pk9utuxMvXrxUMpLK2I7cLgfZBTVJ3
         8ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mGdoH7aBBtCdhYfLcQjLr73AllgTibDxP6UFUA4o5J4=;
        b=WK4H61PLcOegyGEMVayq3MOTSTDPAFemWRNSlmgUDaK2mfuRHc2hNzSp8Kq2eyu2An
         USotcdoRtnPtwLbcAVjf+3PA5X6bmSbopru9GhlBVecp1SsCfC79gzBBcl70VS7c3/nf
         /M9tBje/U7OFfdZogwFbUcYvfIn/ZTJp3P/jhbpWBaTyGn3XMxdYz3mpvs9aZI2xcxiI
         X/gj8mDP5Ysycy8ooeFctuaKjl9lbJ9g/6vP4l3muPZUj+LpsjwYXyW1CxFH1PNT0Fuc
         6cbo2yPbmK4O7U5ASdyc2EErKvL0v2vNHxMPp6j9+l9rB9OOlj6jW0t9goja0JZVBTZp
         3nCQ==
X-Gm-Message-State: AOAM5311sKHbaKLv0iijx1y9Y6lOiFD2G0eJ8hKIDyVcbMdPLVMFXcG+
        1979eHPHM9Qj1i9P5muIyWxwsVQvYPw=
X-Google-Smtp-Source: ABdhPJxSP2EOyTVCfRqda9Fa5M63/2XdmMMZWZ0SCjugTxLMRWtY9MqjWhDR91zPwcwrDME0au56eA==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr3260452lfn.465.1623840559827;
        Wed, 16 Jun 2021 03:49:19 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id x17sm229615ljx.75.2021.06.16.03.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 03:49:19 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] thermal/drivers/tegra: Add driver for Tegra30
 thermal sensor
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20210529170955.32574-1-digetx@gmail.com>
 <20210529170955.32574-5-digetx@gmail.com>
 <6f2b6290-095a-bd39-c160-1616a0ff89b1@linaro.org>
 <20210615102626.dja3agclwzxv2sj4@vireshk-i7>
 <595f5e53-b872-bcc6-e886-ed225e26e9fe@gmail.com>
 <fbdc3b56-4465-6d3e-74db-1d5082813b9c@linaro.org>
 <4c7b23c4-cf6a-0942-5250-63515be4a219@gmail.com>
 <20210616080310.vhvauvo5y6m2sekz@vireshk-i7>
 <CAKfTPtAxvj4_TBpFesjQxcVzvEi3QVUThccfSAJXwwrLtOH-xg@mail.gmail.com>
 <96bf59af-20b6-b706-5ff0-fe70f9eba827@gmail.com>
 <CAKfTPtBDzFaFKuYgY5XC+-vFxFSJvxKunGFwY50E98bYn0VE5Q@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <57e044af-072f-cf7e-8f25-dc8b814c78c5@gmail.com>
Date:   Wed, 16 Jun 2021 13:49:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBDzFaFKuYgY5XC+-vFxFSJvxKunGFwY50E98bYn0VE5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 11:51, Vincent Guittot пишет:
> On Wed, 16 Jun 2021 at 10:39, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 16.06.2021 11:30, Vincent Guittot пишет:
>>> On Wed, 16 Jun 2021 at 10:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> +Vincent.
>>>>
>>>> On 15-06-21, 22:32, Dmitry Osipenko wrote:
>>>>> IIUC, the cpufreq already should be prepared for the case where firmware
>>>>> may override frequency. Viresh, could you please clarify what are the
>>>>> possible implications of the frequency overriding?
>>>>
>>>> The only implication is software would think hardware is running at
>>>> some other frequency, while it is not. Not sure if something may break
>>>> as a result of this.
>>>>
>>>> The scheduler's view of CPUs will not be same though, i.e. scheduler
>>>> will see capacity as X, while in reality it has changed to Y.
>>>
>>> thermal_pressure is used by scheduler to balance the load between CPUs
>>> according to the actual max frequency. If the thermal pressure doesn't
>>> reflect reality, scheduler will end up enqueuing too many  tasks on a
>>> throttle CPU.
>>
>> What if all CPUs are throttled equally and running on the same
>> frequency, will throttling have any effect on the scheduler decisions?
> 
> Yes, the capacity is also used to detect when CPUs have spare capacity
> or are already overloaded. We usually try to fill the spare capacity
> of a CPU (CPU's max capacity - current utilization) but he max
> capacity is reduced when the CPU is throttled, and the spare capacity
> doesn't exist but scheduler could try to it
> 

Thank you.
