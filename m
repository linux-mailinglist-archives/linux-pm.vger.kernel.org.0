Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86DB408BFC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhIMNID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:08:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51946 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238976AbhIMNGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 09:06:14 -0400
Received: from zn.tnic (p200300ec2f097300d78cc1b25aec21e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7300:d78c:c1b2:5aec:21e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BB911EC04E4;
        Mon, 13 Sep 2021 15:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631538290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ttLJKLYi5pA+YcY2I7cFti2sz8nubJ1m8ZVVm6G8PV0=;
        b=A1SS7/b6jTZkO71Imi/1eJaJjRRpqn5FVqXGEw9yqppuvQ93HnXlCDFn99Z8nCzGK+MLZ/
        Dwma2jcfQL5iutHcSs1pUm7945jiXM5VdKE+/4YZxvUDVfA06qEUNl+6fLX60j7nUAJGgB
        YVMP/zW1Kb455o7FxbLWKq6WBy8dI5I=
Date:   Mon, 13 Sep 2021 15:04:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
Message-ID: <YT9ManjgABReBVX2@zn.tnic>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
 <YTpLO6M2C0IqJ9XC@zn.tnic>
 <20210913094851.GB3731830@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913094851.GB3731830@hr-amd>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 05:48:51PM +0800, Huang Rui wrote:
> This feature flag indicates the full MSR hardware solution of AMD
> P-States, if it is not set, that means we will go with in shared
> memory hardware solution. So we name this as extension.

Nobody cares whether it is an extension except you guys. Also, having
AMD_CPPC_EXT suggests there already is AMD_CPPC. But there isn't.

So call it X86_FEATURE_AMD_CPPC, please, for simplicity's sake.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
