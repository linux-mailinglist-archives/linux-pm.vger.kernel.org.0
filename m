Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A724FBE9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHXKtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXKtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:49:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2161EC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:49:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d4so3992475pjx.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjkxxuC1szwGHRNIyVmrAyGGddXINTGLjaWFX2iRopg=;
        b=EXPALbqEGdBWrXZTav4s+et5rfg6rS58r3zndXrp+McI35Rm83F6MQet+ZJy/fFXwF
         E/O0zJWQxixcmZZTaShryTlt7My52xNjF/PBJ69jLrkw0IBZcal/OMqJmZNWtmgRM5QD
         a6uhQCPw9/1Hwtqgsp5pyof9VCZmq8WOKqrusIdddSS1ywA7L2H6a9LO2NtCLWWHWkuf
         D9uc/hWb33nHXL35O/bS+wcsPstSY3cF6LEecILry2tb2UhS5oJiKjgl7slUeo/M1WCj
         0e99UmInpKq/3ws3OeQBZWXuiGoEQz0TObC1XwUvRTYwEXUJy0jPYRaMNrHmo8HYKK9D
         ZePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjkxxuC1szwGHRNIyVmrAyGGddXINTGLjaWFX2iRopg=;
        b=p7ncLf42/R0QXmckAcFSd2X0wyW36LIyfAHYt9aUM/j42ULVJWiKP/vT1e/m2Z/UCj
         1wMdsmFobz06N9IKzdBqGRjAreyQUqeON5M5F/YcgjMIn3J8VHCtPsJJfU5BCz42BTlg
         O3Sdn9TjtDjb9GjNT62utl9YxkBvp39veIIKSXH69hHE9a76YZ96jiK9OeX6aDh/miRh
         Vg2ko7xAES4QxUwF0GJ05FepoXYvGdGLW4Ncmy0VWIElmfTk9NO1V7QZgCwUiFwmTNsT
         /ZdQLWh67F5tMtOlmikNNwMV6Z7WUWnW8wCw14gp4iQEk/8ovJp87Gdrz+Kei/ftOsP7
         0egA==
X-Gm-Message-State: AOAM5339eOSGwEpwsNmyj2jxdF0Wba8wUalHISRe/sGtC35F/XRt38m1
        fGe7qllblU6WTHuhAnQHSy6gEg==
X-Google-Smtp-Source: ABdhPJx+vU36rrPlrMYKD5y8C78AstfN/rXHjPa8ivCIrsANOcEK8dlK1TG599BP5mpzzd1DRLnbMg==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr4070886pjb.143.1598266148651;
        Mon, 24 Aug 2020 03:49:08 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id r91sm9435704pja.56.2020.08.24.03.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:49:07 -0700 (PDT)
Date:   Mon, 24 Aug 2020 16:19:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
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
Message-ID: <20200824104905.vui6bdcpsmxluj4m@vireshk-i7>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-07-20, 11:38, Vincent Guittot wrote:
> Yeah it's exactly the same behavior as x86 and re using the same
> mechanism seems the  best solution
> 
> The main problem is that AMU currently assumes that it will be the
> only to support such tick based mechanism whereas others like cppc can
> provides similar information

Ionela do you have some feedback to Vincent's email?

We can't handle this apart from the tick handler, i.e. capture this
data at every tick like it is done for x86 or AMU.

-- 
viresh
