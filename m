Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C112F1B50
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbhAKQol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbhAKQol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 11:44:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A921EC061795
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 08:44:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c5so441712wrp.6
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2021 08:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Hp9A8/hK542k3HGO/BcxhgR60TvBqtFaVODw3rwYZY=;
        b=GfZ8RGI6QZLTTEBOcYp6d9hPCK5gzpEcZNZP9GIjnq5imwb4NojcaSmbBMQyfs1vd6
         Pn5yCSAK+ln+0ropRUUTnwW3nKM1EbwnE30EMpY5i/Cp9m0YN+ZBpZVohFdLg1ML0MhX
         S2bhkomGtlVIR1WI8pXFBC8evKNY7yRXYlJVNExyYE/J/sD0LIVwjjPaNs0m7TjVP+d+
         B6vSm/fBft0mEYAvow8SY472qknK513cwMD/PNEi66qnK+Itn40Hkjyb3yeL7ZiWuqxy
         eZqZnb3SXFBvdHlbPaO4Jj2z4ou1Jixy1ioVrnKo1vCWSiJs2ahlYs8Kknp514Y2WoQA
         zjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Hp9A8/hK542k3HGO/BcxhgR60TvBqtFaVODw3rwYZY=;
        b=Bvebm1aY2vGlA6zwcRkBQFIolr9oZzW/15LoxGMYm4bf+xJcPia9yy9vBWs7QHWwjP
         +ApJaghmD//ad+m3FIJXGWGWPFMddho/skT/7OCl4mhxPsFBgacToq9O1Wxn11ir7Gh6
         75z5Du+M0k8M/ajWA0tpD8p1gDvwQAOqOTTEWdQ71Je7SrZbCruikyF8yJ+Tq70/gvj/
         SPmgPa2sWQDhmOyBsGbsWP8rpefjDvn5SWwrQiSo1ti9HU0K7CZlOYiFVkICahgjvJL7
         x8w6gh7Q9m3C1YrfnOK6e+/q0l7ao2Idf958DCuSgTZenvKxNuQh8Sg0Tv66/cPdVk6c
         j+4A==
X-Gm-Message-State: AOAM533gYbHhShj7r93TOPAn8ClHhKgjwBrC2AUfMfyDCjPxw8w0I96Z
        Vs92FlrcVHtByKbmsn1qE7OeLA==
X-Google-Smtp-Source: ABdhPJzH/3JXnXfnkK6TlKy4lgufv573bXaHLkv6HS1DsIu8T26xHCfTpWMEu8z56FpGQLqjZpOocw==
X-Received: by 2002:a5d:528a:: with SMTP id c10mr450wrv.117.1610383437762;
        Mon, 11 Jan 2021 08:43:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:857c:93df:6003:8cc5? ([2a01:e34:ed2f:f020:857c:93df:6003:8cc5])
        by smtp.googlemail.com with ESMTPSA id g191sm390288wmg.39.2021.01.11.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:43:56 -0800 (PST)
Subject: Re: [PATCH v2 1/2] thermal: int340x: Fix unexpected shutdown at
 critical temperature
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Zhang, Rui" <rui.zhang@intel.com>, amitk@kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Matthew Garrett <mjg59@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201221172345.36976-1-kai.heng.feng@canonical.com>
 <CAAd53p6Yn2n-oBVk026nf3oZ7y+_7NFtywQe3PBhTr=3Lo7-Bg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f6d05777-c062-ed80-f3b8-b3b0ae042e20@linaro.org>
Date:   Mon, 11 Jan 2021 17:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p6Yn2n-oBVk026nf3oZ7y+_7NFtywQe3PBhTr=3Lo7-Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/01/2021 17:18, Kai-Heng Feng wrote:
> On Tue, Dec 22, 2020 at 1:23 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> We are seeing thermal shutdown on Intel based mobile workstations, the
>> shutdown happens during the first trip handle in
>> thermal_zone_device_register():
>> kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down
>>
>> However, we shouldn't do a thermal shutdown here, since
>> 1) We may want to use a dedicated daemon, Intel's thermald in this case,
>> to handle thermal shutdown.
>>
>> 2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
>> ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
>> "... If this object it present under a device, the device’s driver
>> evaluates this object to determine the device’s critical cooling
>> temperature trip point. This value may then be used by the device’s
>> driver to program an internal device temperature sensor trip point."
>>
>> So a "critical trip" here merely means we should take a more aggressive
>> cooling method.
>>
>> As int340x device isn't present under ACPI ThermalZone, override the
>> default .critical callback to prevent surprising thermal shutdown.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

Applied, they are in the testing branch now. They will be a linux-next
in a couple of days.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
