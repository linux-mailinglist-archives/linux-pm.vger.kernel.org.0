Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6543FE91
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhJ2Ol4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 10:41:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJ2Ol4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 10:41:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A54821965;
        Fri, 29 Oct 2021 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635518366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMl6XMWQU8PSi/h0g3mYu4dbu43K75wkrTIz7kMuvTc=;
        b=AU8z2m/uf+cGXki+h7Z7wV6RYo9eOp7IrHxJ/DVsd9GQyFRY/q9O7dHK1zfWfEjnMZ/J0r
        hYK83M6LWfXo0ANJKJurMTCime56igr7ypPGNRnTaRYSwqlxCD1dmn8kNCpA5kRUg3yqmu
        XhLHqLKBEFQJG/4EbvHAOct2LI71PZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635518366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMl6XMWQU8PSi/h0g3mYu4dbu43K75wkrTIz7kMuvTc=;
        b=3llfTrrHSYKAXP7Vn4qn3OxG7skZpS/qI2gUPu8IHOZx7xvSFMBmNhiz0F3vTewvT+e3OQ
        9gH65grZBBgIR8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6413A13F6F;
        Fri, 29 Oct 2021 14:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LsZmGJ4HfGHLOgAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 29 Oct 2021 14:39:26 +0000
Date:   Fri, 29 Oct 2021 16:39:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-pm@vger.kernel.org, Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 01/21] x86/cpufreatures: add AMD Collaborative
 Processor Performance Control feature flag
Message-ID: <YXwHm84HYnIGm0hx@zn.tnic>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-2-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029130241.1984459-2-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 09:02:21PM +0800, Huang Rui wrote:
> Add Collaborative Processor Performance Control feature flag for AMD
> processors.
> 
> This feature flag will be used on the following amd-pstate driver. The
> amd-pstate driver has two approaches to implement the frequency control
> behavior. That depends on the CPU hardware implementation. One is "Full
> MSR Support" and another is "Shared Memory Support". The feature flag
> indicates the current processors with "Full MSR Support".
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..f23dc1abd485 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
