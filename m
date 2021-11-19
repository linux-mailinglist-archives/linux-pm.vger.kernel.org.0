Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E350F456DBE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhKSKuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhKSKuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 05:50:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D0AC061574;
        Fri, 19 Nov 2021 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qwi0Zl08JpIubpCNmWPjJv4J2ykHE5o3WhrHPHXKUy0=; b=V/X1L+W8ois+PtP/N3WV1NOo3v
        QkJtP14/G+fjJgmFc1Ki3tHkMtoH7HxhshspJvSdY5LVwQRVKY4U1/vhK/AU8UtmBp3KNiloruP1/
        LHfNAJBEKtcxplG6+M4ot2TLxEwcibFKXWpDYhGVfmlAmVSxvyud4ayZ7PiMfpS70yYmybHh9cssF
        E4XERg9iIbiRBJ1ZJQw+WJVl+l29Wo+aguNX85Ie+zexvgLZj7awPnLIb6+6ZyV3NTvAM+FDl7CjN
        vpqqejzWXg2O6kg1/ESh3B6MHR6nPOw7reuxU+P5TSWhfS0rRwInoYG084xTnRrJ6SlQVLQAp7Yku
        b+hnWzUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo1Q3-00Gslu-KL; Fri, 19 Nov 2021 10:47:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD8F2300243;
        Fri, 19 Nov 2021 11:46:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C482E30B01606; Fri, 19 Nov 2021 11:46:58 +0100 (CET)
Date:   Fri, 19 Nov 2021 11:46:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-pm@vger.kernel.org, Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <YZeAohkzXVQ7Nd2Z@hirez.programming.kicks-ass.net>
References: <20211119103102.88124-1-ray.huang@amd.com>
 <20211119103102.88124-7-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119103102.88124-7-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 19, 2021 at 06:30:46PM +0800, Huang Rui wrote:
> +static inline int pstate_enable(bool enable)
> +{
> +	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);

Strictly speaking that ?: is superfluous, a _Bool when cast to scalar
type will have exactly that value.

> +}
