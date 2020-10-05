Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27A0282FE5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 06:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJEEyS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 00:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgJEEyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 00:54:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDEC061787
        for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2020 21:54:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x2so4794066pjk.0
        for <linux-pm@vger.kernel.org>; Sun, 04 Oct 2020 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wuaS5eoV+4nKA4VFTKBSqLfD9xKQazApFVRKGy/0lFI=;
        b=l5zJxdYME3oq92mSrDYLm0d0cCxlAMOfFeEdnzoaIogFaG3LCq0FidCwSStVutLvyx
         0wv96FjK586m5ycfowTJS8JHcNKOIj85DI18zCUfDKwcxnbEJZVTtF4FTJFjDGTXus8l
         YXQWrqgzelB5W0jNefaUuShjIwPewvlrYgXSaqp7bsM3/DqdCi8KMLtM0nopUiGlBlGe
         m6y0i7ZHvckJxDBDEbCXSSflghzhBCIiFRpC9GGZ8o+VfSqmtbumc5SHclxAk/RA7mNm
         9DMJxniiTVDg76zGYXQqvD40l923tkcyRUcrtB3DUlHsbWjO92CGL8l1A0TxipSv6fDb
         L1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wuaS5eoV+4nKA4VFTKBSqLfD9xKQazApFVRKGy/0lFI=;
        b=hiVcjnfdEmqOC5MTEAPmMVH+FRxPMDtllAINch4JJLtQmIwK2aZf1KOh+Vp8P+pvt3
         yaYiulvnwsrARbwzH1+DcjmwGvH6EWHTvw7z+lpqWBd63GqkjjX1QT5DVBRNi9PYjGns
         bSHZqeOLwL8kvjCpn2Jzvv85AkeeMMvCQqPHcC0aT4U6jXRSLqio/RLg4ngTAdAFl3xE
         8ZjutplsQ5TyxR2LE1Ban4q9NtxvqAgKK4THjtFeWClzVCz53DnQUp9nge3uaRESVHW2
         BYIqPUUOUlvAUnOB0h+smHXjuv9PwdGcCkxc8SJJ2FJy56lV+pPuyuSkL1x56DjPmWmK
         7JRg==
X-Gm-Message-State: AOAM53012snGQqCuxPWDFkHXh4LkrwfJGcPF8qG8O2iQMUSuaOdAG5up
        2O4BVQmfnazdGHjZkWclesEgjw==
X-Google-Smtp-Source: ABdhPJw+IAPREkiT644OHOYPN0WVvdn6QTaP4XckNLU7A8dFCB0SkJqIEdtw04oWZuqUFMNvTI/UIA==
X-Received: by 2002:a17:90a:528a:: with SMTP id w10mr14695733pjh.107.1601873657786;
        Sun, 04 Oct 2020 21:54:17 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n7sm10536512pfq.114.2020.10.04.21.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2020 21:54:16 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:24:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Message-ID: <20201005045414.fmntm7ejad7zxcrv@vireshk-i7>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-09-20, 22:41, Sumit Gupta wrote:
> Warning coming during boot because the boot freq set by bootloader
> gets filtered out due to big freq steps while creating freq_table.
> Fixing this by setting closest ndiv value from freq_table.
> Warning:
>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>   cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
> 
> Also, added change in init to wait till current frequency becomes
> equal or near to the previously requested frequency. This is done
> because it takes some time to restore the previous frequency while
> turning-on non-boot cores during exit from SC7(Suspend-to-RAM).

So you are trying to figure if the frequency is listed in freq-table or not,
otherwise setting the frequency to a value you think is appropriate. Right ?

This is what the cpufreq core already does when it printed these boot time
messages. Do we really need to add this much code in here ?

If you really don't want to see the warning, how about fixing it the way cpufreq
core does ? i.e. with this call:

ret = __cpufreq_driver_target(policy, policy->cur - 1, CPUFREQ_RELATION_L);

-- 
viresh
