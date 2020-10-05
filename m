Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60128313B
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgJEH60 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEH60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:58:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83065C0613A6
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:58:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x22so6273780pfo.12
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wt1eY5ySQ7zeKuyklJDHkBCjNeSzu8NHJjYLWLeX8sY=;
        b=swvOXot1YbYCGNxcWiToQ+75e2uZCnTPbIHfKBFlaufFP1FoE5tGqi4hYg2/x6recG
         2qKx+Y4U8lh6eYiuS2Hjf+5m5NuzN+nDj0Tt1zIK/qTdZa9U5FoCB5KMcoVdeLUTyHlW
         BJ/xME7KZdjZ1GlBTR5R59QEv2aud3qyzwi6Vz2nHab+G+wrIQo0LlKBVpVIaUVZw8CT
         Ju7O2SrML+bEN0jPB4LkviL476tmAVxdXOMiibdjG6649K89qzHDM/uTvQm1lqY4m5/k
         SRahPw7ERiw8qksATVagKm3rck4u8q7BIMCFYAts3wQearQUP3Ltl5sbyr7aVdHeeGCu
         A9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wt1eY5ySQ7zeKuyklJDHkBCjNeSzu8NHJjYLWLeX8sY=;
        b=H7y8esemhO1JP7ByBuMDDtRsErF6KFho+wFxPlL7Rhok7s1mX/FLw1PW/A97VLo/9w
         tfztSfQYg2Tmayz2PdDdIunXdHi80BR0yl9CKUPEWpSOfWcI6tyU/jhLsS209eGN19KT
         keGg4DeZWsV7b89oRPdX+TatUqiQWr5lUFD3mBvepXvBfhTG0Maa628zTcwmK0ih2YAb
         h/stSD8+uYb1rOIan5+wrjwy7ANey6th7MZ40uJoF9YsKrSpjqsZvmZMm90R4N6pft4F
         cHNNZdBZIRCBsb7XK+utuDI+Cqlrb3sYwu8B6HgLLgidf0osCq0pttj1bew2o5VIPXJS
         cSlg==
X-Gm-Message-State: AOAM532GMR35JRFbvrZs0+WzB/nNaqnkEmsiKCTrUOWf6V5zc5dUZwp9
        SCL46ucUKs4suOoXQ3PHf27laQ==
X-Google-Smtp-Source: ABdhPJwBcFs5doqrGh/r9Eqn6hv6BOLwBEiNp0Xq+5FMT3S3EADoPW6HdBXGFiV6qCitdHKCC1LIoA==
X-Received: by 2002:a62:545:0:b029:142:2501:35db with SMTP id 66-20020a6205450000b0290142250135dbmr15763183pff.59.1601884705073;
        Mon, 05 Oct 2020 00:58:25 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c185sm11436315pfb.123.2020.10.05.00.58.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:58:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 13:28:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20201005075822.6odp2ulk6wopcwtn@vireshk-i7>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
 <20200825095629.GA15469@arm.com>
 <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
 <20200827112740.GA9923@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827112740.GA9923@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-20, 12:27, Ionela Voinescu wrote:
> I am in the middle of unifying AMU counter and cpufreq invariance through
> something like this, so if you like the idea and you don't think I'm
> stepping too much on your toes with this, I can consider the usecase in
> my (what should be) generic support. So in the end this might end up
> being just a matter of adding a new invariance source (CPPC counters).

Any update on this ?

-- 
viresh
