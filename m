Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69F42A0F8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhJLJ2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhJLJ2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 05:28:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F3C061749
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:26:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k26so17118195pfi.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UThv9/l5JLWRg1EUeAvAf2rdPT35TBaOdfxcZAHIs5s=;
        b=voDlimX1xu+r1wO6ZvIbywJAaRgOgRtqddCp3Hh1AeXbQ93FTDKhoeQ42v9vpzTxYv
         HFn/5wqHW1p4MuYCK2nkAEW5LeRFKqprZ8K6iURkCe/V5KrfviM0SOYVYaebrv0WBRSZ
         RKJxDFFc+kCsdm5lAe9oQoolSePNiEGXpBIbn2t1OlAvRDo9NzlcrIqG5AIjZ5c6MISO
         Nd2ivsspRDIPUS4BfUtKRspXloSe/k0oCTpttKIxUWfLchexZZ+KW8uOdt4BnO26/I0o
         cu8FeKhUJgmm/PDqrPK4jCXM+U0L8HVP+fnWvwNrdXo2YL0TZc3zq6TgH6wzQRfuOkaJ
         AzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UThv9/l5JLWRg1EUeAvAf2rdPT35TBaOdfxcZAHIs5s=;
        b=cZvy97F0Ykkuf33KJgOtnb8uUYX3XqhJ2t8nX/hXY1OhiUaAMBME62gfsp1YObLUSt
         37rmju4UzvM2eOcCkzCSA1cPH07AIKFOTwbG0gICnZ7Im4kq4uDmCpTC7FjGVcvwV16u
         wfeC9T/8YfcWM2VsOTY4hiCnp6AcXPtu5Qj7birCzou23w78zcSJUSpfhnOGKLlJ/e5M
         qaY6kV1EgPohfUMQmfhegsWS/bCql68Y4xIKn9ouanSsn5HgiP5SaoJelPrScikQpLdB
         MAXyFh/Lhy04IvMo9b0p0Cj1f0M3jmSUFafeQtIPLO3HTyU3fpeDBOabyufKBwEAEqQw
         rB/Q==
X-Gm-Message-State: AOAM531h1gt145hR0THLzoQJ6831Fo2q8NOYbdqFipy8/lRnNXj+22Pi
        C9rlEgbmLNeZI4XYtGl18VvaUQ==
X-Google-Smtp-Source: ABdhPJxfgS8Y8jGCRj45ARUvTIJ99eYeufFhQrb7v3F0pttpzckQD45Ok68amrQxDgv2TgaRtqRFuQ==
X-Received: by 2002:a63:555d:: with SMTP id f29mr22264998pgm.33.1634030765435;
        Tue, 12 Oct 2021 02:26:05 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id w13sm1961636pjc.29.2021.10.12.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:26:04 -0700 (PDT)
Date:   Tue, 12 Oct 2021 14:56:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device
 does not exist
Message-ID: <20211012092603.lkmhhjoo5v67wh44@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
 <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-21, 14:57, Hector Martin wrote:
> On 12/10/2021 14.51, Viresh Kumar wrote:
> > On 12-10-21, 14:34, Hector Martin wrote:
> > > The table *is* assigned to a genpd (the memory controller), it's just that
> > > that genpd isn't actually a parent of the CPU device. Without the patch you
> > > end up with:
> > > 
> > > [    3.040060] cpu cpu4: Failed to set performance rate of cpu4: 0 (-19)
> > > [    3.042881] cpu cpu4: Failed to set required opps: -19
> > > [    3.045508] cpufreq: __target_index: Failed to change cpu frequency: -19
> > 
> > Hmm, Saravana and Sibi were working on a similar problem earlier and decided to
> > solve this using devfreq instead. Don't remember the exact series which got
> > merged for this, Sibi ?
> > 
> > If this part fails, how do you actually set the performance state of the memory
> > controller's genpd ?
> 
> The clock controller has the genpd as an actual power-domain parent, so it
> does it instead. From patch #7:
> 
> > +	if (cluster->has_pd)
> > +		dev_pm_genpd_set_performance_state(cluster->dev,
> > +						   dev_pm_opp_get_required_pstate(opp, 0));
> > +
> 
> This is arguably not entirely representative of how the hardware works,
> since technically the cluster switching couldn't care less what the memory
> controller is doing; it's a soft dependency, states that should be switched
> together but are not interdependent (in fact, the clock code does this
> unconditionally after the CPU p-state change, regardless of whether we're
> shifting up or down; this is, FWIW, the same order macOS uses, and it
> clearly doesn't matter which way you do it).

Yeah, I understand what you are doing. But the current patch is
incorrect in the sense that it can cause a bug on other platforms. To
make this work, you should rather set this genpd as parent of CPU
devices (which are doing anyway since you are updating them with CPU's
DVFS). With that the clk driver won't be required to do the magic
behind the scene.

-- 
viresh
