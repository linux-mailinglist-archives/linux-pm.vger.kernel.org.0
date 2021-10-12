Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF6429D5E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhJLFxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 01:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhJLFxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 01:53:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F63C061749
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 22:51:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q5so4840598pgr.7
        for <linux-pm@vger.kernel.org>; Mon, 11 Oct 2021 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBtpCZbIOWtvahLXRDKKDjKecXESKAiO4U+qtM3fqF4=;
        b=TnaMy710dXLuP2UJpvYYEci0HGuzrNFBasfSx2IKwcweLvhm7Ijn2ywSfxqmyqB+pP
         1QN5V1L+gMujcMAp8UkixsGDdqUFYk/ECuh4XIEV25SpY7BcW2YSUxOtLgd5ZBTsf3uY
         hRmDbHVciUR81IbQvUPR9YFNx5LNWWAoQr41EirdPU2Us/c8VbuBU7Xof9R+ZOMlP/3l
         tjjZ1mW36NloFY/ns5OkKXzyfaWG0wXP4ClZ3Neg3bYRZBvsULE1WZbaZVDflXXhQvFc
         ZF/6VxzdRLWUhHgZxgkuDn634tLGA6Ek7AiEFNJ+w1Aemy0Y9wNI4aCjlhgow47qNwoN
         9UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBtpCZbIOWtvahLXRDKKDjKecXESKAiO4U+qtM3fqF4=;
        b=t41+4paUFlX+mI+AUfow8HMznKHzX6PinohbflginSVAMkzgFzdLWY6I4d/ywROz+P
         3NSj0xIskeIYGFdXAtWKVqawjQ0tJXRT2a3u20h5UtWHFHaR8qcfsdO92pEXKpyLLl8A
         sKkWkM3xl4taftTEIa/1/O57Km97nUOgmwcfZrpLrsGszELJjlU5JYqbMo5Vbpi17TmB
         btnfU7OV8GK/Gop44Yij2SqEMrwmNrsjSNlVYP7HfaP2bHHemo38tUP4Arkr0ruecDzd
         RtPrlSXHliXHabuDfEq9WVyKRrbadNlG3Gc3Y9NFXh4S/RfJlTaNxJhUaJrZ+ruy+oX6
         TnKQ==
X-Gm-Message-State: AOAM5323Jo6Qk2DGRXT0c8SU7oQsZL4YYjwk+8tGPDhdTiMEovfJcTgh
        K4FjZOGKNJFRQyWXZSxWGFEptg==
X-Google-Smtp-Source: ABdhPJxmbvSSSRs/QD+1yS5ZcH1WaRkFLvr50doFVs/VKoJlbooNZMTu2jEh9QgF3xf5jI/HzOhtPQ==
X-Received: by 2002:aa7:870b:0:b0:44b:bcef:32b4 with SMTP id b11-20020aa7870b000000b0044bbcef32b4mr29407229pfo.41.1634017905739;
        Mon, 11 Oct 2021 22:51:45 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id y142sm9477261pfc.169.2021.10.11.22.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:51:45 -0700 (PDT)
Date:   Tue, 12 Oct 2021 11:21:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20211012055143.xmkbvhbnolspgjin@vireshk-i7>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7>
 <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-21, 14:34, Hector Martin wrote:
> The table *is* assigned to a genpd (the memory controller), it's just that
> that genpd isn't actually a parent of the CPU device. Without the patch you
> end up with:
> 
> [    3.040060] cpu cpu4: Failed to set performance rate of cpu4: 0 (-19)
> [    3.042881] cpu cpu4: Failed to set required opps: -19
> [    3.045508] cpufreq: __target_index: Failed to change cpu frequency: -19

Hmm, Saravana and Sibi were working on a similar problem earlier and decided to
solve this using devfreq instead. Don't remember the exact series which got
merged for this, Sibi ?

If this part fails, how do you actually set the performance state of the memory
controller's genpd ?

-- 
viresh
