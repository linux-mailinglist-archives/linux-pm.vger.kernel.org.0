Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360A83A962F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPJdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhFPJdg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 05:33:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186EC061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:31:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t9so1487298pgn.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7INce7DdjlIoO6pQnhmR1LewzChUIQ8ifStkrVLKfI=;
        b=ngcV0jd8lbABGRn4n/Viz6DGYS/tsyOZ08bz5BxdprCpHYNzqYwb8lQ/x2REaG01w/
         H6prjz3FKGb2QoR3ayUXskSrN7PIc7OX5JrqvPOU6ecrRVNcHavn+vRxDrcCnEwVCADV
         BltWngTtzvMUM8BzxPJlu9FySW6YzHqG5VNLUFdu25KEZW2nP/gMhB9zN2mEpuXejnsZ
         XNRCnj7Yh2IDT3Cuq6NdbrBA0gkYaY1r1EY1w5a0dGKuKCMrUdnXW2OsnXm0t2tKU2DR
         P6cYHLEvMeId6xZugCRkqF0l9fitZ2MAwVNdhOjoE7bsH/5OuDbP3YvYI9APunqrpQyF
         Qu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7INce7DdjlIoO6pQnhmR1LewzChUIQ8ifStkrVLKfI=;
        b=ciD9OlhG3f+6wwBAx4E6GsyjF9MUnzo3kzWSjbdK0jCskgR/gDNYDsuA4gdMEhU3Cb
         vgtZZnyAodn+WlWM0N+47A81CYvLGogp29BF52ON5bthlE9jsSCBtq25KhEadfmtG2EO
         KVOY1B7Wl7JREOIx3iAZX6lazVsUkC859FZy9xEk2/nS8cWcUuBBlFUSSZOtrfwMwJfa
         lhAsP7Ujbifj/5i7KYjYzVtBofZMFxm8OJtQIuJx7YiKv9eKPi0WcnfLZYEAjyb/IMBn
         dd099pDGVWTkzUzr1EhH78pUr0BaKegb8oKBshTi6olaYMiCmftiG9mDI3gGvC22CboE
         wscQ==
X-Gm-Message-State: AOAM531WYfYgVsZOwiDgu1UD0xzVv6trrzeD2EW/IzubT/6DmsJcCduQ
        25Q2141984N79uS7rco12lR2le0NVEEMkA==
X-Google-Smtp-Source: ABdhPJxGOQMzinK4SdgVK0mGxrJfLJ48UXNgliAYyQMOmWXK7eF9Hx8X0k7leeRTvsv2+3O+JNzYtQ==
X-Received: by 2002:a62:d148:0:b029:2e9:9eb8:113b with SMTP id t8-20020a62d1480000b02902e99eb8113bmr8800296pfl.56.1623835889866;
        Wed, 16 Jun 2021 02:31:29 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id z16sm1602863pff.203.2021.06.16.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:31:29 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:01:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
 <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 10:03, Lukasz Luba wrote:
> On 6/16/21 8:35 AM, Viresh Kumar wrote:
> > On 15-06-21, 18:15, Vincent Donnefort wrote:
> > > But if we sum-up:
> > > 
> > > 1. em_dev_register_perf_domain() find inefficiencies
> > > 
> > > 2. dev_pm_opp_of_register_em() apply EM inefficiencies into the OPP structures
> > 
> > I was looking to add a new API to the OPP core
> > (dev_pm_opp_mark_inefficient()) to mark an OPP inefficient. And then
> > get it called from em_create_perf_table().
> > 
> > But I now see that EM core rather has callbacks to call into and with
> 
> Exactly, that's what I was trying to stress.
> 
> > that I think you should rather add another callback
> > (.mark_inefficient()) in struct em_data_callback, to set inefficient
> > frequencies.
> 
> I disagree. That's why I prefer Vincent's approach in this patch set.
> This proposal would cause more mess.
> 
> Vincent proposed a small and clean modification. This modification
> can be done easily in this cpufreq place because we have EM in
> device cpu struct.

This may look clean to you, but not to me, sorry about that.

Clean is not lesser number of lines for me, but rather having the
right ownership of such things.

For example this patch:

https://lore.kernel.org/linux-pm/1622804761-126737-6-git-send-email-vincent.donnefort@arm.com/

tries to add EM stuff in cpufreq core. Cpufreq core doesn't care about
EM and it shouldn't. And this piece of code doesn't belong here.

Would you guys like to add a cpufreq specific call into the EM core? I
won't, that's not a place for cpufreq stuff. It is the EM core. I was
fine with not including OPP core into this, and I gave up that
argument earlier, but then we realized that the cpufreq core isn't
ready at the time we register with EM core.

Honestly, OPP core looks to be a better place holder for such stuff.
This is exactly the purpose of the OPP core. Moreover, we can apply
the same logic to devfreq or other devices later, with or without EM
core. Again, OPP core fits better.

The cpufreq core already has the relevant APIs in place to the OPP
core and this won't require a new API there.

> Let's don't over-engineering. The inefficient information is only valid
> for schedutil, thus IMHO it can live like this patch set made - in the
> cpufreq table.

For now, yes. There is no guarantee though that we won't have more in
future.

> Compare the v1 (I still don't understand why it was blocked),

IIRC, it required more work to be done in the hotpath, i.e. traversing
the freq list twice.

> this v3 and your proposal.

IMHO, adding such callbacks to the EM core, like .mark_efficient(),
will only make this easier to handle for all different frameworks, and
not otherwise. The code will look much cleaner everywhere..

-- 
viresh
