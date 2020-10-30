Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C426F29FFF8
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgJ3I3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ3I3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 04:29:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B262C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 01:29:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k9so2894300pgt.9
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5m24XKv3rmYhiflffWvjSLRsXqJcmEBkgd6KO60GGg=;
        b=TIrsUG6Ly9+zRcq+SJ/qIs+D8xBuzYeRKRBPKuzBE9LVf0SL0kNg4ppBSNsxfDNDul
         Lk0zSfFvoKqSA7GIBDxpyXM8l3ABGxY3L4ImhU+1V4jOM4Os3vDryyJ6MRgNMKQ0uGMX
         GEABVA3XiS+L7A12O32xu+vcrlPJC/drfj+6Mk9i+uL9X+E4X8n6mLcQQa52KY5kuf+y
         MNKt/fG1vjTziXyBYz2WOE8HSADd+zwXaSGj0gMmNPs8SBqOY/MFn6X7+g4S+G07aFC8
         VWaLYR0d9356UhkX310RR+dXx/AplZlRxmwCxeTGLe661aZ1Tu1zgeEBmzN/ZECyPY6L
         hiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5m24XKv3rmYhiflffWvjSLRsXqJcmEBkgd6KO60GGg=;
        b=bJn18hl53rHjpyqakn6jLFBGeSCwFM/3i1XbdyvqgKIQwz0o4xor9O1yHugN4ZaOKW
         VO/JAbn4TXVgLzdX62d5n8+6k9kyaCAb9l+dBv7WpystncaVqFn6W+oIog08KqbPROig
         GbA0mBnbyCCtU3dmUTdtrh64iMI+Y/KMty8/qc9d6DfeaW6CdyB5f4t10b8+jv67uMQF
         qfLpUujzHRxZR9i2uiHmD3Yceasmz2Hwcyad2cXv5fXLDUYmIF4OLSBCW3ylKGNCBwAm
         sPJm8CZu1rw88/ZRn60GO5klPmCF/wufArMUaQYjdOmUXRbRXv32R15jkHRWrFRGgHVo
         JQGA==
X-Gm-Message-State: AOAM533FqjJ/9WGQjkuKjJ+6QvmWnMd+aiEd8mTs3u3NNp+7rEvf+Elo
        XP3F4LqrwWtIFObYRUSo/RpYHQ==
X-Google-Smtp-Source: ABdhPJzzLhbSDKD9gMJkttY9BBUGB9camLeOPwGl5E90BxlosCMqvnnScYBJaBwfmhPyHTY6LhFUAA==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad12 with SMTP id y17-20020aa79af10000b02901526101ad12mr8094707pfp.40.1604046580892;
        Fri, 30 Oct 2020 01:29:40 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w65sm5135011pfw.145.2020.10.30.01.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 01:29:39 -0700 (PDT)
Date:   Fri, 30 Oct 2020 13:59:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
Message-ID: <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
 <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-20, 09:56, Lukasz Luba wrote:
> There were discussions about Energy Model (EM), scale of values (mW or
> abstract scale) and relation to EAS and IPA. You can find quite long
> discussion below v2 [1] (there is also v3 send after agreement [2]).
> We have in thermal DT binding: 'sustainable-power' expressed in mW,
> which is used by IPA, but it would not support bogoWatts.

Why so ? (I am sorry, can't dig into such long threads without knowing
which message I am looking for :( ). Lets assume if that same property
can be used for bogoWatts, will that be sufficient for you ? Or you
will still need this patch set ?

> The sustainable power is used for estimation of internal coefficients
> (also for power budget), which I am trying to change to work with
> 'abstract scale' [3][4].
> 
> This would allow to estimate sustainable power of the system based on
> CPUs, GPU opp-sustainable points, where we don't have
> 'sustainable-power' or devices using bogoWatts.

Then maybe we should ahve sustainable-power in those cases too instead
of adding a meaningless (IMHO) binding.

Honestly speaking, as Nishanth said, there is nothing like a
sustainable OPP in reality. Moreover, the DT needs to describe the
hardware as it is (and in some cases the behavior of the firmware).
And what you are trying to add here is none of them and so it should
not go in DT as such. There are too many factors which play a part
here, ambient temperature is one of the biggest ones, and the software
needs to find the sustainable OPP by itself based on the current
situation.

So I don't really see a good reason why such a property should be
added here.

Coming to properties like suspend-opp, it made sense for some of the
platforms as the last configured frequency of the CPU plays a part in
deciding the power consumed by the SoC even when the system is
suspended. And finding an optimal OPP (normally the lowest) there
would make sense and so was that property added.

-- 
viresh
