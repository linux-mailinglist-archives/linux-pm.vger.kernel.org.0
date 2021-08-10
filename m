Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5083E5475
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 09:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhHJHj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhHJHj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 03:39:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DBC0613D3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:39:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so3066528pji.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ntw80WcoYw2k1hjudlNm5ZKzgT6mSw/SUM69mB5W9w=;
        b=jfGP7mWN32YXtc/wS6HGdAjMtK0a7rR9l7mWSs66zS6dhwwdfXppbg1DgT43o2UI78
         UgDhw8r7tyF275MuJ2K6KZKrYI8Jo3mt9lgF3zAYAWivD9lbAgK1SXfLbWyCOKc+HLWn
         ueRkSQaW8QsndMCBSvazzmAbkKSfjD0tUM46w4uIaKG3NyDea2k/t+JD5CakaIMHv4i2
         7r4XAALcGS1lg61MzdPN3Gu90MLkjzTFRcB8LSapn6QUF4x0RQFRaSH7ODAYpP8a8gqE
         /sNOpx5a3jOvOfxzMc/8LvoLhj7RzuurAMj18phF7W8AGhwisetNleqcgF/3sF11XxO2
         T8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ntw80WcoYw2k1hjudlNm5ZKzgT6mSw/SUM69mB5W9w=;
        b=eGLIr80DluLELjtR1FVl0Ekn6amwGTKHRpE3RYjEYPR5od2gI9jNY2mE+OFFTA5Wsv
         YchN83tiCjrj6L61fe8TB82hNUVe5f1HyiG8IiCclIKGXa4cmZgyflL5DBD5bOtD1DlW
         ff+d4aTm+Yeqi8aPBTEOgNEgBvhqndBPzqMZ0HDS9ri/DlVWONg4ME9ey2M3102/i0Cq
         7k0/k9IefdBMiVq4Ypo5UfnpPdUSkmYYKzVXgyljtUQa+qy5UQ/fM4HPJ7nE0u4uQpuj
         oW3L3EN1ZDwuh51L6/caYa1M8JXHnnXLzAY4/QCiX6gGr8SJTqrtftM9OjcsOfeiS8Gb
         R+Lw==
X-Gm-Message-State: AOAM532yFcbH/fEnJNRu/Rui89lvYpyXM3NSL0YUHO9rl5NjzFc9P+Hd
        KzXFYV8G889Q+hMypzsfHznBRQ==
X-Google-Smtp-Source: ABdhPJyk5dJq2QEK2r5lKHRN5GNf4eemopPHfYI7nelk6fyGWp6Tjd8zqgwKjWVOJ5d9w2qB5+a3Ew==
X-Received: by 2002:a63:580a:: with SMTP id m10mr1153533pgb.254.1628581144435;
        Tue, 10 Aug 2021 00:39:04 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z33sm25738064pga.20.2021.08.10.00.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:39:03 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:09:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210810073901.u6iw4fqudkqaag53@vireshk-i7>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 11:43, Viresh Kumar wrote:
> Now that I see the current implementation, I think we can make it work
> in a different way.
> 
> - Copy what's done for thermal-cooling in cpufreq core, i.e.
>   CPUFREQ_IS_COOLING_DEV flag, for the EM core as well. So the cpufreq
>   drivers can set a flag, CPUFREQ_REGISTER_EM, and the cpufreq core
>   can call dev_pm_opp_of_register_em() on their behalf. This call will
>   be made from cpufreq_online(), just before/after
>   cpufreq_thermal_control_enabled() stuff. By this point the policy is
>   properly initialized and is also updated in
>   per_cpu(cpufreq_cpu_data).

And I was able to get something out for this:

https://lore.kernel.org/lkml/cover.1628579170.git.viresh.kumar@linaro.org/

-- 
viresh
