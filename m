Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6249A86048
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfHHKnF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 06:43:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHKnE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 06:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VcZrARhSE3qBwq5oVlGMKVHmroJrAIRYW3Oc3mvar5k=; b=u8YI4I4Oq3AgGmfTp7QqH0oO7
        fLJ6wqLEj3cdtVBg/jgxdg/jPycqeUiWjYdPaUK0W74N4uNAolzKSGAiC3vjsUaBYKq/Tr1HtuNQz
        r4yEO5Y1lasNa6cBCMbOQgPqUjJSf63PUxo/EBimcC8QioUoqkj0V5TNrzovfdeq7333zSYOqkkVe
        w71bWJjqUvMChjTxx53cVD41EaT34uejEzJFAo/cvWZk06wh0pkfkLl9/23Gcz+xBWY9elNLJ3kdC
        T4APDjZU7K99vGr0xxpZv2lhikXynJYo2ET2TkjkiVLeWDMBHlulDGK3V52Bi+nuCYtZQ3ncR8YPT
        NW/djxS3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvfsn-0000AU-4q; Thu, 08 Aug 2019 10:42:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D1A530754B;
        Thu,  8 Aug 2019 12:42:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABF2E2018B96F; Thu,  8 Aug 2019 12:42:53 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:42:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Cc:     x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808104253.GG2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 03:40:45PM +0530, Rajneesh Bhardwaj wrote:
> Elkhart Lake is Atom based SoC that uses model number 0x96. CPUID details
> will be documented in a future version of Intel Software Development
> Manual.
> 
> Cc: bp@suse.de
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Cc: Linux PM <linux-pm@vger.kernel.org>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa66ef62..06e94ae65f28 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -79,6 +79,7 @@
>  #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
>  
>  #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
> +#define INTEL_FAM6_ATOM_ELKHART_LAKE	0x96 /*Elkhart Lake */

Almost, please try again.
