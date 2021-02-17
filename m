Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9544631D8A9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 12:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBQLnk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 06:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhBQLnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 06:43:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D259C061794
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 03:40:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so8214100pfj.12
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 03:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11pGVD0nzA2DAiJ7cWPXp9I44T8zR661lI4xstwokb8=;
        b=nN3POMtqLZQF8/79uB0ZdenvqJkcov6oKL3+Yaukuqsj3U0pi+rmZsW6D/unqNXCP0
         4Xdu9O8wIAQpxqis6OuGqhr9RyyW/HWKYqZvwuPiAvJH+AHoGjRTDzciOgrTwWOkCoUF
         XT+TnNXJQBqDJCNrAYWI7L4mVB0cgLerE8aevwJe0wxiKZjvQsNBpi12uHi1aFyY+LEN
         9HAfWZMhSvePdMxjTbgmHXF0qK740ZMRl8hnxQotc2GLAzMrDYRs03JAFseq1X4pOtbd
         lNCp3VQMft6/UqDuzuWT4qnPLMsSrIfq3lbn5vOqg/MtC5jv83XFjcuEW3ygFDMyvUoR
         IK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11pGVD0nzA2DAiJ7cWPXp9I44T8zR661lI4xstwokb8=;
        b=TkY9NTcDWj2KfW7UVYzXefyeb8EVEiPXbdGm6bBRMLd3jZAcNHu6EsTC3Pvfmpo6qr
         op3u3WkQUwewl6lrsFLNQ4IJ7xrG0vhH3UbWrf4XhCkyf/comTTnxNnnUe0AjvECas+f
         riOoIud1sRCXIFy5fMaadzb3bAYr/IEKziuNz7QiwMygKJJuj8E3JV72ca7p+z8R/VkX
         D41omyipQCe+20QAVsMWg+opy/vZUP06YSihQELejxTpPML9HG23fftXqUpY5r3TJ4J3
         YuzgtTSn+084qKzWYe3Q/7YRdp6HZqmb3aY2owAe995qHcG55L/DdyOOt4AM0B6QcIzE
         rBGA==
X-Gm-Message-State: AOAM53002vf9HaXSEC00Mog8QQDsjkNxs5eBF2uuT+yr4jFF7eg6A30o
        6ngSPNFteRZursDBaee74+cpSw==
X-Google-Smtp-Source: ABdhPJzr4uJe4QkljUPFWlLqLXnOjixB1cwYPo3cq1LNkxSXQbV/GK5ae2xqgQx6gdCFQbeMSp90cQ==
X-Received: by 2002:a62:6585:0:b029:1b9:d8d9:1af2 with SMTP id z127-20020a6265850000b02901b9d8d91af2mr23638713pfb.17.1613562030391;
        Wed, 17 Feb 2021 03:40:30 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id h124sm2331354pfe.216.2021.02.17.03.40.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 03:40:29 -0800 (PST)
Date:   Wed, 17 Feb 2021 17:10:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210217114027.ashqh67hrfk4hwib@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210217042558.o4anjdkayzgqny55@vireshk-i7>
 <20210217113011.GA22176@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217113011.GA22176@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-21, 11:30, Ionela Voinescu wrote:
> The problem is not topology_scale_freq_invariant() but whether a scale
> factor is set for some CPUs.
> 
> Scenario (test system above):
>  - "AMUs" are only supported for [1-2],
>  - cpufreq_supports_freq_invariance() -> false
> 
> What should happen:
>  - topology_scale_freq_invariant() -> false (passed)
>  - all CPUs should have their freq_scale unmodified (1024) - (failed)
>    because only 2 out of 6 CPUs have a method of setting a scale factor
> 
> What does happen:
>  - arch_set_freq_tick() -> topology_set_freq_tick() will set a scale
>    factor for [1-2] based on AMUs. This should not happen. We will end
>    up with invariant signals for bigs and signals that are not freq
>    invariant for littles.

Another case. cpufreq is included as a module and AMU is implemented
partially.

- first time cpufreq driver is inserted, we set up everything and
  freq_scale gets updated on ticks.

- remove cpufreq driver, we are back in same situation.

We can't control it that way.. Or we add another call layer in middle
before the tick-handler gets called for AMU, which will check if we
are fully invariant or not ?

-- 
viresh
