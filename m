Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E855446D6B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhKFKdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Nov 2021 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhKFKdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Nov 2021 06:33:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30BC061570;
        Sat,  6 Nov 2021 03:30:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f24220090a6d55143070fc9.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:2200:90a6:d551:4307:fc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 132DD1EC03AD;
        Sat,  6 Nov 2021 11:30:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636194654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CWWsbcPKigAg0VlntD1Pn97j684PNCoVltKLlMIctUE=;
        b=Ya9g29eVrh7JQaH7aP580Sk9mllcBhs2J5IVMhvquF+CODnzChh8Y3Bg4mLF64IuwnTtYH
        F3Qc4pMNIRsY5Gkx04O1iONHfvmoFhJojkrpUB+PmIgXqNQXaaynwOiFUlVoRmB8dwVMX/
        XfH1pGomfNC2uA65Wq7EWujbnDwQW0o=
Date:   Sat, 6 Nov 2021 11:30:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] x86: Add definitions for the Intel Hardware Feedback
 Interface
Message-ID: <YYZZWzNWdmeCFBAd@zn.tnic>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106013312.26698-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05, 2021 at 06:33:07PM -0700, Ricardo Neri wrote:
> Add the CPUID feature bit and the model-specific registers needed to
> identify and configure the Intel Hardware Feedback Interface.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/msr-index.h   | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..d76d8daf1b2b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -325,6 +325,7 @@
>  #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
>  #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
>  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
> +#define X86_FEATURE_INTEL_HFI		(14*32+19) /* Hardware Feedback Interface */

X86_FEATURE_HFI

i.e., without the vendor name is perfectly fine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
