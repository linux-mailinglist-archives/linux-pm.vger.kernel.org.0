Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA728FD16
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgJPEHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 00:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgJPEHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 00:07:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A13C0613D2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 21:07:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j18so731577pfa.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vX6ndPTi8E0weS4M30AEHmjjkLUgJeoHZsUqEDqihg=;
        b=dUdKWY6Jhx5+1cfkWmojPdPlr/pmkDTzwPQ+xyqNJObDcOwpuvD+A3cr0W+xkwP/M0
         YgRdYCg64sgcX/z/zh1WhITxU0bWX+5gGSinRooozAeNpb5zC0VNMteclsfIepJq4aoG
         utgGwQ0GWhETE5xvJI2sC6v0ffOwQOXy4T87rUfAgDozbyke6L7owsoTd/JtQ2LM4cZd
         juG05Xa0+MNJgWGp8qCFkYRpUe17UdqYgsDMdW8tszaWZwBbm/Fl1yrAt5DeMtffO++U
         xa995M0boaXZ0+HhiM8rcI8P7JpATbsG4N3ONQgIZCPZDQUiKVXSTjnGC1i9dlxtEfMr
         TeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vX6ndPTi8E0weS4M30AEHmjjkLUgJeoHZsUqEDqihg=;
        b=aDNNA+NscwmTV/aVf1YokAsUdUzYNkMNk4EMsRvGtVss6dAhzkyTcQflcYarb1MXqd
         s+wQ9MkI0IjWI9qRWNvTrNxW4xd8nbQvn155/IPlHM68pS6uAC2cSlX8ksVGvDh6jxh8
         W4f8FFZIKKawdVJk0bbS+E3mDPW8qp8shAaE5J4ZFLzW/kiXXcO4IFjHkFAskz2KzpW3
         35LQjq2LSjSlGFJ8AM6DfEWo8ZZdDziSnxM7140E952JptSwRTce7fCMS8HrvVeIGTCT
         uN7Dj3u4rFedLzB/EFprgty77AataKw2W83O9V3LkTH4rhlzcLb5scK0QOgv7aHzxna+
         XsLA==
X-Gm-Message-State: AOAM531RVTvXtPDD+J1xZBmHiVRG0u8D1RI1u4tzi4IAMg25F+ye6zsS
        R6/3Bp3DxotWKGcUJVpdNmYdaw==
X-Google-Smtp-Source: ABdhPJyBTTEAFamTg4RJhFEdUUEc/mchclzo4KAppRt1V0Onx7JzwJTpskED/j0U2zGvoBE6O9jPNw==
X-Received: by 2002:aa7:83d9:0:b029:138:b217:f347 with SMTP id j25-20020aa783d90000b0290138b217f347mr1937661pfn.0.1602821223447;
        Thu, 15 Oct 2020 21:07:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e20sm858618pfi.30.2020.10.15.21.07.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 21:07:02 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:37:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
 <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-10-20, 15:03, Jon Hunter wrote:
> If not too late, would you mind dropping this patch for v5.10?

It is already part of Linus's master now.

-- 
viresh
