Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E53420830
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhJDJ1B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDJ1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 05:27:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40FC061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 02:25:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so3477543pjw.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fcQsXr7X6789brlUNea0yLwgERc7QKWwEUY0K/Hgp1U=;
        b=FrtA7bBeW72k7cYxcKLEzIH+9iixj3QGnG6/XV47ZXymLKNmpJmIM/3ec4KWniUYyE
         tz34SsnqzWTL4ec4oJGve35+lKEvCFVYEnGCcqr4x9Q9TLl7d5WlRw/XSu3f/lwh2kG2
         B3ikWS2IXRSkvRIyAgofPlkoJ8FuypqL9hLwX/hDwPShzRWP2HJBhiSDAjp5yCrtIZsF
         DTvOOPSy7Cd8k5qf+h8uoIobQSBSj2uXU8lKv/EFJYnRiETFVm/OLjLBUnfHOJW+I13v
         lv/J54TpG86r1gLhpf1ChAgLF7p2SdnnuNnfzQTYbV2114kVac1rUedhlyyNZ7cKXorB
         F34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fcQsXr7X6789brlUNea0yLwgERc7QKWwEUY0K/Hgp1U=;
        b=y3oN6WCsoXm9c2RfKDuz7QeOoLy5ZhKz5+IDb+XAnNtJUXQrgHwJjlJ5nCbnIJAaCZ
         hLghjPaLZ7O/1JswSdisdILQIKaUvq9hFdUBRrYTzsHL1GkqvaQekjmHXwetZpptxH6k
         0uDX9d7hIs8LiBx+1SaKFJZqbVrxsXR4g61FxhllkdOt41v4Rl0P1SGtU73UP5tIae/t
         HE7AAPNJH9iH0Ptqmm989sqaKMNFQlUk/XSO5Vxt6PsgzswSquzUISl38rqTHjjcY3it
         CKANPFjsQ90Pj8REDMB5pW6X4Ou2Y13c5hXTi5ed1Z8fail0qvUqvDxuiSBCcT3taiCM
         6LbQ==
X-Gm-Message-State: AOAM532o47Qc5cCV/yVJFPyQ67J6zdo9cCk+XqxQrHc7fWGEXiuO1IvA
        1IGvKBKLoOaF8fBc9BA5UV0rVA==
X-Google-Smtp-Source: ABdhPJzi45v2R3NYQ18aQo6Pcw81MgGcWsNPMMK7jaFcGX+QNHDfilsYf59InLIY4riv7XL7wCrTtw==
X-Received: by 2002:a17:902:904b:b0:13d:c33b:294f with SMTP id w11-20020a170902904b00b0013dc33b294fmr23365261plz.35.1633339511573;
        Mon, 04 Oct 2021 02:25:11 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id d67sm4747510pga.67.2021.10.04.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:25:10 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:55:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v7 0/9] Inefficient OPPs
Message-ID: <20211004092508.tokhwodfa73terif@vireshk-i7>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-21, 15:05, Vincent Donnefort wrote:
> Hi all,
> 
> Here's the new version for the inefficient OPPs. This patch-set is based on the
> following series from Viresh:
> 
>   [PATCH V3 0/9] Add callback to register with energy model
>   https://lore.kernel.org/linux-arm-msm/cover.1628742634.git.viresh.kumar@linaro.org/
> 
> The main change in this version is the re-introduction of CPUFREQ_RELATION_E,
> as a relation flag. When set, all relations will try to resolve a frequency
> across efficient frequencies only.
> 
> A bit of context:
> 
> We (Power team in Arm) are working with an experimental kernel for the
> Google's Pixel4 to evaluate and improve the current mainline performance
> and energy consumption on a real life device with Android.
> 
> The SD855 SoC found in this phone has several OPPs that are inefficient.
> I.e. despite a lower frequency, they have a greater cost. (That cost being
> fmax * OPP power / OPP freq). This issue is twofold. First of course,
> running a specific workload at an inefficient OPP is counterproductive
> since it wastes wasting energy. But also, inefficient OPPs make a
> performance domain less appealing for task placement than it really is.
> 
> We evaluated the change presented here by running 30 iterations of Android
> PCMark "Work 2.0 Performance". While we did not see any statistically
> significant performance impact, this change allowed to drastically improve
> the idle time residency.
> 
> 
>                            |   Running   |  WFI [1]  |    Idle   |
>    ------------------------+-------------+-----------+-----------+
>    Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
>    ------------------------+-------------+-----------+-----------+
>    Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
>    ------------------------+-------------+-----------+-----------+
>    Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
>    ------------------------+-------------+-----------+-----------+
> 
> On the SD855, the inefficient OPPs are found on the little cluster. By
> removing them from the Energy Model, we make the most efficient CPUs more
> appealing for task placement, helping to reduce the running time for the
> medium and big CPUs. Increasing idle time is crucial for this platform due
> to the substantial energy cost differences among the clusters. Also,
> despite not appearing in the statistics (the idle driver used here doesn't
> report it), we can speculate that we also improve the cluster idle time.
> 
> [1] WFI: Wait for interrupt.
> 
> Changelog since v6:
>   - Bring back CPUFREQ_RELATION_E as a relation flag.
>   - Make the policy min/max hard limits.
>   - Remove the "efficient" member from the freq_table that was pointing to the
>     next efficient frequency.

Had a quick look, LGTM.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
