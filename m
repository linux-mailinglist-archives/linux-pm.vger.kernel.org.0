Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4EB31D79C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBQKj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBQKjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 05:39:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A7C061756
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 02:39:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so1367516pjs.4
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hZFcwR5BRWH+3EYg5+obcKKhiEoxlBBTkBhbZP7VP0Q=;
        b=E2O+q3qUGv/vnR2egym99EOzyONntxOQSfwgCiA3Oj3rP579WSkfBMvSI3Ek31ajNn
         K7nIt5+3YSRFI3Zj+wcL2AdTp7RSz22KlJoNwtDyE8R5E11/zUhoD5Q4B4hwTep4NqqO
         pTj/qCOyqVy6HfPaYVKR/9oOI0uiRk7UypHtMqPqA43gLFE6zKVudWrpxwetjFs1Kguv
         /87sPB7Xl/YqYl24I9wOaF1FY91cBOAqbVtZszUnwdUYr+NQH9uOEtvAGDzLAtTX7Yq2
         130hgYhljzG4a7C1kpFsbf45vzl92uoXSJ3NbbNRN3Xlbp0tH/mPMYaEBk/G+HKPjsxX
         1l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZFcwR5BRWH+3EYg5+obcKKhiEoxlBBTkBhbZP7VP0Q=;
        b=lTUoc76usQeY1UytQDX/z3QWhaYYKieJkdgz00l2oLxLnKkTpyhJjJNlMoZ/wTWNMu
         Q0/GD+jwl6eNs3TtLiXmP6pyMm6loqzvhaXH7u3RPsoPdjBBzzpXEO2DYP+TRD6ZKzuq
         SCLrZCH8a8AJVr79BFyS+jN5pMt7GdlsxRLeXBYH5SjfTmjbZGriUZWPO+uS8O/B69j3
         UpxTEwj6UQ8CX+UZy5nSLKkU3Ttn6wOv9uU4rZJaX+psG6MyyewP9eLmC6dXBAJQmzss
         bv48CodFY55BM66+/+PhzJSGsX6JMS80hWO//xb8qhCVDjmVCb4TO4x+neyXZoS/1qrr
         4F1Q==
X-Gm-Message-State: AOAM532gj/JwoueyXmX7GQYCNSfR8WdfyhGg15gAu5vKlf4uwZbZvp67
        HvIGB60XKyp/O5SSZGPQRts2pw==
X-Google-Smtp-Source: ABdhPJx3xROzVqnQy00H9CkkHbW2uVh8IV36hU56AUZJi5cJGXWOlqpUOqxggnmYTDM4OHZiOwo8og==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr8673581pjb.18.1613558353955;
        Wed, 17 Feb 2021 02:39:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u129sm1996908pfu.219.2021.02.17.02.39.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 02:39:13 -0800 (PST)
Date:   Wed, 17 Feb 2021 16:09:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "v5 . 7+" <stable@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: cpufreq_cooling: freq_qos_update_request()
 returns < 0 on error
Message-ID: <20210217103911.n34zzjttyso7dlco@vireshk-i7>
References: <b2b7e84944937390256669df5a48ce5abba0c1ef.1613540713.git.viresh.kumar@linaro.org>
 <91749e19-9091-1292-b8aa-c923efa8021d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91749e19-9091-1292-b8aa-c923efa8021d@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-21, 10:29, Lukasz Luba wrote:
> On 2/17/21 5:48 AM, Viresh Kumar wrote:
> > freq_qos_update_request() returns 1 if the effective constraint value
> > has changed, 0 if the effective constraint value has not changed, or a
> > negative error code on failures.
> > 
> > The frequency constraints for CPUs can be set by different parts of the
> > kernel. If the maximum frequency constraint set by other parts of the
> > kernel are set at a lower value than the one corresponding to cooling
> > state 0, then we will never be able to cool down the system as
> > freq_qos_update_request() will keep on returning 0 and we will skip
> > updating cpufreq_state and thermal pressure.
> 
> To be precised, thermal pressure signal is not so important in this
> mechanism and the 'cpufreq_state' has changed recently:

Right, I wasn't concerned only about no thermal cooling, but both
thermal cooling and pressure.

> 236761f19a4f373354  thermal/drivers/cpufreq_cooling: Update cpufreq_state
> only if state has changed

This moved the assignment to a more logical place for me, i.e. not to
do that on errors, just that the block in which it landed may not get
called at all :(

> > Fix that by doing the updates even in the case where
> > freq_qos_update_request() returns 0, as we have effectively set the
> > constraint to a new value even if the consolidated value of the
> > actual constraint is unchanged because of external factors.
> > 
> > Cc: v5.7+ <stable@vger.kernel.org> # v5.7+
> > Reported-by: Thara Gopinath <thara.gopinath@linaro.org>
> > Fixes: f12e4f66ab6a ("thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping")
> 
> I'm not sure if that f12e4f is the root cause.

Hmm, depends on how we define the problem :)

If this was just about thermal-cooling not happening, then may be yes,
but to me it is rather about mishandled return value of
freq_qos_update_request() which has more than one side effects and so
I went for the main commit.

This is also important as f12e4f66ab6a got merged in 5.7 and 236761f19
merged in 5.11 and this patch needs to get applied in stable kernels
since 5.7 to fix it all.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Hi Guys,
> > 
> > This needs to go in 5.12-rc.
> > 
> > Thara, please give this a try and give your tested-by :).
> > 
> >   drivers/thermal/cpufreq_cooling.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> Anyway, the fix LGTM. I will have to make sure that I'm CC'ed for these
> topic, so I can have a look (I missed somehow 236761f19)
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks.

-- 
viresh
