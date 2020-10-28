Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189A229DD26
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgJ2AfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 20:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgJ2AfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 20:35:18 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A28C0613D1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 17:35:18 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f4so591744vsk.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWYH94BORZv4ozup4OC59HMYznaFyiTGBncXRcc6tuM=;
        b=YXgUXHApiqcAnVatjPnEi407J7W2aEza7kXEObfTTVd4VTsEZwUSGbitW4GzZ44reN
         HL52RtVoffqrmmiRa+J70ZoM0IBk8HwhDGtbpoJosVs+5haUvB6Bf7mQiSB3rZAgcOki
         RMbhDoTHDUm0PK+fgKRoV2b5Qd7NkcKwkQB3tDXHJ59EbjLL2S3nzrbIm0eBy3ag3kSs
         C6WC8KlnfhJ7qRGM3u15oVHwr0039EAlAbRtfkWqsuPEeXVWkUhHyokqVdAzCjydisum
         qapHgHsBv9KYGQexSIGxivUrVR0j7yNmiNHhrA6QR9mdKUIvw66PVHpD3nM/I9arppu0
         7Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWYH94BORZv4ozup4OC59HMYznaFyiTGBncXRcc6tuM=;
        b=JkX/BlHCjRlK+uGLwB8fyC6Vx8z6Qfwvkl6G2mQZyF90yQtZwREPa25lSoYH+1ZKja
         garsDf+rTtVcE2kP9sWz3aZsIGxcY7IvVmUexlR/JCyx4SfMzLDSzgSfJx0VAu2H4uYr
         DZuN26tCQ88GdyLDyHxRFIo20jKIAFP4cr29YQOMexOQ7qmXIsr8MloxLpRigISu7HC1
         eRFm+W06CG4/AjyXSUJkrrL9V8PMHUAssJW/qIUpShkS/JICeCK+uYHEZTx8hqRlP4Xc
         Mqrq9JSek4CPqqftRnd5wEkHj52BZLMqF908zZ7NW3QNIjf72nFhq0ZUII8cgJ+pFBQl
         6f2Q==
X-Gm-Message-State: AOAM533W00WfaeD//fcZBcuPTiNXgb5dYRgedz0TyZcEk4LgkB3hVSri
        L5gxMtCESuu6XOCIhKmUEPVT673yUFrDow==
X-Google-Smtp-Source: ABdhPJy32sza5hlY9q9DusherzKtC59C8yPszw9dBZkXd2Ch6JlZ9EJGtRX781Qk5m0PYnI6dFRCzg==
X-Received: by 2002:aa7:9095:0:b029:164:75c4:5d15 with SMTP id i21-20020aa790950000b029016475c45d15mr578656pfa.49.1603864199760;
        Tue, 27 Oct 2020 22:49:59 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id v79sm4207978pfc.197.2020.10.27.22.49.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 22:49:59 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:19:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
Message-ID: <20201028054957.vr47r3wd3zjycten@vireshk-i7>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
 <20201023103407.GK2594@hirez.programming.kicks-ass.net>
 <20201023105452.aivb5o6dws76evc3@vireshk-i7>
 <CAKfTPtBgqiR1zaoqL_q_sMNnXYrzZczTeE1TMF+WR6knHFjGRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBgqiR1zaoqL_q_sMNnXYrzZczTeE1TMF+WR6knHFjGRw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 14:34, Vincent Guittot wrote:
> Maybe it's time to make sched_util and pelt available for !SMP too.
> 
> With util_est and uclamp, I can see some benefits for !SMP compare to ondemand

That's a decision you guys (sched maintainers) need to make :)

-- 
viresh
