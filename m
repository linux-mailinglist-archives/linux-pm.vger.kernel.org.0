Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32F44F667
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVPHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 11:07:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42549 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVPHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 11:07:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so10000696qtk.9;
        Sat, 22 Jun 2019 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbUv5Ghr2QUEpwlMJyUaWOcmUJZ/i8veZoTP8QCCKKo=;
        b=bux3eERfT9v0n1r99AC5YnwdZOoOPt9Gf8McdzxCGPLnXp6BM2TFYr0P207lgK7bNW
         R1LqhDKLEjzoFCnCni90/Vf8HVHL0FewydXa2g5SxNe9zhtP7jdjGwnw15T8Zb3hc4BL
         0Zf4C/sSjsTC2iVqBGwRBGHMt0ig/QuDrOnUmDiM4yhcFnqzinMNtsaFLyHaDMju4sTk
         1v8Vk2KFZnBZq1O+6jLcjU+hBiVfVNlUrxlzhYBEzugiqbNWRA1hsMJwDqa4xCVPc+Vb
         Hr0ahmxEoKWx+t9OnqIADxuh2DHYOtcZA7dmS7m2bwkhTXB5RkfajZnhxzWvgJUziWVQ
         4tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbUv5Ghr2QUEpwlMJyUaWOcmUJZ/i8veZoTP8QCCKKo=;
        b=OmQwheiqZGUsd11QHxw30kWK2srx2BJscZJvSjPHJVtn2G9HxCjQqXst6Bfc3Vwo50
         tMknF2O2ixdDetUYXcBIsLiI5HEgCk6xrRDpEom4WQsMg51biW3XUky5exJemYQVR7OR
         hiPue1ethFCKouzHV/gK+uoXOYbCw+PyGogZ67xvv2RB+a7996u0Jv5WjFDtjE6jC6mB
         86qKOiWGToWjdrnxOs8+y0bNSbN90xoJpulzF4tdAQ19jRjhk/v76ldQ9NUra6IvUtqi
         XUeJ/4yXoZyXkICkibgedKsWsRHzPu3ty3fmuDTUTCNnBR62LshL3bPA6t/Up6Ncrpbv
         xQTQ==
X-Gm-Message-State: APjAAAUrYDBUoBFh0tNPYart4g7/muJBODPrC2OHubCHlkoW1irzz4Jy
        OclBjL0RuW6AJITG63a/fW0=
X-Google-Smtp-Source: APXvYqwU73SsA/hFAtFReQpivN5lJdBJfNcjqquwiaZFBP5h7ofbtO0CeqIzxtNOKXqZEkhn19EPlg==
X-Received: by 2002:a0c:b12b:: with SMTP id q40mr20280998qvc.0.1561216072644;
        Sat, 22 Jun 2019 08:07:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e3ca])
        by smtp.gmail.com with ESMTPSA id x24sm2245761qkf.27.2019.06.22.08.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 08:07:52 -0700 (PDT)
Date:   Sat, 22 Jun 2019 08:07:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 13/16] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190622150750.GN657710@devbig004.ftw2.facebook.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-14-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621084217.8167-14-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Fri, Jun 21, 2019 at 09:42:14AM +0100, Patrick Bellasi wrote:
> Since it can be interesting for userspace, e.g. system management
> software, to know exactly what the currently propagated/enforced
> configuration is, the effective clamp values are exposed to user-space
> by means of a new pair of read-only attributes
> cpu.util.{min,max}.effective.

Can we not add the effective interface file for now?  I don't think
it's a bad idea but would like to think more about it.  For cpuset, it
was needed because configuration was so interwoven with the effective
masks, but we don't generally do this for other min/max or weight
knobs, all of which have effective hierarchical values and I'm not
quite sure about adding .effective for all of them.  It could be that
that's what we end up doing eventually but I'd like to think a bit
more about it.

Thanks.

-- 
tejun
