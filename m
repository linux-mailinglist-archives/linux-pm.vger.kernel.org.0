Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C729696A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371537AbgJWFjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 01:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896447AbgJWFjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 01:39:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A3C0613D2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 22:39:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h7so286784pfn.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FSl9yZQEGsIPYQVxtj+sm52raMGyjPKKi+Jg6yVVKDY=;
        b=jUqn3talUm2gCjYA1KLQa2/isLqjGJBLC+efpw8zNRZweJiPqSsMHNO7vDIss5LQ2S
         FgmXDpd8YQbejlZxvdqkMMD2qQUypmt1Scmg1g06r/na9AEHhE79Arv9R421VxTKveyD
         5JT6uHOc5jUtPzYE6KhK5tMuM79UC6YEqE5qCElWhJoGqshe1sZpWt1koW8McgbNcQgY
         qwMpbW8epOejhXwilml5QK0wcjtR6MvdzK9ARYcDZcdCInq5Ss3pGNd9Xp7b1pHAfC87
         YZtsimTtNX7lgwU5qswV/4f7dHDhp889U5JJ1kNq4Q+QAbs3e1HCSWrEqfCHckjvW/4E
         66Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSl9yZQEGsIPYQVxtj+sm52raMGyjPKKi+Jg6yVVKDY=;
        b=ONu+Rcr9b9IFBM3xQsluSVfIrD2N07DA5pzG9x3xzik9wiILuDvfK05YJRsDygHMm0
         BsE8yo/qcSCWYcAsUkifFGRvC3dOoGHsgSN5tkRtAuJTui3eq4vWdBOFcB7vgFqXUSAn
         9LY0wn0fHgLgRwvE4dPmWVNEZl9dxBXpZy1fya65p3YJThWL5Vlf4xXEBG7abh3IU3wN
         ulf+1uDxEa04TeaV4h+1uF+ZjAblq+v2faq/2Q7U6nTa4ft732YylrOBC1P8hr+QYbra
         7p8PPq7n/md3VK2zl54lcIOKz9jiUNv0ookVQNtoGFmmBLJPjKgjZAR5DDPNKkwnn1Nr
         9CsA==
X-Gm-Message-State: AOAM530JjSF8Hw5wpmNNyHnGTtmLqCnwK9iABJrrHLXHQGXguDp+O9BY
        CrrRVJmml4W3XZPt9E1BefqU4A==
X-Google-Smtp-Source: ABdhPJwwgMlBA7avKaLbk7ip6uKKjC8HhmmBDd3qnEE1JHCTvvMQNT89AjgH+zDznYNOwhrAQ83GYw==
X-Received: by 2002:a17:90a:4481:: with SMTP id t1mr673937pjg.216.1603431581668;
        Thu, 22 Oct 2020 22:39:41 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id d9sm501375pjx.47.2020.10.22.22.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 22:39:40 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:09:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] cpufreq: Drop restore_freq from struct cpufreq_policy
Message-ID: <20201023053938.4lu6f6uvysfevhm6@vireshk-i7>
References: <1666263.spd1I39WAV@kreacher>
 <3286881.tlMdjJ8CK2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3286881.tlMdjJ8CK2@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-20, 13:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The restore_freq field in struct cpufreq_policy is only used by
> __target_index() in one place and a local variable in that function
> may as well be used instead of it, so drop it and modify
> __target_index() accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   10 +++++-----
>  include/linux/cpufreq.h   |    5 -----
>  2 files changed, 5 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
