Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC022202FE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGODl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 23:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgGODl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 23:41:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17833C061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:41:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so1885334pjc.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vTG1xamLSWn3+gjpIQxGwQTRUmaQ7UcFDFjtnK+VAKI=;
        b=SNkj1nFUb/t+RuAmTygCKpTD0PfGcdL9in336B12K/AwZ/knTpnpA3PiN0VgEmKaAm
         aR/LFJr2OAohyyNODc8u23ouAF/UnMTM/RIBNY06UXq6ZAvZHqGpYel1z2ZKaNBh6vki
         VzG34DiD7XEui+AXbg33Ir2hM/8L5yP6RcX7o0PIipbNCRjfenSoh0nG3QPRGg90t6+2
         46fZXigjVaRTIDaNtDXIx4vYpq0uqAJZ5oZmocC4CW376L3q8nfiHUCGp7TgphVTAEmc
         tQDKvL9aaKyDMFrRQi7LoyzPLxWt8oa7rp6OTV6M8JJLpbOj14PCYp78dAFyyzb4UWiS
         5uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTG1xamLSWn3+gjpIQxGwQTRUmaQ7UcFDFjtnK+VAKI=;
        b=qiXpe5DN4uPKJrzWCMOm0Whu8AAWln3vOXK1F2s9pkVZEp5yGnvcrLNMiBorHq5FhN
         zUcF87fLScSTPqalv7fnf7TVfE/C2pq72QGJHxdF3l1qwq00Dc21dak14WIjZh1Q5KUU
         TnhjaQRcglxZIoXVyBiQ99LpJDi8gHkMeYHwkevzWfHwBwpmSwm+UV30gRuE0/c5aoBI
         yL21Ri8rdelOuUFG+NYhsQXKSH3buUPs2j3blEP0Eh+OWetmTihNOBUWh6MqZv0XjnWS
         VM2ze2uo7uiglWpMnSOLViJldaqn2Jt9kzHf3iWE62GapwCQmI6MWDJYYiIMR20j3ahx
         L5+Q==
X-Gm-Message-State: AOAM530mxTfycza2kWWfVemczORpFnIrsrTzO9++7pKo9gK2uO5ATiWM
        XPQVG29cQLqlPd1gWke8XhdiZg==
X-Google-Smtp-Source: ABdhPJxJqZELAUdvWQzhKMiCqkL3CT9TroksY/E+OgIBdQMY5m4nMaJXdU8P5LtvJ/r9I2eH00/CbA==
X-Received: by 2002:a17:902:c402:: with SMTP id k2mr6251062plk.185.1594784488572;
        Tue, 14 Jul 2020 20:41:28 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id o18sm534061pfu.138.2020.07.14.20.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:41:27 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:11:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>, lee.jones@linaro.org
Cc:     Hulk Robot <hulkci@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] cpufreq: powernv: Make some symbols static
Message-ID: <20200715034125.6x37w3csqmnia2jg@vireshk-i7>
References: <20200714142355.29819-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714142355.29819-1-weiyongjun1@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 22:23, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
>  symbol 'pstate_revmap' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
>  symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
>  symbol 'gpstate_timer_handler' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
>  symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?
> 
> Those symbols are not used outside of this file, so mark
> them static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Lee also sent a fix for this, but yours look complete :)

https://lore.kernel.org/lkml/20200714145049.2496163-7-lee.jones@linaro.org/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
