Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024813E9D11
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 05:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhHLDxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 23:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhHLDxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 23:53:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1682EC0613D3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 20:53:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so13085289pjb.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bquCFNIcCvdCbwIly19HSfu6034c+GYMih/X5YZeEUc=;
        b=FnDDISYVm2p6A4RVyJW8Sa32+5J7DpqcCegOdTwai4N/VkU/tKFXjF/2gQ7rFHbQlp
         FwRRWU9n9DAvtbfPp5JT5ChcbeGb7riK9XjmUa3GMU40VHW+A+y0JnX+XdPCBlCi1xGd
         gtieHNK5DXET5MnzZRK3eB8LndpICtygcequ0jEjiiPQ0TTMYNBLVxvo8jMXFgG0i+Ld
         gy/ZRotP4Fu7lzD5PHxCuS8EMj7S6fJ1biEDtyd8LjQXa/FcZcIaPpdyx7gtY17qBhoK
         fhiSM1M4UzEkXEd+TsMjtJc9jtoxCV58+SndupIDRsclXPV7hE+6p4TIoGNifnflzu5j
         AKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bquCFNIcCvdCbwIly19HSfu6034c+GYMih/X5YZeEUc=;
        b=YGgI6MjLcN0V676bsTBEm0yX/IoK5VaHrUl9dxuvJBAcCjIYjLSVsXFG1QXxmExd77
         fiG66LX8MQ/f1WlQ3BUbWDvz6Kz5y/Z0f1wFWZJeFqwbV8nbxtK+y+TQRWgnfFiqGtMW
         vOwshDHuBB+LyrDCYXeZc537WZ3cyXeUbKoQ19bMEMpn73e18gBSJ/nuPgTha5tvtU5s
         oqQ3Gc8oYXYl3nFn/U/q8gD+1xxJF4VVlyZXc7eN0GMVmHcfwQGtfDTgZLK2/d098XtE
         ehMYSeJnGWLsWhtzs62xftrBQv+a7bsP6fajITkr9PtvlseV+kHmFTtNX6VyGhjr6R74
         Y19g==
X-Gm-Message-State: AOAM532Sxm8EdoFJaIgXX+KGrFyMfE4x+lVCsm88UoltU9yUGyh4mS5j
        FQjg+vGX8T67M1aDqmSj+PYDZQ==
X-Google-Smtp-Source: ABdhPJzgbdGIsXFDYBD0by0Ubi7BaLW73k/Bb4qfddZ5rXI4H4FjGzEYgpNxg5+S6pjYDThMf6DdAw==
X-Received: by 2002:a17:902:dad0:b029:12c:83ca:fdd4 with SMTP id q16-20020a170902dad0b029012c83cafdd4mr1870821plx.77.1628740399104;
        Wed, 11 Aug 2021 20:53:19 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c9sm1241024pgq.58.2021.08.11.20.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 20:53:18 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:23:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
Message-ID: <20210812035316.jen62wsrl4tlbrpm@vireshk-i7>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
 <YRPN8zjp1wqkHg6t@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRPN8zjp1wqkHg6t@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-08-21, 14:17, Quentin Perret wrote:
> Also, we can probably afford calling dev_pm_opp_get_opp_count() from the
> em_register callback as it is not a hot path, which would avoid wasting
> some 'resident' memory here that is only used during init.

We also need to make sure that OPPs are available in init(), else we
fail. So, we can't really move that out.

-- 
viresh
