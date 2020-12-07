Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255F2D0CC1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 10:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLGJNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLGJNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 04:13:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE47C0613D0
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 01:13:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j13so7071973pjz.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXyGHqMNoAToiZLip7CsylqLRv6dmkkfS4SqiTDrHnA=;
        b=RfA3pAHf0uB8kDYYj9jVtdiymX8U2HGk2Oz6idjWPU0gtUzxQH7entwmB9yomr7zwF
         PxVpEMh6Rjj9hBkLtQRKjZpGGUidn/XPCCZ/Tv0TYLu3hA2YcXPN5CRvls74eXc92Z5M
         ctb4S3aMmOZcrUPY5RdPVzaQsEr40wKSSxlpQcmvm2gvvPNB6oEdrZOhF2Cb9q2ZYo4W
         iDiK4aeyj+8wXV+rUeOKKUzZLibsm2gAcvzj9lKXgXPl5h5sf2KhTQoovbwMEZIOb6u/
         MSLtG2i6vTQmmgJXsxlCuVvMovUDwKG1s9YlCNqH8xiyJ+Bds7m026rAZeJFYJDQ53Ny
         6NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXyGHqMNoAToiZLip7CsylqLRv6dmkkfS4SqiTDrHnA=;
        b=UfgS6wZMBk3ORexoZ2PqrSFbDcJiRwHWJFPAODb12oMaOno0zX7TlWdFc1n0TeLXC1
         qXk9brmNLSN2I1ywjHGkfAy4tzl3gBIkgWfkGL4i+YqAmOocsnmZXcLZu7m2D4pWRsJf
         igxK+QJNf2iC1Szjdsq/OmpW+woo9O0dW6WUGTO1UH45wcpsoVC1OdHtOD9LMdaXVJXE
         Yz/StiTolXMnrdMVGkIUzjN+O+FLc9gVbyhzm6sJQfwVw1B6f5Jsll03VqHUGn6IHLDS
         a/rQ2WiiDQXxVZu6AeyBbi3N8Tp8m8qYSXBpHbmsc6Iq7s6T2GMFQAxANwJW97VKETsd
         EQgA==
X-Gm-Message-State: AOAM530MuAM3vx2q4I+iIoqb8ZAyzHtQKXd9JVN0Xseov5bVyH7Z7na+
        nemXIEMMtDKkTMt/F8L3ATeesg==
X-Google-Smtp-Source: ABdhPJzBRx7PrG7qtbioRHziCz+qPK7rVoQ62jUWugl/HEXUxpKFu7ssRkYNkjaYqXmqItxJgvSK5w==
X-Received: by 2002:a17:90a:8b8b:: with SMTP id z11mr15577306pjn.117.1607332395854;
        Mon, 07 Dec 2020 01:13:15 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id l10sm9616503pjg.3.2020.12.07.01.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 01:13:15 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:43:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/2] thermal: cpufreq_cooling: Reuse sched_cpu_util()
 for SMP platforms
Message-ID: <20201207091312.cyi6rkt3owlkwsew@vireshk-i7>
References: <cover.1605770951.git.viresh.kumar@linaro.org>
 <1fa9994395764ba19cfe6240d8b3c1ce390e8f82.1605770951.git.viresh.kumar@linaro.org>
 <jhjzh2xtp45.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjzh2xtp45.mognet@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Valentin,

On 01-12-20, 17:25, Valentin Schneider wrote:
> PELT time-scaling can make the util signals behave strangely from an
> external PoV. For instance, on a big.LITTLE system, the rq util of a LITTLE
> CPU may suddenly drop if it was stuck on a too-low OPP for some time and
> eventually reached the "right" OPP (i.e. got idle time). 
> 
> Also, as Peter pointed out in [1], task migrations can easily confuse an
> external observer that considers util to be "an image of the recent past".

I agree with what you wrote and such issues may happen here as they
can in case of schedutil as well. The idea behind this patchset was to
get the allocator (IPA) and consumer (schedutil) in sync with respect
to frequency and power. It is better to allocate the power that
schedutil is going to request, then to allocate something based on
different metrics. If there is a problem with PELT signal then I will
let both the entities suffer with that.

-- 
viresh
