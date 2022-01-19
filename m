Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8795C493516
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jan 2022 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351846AbiASGke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jan 2022 01:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351825AbiASGkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jan 2022 01:40:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E261C061401
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 22:40:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pf13so1645806pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jan 2022 22:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpqOr/tBRi75Pp8qLo4l0nBsgr344a1nSf9Rbnq+odM=;
        b=qEYIK5rApXpv0wg81nkrlkx1T++XKJBs1RDU+7UymNOd/serK07jnV/QZUYpzO1cZx
         wj6xTp+NFXcu/VVvkGp0KBC0MfieDkaiP5XvpIvvJKB6tbSd3+sSr5ueB8ITW9ftDO/u
         yheozRHgkCfFm6CVnnrKd6XiKG2Su3UOFenBTkSPuvzul0kpK9ncGpQJNPSj4vw5afam
         GYNFNl6Oov2WscSyYFmKYYuq+EJfNE0yfTueSoo4RuDtNhXRP6U1d5CxcfJ120j9HVLg
         Mj5zu7jCDAtYo8SUwn+zSVSF0TeeL27Wz3XKko0KU5GOn3lm2i2OTWH1ygcjd24A8CHU
         2jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpqOr/tBRi75Pp8qLo4l0nBsgr344a1nSf9Rbnq+odM=;
        b=CljMnaLMMQcK94H8/a05Nf5hS0lC6xtmXcJ0GhyafqTeGI4KbR9/ZpDX0s250TOgTw
         58iv2kHRpDVQ2ve0A/vhwzravAC1fi8tZNvjw+KUDsf90ud5fJwyGmkMS6AkF6RBsItA
         reStWMw9eXZCiO+Qq4/GUKGEhDKqfni2LkY/EgxIPtB4ffwN68FAxG+w4sJ+7CkhlBjg
         SP+o6hzqitMOttRtSAkO0k4i0kQzEjtLz4+C7hGDTHpEZVamKCgoG4N22wgAmWTPYymf
         otRk9wWcCfahK1h4Cr6D5yo11F/ykEdA1MQyOp+mP+/BnkZCo7PTOn+bmYs22aRKsL6s
         OCQg==
X-Gm-Message-State: AOAM533eLf2V62Zs6AXB2lq4qnm2cLEyYiN9pcE00zskhLTee9c4/wS7
        nOKjyNv6c9yswIlJooVlGaEqww==
X-Google-Smtp-Source: ABdhPJx8ka9jtqv7zCBJO2qiQ9/AM6qAF/k8L4Cci5O8W/jOWZTORT9y08zINcOya2zj/P+qTeHWVQ==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr2608936pjb.19.1642574431950;
        Tue, 18 Jan 2022 22:40:31 -0800 (PST)
Received: from localhost ([223.184.90.234])
        by smtp.gmail.com with ESMTPSA id a9sm18672318pfo.169.2022.01.18.22.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 22:40:31 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:10:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: qcom-hw: Use initialized cpumask for
 thermal pressure update
Message-ID: <20220119064029.b2yhqcazhpdbhasc@vireshk-i7>
References: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
 <20220119063547.hktwzbycf7trqjju@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119063547.hktwzbycf7trqjju@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-22, 12:05, Viresh Kumar wrote:
> policy->cpus keeps on changing with CPU hotplug and this can leave
> your platform in an inconsistent state. For example, in case where you
> offline a CPU from policy, other CPUs get their thermal pressure
> updated, online the CPU back and all CPUs of a policy don't have the
> same settings anymore.
> 
> There are few things we can do here now:
> 
> - Check for empty related_cpus and return early. Since related_cpus is
>   updated only once, this shall work just fine and must not be racy.
> 
>   While at it, I think we can also do something like this in
>   topology_update_thermal_pressure() instead:
> 
>   	cpu = cpumask_first(cpus);
>         if (unlikely(cpu >= NR_CPUS))
>                 return;
> 
> - And while writing this email, I dropped all other ideas in favor of
>   change to topology_update_thermal_pressure() :)

And then I saw your second patch, which looks good as otherwise we
will not be able to catch the bug in our system where we are sending
the empty cpumask :)

So the other idea is:

- Revert, or bring back a new version of this and register the
  interrupt from there. But that is also not a very clean solution.

  commit 4bf8e582119e ("cpufreq: Remove ready() callback")

- 

-- 
viresh
