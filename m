Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92111EDC71
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jun 2020 06:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFDElp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jun 2020 00:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgFDElp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2020 00:41:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC9C05BD43
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 21:41:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v24so1642031plo.6
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 21:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8WDlsjrMlty5dE62ZezIYU+NL84xC3Chb0nBV1myZPA=;
        b=U/1Y6fc0FsAR9q/fDRBBbl4f4ErUS4R91YBctvPmeCyz4QlZMRhbPe4f3+74RBGRWd
         dDgiXGgYoKG17vzZO21zRqkMlPQ/6TUV4Q71GTsjSjlr6Q2dLJNH8A34GhmXD74O8+EZ
         JDkIItQE0Tv6jEgvHP5H5CHgsGZ8cShuYQuNKk4GcxBLssCRu/T6Tb2ZCAJI8yy0w6Yj
         QMNEX9HsXX0bGHCinzKIUrSGirJxIanJ+uVuEtVjq/zxV3JCBaIzLh83xWD0aJYjQAE0
         /e3WnZwWiZAIpHKSLhRejOEOE9ZrbjOUFCGZORu6AVHywzoxSv6NsdHF2grmh8Q4sv7Q
         T1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8WDlsjrMlty5dE62ZezIYU+NL84xC3Chb0nBV1myZPA=;
        b=FahK4tDd6p6vC2MCw7OkllMP7eNlX0a9rYwKs2r5I6dH45Yu+Yo4vzLt6kqFcnA2Py
         X8vkBN+oVDwYSpqW3B3QsLkt4G8pUIqaVA7D/VHwuMJqo/jOcsQcqVv5ZHApGbeiu4vH
         ER/qYYGwGO9E5TaIkmDUs2x9oiE5Ovy7g4jwPgv0bW3VIQUxBnqCiQ3LY1oLbmE+fYz2
         HgChd8EiNzgtkw3rF1+zQphY6HSqCFsugDSs4w1LB24IJOKUs08V17+LQBhi6XokXTmO
         UkzRZChi0lGu4o8FdhNdzMk2ADqK1cuP+O8A6pcHb6vuFYVoHCb3eAw7a9uqj6Mk0ww5
         RrpQ==
X-Gm-Message-State: AOAM5314HWeIdGQrnn1vtXy7aqKL/r2/nIkNf5qAHxjwIfJ0OCI7EbLn
        ZRjIsrCzuGB64tC2iCl64acE3A==
X-Google-Smtp-Source: ABdhPJy4dhvsU8hpYj5pyPZ5zOBHdPM95AWZsa5qnxKP/WfKDaOyJnU6DFKxxSDRmg6+YaD28vtaPA==
X-Received: by 2002:a17:90b:2042:: with SMTP id ji2mr3896276pjb.68.1591245704073;
        Wed, 03 Jun 2020 21:41:44 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id p14sm4185557pju.7.2020.06.03.21.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 21:41:43 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:11:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200604044140.xlv7h62jfowo3rxe@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
 <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-06-20, 09:32, Xiongfeng Wang wrote:
> On 2020/6/3 21:39, Rafael J. Wysocki wrote:
> > The frequency value obtained by kicking the CPU out of idle
> > artificially is bogus, though.  You may as well return a random number
> > instead.
> 
> Yes, it may return a randowm number as well.
> 
> > 
> > The frequency of a CPU in an idle state is in fact unknown in the case
> > at hand, so returning 0 looks like the cleanest option to me.
> 
> I am not sure about how the user will use 'cpuinfo_cur_freq' in sysfs. If I
> return 0 when the CPU is idle, when I run a light load on the CPU, I will get a
> zero value for 'cpuinfo_cur_freq' when the CPU is idle. When the CPU is not
> idle, I will get a non-zero value. The user may feel odd about
> 'cpuinfo_cur_frreq' switching between a zero value and a non-zero value. They
> may hope it can return the frequency when the CPU execute instructions, namely
> in C0 state. I am not so sure about the user will look at 'cpuinfo_cur_freq'.

This is what I was worried about as well. The interface to sysfs needs
to be robust. Returning frequency on some readings and 0 on others
doesn't look right to me as well. This will break scripts (I am not
sure if some scripts are there to look for these values) with the
randomness of values returned by it.

On reading values locally from the CPU, I thought about the case where
userspace can prevent a CPU going into idle just by reading its
frequency from sysfs (and so waste power), but the same can be done by
userspace to run arbitrary load on the CPUs.

Can we do some sort of caching of the last frequency the CPU was
running at before going into idle ? Then we can just check if cpu is
idle and so return cached value.

-- 
viresh
