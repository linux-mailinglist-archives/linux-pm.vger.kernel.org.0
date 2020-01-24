Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B4148ACE
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 15:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgAXO63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 09:58:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35192 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAXO62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 09:58:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so2338246wro.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2kMYwKVMZJJODmSCD9XB1XUy/1Vo4ht1rbsU9Apdvk=;
        b=bkthCIDnMnmz7IMKNGdlKVN9leVC3eeQHCjo7uykoVZG47klS81XDDBrRidkGfyR/7
         mz+/ZCHBzRCgPKMVVHRQLyEPMtyXK8ebtOxJu0hPA4Ej6cC+SUz9h11meJQuamkzmwGa
         /4hzbwju+7guE3O2IFZ3pn5uTfTT2zYW9z+FcA3EXuhHXrfbKfnUnsjP/n8FFaOA982R
         E7Y7viGUZaudicKOMw4T7lXq1JIAiiO0z0u4X6efsTOwbMgsTV2259G899Li1Q/Np+/8
         ulWrL+9Vjt0Ki2qeoeJyDE6QYoT7NRfuo5RPqxPYmeMfHNLJzHSQ0vo3zB6n0lMFri3E
         83MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2kMYwKVMZJJODmSCD9XB1XUy/1Vo4ht1rbsU9Apdvk=;
        b=ubMdudtZvHueE5l/xZNe++pzW1Y7t7UCrzsO0FZBkoTpMpZWD/jKwm+2HsCgSMXjyQ
         dngZSklJ94O91nvuTlay2SAnxHJ6TR6oc/AbOu+dW3nKHREtkDcl8Z4mn5pMr21wR8eX
         rawCoCcKEdNKeNEpyRhfuSMIZ0u+cRHRqKl3cJurK4hPMo93Jtbp8fYXHL4vurKT5Z9k
         zpxAK40/xiEiGxQZ6kXdfDCmhYeJKNK0EKGeaXGLNqTRQb6Dc8k3qh5F4DjqLq4F+d2o
         3tjKuVOaxp9jtlBuvVwiC/Ds4Y/icaImlRTdObDE6IZ0lEcUeYPC7VasqgN8pkxO/wLF
         ry3w==
X-Gm-Message-State: APjAAAUfMw1AEd9KiX25Yi8a5W/3m3Y2GLH89SEFRWsxrFS4MOgjdpc2
        6gig9j3aAmuSC8IvUsVQ5Ig5FA==
X-Google-Smtp-Source: APXvYqzm6jwWCBsOTsmoHYpWta3NHDV77loe37XCpWXtBF3jbOk4inufxpPJJAfjO7rpqpQTd7DeOQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr5067863wrr.226.1579877906269;
        Fri, 24 Jan 2020 06:58:26 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id k8sm7561244wrl.3.2020.01.24.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:58:25 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:58:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
Message-ID: <20200124145822.GA221730@google.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
 <20200123161644.GA144523@google.com>
 <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
 <20200124143704.GA215244@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143704.GA215244@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 24 Jan 2020 at 14:37:04 (+0000), Quentin Perret wrote:
> On Thursday 23 Jan 2020 at 17:52:53 (+0000), Douglas Raillard wrote:
> > We can't really move the call to em_pd_get_higher_freq() into
> > cpufreq_driver_resolve_freq() since that's a schedutil-specific feature,
> > and we would loose the !sg_policy->need_freq_update optimization.
> 
> Depends how you do it. You could add a new method to cpufreq_policy that

s/cpufreq_policy/cpufreq_governor

> is defined only for sugov or something along those lines. And you'd call
> that instead of cpufreq_frequency_table_target() when that makes sense.
> 
> > Maybe we can add a flag to cpufreq_driver_resolve_freq() that promises
> > that the frequency is already a valid one. We have to be careful though,
> > since a number of things can make that untrue:
> >  - em_pd_get_higher_freq() will return the passed freq verbatim if it's
> > higher than the max freq, so em_pd_get_higher_freq() will have to set
> > the flag itself in case that logic changes.
> >  - policy limits can change the value
> >  - future things could tinker with the freq and forget to reset the flag.
> > 
> > If you think it's worth it I can make these changes.
> 
> The thing is, not only with the current patch we end up iterating the
> frequencies twice for nothing, but also I think it'd be interesting to
> use the EM for consistency with EAS. It'd be nice to use the same data
> structure for the predictions we do in compute_energy() and for the
> actual request.
> 
> Thoughts ?
> 
> Quentin
