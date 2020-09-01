Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5462258A72
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIAIiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIAIiQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 04:38:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4CC061245
        for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2020 01:38:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so302313pgy.13
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2020 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sVtA4BoZtd+qYp70Vhjk25E1OWB6lKP1vnEo/fyHhLs=;
        b=SnQgHt594OnvLQ+HxoV+1b+xHTfWiZdjynemjFAeMz42JIh9tNJ12ru0Sdf87mOruN
         YIS2eu2r1BgbUmwZ5B6/xd2LkGoztpFrlWs8OA5BQTUysDWl9UFYPnuOpjogN4KbX2YR
         cKS6X66plUmYw9WLQnKQB2lbF41fKnPmq0ZAc4NUbGlb6lhiNtmG25L7KtxXA67rgAtq
         2BNfqsH4eLHVD18cv5Y0FLwxrPM2ZeN9ZVsrWYIVi7A8mp3/FYORXPRdo5jFVHPf8xtD
         JaHb7u2FUskbMnYCc+RlYKp/pNEoGHUdb790uRF8fS08FGQeaVWozJSDGsWLJt2fZCRE
         PsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVtA4BoZtd+qYp70Vhjk25E1OWB6lKP1vnEo/fyHhLs=;
        b=PrRIEQI2fLbql3CMiydne9BtXJAqxSDXk2fP6VdOxfShXlbWGi05dW3oS9o+nWIvWW
         mwlCE9GD7/coxP9IaYvzyrzF/WHitbzF+hSq4wWh3tI+gnSJInfKLSa/aTLw9Viquyu+
         iUgz1lx/7iCM7iB/+uqw1HtvxL76eex0FcZNmEl5rlzVu1V4NKv+jWUYTM2CRhcVO9NR
         GUYk4TXGnTb+fDptPC17YOu0dT8Q7jdpuNE4cv+EixfBBbOMWfucC7FHqe+iXIhNpCMh
         vVC9QDC5uLFeq7TLFQU8eKUSOD6g49V/NjOrFaqjQIKHIOMEOGMBn46iNtaY+XAvZpAj
         ZyuA==
X-Gm-Message-State: AOAM530zVdfaBbflD/lp325Fey68fCqCVpO6kPVlnjgz047q0K1jZLzW
        KmYkEJUtwBJkOgkpe4RUnecR6A==
X-Google-Smtp-Source: ABdhPJwZHBfT3ETPIgNI5qRnnz8/BpmRAeI4KxWCHE2M6+mIYJNgUAe/wNWoWcH+xoGqRksqZeUjGg==
X-Received: by 2002:a63:ba49:: with SMTP id l9mr605427pgu.101.1598949495328;
        Tue, 01 Sep 2020 01:38:15 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id o6sm708807pju.25.2020.09.01.01.38.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 01:38:14 -0700 (PDT)
Date:   Tue, 1 Sep 2020 14:08:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20200901083806.a2wz7idmfce2aj3a@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
 <bc64e031-c42f-9ed2-c597-18a790a4d3bb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc64e031-c42f-9ed2-c597-18a790a4d3bb@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-20, 13:01, Rajendra Nayak wrote:
> So FWIU, dpu_unbind() gets called even when dpu_bind() fails for some reason.

Ahh, I see.

> I tried to address that earlier [1] which I realized did not land.

I don't think that patch was required, as you can call
dev_pm_opp_put_clkname() multiple times and it will return without any
errors/crash.

> But with these changes
> it will be even more broken unless we identify if we failed dpu_bind() before
> adding the OPP table, while adding it, or all went well with opps and handle things
> accordingly in dpu_unbind.

Maybe not as dev_pm_opp_of_remove_table() can be called multiple times
as well without any errors or crash.

> [1] https://lore.kernel.org/patchwork/patch/1275632/

-- 
viresh
