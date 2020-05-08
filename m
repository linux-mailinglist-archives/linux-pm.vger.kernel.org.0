Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEC1CAFAE
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEHNSx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728978AbgEHNSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 09:18:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF483C05BD09
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 06:18:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so10145676wmk.5
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2020 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4KMLQ4EJCkyzbgYa2IJD+khf7hToXVbXh2lcQiHZtv0=;
        b=ove31f7pciE4Fbhm6NDLjUI9JBlFL/PA3cUZfCszFLpIChGlte7eSbOLZymdajQ9kK
         gvPBvpGJZMgMzeDA1EWhE0mUt1GnwHlyuFs+gm9exfx6IXGGNHzVY4W50lYSmpTxaCsr
         60fGF+UTCK5hnkhDKeZlzt0pslaA7Y4MwXdN6ESNWcuWEQBFvqVx6K1UAb/+sraNF90l
         xMAMizHB0CVXKviA38ftlh3FUyyE1yDtVKxWT6kZls3slkOAl0Q435rKgLdXkdtvuOtf
         FVitAidX3tCzTkx6dJUJxHvvAArCb6NPH2LSG4Egd+Ea7/031fRzmYTwHdvZh+FaQx0J
         x81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KMLQ4EJCkyzbgYa2IJD+khf7hToXVbXh2lcQiHZtv0=;
        b=pGNBbCeIqcD8eAGNFo8uLRaPcJKxU5e7P4r/tojRH0okpkz5044arTVJr4GrCFEcT5
         gponLCKLk8HWiyGup346rGkhkv9UHQKrfkePus7QIsKPYc9T4YAkunYP7x8OGgTS0Dgg
         YkcT8gxK0t5kbEi8ii5bfaGr7eqjHWLd4Ffu8extwL6+uzwxmieZDj3Hgv5p4iQKC20Z
         xCwo7lnyugatERKycl7I0U1LMVAHwhnXBg1C7q8UO8mNROHdjW+0GCqk4x+ZjGoNGnwK
         RIZic9EGTKNbnX9/kVeyQbQ/XF7bH+j0KGiRRdBfhvkaxF6smwibNpbBZZKSF8tY//Ve
         cH7A==
X-Gm-Message-State: AGi0Pub3J+5iOF4Q9kCGCoBDgauy52fSxNPq/H86DyqE9jb6GM8MQlO5
        CopCW5gE65mJW8zOu4oVmeyklQ==
X-Google-Smtp-Source: APiQypJdRU9stBd3NG3JUQJliF1xwamMgT+gqtFcU/P7BSs1kniXBB4NJN4eJrTemJwu3kbPfB9g1Q==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr17057953wmf.189.1588943923328;
        Fri, 08 May 2020 06:18:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id m82sm988007wmf.3.2020.05.08.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:18:42 -0700 (PDT)
Date:   Fri, 8 May 2020 14:18:39 +0100
From:   Quentin Perret <qperret@google.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 04/14] sched: cpufreq: Move
 sched_cpufreq_governor_change()
Message-ID: <20200508131839.GD10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-5-qperret@google.com>
 <20200508053523.GH19464@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053523.GH19464@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 08 May 2020 at 11:05:23 (+0530), Pavan Kondeti wrote:
> In the previous patch, you removed reference to schedutil and replaced it with
> " an EAS-compatible CPUfreq governor (schedutil)". May be you could do the
> same here.

Good point, I add it to the todo list for v2 ;)

Thanks,
Quentin
