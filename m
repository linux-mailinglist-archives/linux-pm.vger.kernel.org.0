Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B271723D2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 17:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgB0Qpv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 11:45:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42593 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbgB0Qpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 11:45:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so4207730ljl.9;
        Thu, 27 Feb 2020 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wVNFcIlBUE9RxinpT2V+KF01085Ap+cWrCWblxB3kzo=;
        b=lo+lBayS6a01ISYJ7chK3YPXl8VJlAX+zC+JyxsrdKlxc54e7G9/IVxdFy+dbNJrLd
         OjLppMBG9NAHXXqywhlJ6crXvV57lsMwk9f6YN+b3mddVt5a5aNY8Y4aUMm0AJSiepIg
         WMr7TYua2I9JZSbtcwql76J/cLWQ61GLC2jwFcAMWkJyUjKKeoQiQmIR24yQMVyzWzdX
         SLpcuFSIHDt2eZs5LmkqsPI3iItsXFxe9ZhqPK8Msk5Zz2Nvd0S6dRrO5NO8jzUx5ZHz
         4rhRREC+MuW+JozkTC3Bu32df/mn5QSzr515Hv5K/GRgRnW/xhASukYfq3Ox4WuW/7Vv
         v46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wVNFcIlBUE9RxinpT2V+KF01085Ap+cWrCWblxB3kzo=;
        b=GmZl1y+/grp2km6qcJ728ALIkXD5b3+jOxitgKzW0NsgxyFHtGE27QZozL12tlwBRq
         GgsH63BrW0BAi6mAiwCMAOkJq17Z5vYnhlPy0siRlOeGN0MDbcusOnHZk+nIe4Rofkw0
         rPWb24sdqetTKfyDvZ3Csn9yt0WrclBpheC3W2wprSBuTDtLCZqjvn2m++YqS/3W3sZE
         BhcTEFN7puyTI/39BUDFr8fxkG6+xsJ50zEiXk92G1KRxVcoteO/BqmZz3lplCYpkeZD
         JqTqKZgz2NS89boyh41MHeBX8rGrXnwMVmvaJVFTWlyy2AOGkd/Oij8RUUN6ETROeKVR
         BrLQ==
X-Gm-Message-State: ANhLgQ1GBI7BJv//aT8KZxsHD5zBbGSJE/DTJ0tZ9nI/OMn9l/13Qvg/
        q4bCPrL+CigTI64MbrnZtmFChxlS
X-Google-Smtp-Source: ADFU+vvl7Ppl4IgVJKzIc35yc7GsPEAc4o9RTr0Yf+7YCzTiSIFWHuhjs8G6wF6GCth9q9RI5/y+4g==
X-Received: by 2002:a2e:9e19:: with SMTP id e25mr233139ljk.179.1582821947568;
        Thu, 27 Feb 2020 08:45:47 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i1sm3637987lji.71.2020.02.27.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:45:46 -0800 (PST)
Subject: Re: [PATCH v11 14/17] cpuidle: tegra: Squash Tegra114 driver into the
 common driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224224057.21877-1-digetx@gmail.com>
 <20200224224057.21877-15-digetx@gmail.com>
 <dcf45352-8ea3-6273-b4e8-0142f5d5e9f2@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4f452e32-10c4-b906-7d22-dc8977962666@gmail.com>
Date:   Thu, 27 Feb 2020 19:45:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <dcf45352-8ea3-6273-b4e8-0142f5d5e9f2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.02.2020 12:21, Daniel Lezcano пишет:
> On 24/02/2020 23:40, Dmitry Osipenko wrote:
>> Tegra20/30/114/124 SoCs have common idling states, thus there is no much
>> point in having separate drivers for a similar hardware. This patch moves
>> Tegra114/124 arch/ drivers into the common driver without any functional
>> changes. The CC6 state is kept disabled on Tegra114/124 because the core
>> Tegra PM code needs some more work in order to support that state.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Awesome, thank you :)

@Thierry, could you please pick up the updated patches for linux-next +
pick up the cpufreq series? Thanks in advance!
