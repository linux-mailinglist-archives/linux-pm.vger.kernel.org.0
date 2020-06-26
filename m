Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8027520AE3B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFZIJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 04:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgFZIJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 04:09:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7487FC08C5C1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 01:09:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so7005131wmf.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rbLxPkU5zn6HuEV/rtbUuP7BkhVC3DU9UZS2cCgUUqs=;
        b=UrQ53aSAoNkLtJVEW6BDnSQ+6v0IYcarF2DEe3WeSNTvG7qhv/sVQjRNLftA1/WvTd
         rNga5sYIc0HtDHBmVny1DPoauZqqRn8iO8KpontGuzATd0MHdoAWU2xr9Xj1OdEZFShN
         YDyZbpxLiDck3HTKArsqvk3lNFCR9A3pAYLmA6qSCdm8CfqftPGBgmrcX9TEKwjrXI2N
         5hHn8+dFFTpVRNncH7Cjn1dfaEH2KxtiaeXc3itC4vpSwRpS8lfJSsx5i4+AdUM9twU8
         4t6q0s/b2Yh5yiyi4k3UnlXnyjPddkjPNH2OvXBekElzPhoJferFRvZJdJjRxutlfkZL
         jeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rbLxPkU5zn6HuEV/rtbUuP7BkhVC3DU9UZS2cCgUUqs=;
        b=nKrhTqCtqHXpsT1h5GsfbZk5IqRpo7PdbKV8vbBfnySGmP9vmbNPLtgN7zaicRehxq
         qCOAV3iJQB9XERKSbohODQ+1KCSr2hZcKIaaGgAUz8dFdQPzjcBBNLvV84K90U1PRDDj
         +80BgCXWzuCN7LLKC2JGjcVgXCVjH1N5/VZDVF/Ob/bSoV5SAQ2cwJOb7cDxGmcszyMN
         J8adAmWSsH8Xz16Ewuv5JN8zAE84x8XiaDtb3+4sRsyT9JJUdyFxesgEG9JxGtO2ltXZ
         31NxfZ3VGMey8d01PtrqwZkIYLKn/jmdZKgI3asaC5Dn/IWvdlHOxOA/Fuk2B+5VmESW
         AqTQ==
X-Gm-Message-State: AOAM531K9X6FkXMslP37amPW0DnVdbh3ycQCYtJFoFWDi1fvidgjUpW+
        Wf3jvju7J++wNtCsIOWbDxLuew==
X-Google-Smtp-Source: ABdhPJx1PfO/ReemODrB6fHZaYmkTV/XN0aLHdRmjz7wS+SEB2F1Yigl4vidu1EkS+IX0ywuZs+W1w==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr2196788wmh.73.1593158968078;
        Fri, 26 Jun 2020 01:09:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id d2sm35925710wrs.95.2020.06.26.01.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:09:27 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:09:24 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200626080924.GA281178@google.com>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
 <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 26 Jun 2020 at 08:23:46 (+0530), Viresh Kumar wrote:
> On 23-06-20, 15:21, Quentin Perret wrote:
> > @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
> >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> >  	BUG_ON(!cpufreq_global_kobject);
> >  
> > +	mutex_lock(&cpufreq_governor_mutex);
> > +	if (!default_governor)
> 
> Also is this check really required ? The pointer will always be NULL
> at this point, isn't it ?

Not necessarily in this implementation -- the governors are registered
at core_initcall time too, so I don't think we can assume any ordering
there.

But it looks like your new version has fixed that by design, so I'll go
look at it some more, and try it out.

Thanks for the help!
Quentin
> 
> > +		default_governor = cpufreq_default_governor();
> > +	mutex_unlock(&cpufreq_governor_mutex);
> > +
> >  	return 0;
> >  }
> >  module_param(off, int, 0444);
> > +module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
> >  core_initcall(cpufreq_core_init);
> > -- 
> > 2.27.0.111.gc72c7da667-goog
> 
> -- 
> viresh
