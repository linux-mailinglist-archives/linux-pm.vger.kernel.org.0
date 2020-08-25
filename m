Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E646525120D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgHYG1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHYG1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:27:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED11C061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:27:46 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 67so2997283pgd.12
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=94MSSc6Bw+ePCcLcj9S6ugcreG6qu4BBnSYozoT3V0s=;
        b=HunUM9M5QD0dPkyiCaGhJhjgK4tiwnoi5/fgs8rW5CPYd4dtGClL0fylBu0MsgjTiI
         VtN8xkLXyaSIVhlU3eiJtUAb58guTng9h0FlsNglOxWHUkJx/Zw9YPQrWvuFoWfCu8Nd
         b54BpMYtOxUpuRIdBgsNjIKNdwM1OaY56Qsw32T2ys7T30fEB3pIu1cobZPLSbckJGm6
         /Upd8zGNaWRqNKVPi3Qo22Yxp3+UUBKLraX6GF3s7XpAk+t5q6vmcsLlToBWdxoMNBvB
         qoQmhOpC9D6GcrqnyWRE7Y+U4VC5XNordG9WsNumB8qCLZaal2zANOnpFYyKYG0bIOTU
         ueQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=94MSSc6Bw+ePCcLcj9S6ugcreG6qu4BBnSYozoT3V0s=;
        b=FpdsoqEK/5GcVBTwyPOXdGoSs9qZbz5wSDjnYc9TEDe71mkQTFNplwTrCSbXCqE+5/
         1uoi+a2b7WCjzYDmfXlw3pEIiTo4e/3tAFO7DTFcnxuDrzUzGieK6aTEruVZqCgC/33V
         aHAX487fxT6/6Z5K6/XPDRgb4Cp/bJTST5t3IE16bq2WIWHIfhH+olXfZHFsu6eAweBJ
         Z1ICC+4Ft6ZVQ2VgVjDhStDg1KuPMtz2JLkUeiI+0iZvbK0IKxBihrbFRzEmj5znEeVt
         f1xNl1FEm0JOws4ts09vqO9gxHOfbHlu6K4tavOCtoPRjZqh/dSu69+iK63OpoUSlHkK
         yVSw==
X-Gm-Message-State: AOAM532YwgTTJXhJ43rZGnjhSVpWS9yRTvgIkEtNmPas1nxrry+OUEFr
        L8yy4CuMtoqaY/tr2LqYRso3Hw==
X-Google-Smtp-Source: ABdhPJxUaiTJF/Sy9hbAUOY7Tja+Z4piLIACl5WlyQYBJJ8kL4CGYfZ2NHJkit4vpYUkT6HD2pjf7g==
X-Received: by 2002:aa7:9e4e:: with SMTP id z14mr6932510pfq.60.1598336865613;
        Mon, 24 Aug 2020 23:27:45 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id x12sm3159096pfr.42.2020.08.24.23.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 23:27:45 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:57:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] arch_topology, cpufreq: constify arch_* cpumasks
Message-ID: <20200825062743.mi6rwltqdqfddjox@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824210252.27486-5-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 22:02, Ionela Voinescu wrote:
> From: Valentin Schneider <valentin.schneider@arm.com>
> 
> The passed cpumask arguments to arch_set_freq_scale() and
> arch_freq_counters_available() are only iterated over, so reflect this
> in the prototype. This also allows to pass system cpumasks like
> cpu_online_mask without getting a warning.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c  | 2 +-
>  drivers/base/arch_topology.c  | 4 ++--
>  drivers/cpufreq/cpufreq.c     | 5 +++--
>  include/linux/arch_topology.h | 2 +-
>  include/linux/cpufreq.h       | 3 ++-
>  5 files changed, 9 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
