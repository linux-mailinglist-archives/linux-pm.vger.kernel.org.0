Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E85209B91
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbgFYI6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbgFYI6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 04:58:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78D5C061573
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 01:58:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so2014868ljp.6
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fQj8GSzsb1+pdtgnS8aKkWuOlGiJbZZkRjMYogMxMTI=;
        b=1EWytFWvMUGPjkoyq01zk1IliKJQ84AmrrPW33B1e7rNo9Ut8nGhjDBjgaU9Qgkfff
         KrU1gDUGypDzp2buWc0un/jKmONipjFfHGZD1TnfljvD02mLT9vun0t7fLA4Vz7PZhps
         ok5lX6EWdv4mxfGY9VwTciEkkifSvCHENNXcaIgrA+IxSkUpiHKQwfWpBH+Hy2sLzkGX
         uh2kpE1K3RgGkP7ACtHMJjJlaLuH3LLkpGZl8agU/yxLTymwULCUYZQGvs861TAFMbKP
         QhWuWD/ozt9lTu9FQaQRiuzzh55vk5JZaD7OouF9QZyS05g6xC+89M4IoYNDhB0mg5FZ
         XJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQj8GSzsb1+pdtgnS8aKkWuOlGiJbZZkRjMYogMxMTI=;
        b=ElqbzEnkPUDggeGs0q3ApuLumqTYqjhtu+QrerfGwzSvEBPfns4RIb/FKL9cKnxleJ
         dbPUpP7YHmMp89YbRRQonaSKNsqU4ZGWQFIUG2vpKIcv3nD4EQIxxRKpGlL6dYW0ANuG
         KQ+D6k7wi7NczAxSNOf2wB3zYU3A5RhTdP5TJt3yQfliqnP9+NmLY606puLUGEqukEq4
         4UW9jGpfr6+dXvK1I1w2HTT8Mhy43ORBou3yzH6egV/C+Is8FKIVbDbhAhy8bOGzzYJz
         oJ72slaOElttXU1bo0+jg48qX6sAD3x3y/MvQeJ7PnWqwmL0IDuPU4R62JzAFgwUwUz0
         Lg0Q==
X-Gm-Message-State: AOAM530RTxQI7haItkzBGvJqrC+Gy6v9BEApdyQBExHeegisBb7NGsZ3
        GEx+225aMFcw4BVb5LB6HuQ/sg==
X-Google-Smtp-Source: ABdhPJyO5HRSKP5oqtkzIm8TtNZ0ZVzBzQuBPqObhKqjTV1lNH34HDQicYxSmxAYD7MnkvyMmcSsZg==
X-Received: by 2002:a05:651c:338:: with SMTP id b24mr15335953ljp.87.1593075479157;
        Thu, 25 Jun 2020 01:57:59 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:44da:b8e6:887f:f9f8:ffc4:9fb8? ([2a00:1fa0:44da:b8e6:887f:f9f8:ffc4:9fb8])
        by smtp.gmail.com with ESMTPSA id w1sm4690973ljo.80.2020.06.25.01.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 01:57:58 -0700 (PDT)
Subject: Re: [PATCH v3] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     niklas.soderlund+renesas@ragnatech.se, van.do.xw@renesas.com,
        dien.pham.ry@renesas.com, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <db9e3bd3-d3f0-61d2-7ffe-3306003f57d8@cogentembedded.com>
Date:   Thu, 25 Jun 2020 11:57:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

On 25.06.2020 5:56, Yoshihiro Shimoda wrote:

> From: Dien Pham <dien.pham.ry@renesas.com>
> 
> As description for DIV_ROUND_CLOSEST in file include/linux/kernel.h.
>    "Result is undefined for negative divisors if the dividend variable
>     type is unsigned and for negative dividends if the divisor variable
>     type is unsigned."
> 
> In current code, the FIXPT_DIV uses DIV_ROUND_CLOSEST but has not
> checked sign of divisor before using. It makes undefined temperature
> value in case the value is negative.
> 
> This patch fixes to satisfy DIV_ROUND_CLOSEST description
> and fix bug too. Note that the variable name "reg" is not good
> because it should be the same type as rcar_gen3_thermal_read().
> However, there is better to rename it in a further patch as

    It's better.

> cleanup.
> 
> Signed-off-by: Van Do <van.do.xw@renesas.com>
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> [shimoda: minor fixes, add Fixes tag]
> Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
> Tested-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
