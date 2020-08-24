Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E324FD7E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHXMKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXMKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 08:10:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407CC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so4133034plr.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UE8GsvqgRfc/MyLKuyAyg2OP5wLsadeZZ0TASbpeOos=;
        b=KTv84FgOZYRLZaVzaKcnEGSiCtWts+r2p99KbkS11TfoNQ/BrCBvN7N4i/4/qHxOsq
         CP1xcENdSEXYN3VrgKiqm3XSXW5FZLjPbs2bnilRxS0c5ke1bpt6oMDLCBzVUaNmI80H
         Uu2UdzVMM5csaNwdlcoX5mKA85TnAmliqBPhjktUQ6XmF+2ys2vH5kzZ+JlPDWoLUdiV
         Hzkwd7Ff+WKIKcm7fLxxNJivNlQEmdVhz/ohvd2+cyIRibD6OjtMjt2+pN+F8sHqYPzS
         Cyzh7HmJxTSzw7GgnJBd6B0xw5MX0UN3U/zwLzLPWvlekTPwJpjnEqlUGPtg5808CLSM
         96tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UE8GsvqgRfc/MyLKuyAyg2OP5wLsadeZZ0TASbpeOos=;
        b=Ba7oRpHKY0r8+NsBTBCC6TZMQExJ95ps5+cpkptvNNeFyWOu5FyVdD6N97vbGL4F8o
         8XUlx8EY0RICFyEWTo3WUvnrmE/nzd8rg2p2SxvcLA6nvbE+6qlijH2SUQjdRQAeIhcN
         fy1YWB2cFfGkMOttiHes3Vbdqd/vHNhzz8x+MOzB1htn4raosYRUb+Bfw4y96WM6y0Rr
         D4omj7leT/FvwoOksRZDcB9kKfTA1Sx34LXm1TX540DzrgZcCPR1B2h43YB7IoS5RzEm
         /CNqGhzqNBtbaRW3K4HzJmnHIi9uo12xDGppJDYioT+uwAk5/n3+iUEmSyEbC29lO0NM
         J2aA==
X-Gm-Message-State: AOAM5315LF1Grg7uBYybBct6ukBzbg468FOxcXYfpTZ3DMv2orOxj0Lq
        OE/fD1umVCtUM9rVBWWkLo11tVc6bOmZAw==
X-Google-Smtp-Source: ABdhPJzTb31VyJiQjxBciWNtrTi8EcV65QqVW5MQGVt8MNlXhG3Y/Wn8eVkWOXBIr1qDQ+OLlpCMkQ==
X-Received: by 2002:a17:90a:dc13:: with SMTP id i19mr4052844pjv.161.1598271007440;
        Mon, 24 Aug 2020 05:10:07 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id 124sm11616600pfb.19.2020.08.24.05.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:10:06 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:40:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/3] opp: Reduce code duplication in
 _set_required_opps()
Message-ID: <20200824121004.mvssnqu4khg75cyb@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-2-stephan@gerhold.net>
 <20200824111820.rcaingohxw3wozgd@vireshk-i7>
 <20200824113016.GA131681@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824113016.GA131681@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 13:30, Stephan Gerhold wrote:
> You're right. Not sure why I removed it.
> 
> I suspect I had it in _set_required_opp() at some point, but I moved
> code around several times until I was happy with the result.
> 
> We should just add it back.
> Should I send a v2 with it fixed or would you like to handle it?

I have applied the first two patches to linux-next branch in my tree,
please have a look.

-- 
viresh
