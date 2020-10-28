Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1307B29D386
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgJ1Vop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgJ1Vo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:44:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A868C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:44:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so1163063oij.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VZhYQ3voGqU0Lqb72CUJ0+414mJOlhh3pEzgjKJchCU=;
        b=AQlIzqq+EQcYPj5CWxqiwiFcK/jJlWiKiIxPbpguHDF8liq04//dXkC/VkMeKbQhfL
         MA1h/bMSt2QQzjBxIyrAvF3GvOKbKOvtfP4IBQRyNu+8R/3xJb7DNgJzeFGwa7ACdmwV
         OKs14hlGABh/mcmGFivQN+xhq2tugVHEDfnjW4nTzXVX4GFepqHp6JVtEFVDv7oybu8a
         IvwPXyB8FN13O258g/5k60wmej6NiCyxTJnc5xU7aBW8ZpR8UKyDAp5ryHOMxCE8DCtL
         z9WeliQDBqqT119hHCd6CwnGUrF2S+1v+p9E5XN5tjwgWqzO2/6+LGicEGH8SVKnBxtW
         WQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VZhYQ3voGqU0Lqb72CUJ0+414mJOlhh3pEzgjKJchCU=;
        b=JsoX2rUpKZRoOS7tJFzIA4pKtXdReM30tTIvZwuAlgrIsYPTU0Qy1OVkDbAsj6eTzz
         s46eNKf9wj4B58rWuZ234OgOpdpB+yq/Oc1n8T/IoFjSbxaslzFepdGkby9p/YC3NcQW
         z/dz1RmT+5K69Ji1nav2/OZXPoaYP5zcGMNqKxE2KAkO430eg+7gSIO8vwIQLQnN4WP8
         UM440FGkedEVauNswzBNcLRWKS6pQk19P77pkY0zxcMkx7I1eQJEhRkMPBSOQHieWK5g
         xXAUg9GDtZmPHGdWI6tEiXvMjAiQKO4qaSBe+xWtqkwMSMNLOUnirBROLauegCg2DRnO
         LM8A==
X-Gm-Message-State: AOAM530czqRKuUIVJ1mL0wYr+OSNnyB1EinYMtoQNU7DJwLkc5zwfp52
        lpT6NUddl3REuUYRrdhLWAkz1AT5zzoGRw==
X-Google-Smtp-Source: ABdhPJzmx5He1K5nH+KMxuqqoFSYMQNrCd2NRiKRBjul6UvJgdmjyKWuA7j+CU74D92TX7GCqNfyMA==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr5701260pji.117.1603865416676;
        Tue, 27 Oct 2020 23:10:16 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 21sm4645316pfw.36.2020.10.27.23.10.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:10:15 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:40:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        ksitaraman@nvidia.com
Subject: Re: [PATCH v3] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Message-ID: <20201028061014.xy6dkwitcnmw3sng@vireshk-i7>
References: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-10-20, 15:06, Sumit Gupta wrote:
> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
> and keeps changing slightly. This change returns a consistent value
> from freq_table. If the reconstructed frequency has acceptable delta
> from the last written value, then return the frequency corresponding
> to the last written ndiv value from freq_table. Otherwise, print a
> warning and return the reconstructed freq.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> 
> Sending only this patch as other patch not required after the change
> to convert 'pr_warn' to 'pr_info' in cpufreq core for unlisted freq.
> Changelog
> v1[2] -> v3:
> - Removed unwanted checks for cpu_online and max cluster number
> - Used WARN_ON_ONCE to avoid print flooding.
> 
> v1[1] -> v2:
> - Minor changes to improve comments and reduce debug prints.
> - Get freq table from cluster specific data instead of policy.
> 
> [2] https://marc.info/?l=linux-tegra&m=160216218511280&w=2
> [1] https://marc.info/?l=linux-arm-kernel&m=160028821117535&w=2
> 
>  drivers/cpufreq/tegra194-cpufreq.c | 62 ++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 9 deletions(-)

Applied. Thanks.

-- 
viresh
