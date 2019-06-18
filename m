Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0210249D13
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfFRJ0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 05:26:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46070 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfFRJ0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 05:26:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id s21so7336320pga.12
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACmcdqOP2gSGSso0d/MiQ00IgAVGq25vQtNqguYCF5w=;
        b=sc0E/8iB4qaqHn9Zp1WR0OtM9S8b0KYzP6oOnRw5yROW6enOifvofAeCtv31AqOYo/
         a8y5opv8HfdW6eTBEHVj7aAJilzMPTo9rmEpF8/79ZrG7Tz2xvc18qbElUHHCqtdm++F
         cgWe47VNKw5H6+E+VSZV3v4mL57BeVLM4cSW1rbq3QY48kquBQpPf519wgWpEDuFkeI9
         5wKIrFfJbP5sEaQHHdDzIqqTxj4DFbsBHbg91ivq5Y8LquUvB4OHHLku8qEeQXj74meE
         PCPfSLjxdUCAjl0Rk7VQUyPz7sORJR8qPHvNW/rQ7KMTGcpfH5kNpXt8S7IeJz4qC5jr
         wmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACmcdqOP2gSGSso0d/MiQ00IgAVGq25vQtNqguYCF5w=;
        b=kCl3NL1DBLrZaV/q3+Lyq9QpLpw/XL+stlyX3EAyToqVQ/cZ9kJv90uWwy0bj/S4w4
         y+D1PJ0xMMA1uwqgzNT64otbBKw5WQlJYoP/joOMMsZBh/njCG3fQI4rowE1gTWs+dZR
         YdOLTQHcM4bwIBAplPfh+HjZCyF7dRr6hnCmD+uoI0Z/UhPfz5e50CLZRg2yiHyAh4Nb
         szLbzSaFpO7t/uSu7TJ9cXaNVd1276bNwk0gyORsX9pFVJbeoR59gaubk4hc7c1zHKiL
         PD31VGLzXeG+OApoUD0m8UL7B9CeaLKXlt1KG3dntvW53ijBR9QBTNJN2+erieT+ZETH
         momA==
X-Gm-Message-State: APjAAAW3qGB+pnxCS0IlsvibZlNEmD4dHk97ahjRnvkBacq8o5AjGjkK
        CDR7DESUQqWaOg26Df57cmyUQg==
X-Google-Smtp-Source: APXvYqw7S7g+LxxyGBTPUPd97vZx4Wcl8CWA1Ovr31OCsPH4/P6Iao8SMp+SLw9BjAv0mLfR5zA/5A==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr1732002pgf.38.1560849964851;
        Tue, 18 Jun 2019 02:26:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id ci15sm4292839pjb.12.2019.06.18.02.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 02:26:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:56:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, quentin.perret@arm.com
Subject: Re: [PATCH] sched/topology: remove unused sd param from
 arch_scale_cpu_capacity()
Message-ID: <20190618092601.2aws7kujvk2pulwt@vireshk-i7>
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-19, 17:00, Vincent Guittot wrote:
> struct sched_domain *sd parameter is not used anymore in
> arch_scale_cpu_capacity() so we can remove it.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  arch/arm/kernel/topology.c       |  2 +-
>  drivers/base/arch_topology.c     |  6 +++---
>  include/linux/arch_topology.h    |  2 +-
>  include/linux/energy_model.h     |  2 +-
>  include/linux/sched/topology.h   | 14 +++-----------
>  kernel/power/energy_model.c      |  2 +-
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/deadline.c          |  2 +-
>  kernel/sched/fair.c              |  6 +++---
>  kernel/sched/pelt.c              |  2 +-
>  kernel/sched/pelt.h              |  2 +-
>  kernel/sched/sched.h             |  2 +-
>  kernel/sched/topology.c          |  8 ++++----
>  13 files changed, 22 insertions(+), 30 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
