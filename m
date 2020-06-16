Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7D1FA7BD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgFPE2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPE2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 00:28:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4FC05BD43
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 21:28:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so8662901pgm.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YaFHme5I+vEiE9uZgkx1lHevUOVlBP99z4TPAG/B6Js=;
        b=n9mKx0XLblljfU1/2otAMQ6pOQK99gXRz18ZgUZanhinH4owiDvYtypcf6Sqq8gdZG
         Yb2CBv7G7K2Yb6rXbPVUvT3oyqsRA3u/c8QRqvJ/zi8KD0E0RBo4aBUCBPJVrq3dWApo
         j0tAWc8e3IDgc89c+TIzduQ0sDiDTd9muFhIdDU7HsJCvRhJhGGGEz4h6378+1ZpL+Es
         GxLDhhajfiVsOIZH15jDXXb767tbDzuQjAvSief8u3zUyPKP6XHCtCKkyf4iewHo9Odl
         Q9KvqSKO8336D8/ZgFsKI6z6gXxnfqM7P3IC/gngXLggYeSojKqsQNto+keFGVdQGGCF
         b5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YaFHme5I+vEiE9uZgkx1lHevUOVlBP99z4TPAG/B6Js=;
        b=kU5OEBAVzm6horWtfjeHSGF1Ju32TWdBrsmVQ81YglqSfzSPBP3Vwgzw1jtZnmu9sQ
         /hZu/JkuIcV503vCMti0JZ1Y84Pr442JWJCrDAUhh8GJIknzf9UOzbqNt8vzAmNgE1Wv
         shvkFv8LnQFg6mXDyiqCKUROuxKVpAHycr5Yyr+Wgbygyot4l3j0BYylOT+UUYnNtUwd
         UDWSvfOgtSMz67RgY35EVDU2bSVs5TsD8pxT86bel7rdVVLJ2na1UUNP+stl/n4cdPor
         5dU4+G13E3jnFLHH7im5IfAkKNRfUfpxAjvpcwgaQYB5skxE5H1/uXMNaMOI6dK8Kwqr
         lyGA==
X-Gm-Message-State: AOAM533f87/BQVoSy99OJFaaOtoKBklnVB0PWbO80z98kDN2CPFsVtDL
        WNQzB2y/GmhJi1ZrH+0Ss0Rz1A==
X-Google-Smtp-Source: ABdhPJxpnwaDV/9AKfcTr2LjEIIk4xAPjUH6jqsguih+3J5o67WPw9vRcApVwL9o95WNsa02ug5U5Q==
X-Received: by 2002:a62:7bcd:: with SMTP id w196mr433531pfc.73.1592281715522;
        Mon, 15 Jun 2020 21:28:35 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id q10sm16272276pfk.86.2020.06.15.21.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 21:28:34 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:58:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 1/2] cpufreq: Register governors at core_initcall
Message-ID: <20200616042831.3kazrpvvjhbahoaj@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615165554.228063-2-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-06-20, 17:55, Quentin Perret wrote:
> Currently, most CPUFreq governors are registered at core_initcall time
> when used as default, and module_init otherwise. In preparation for
> letting users specify the default governor on the kernel command line,
> change all of them to use core_initcall unconditionally, as is already
> the case for schedutil and performance. This will enable us to assume
> builtin governors have been registered before the builtin CPUFreq
> drivers probe.
> 
> And since all governors now have similar init/exit patterns, introduce
> two new macros cpufreq_governor_{init,exit}() to factorize the code.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> Note: I couldn't boot-test the change to spudemand, by lack of hardware.
> But I can confirm cell_defconfig compiles just fine.
> ---
>  .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
>  drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
>  drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
>  drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
>  drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
>  drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
>  include/linux/cpufreq.h                       | 14 ++++++++++
>  kernel/sched/cpufreq_schedutil.c              |  6 +----
>  8 files changed, 36 insertions(+), 106 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
