Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F033E1C5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 23:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCPW5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 18:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCPW4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 18:56:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67304C06174A;
        Tue, 16 Mar 2021 15:56:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 20so25969lfj.13;
        Tue, 16 Mar 2021 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wLg47B/AUgciaorlDGJkN+ovMSLy89KbICE6kVN8kNo=;
        b=ueGVsl+nBjXtDGVKSJrlDWN3+r+4XYktLURYZS8E7OPlOb3VqBjNq8ymlog3Z8SBeM
         y+tBOebjwxc8/vhsTFYjzCGqyPOfTNoBFkG36KG6MG63DhPqJ2SvOXPI3EWE/xbivMSZ
         X2EXbxS6/lH+vxdnXxCOELjD+XwFqRUzwywsLiAjo2eW9U5IwpTP8+XQ4Eg2VEwCkiX8
         hzziE5vMrEtqTbebDR7aToxhQciDPxU+KYqGXA7DOM8UjGwaR9Efafw+lk+6Scbvl26n
         UiTW1dKNskJkRV7tlbkTTBC3gOSkOZomnqgbBUMUvPMZUy/T7SnXhCjyH0hDUv2H33f1
         bcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLg47B/AUgciaorlDGJkN+ovMSLy89KbICE6kVN8kNo=;
        b=NMV3qlgIRwMs+WUAsIIBcfWzP3eDY4BNKTfrzxMukbrrcIWdWCA+dfGCF5H62C4dex
         37iLqbWpzKFGzwG4AsNfqslYUbK9szkJgrxSMXKpPtGlmYxpjpXEyLGFqpri+Ex0exW+
         6ecMuQ8sB1wmgB51LMrykLG7P0QMzJueYrY4zp+dywRrTkpG3gAIcqk/9YIyNcM0eYwE
         /DsYfvciNRaNOs/SMSeS9AUb6ohHXWGrnkcOitL9Tyv5MaBr25OIAOG82eZpIYe2fBLj
         HJ4ouIgGWI3NyiYJER49X0v0z43KwiX/v5Eg2tLwhI2xUxS7ZrxYMbTKfRLXU2AMbyjY
         diXA==
X-Gm-Message-State: AOAM532UomtqmiPiF42u/vlspJckslQuUWkwFh8V2kv1oy89PAOWTWtw
        TOU3ZiB1Dz385dV9eTsWRwE=
X-Google-Smtp-Source: ABdhPJzZ7uBVGHZZTofmoJL/AsPmI8yLkdkuqSbSTv013CXLLTBqYD/9Bh6EH8kl6rjB3TwFGmTsng==
X-Received: by 2002:ac2:51dc:: with SMTP id u28mr573234lfm.322.1615935399908;
        Tue, 16 Mar 2021 15:56:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id e18sm3324938ljl.92.2021.03.16.15.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 15:56:39 -0700 (PDT)
Subject: Re: [PATCH v15 1/2] drm/tegra: dc: Support memory bandwidth
 management
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210311172255.25213-1-digetx@gmail.com>
 <20210311172255.25213-2-digetx@gmail.com>
 <20210314223119.GC2733@qmqm.qmqm.pl>
 <1158bbca-8880-918d-7564-e2e30552e6b3@gmail.com>
Message-ID: <49a69c69-44e7-741f-b86b-ef4fe83c76b1@gmail.com>
Date:   Wed, 17 Mar 2021 01:56:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1158bbca-8880-918d-7564-e2e30552e6b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.03.2021 21:39, Dmitry Osipenko пишет:
>>> +	/*
>>> +	 * Horizontal downscale needs a lower memory latency, which roughly
>>> +	 * depends on the scaled width.  Trying to tune latency of a memory
>>> +	 * client alone will likely result in a strong negative impact on
>>> +	 * other memory clients, hence we will request a higher bandwidth
>>> +	 * since latency depends on bandwidth.  This allows to prevent memory
>>> +	 * FIFO underflows for a large plane downscales, meanwhile allowing
>>> +	 * display to share bandwidth fairly with other memory clients.
>>> +	 */
>>> +	if (src_w > dst_w)
>>> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
>>> +	else
>>> +		mul = 1;
>> [...]
>>
>> One point is unexplained yet: why is the multiplier proportional to a
>> *difference* between src and dst widths? Also, I would expect max (worst
>> case) is pixclock * read_size when src_w/dst_w >= read_size.
> IIRC, the difference gives a more adequate/practical result than the
> proportion. Although, downstream driver uses proportion. I'll try to
> revisit this for the next version of the patch.

I tried to re-test everything and can't reproduce problems that existed
previously. We didn't have a finished memory drivers back then and I
think that Tegra30 latency tuning support and various Tegra20 changes
fixed those problems. I'll remove this hunk in the next version.
