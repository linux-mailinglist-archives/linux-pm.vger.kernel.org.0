Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98037446D67
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhKFKbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Nov 2021 06:31:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhKFKbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Nov 2021 06:31:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CD501FCA3;
        Sat,  6 Nov 2021 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636194545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/HgqTYuQp+cnwwMHpiHFLT7O0dhDvkwRVXD4HVG28Y=;
        b=m2yGYxUXCh2FN/a7QFawYQ7gW2iX24ssXPmu49koKojkNIJJCUfEbaKCTPVwRZ4rZJfgGf
        rk182bt7z0d/vb3nQu5VBlW6EhNVp0E+z0Y0QQ9q/GZpoh4x5MpGEXuYe6MCJbkINX34RB
        4qwFtS0kZOCypbJZxR3B46/aFNF82rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636194545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/HgqTYuQp+cnwwMHpiHFLT7O0dhDvkwRVXD4HVG28Y=;
        b=Era4DoNoIt4LMO14+7gYM+wqGZAsqxCCwBKICRZTrk01h2Lcbpf7f9jRZKmesmqWI+j2Ik
        SyL2vAHnDRVrK4Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 151A413AB3;
        Sat,  6 Nov 2021 10:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bn/XBPFYhmGnHQAAMHmgww
        (envelope-from <bp@suse.de>); Sat, 06 Nov 2021 10:29:05 +0000
Date:   Sat, 6 Nov 2021 11:28:54 +0100
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
Message-ID: <YYZY5koNqNZD/Fio@zn.tnic>
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

I know I have acked this already but an Intel patchset made me look at
this again: there's no need to have the vendor name in the feature name:

X86_FEATURE_CPPC

is perfectly fine.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
