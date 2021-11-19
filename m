Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635BA456F2D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 13:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhKSNBc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 08:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhKSNBc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 08:01:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17EC061574;
        Fri, 19 Nov 2021 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5n4/5dnWB20h+p8lPW2VI/D1yAQ89NbYXpyAxeA+Ic8=; b=KO3nHMA+w2IZel9pRLUrpVg7q/
        Z80uRjYKoJ25LA+EvCkGNLTwfrqYkaEcU27JH+R01SH4iYB2pzNVMAcEt67uT7BPzr1igjmFGpVww
        Se8BHOlrOl24aCxl7xaWMiEYspOavoa7tZw1GK+nna/i2LpKUvYB7/V/sNmX5cl87ohNu3Yi5g/Xb
        IBuMZyLiCdX1JgdeKmytJjidwtfnKImlvAnw1cfVGdIh7KWSLpUIYPwqYdoFiMueule3xxLF7j9zJ
        Y61+zW7v2/7+RURxESNvpBScfxGDCg6MO3JyUpZiZD95g/lxECSQ2k36+OX/+DVmJcumaJvysWoXK
        b8cMRHWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo3T9-00GuTh-1F; Fri, 19 Nov 2021 12:58:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24AF3300130;
        Fri, 19 Nov 2021 13:58:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02CBB20165531; Fri, 19 Nov 2021 13:58:17 +0100 (CET)
Date:   Fri, 19 Nov 2021 13:58:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <YZefaRePXGLNDSpP@hirez.programming.kicks-ass.net>
References: <20211119103102.88124-1-ray.huang@amd.com>
 <20211119103102.88124-7-ray.huang@amd.com>
 <YZeAohkzXVQ7Nd2Z@hirez.programming.kicks-ass.net>
 <YZeHdVexjhXN45qn@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZeHdVexjhXN45qn@hr-amd>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 19, 2021 at 07:16:05PM +0800, Huang Rui wrote:
> On Fri, Nov 19, 2021 at 06:46:58PM +0800, Peter Zijlstra wrote:
> > On Fri, Nov 19, 2021 at 06:30:46PM +0800, Huang Rui wrote:
> > > +static inline int pstate_enable(bool enable)
> > > +{
> > > +	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> > 
> > Strictly speaking that ?: is superfluous, a _Bool when cast to scalar
> > type will have exactly that value.
> 
> Right. Will update it to "wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable)".

I think there was one more site that did this. You don't *need* to
change it, but it's something I noted while reading through the thing.

Over-all I think the series looks nice. Thanks for doing this.
