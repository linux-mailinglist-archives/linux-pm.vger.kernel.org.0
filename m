Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764F61CA2B0
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgEHFeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 01:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgEHFeC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 01:34:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628BAC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 22:34:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s18so340190pgl.12
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ek85+5EOYLMSUNDa2pk81mbaX6vTrFpa0o8AoGuV9zA=;
        b=N73uucdqyUPlc2R76m0kX5oIw8VwOcGlpjiOR17583QDP5OzJzReJ5AM/Z4MXMu44n
         tf/L2XGF3JhG8xLpjuA46jEKBAcCLTQGTGn6Sst8YZpO37cgPhPGwvpD/KWWDtwJMchT
         yafjsM1HCnPahw3QPaj0JdouQoLw0+qs2b287bxqogw5fwlUeT16lfoaTqdheM8O2lfC
         WZZSAqtXNgLBxE9B4Md1wdWZqyrhTNrOy+lK1tGjtTBMrhPkCQEGZiK7VVmt90ay1z8O
         FYTIHycL6nkKdiolwlm08Ix8FmVc7lrji14z5IAfq84Vo8tD6Z/pyIsKJwfGnt3ObXiz
         EW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ek85+5EOYLMSUNDa2pk81mbaX6vTrFpa0o8AoGuV9zA=;
        b=prLKhjb2/6KgcpHBzKpRZH3T1Z17Ul8PVucZ5m4jqdHAgLieJ5qn1ayrrkRjeqjMPB
         blXT4LmUMrBkVKE0bBhiCU41ZTkaiKezKcCtnabDaGVmt/eNfgZ3J9Zwgre5LFzLXi7C
         lSl75ePIWL9hC3zrt0/jridG5EU1NAu28kfd1y1/spr74MWJAI2V54jYeajAUeGk1Xre
         nH2Vkic5R4pHBJITTOZ6q9Z1cnVMmAqnyaeKNaEktMPQFaZh4RGfiYe4qgg0xGW9FGxT
         Dxdbz8cF75qvf9vlPK7ozt3/j5CyW3zoAbLF3vZYXYeTAB7DWi/aFtOoEsgd1wOKVfMF
         /KTA==
X-Gm-Message-State: AGi0Puat8D5bGISl1Hz7xGJvgzSTJebwB9BM5H0nysku2alivhJVK6Az
        tnLFZaesxhIxJ28gywMTcRjuyA==
X-Google-Smtp-Source: APiQypLarkLj/uc/Nq9W7V3UCRxdpQ96qkmYq8vA11V45RrVGKvf11uWNMgLc9quK1Zo2sxuDF4DSw==
X-Received: by 2002:a63:8e49:: with SMTP id k70mr732060pge.73.1588916041742;
        Thu, 07 May 2020 22:34:01 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id cv21sm1383514pjb.23.2020.05.07.22.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 22:34:00 -0700 (PDT)
Date:   Fri, 8 May 2020 11:03:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508053359.ul5dbws6vkpdrbef@vireshk-i7>
References: <20200507181012.29791-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-05-20, 19:09, Quentin Perret wrote:
> Android is trying very hard to use a single kernel image (commonly
> called Generic Kernel Image, or GKI), closely aligned with mainline, to
> run on all Android devices regardless of the vendor.
> 
> The GKI project intends to not only improve the status quo for Android
> users directly (less fragmentation simplifies updatability), but also
> to benefit upstream by forcing all vendors to agree on one common
> kernel, that we push hard to be aligned with mainline.
> 
> One challenge to implement GKI is to avoid bloating the kernel by
> compiling too many things in, especially given that different devices
> need different things. As such, anything that can be turned into a
> module helps GKI, by offering an alternative to having that component
> built-in. This is true for pretty much anything that can be made
> modular, including drivers as well as other kernel components, such as
> CPUFreq governors.
> 
> Indeed, in practice, Android devices often ship with only one CPUFreq
> governor enabled, and don't require any other that would simply waste
> memory for no benefits. All CPUFreq governors can already be built as
> modules with one notable exception: schedutil. Though popular in
> Android, some devices do not use schedutil, which is why it would be
> preferable to not have it unconditionally built in GKI. This series is
> an attempt to solve this problem, by making schedutil tristate.
> 
> While modularization is usually not something we want to see near the
> scheduler, it appeared to me as I wrote those patches that the
> particular case of schedutil was actually not too bad to implement.
> We already have to support switching governors at run-time, simply
> because userspace is free to do that, so the infrastructure for turning
> sugov on and off dynamically is already there. Loading the code a little
> later doesn't seem to make that a lot worse.
> 
> Patches 01-05 refactor some code to break the few dependencies on
> schedutil being builtin (notably EAS). Patches 06-12 export various
> symbols that schedutil needs when compiled as a module. And finally,
> patches 13-14 finish off the work by making the Kconfig tristate.

IMHO, you have over-broken the patches, like first two could be merged
together and all exports could have been done in a single patch, etc.
i.e. all related or similar changes together...

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
