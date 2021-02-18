Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363631E7EC
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 10:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBRJWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 04:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhBRJCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:02:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D3C061788
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:01:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gb24so961706pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UuE8Kk0Ft8xXaK+dKRJAML723g16xNEkqk4oyYxtLIA=;
        b=mQuAECgdy4uodSx8f7K2ZlsplUjdFmhjtPIbLozp4qf4ucKR8ngWFaBZVPQdS8aBEP
         suArLHZFAVuqYS1ppAWlerQXKHyAivH4FTtT6f+cSnMHUMoYrSafzwEoekjIAy+7jI8Q
         Qb2wAW9JDosRlEeEHf7fSMZqlgkqRDGKBlU2SNEWC/t3l0W6LBwQMXNukqnJoebfijGH
         OAwP5NT/m1Ih2Djc0RjBOPf93SoyN2MEMvDG8PjniWXlY2sCNW7+G0Tjo3LLjN5WbVLa
         4JqI5EvThL0FR/tzvoMIuLCpWABXTdE1SkXMXU9a3qyqxm/xyVoawiAPiqJMveEw+9gM
         8mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UuE8Kk0Ft8xXaK+dKRJAML723g16xNEkqk4oyYxtLIA=;
        b=KUHDq60Qd0WZzLHYCkEiJIowDGyLhWcCjRRv0if4NPUwlLtRb5+4uabE65Ktm/ScIx
         ykgASZ6BV/wFNtqu9TofkPBLQ7FKAyXP8/QdFnykOKF7SJ9/raKUZOhzCN09rpONA7pt
         VHNBQaPR4D4LPIt8744oGN17Ib21sqO3/o6BSp7oWml0ViHmSU4I/kj9zRW34pSdKCwm
         vuFQdp3jbtc+y8ZMkT1U9r5AhCtLOUkeVnZnbpDdae/MwVZmEPWgn5k/0iwkvAb3Ixw7
         LbfWNOQNQC96bGnS8LtNeUn162MyB0urFczNguO68Ihk1bHAa99wodcV+4B+bJa9fXX0
         NZ5Q==
X-Gm-Message-State: AOAM532IvBvHaFv0xUn7MuDiNlrzwX6341ipGE0tfBu+/IoOpv58iW++
        AKkcSGEbKb+rj0f+QxM7sne8pw==
X-Google-Smtp-Source: ABdhPJwHO3FeZFDJ7+2o++0fDXBVADcUGcOh8GKfRFkOO0zU9aLphc+cBvvCC6BltWWVlxsCAU5Jow==
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr3045392pjz.82.1613638883490;
        Thu, 18 Feb 2021 01:01:23 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u129sm5227112pfu.219.2021.02.18.01.01.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:01:22 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:31:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: qcom-hw: drop devm_xxx() calls from
 init/exit hooks
Message-ID: <20210218090120.lncn5fomygn5zddo@vireshk-i7>
References: <20210119023925.22724-1-shawn.guo@linaro.org>
 <20210218031938.GA7127@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218031938.GA7127@dragon>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-02-21, 11:19, Shawn Guo wrote:
> What happened on this patch?  I thought we would have it in 5.11
> release, but ...

Just 2 days back I was about find the relevant thread and reply you
guys on the status of the patch that should fix the issue reported
earlier and it wasn't sent until now :(

Not sure how, but I missed this patch and yes it was in my inbox. This
doesn't normally happen as I tag such patches differently.

Any way, I will queue it now. Sorry about the delay.

-- 
viresh
