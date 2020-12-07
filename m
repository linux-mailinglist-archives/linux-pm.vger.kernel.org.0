Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE52D0B25
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 08:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLGHdv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 02:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLGHdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 02:33:51 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112C9C0613D0
        for <linux-pm@vger.kernel.org>; Sun,  6 Dec 2020 23:33:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o5so8169808pgm.10
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 23:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pBx1FDKqYr7mMleextYOkYr//tDyniCmTiD8PorYSY=;
        b=I7HiLIUBizvzV5Hyzt3gyfmphCrc7Wrvp9AwcX74nKb4SCblx63ng8K2BSdDxkjRKC
         yraVUESuEQrT4tSmX+F7mlpVcMzWSgUOVQaJHYy9eeyzZOVsCkjcw4yihWtd3htsaOkx
         p40iP1ICwEIZYdUC2gsj0QeirjsB3D8SkwoO2/PSujMcXp79LcXFrLdmaBO9kGHQWcf5
         JmXHV1fB8+esp+YJ+Jy2A7bOjIIWYL4gWroE/1Bl77TS/QiFUnpR4+DdNLP0HfjKW5hP
         KVRNWuO5W9k6utI7b+64KdJRpB2CYrVMM79DAhC4HatKmW+5jPIqroqqithCTh/xh59+
         4wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pBx1FDKqYr7mMleextYOkYr//tDyniCmTiD8PorYSY=;
        b=gtPkJJq1KSXETz8/OWnLcdlbc1CYiNaKLwyiyayRz8kN/o22RWfFCxLl260CqFfqxU
         5Cb1u/xcsN81i9NVhCaopprBV1TAJ+F4lohkuV4FucoNuJDgtefZq82pNRzV+DSTTJ7Q
         yzhLHRkCZYQeft31Z5mPXmyfLhiEyusMqaQZsJhYi0kmffwAVkFShLyTm866LIhZ8ftY
         ygj0cvdihvfWAIvXP/fkMpW/WatWoBaDo5WoP51W5QGU6cdSgHVfAJUVNfh3CV6MVgZc
         FQF/XWtyMGnCOyBY843w2G5XHdhTzPxalstDXaZwUFvjHTxPvhCSL+iXH7TeuMurWfOk
         a+dg==
X-Gm-Message-State: AOAM530OMLS7YU/g/zA9yC98h+r7Q5ibueKFT4w4CO0LjQxbxLifdbXK
        NHMVus7CJ9UxM4R9abL/CoJkKA==
X-Google-Smtp-Source: ABdhPJwpQw+i6ZfFXW3Kho5QgXjy35ocaPSdR4jbaxsoYu5lJ9r+gQuFOg5x+f2CTytJj98gBimeVA==
X-Received: by 2002:a17:902:aa8b:b029:da:ef22:8675 with SMTP id d11-20020a170902aa8bb02900daef228675mr5422380plr.15.1607326384551;
        Sun, 06 Dec 2020 23:33:04 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id oc13sm9045541pjb.5.2020.12.06.23.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:33:03 -0800 (PST)
Date:   Mon, 7 Dec 2020 13:03:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sumit Gupta <sumitg@nvidia.com>
Subject: Re: [PATCH 0/4] CPUFREQ clean-ups for Tegra186 and Tegra194
Message-ID: <20201207073301.nar5vbqpgxbdgs5u@vireshk-i7>
References: <20201202091419.307192-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202091419.307192-1-jonathanh@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-20, 09:14, Jon Hunter wrote:
> This series includes some clean-ups for the Tegra186 and Tegra194
> CPUFREQ drivers.
> 
> Jon Hunter (4):
>   cpufreq: tegra186: Fix sparse 'incorrect type in assignment' warning
>   cpufreq: tegra186: Simplify cluster information lookup
>   cpufreq: tegra194: Remove unnecessary frequency calculation
>   cpufreq: tegra194: Rename tegra194_get_speed_common function
> 
>  drivers/cpufreq/tegra186-cpufreq.c | 122 +++++++++++++----------------
>  drivers/cpufreq/tegra194-cpufreq.c |  12 +--
>  2 files changed, 57 insertions(+), 77 deletions(-)

Applied. Thanks.

-- 
viresh
