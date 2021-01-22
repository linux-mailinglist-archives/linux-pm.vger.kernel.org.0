Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4239430057A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 15:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbhAVOcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbhAVOcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:32:24 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E1C061788;
        Fri, 22 Jan 2021 06:31:44 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x23so6729494lji.7;
        Fri, 22 Jan 2021 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Bnnhv8/ungSfzdbo4blEjJTqIYQgbA8qgZ1/HTwN7E=;
        b=oBE07xqB0ZvDLI0k7/Hsk7r6F8t/AOGFX/EP+FoGbGnweK/B0k+U/kneVLGC1w1vAw
         B+IvY65C6ivynrcLeUpfcakdNBZClc28ipvA61wqy3lEzKCkD4RZFHTmmZ/yiyyXAd7t
         NMKYSYkVJQw/Pc3q6x/Q43kg9vnp+/fC21H8tlQyMEnJQ5Pp5Ey2h22c+AluSBwBMUga
         U5X3OEgpesY/f6hv0cGKho3y+kKbxeF01mD7fGdTB2yFGxUEYpcwpUgsxa2vMVKg2KGU
         RfO1URkEHLYC7Zr8ZY75PwCNIw4y3K3fcvsRYe7QeNl1jqs1iG3sONBhH78xi0d6o4+I
         CKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Bnnhv8/ungSfzdbo4blEjJTqIYQgbA8qgZ1/HTwN7E=;
        b=J1ZAZFQzjS28XMD3du/KGb3n3X46kDqMCHANIPAeLJyCEW2EY4FHEII68U8YGJghIf
         o1IfkTaT+Mt4R6b+naTg/6KmWt9KpXxzJ3jUR+BSr0l1I646CKHGnbohkui5BTI5urk7
         LkMbazUbmkcvBYDT90tfVr4WV5nqKxaBK0tQ639AHHmNlRhXTP82WwBATc6zTULGL3lY
         SOkTyv0uaku1ifgmIELW6cuq9Ca2N5h+IjnhTWrWSxEl/ebKcj1R94/jRnTLRxdBfp4p
         U0JFgATquPY4XotNjU/ibaZorxLVyP5p7GgAqiF9e57w90Ce9EheRAE+eyhKDgI8e+ul
         gi/g==
X-Gm-Message-State: AOAM532gszFcCzmRCJAvSFreDmiWrRwk0D0DSLN7+6OIgeawDH6575fS
        wQ4u16avFpvS3rCOX06/P0s=
X-Google-Smtp-Source: ABdhPJxTlicx2+sF7zITXF5P61jkAO0p9O/OOyyGbLeLtpy/95Q1cTcuKKYw9f26i4fJvm7t/Iwfqg==
X-Received: by 2002:a2e:958c:: with SMTP id w12mr368249ljh.303.1611325902874;
        Fri, 22 Jan 2021 06:31:42 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id s22sm386867ljh.102.2021.01.22.06.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:31:42 -0800 (PST)
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <b634343a-8005-fc35-e38b-bfeaa7310a70@gmail.com>
 <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8af5abe4-fc3f-8ce4-ff14-542754f0275d@gmail.com>
Date:   Fri, 22 Jan 2021 17:31:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210122044532.pc7cpcgy3kjbqmls@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.01.2021 07:45, Viresh Kumar пишет:
> On 22-01-21, 00:41, Dmitry Osipenko wrote:
>> 21.01.2021 14:17, Viresh Kumar пишет:
>>> @@ -1074,15 +1091,18 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>>>  
>>>  	if (!ret) {
>>>  		ret = _set_opp_bw(opp_table, opp, dev, false);
>>> -		if (!ret)
>>> +		if (!ret) {
>>>  			opp_table->enabled = true;
>>> +			dev_pm_opp_put(old_opp);
>>> +
>>> +			/* Make sure current_opp doesn't get freed */
>>> +			dev_pm_opp_get(opp);
>>> +			opp_table->current_opp = opp;
>>> +		}
>>>  	}
>>
>> I'm a bit surprised that _set_opp_bw() isn't used similarly to
>> _set_opp_voltage() in _generic_set_opp_regulator().
>>
>> I'd expect the BW requirement to be raised before the clock rate goes UP.
> 
> I remember discussing that earlier when this stuff came in, and this I
> believe is the reason for that.
> 
> We need to scale regulators before/after frequency because when we
> increase the frequency a regulator may _not_ be providing enough power
> to sustain that (even for a short while) and this may have undesired
> effects on the hardware and so it is important to prevent that
> malfunction.
> 
> In case of bandwidth such issues will not happen (AFAIK) and doing it
> just once is normally enough. It is just about allowing more data to
> be transmitted, and won't make the hardware behave badly.
> 

This may not be true for all kinds of hardware, a display controller is
one example. If display's pixclock is raised before the memory bandwidth
of the display's memory client, then display controller may get a memory
underflow since it won't be able to fetch memory fast enough and it's
not possible to pause data transmission to display panel, hence display
panel may get out of sync and a full hardware reset will be needed in
order to recover. At least this is the case for NVIDIA Tegra SoCs.

I guess it's not a real problem for any of OPP API users right now, but
this is something to keep in mind.
