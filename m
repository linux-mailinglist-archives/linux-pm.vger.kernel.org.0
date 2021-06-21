Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68563AEC93
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFUPil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 11:38:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA84C061574;
        Mon, 21 Jun 2021 08:36:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j2so30946385lfg.9;
        Mon, 21 Jun 2021 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZm8zZbaVXs8SDuUBCinObEMuZP/+XNNAcVwyswH7lY=;
        b=aXD5UxUlEodrQYRBS9ddtWkRy09zqoRQKErfxaPb0WCVUQ2edBB7/BluWZB4xPghvm
         Xl4mDXd4aDfEDoV2ctBdDuS2al7WQiou775gcnVqwyqQ9TJ4dUXgprxquqp9w+e7SGdU
         5Ic9n87Ii23a635nXi5Q3N7AOJCsTLELbiRs4Bg4yZb8x03CUKWbERbGcO5omGIhnQsu
         Fdpps9I/BYs4bS5Enb7FZmgpqiuXTij1+pcGaapKk6FDcDMZxWAyYzFUaAJscfE7wW3f
         7BQTMjQx/DnsgBGBCo7b+E/Xvjik2Wil1anGHxwxNiOtqcRzqghqJCy6a8GSfU+m3kqw
         nn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZm8zZbaVXs8SDuUBCinObEMuZP/+XNNAcVwyswH7lY=;
        b=lmcj+8B7hK9H0E+mIx067WCJBwu9Y5Nxe4RAdtwV4tZmM2CIoKZQSK7jK0PTRC0sxa
         LjhJGfrlB42BMRaAFn3iXTM23mRTRzfKrsO0JGP8m7YJPIPITv+twWhlwgDA42kNTDHL
         Rkt1NlqMh53dlyJt+pBQnrGzoA3XQOECbWkWlQDdDN7KR4VVhuH8sOoOiKFHHYgt1EUb
         O20oSXtacIK0lFQ4PQ0ovp1X8txr+qRg2v+lPAmpd5VDcKjJ0Ps1sE8e74jkUgT46fCl
         AoQFIsMFDmNanYvt7k5f7khuGSuUIgVqqRtiC18eXSfwXLfcgTq5dvk/LO/SAyroTHI4
         tGcQ==
X-Gm-Message-State: AOAM5303Pu7cin1pGRiwPuDTX4px/yf2k8+sLfgubgR7TRHgJsLyyzRf
        K6sko0NnFBsm0RpGTxXXY7PnUheccBk=
X-Google-Smtp-Source: ABdhPJxXi5tvtZ3lWXr4E1t/FgsW6Qpm7a109AvW6YcGqGwDIaYsLVT1gwAxLpna/5/Uw4PDHaQtYA==
X-Received: by 2002:a05:6512:13a8:: with SMTP id p40mr14791103lfa.14.1624289783693;
        Mon, 21 Jun 2021 08:36:23 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id x1sm2219464lji.19.2021.06.21.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:36:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hwmon: (lm90) Prevent integer overflow of
 temperature calculations
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210620211408.3893-1-digetx@gmail.com>
 <20210620211408.3893-2-digetx@gmail.com>
 <20210621121229.GB116119@roeck-us.net>
 <ac1c4350-687e-7999-633c-6b7354ef9b8c@gmail.com>
 <20210621142415.GA3604789@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ffedf276-245b-1be6-4182-5d7a117eedd4@gmail.com>
Date:   Mon, 21 Jun 2021 18:35:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621142415.GA3604789@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 17:24, Guenter Roeck пишет:
> On Mon, Jun 21, 2021 at 03:14:40PM +0300, Dmitry Osipenko wrote:
>> 21.06.2021 15:12, Guenter Roeck пишет:
>>> On Mon, Jun 21, 2021 at 12:14:07AM +0300, Dmitry Osipenko wrote:
>>>> The minimum temperature value that is passed to the driver is unlimited
>>>> and value that is close to INT_MIN results in integer overflow of
>>>> temperature calculations made by the driver. Limit the value in order
>>>> to prevent the overflow. For now the overflow condition is harmless,
>>>> but thermal framework won't work properly once we will support the
>>>> set_trips() callback because it will pass INT_MIN value to the driver.
>>>>
>>> AFAICS that should only happen for lm99 because all other values
>>> are bound in the temp_to_xxx functions. Where else do you see an
>>> overflow (or underflow) ?
>>
>> You're correct that the overflow affects only lm99. But why we should
>> ignore it?
> 
> That isn't the point. The point is that you claimed there would be a
> generic underflow, which is not the case. That means we'll only need
> to apply the fix to the lm99 specific code (which unconditionally
> subtracts an offset from the provided value, causing the underflow).
> 
> Anyway, thanks for alerting me to the issue. As it turns out, there are
> other underflow issues in the driver. With improved module test scripts,
> I get:
> 
> Testing lm90 ...
> temp1_crit_hyst: Suspected underflow: [min=54000, read 85000, written -9223372036854775808]
> Testing lm99 ...
> temp1_crit_hyst: Suspected underflow: [min=96000, read 127000, written -9223372036854775808]
> temp2_crit: Suspected underflow: [min=-112000, read 143000, written -9223372036854775808]
> temp2_min: Suspected underflow: [min=-112000, read 143875, written -9223372036854775808]
> temp2_max: Suspected underflow: [min=-112000, read 143875, written -9223372036854775808]
> 
> So we'll need fixes for lm99 temp2_{min/max/crit} and for temp1_crit_hyst
> (the latter affects all chips supported by the driver).

I'll prepare v3 with the updated commit message and fixed
temp1_crit_hyst, thank you.
