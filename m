Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABE2AB181
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 08:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgKIHAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 02:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIG77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 01:59:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A3C0613CF
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 22:59:57 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id z24so6341317pgk.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 22:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a31SK/qb8dqpXv8PZA8tXebjDkucH7GRxd49ZlBWSb4=;
        b=JUlMujb0yYGNXl7MjWe2ujzAMl0DfC8/v3VWxwwI7yU0aj9U2xHgQVVlcpzgPDieIf
         /s31/ltC5CbugWyX2lS1Ryh/xiPFPka+rlFArDKG84AEvyO2X/qmxirywcx7ZRHKtBZ6
         AABCy2asbqlA+YBD8/Sr521/6aHJL9IFoPSipiONMs/8x/sjtJN+0ZYwga3sXe5olC0A
         d+a6SUcbYUnLpO/71YQ1C6wZeLYU3is+Slk1eIf+R0HPKkUWf4gL5ovJyBlW5nusXaZX
         NbF+SIJCftWWMeRPjin6VxUpodycImFs3r/Ytwp7WvmGAV0Ex9i/7MIBJ0UeGEcvrekR
         PaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a31SK/qb8dqpXv8PZA8tXebjDkucH7GRxd49ZlBWSb4=;
        b=rIPxsHgcc/SQuTGxW6FNnZ9FZ05U+Ko+4dyTblAVeepCM1e5K/nDZoafKSNLrVjwLb
         Y3ESJHzXZrPF7cz7FAhDeg6yroTTI6a5B8N3S6PBNTLnLNhB6A0/HCzd2E0VUaYdFsBD
         vbSNwb5LRtdLJO12JSul5P+94K6vAR1QpScc4g4OL4MRCi3lgFOVkJ68llRyRGNlx99W
         Uw/hGRQ9L2hSeIMCg346PBtcUQjftpsCY35atUH7MNYmGNifMMSqwdj59N2rz1e3wwVm
         5eftbukIPCyQE8Yg1ShSCdov0dhSn+m2FWJpIeIxBY4gWKD/Pc68ACerjXXuURCjrMuY
         QmaA==
X-Gm-Message-State: AOAM532KSzJs472c2K124EsLI6FKcTONi9UustnUciZE+QAekbG5HLmY
        3/rMoJUvX90ArKqD7pSWv4yRuQ==
X-Google-Smtp-Source: ABdhPJyfvrlGyz61/SbF5FcXsen4Dk77CB/SrqBvQNPM0ZmRjCXZttoLdWQcNsgGMiKTlpid3cgNjw==
X-Received: by 2002:a17:90a:de15:: with SMTP id m21mr11923823pjv.180.1604905197349;
        Sun, 08 Nov 2020 22:59:57 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v186sm1659890pfb.152.2020.11.08.22.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 22:59:56 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:29:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] cppc_cpufreq: clean up cpu, cpu_num and cpunum
 variable use
Message-ID: <20201109065954.zjrghmexd3dptat3@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> In order to maintain the typical naming convention in the cpufreq
> framework:
>  - replace the use of "cpu" variable name for cppc_cpudata pointers
>    with "cpu_data"
>  - replace variable names "cpu_num" and "cpunum" with "cpu"
>  - make cpu variables unsigned int
> 
> Where pertinent, also move the initialisation of cpu_data variable to
> its declaration and make consistent use of the local "cpu" variable.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 143 ++++++++++++++++-----------------
>  1 file changed, 69 insertions(+), 74 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
