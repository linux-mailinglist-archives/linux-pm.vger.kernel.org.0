Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCD302D4E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 22:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbhAYVKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732238AbhAYVJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 16:09:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D772C061574;
        Mon, 25 Jan 2021 13:09:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a8so19858028lfi.8;
        Mon, 25 Jan 2021 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljX94ob0gxc7TBbMW/hwvorCyQ7d78+9C5d6nUuJY4A=;
        b=l8FsEZ8ZKnJFAhD5sfNBKDjgb3XtTjtjRwwpmqVRkHvuw0hQec5jUHcmTJPIU3fJ3+
         euItLtjg7gKpCV1pjAgOqUWu+FIW9C5mjVBC6XHOAHGgSeGwC2FWgOGiVViyylakaQ5h
         bA9u4oeJSbto5gU3zaYoAouYI2RN+bJiF/zw1D0m61jNLdGVDvmRJhrWGMKXw1WWfMYH
         +FWeWiEWI2IJ/qgkE6d+sivsZXixsW853jfsLJWvzCgLnPJSZsx97ng3dPpMMM9gpoCo
         KolGhANnSL4SOZ6WL7chOYSgt1DTI7SrWcOFVbyjvVgaGZSKkYBCvKAkgRNxzX0ImNPS
         HQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljX94ob0gxc7TBbMW/hwvorCyQ7d78+9C5d6nUuJY4A=;
        b=J2eEZpAVznhRdXqWdF0gdZhJRv1ykIZdyCfci2H4k0I/RqkYqBvRtc29Koltevz5yn
         afHE3iiSpSDIqVYkw0qVZFMQ/Xt2ThXnYaDh/DlJ0WP+MQ5d2I0aMSd0sNRvnCaKqniI
         XMIzT+xuwB8mRHQzK/Xn5soUakFZYPGBXzZXCH6IrPZAhN6UeriYSeawUZQKQfEcPxj0
         aEUyIkDhmMpFlOx+GB7zEY7eb7Dws0Tpl2vMbcQxf+MA4D1OHWJrzo8T7f3TK7sd7D91
         UumedGxpB1/NS4dKLCf9+8M1/zzuXBmalK/0b5wMTazshEnDJWAnthTI8+l1i2hA2jqE
         1GAQ==
X-Gm-Message-State: AOAM531TwdRlP8LMhL5IZOJl8xNcHqOBfnD2VUmlT+MavCX/0yqY0ugR
        uYfNji+C3alkuu2XkUqGCzOScTHsru8=
X-Google-Smtp-Source: ABdhPJxNbMSVPgHPo/hTwLSVl2t3E08eBL30MfC6cO0G1scw3qtVdUFtPz51LYvi84N+/v7VL0sTcg==
X-Received: by 2002:a19:58a:: with SMTP id 132mr1091790lff.355.1611608947678;
        Mon, 25 Jan 2021 13:09:07 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id q13sm1069781lfk.307.2021.01.25.13.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:09:06 -0800 (PST)
Subject: Re: [PATCH 07/13] opp: Allow _generic_set_opp_clk_only() to work for
 non-freq devices
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <1585f6c21ea8aee64fe4da0bf72b36ea4d74a779.1611227342.git.viresh.kumar@linaro.org>
 <9b2638e6-b842-8737-e5a0-aeeb84927fce@gmail.com>
 <20210122043506.lm6yiefzlyubq5my@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7d6573e3-7885-fb0b-2290-c181e2c557f9@gmail.com>
Date:   Tue, 26 Jan 2021 00:09:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210122043506.lm6yiefzlyubq5my@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.01.2021 07:35, Viresh Kumar пишет:
> On 21-01-21, 23:26, Dmitry Osipenko wrote:
>> 21.01.2021 14:17, Viresh Kumar пишет:
>>> In order to avoid conditional statements at the caller site, this patch
>>> updates _generic_set_opp_clk_only() to work for devices that don't
>>> change frequency (like power domains, etc.). Return 0 if the clk pointer
>>> passed to this routine is not valid.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>> ...
>>
>> Hello Viresh,
>>
>> Thank you very much for yours effort! I gave a quick test to this series
>> and instantly found one small issue in this patch.
>>
>>> +	/* We may reach here for devices which don't change frequency */
>>> +	if (unlikely(!clk))
>>
>> I replaced dev_pm_opp_set_voltage() with dev_pm_opp_set_opp() in the
>> Tegra PD driver and got a crash, which happens because the above line
>> should be:
>>
>> 	if (IS_ERR(clk))
> 
> Fixed, thanks.
> 

Please remove unlikely() around IS_ERR(), it already has the unlikely().

https://elixir.bootlin.com/linux/v5.11-rc4/source/include/linux/err.h#L22

I'd also recommend to remove all the unlikely() from OPP code since it
doesn't bring any value if not used in a very performance-critical code
path. OPP core doesn't have such code paths. The [un]likely() only make
code less readable and may result in a worse assembly.
