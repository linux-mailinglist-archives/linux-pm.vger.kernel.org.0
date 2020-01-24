Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614BA1489BD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgAXOhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 09:37:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35703 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387691AbgAXOhK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 09:37:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so1925883wmb.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzsZn5YGBm3wUhQPoMDUJ14zEU+MEc78x4rzaBDLSP0=;
        b=G4PCXCZvqK2HNyrqpe/9EKycb+jQXw97AZkRxWS9FasZLV3pYn+fkJ1xa1QmczUANh
         PZQWXmEaQFOnW9EpzrRP/J7zOtCN7iy2MIdoGWSpUPdIoxynMQ3KWZh6W9fxM1w55urS
         oCRqjJmrd9DrJRcfO1teS8g8zNr/5XJJycB8t40LS4sHy9sVgls/wyDfKwVPK8sq4PbD
         Z/n+2MMHuoCSzBI6hRHHirCQyy33Axe6x/gM7tn+Q96IKsdn7lOSybmec5hqZ29PRzSt
         J4J3bpoBYjTnNWrT9kMH6N08+3+irqZ547Dx1GLy99S0ZVBl7v4cdRzBAvCaZYbKTJC6
         NasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzsZn5YGBm3wUhQPoMDUJ14zEU+MEc78x4rzaBDLSP0=;
        b=P61gdOaZMhXP3Fz2DTYdieCrR2zOuD+lMVMtPM1p/lI989B5JNeRm9SukZ1jTPKMm0
         p8rhFS2Z7HTttqQs9kJpd4qeDEfgGS9c2PjhsGSuSqm3Q9yhHnVyYaOKeYDrspf0Tpgt
         U6j+AGl4/w+UhQqCsLBpEcQdyB0eTsJIlA6d9vFMKn52khM9mky4ifIRkrWHqRy3ayJ2
         Xa8FtPE/efczjXAPjYdZ78e3z7dpMv6nP4TVP0RiksNaah3817IRhTN6djdB0zfqWORW
         xgzDDs3RcXll5oBFhhzQ3GZS99SYsr0x4zVvj5v54ix4qxD4uXJzIEp6GEP3gL3ZWhe1
         ujtg==
X-Gm-Message-State: APjAAAWeNy0OCVaHLDZESuVtsLdHarbESoDbkp3x50H6W8GuE56hS08g
        aKu2aDsbz6TXybtM84E1b0/AtA==
X-Google-Smtp-Source: APXvYqyMVfaMhToiGNn5b34BkYqDXlqLtMg4JBeFdVJpPM+zLlKRZ/0/+kA99MsGFZbIep1CF9uRPA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3569784wmd.23.1579876628063;
        Fri, 24 Jan 2020 06:37:08 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s19sm6831173wmj.33.2020.01.24.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:37:07 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:37:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
Message-ID: <20200124143704.GA215244@google.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
 <20200123161644.GA144523@google.com>
 <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 23 Jan 2020 at 17:52:53 (+0000), Douglas Raillard wrote:
> We can't really move the call to em_pd_get_higher_freq() into
> cpufreq_driver_resolve_freq() since that's a schedutil-specific feature,
> and we would loose the !sg_policy->need_freq_update optimization.

Depends how you do it. You could add a new method to cpufreq_policy that
is defined only for sugov or something along those lines. And you'd call
that instead of cpufreq_frequency_table_target() when that makes sense.

> Maybe we can add a flag to cpufreq_driver_resolve_freq() that promises
> that the frequency is already a valid one. We have to be careful though,
> since a number of things can make that untrue:
>  - em_pd_get_higher_freq() will return the passed freq verbatim if it's
> higher than the max freq, so em_pd_get_higher_freq() will have to set
> the flag itself in case that logic changes.
>  - policy limits can change the value
>  - future things could tinker with the freq and forget to reset the flag.
> 
> If you think it's worth it I can make these changes.

The thing is, not only with the current patch we end up iterating the
frequencies twice for nothing, but also I think it'd be interesting to
use the EM for consistency with EAS. It'd be nice to use the same data
structure for the predictions we do in compute_energy() and for the
actual request.

Thoughts ?

Quentin
