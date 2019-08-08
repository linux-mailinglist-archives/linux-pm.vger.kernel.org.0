Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA11E86802
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbfHHR30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 13:29:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbfHHR30 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 13:29:26 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC3441EC014A;
        Thu,  8 Aug 2019 19:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565285364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RazsO85Qhc7Sogfa4Qachxf0wZS+nLcz4jBclEYtWQI=;
        b=LE+KToVQ+fdK1D/dEm72wx8deu5wOkbWWEQtKz+HeqI/vybiDd3u/pvvm1iJKcC4DZ59/T
        wuxJ9UPwbIhzx/sjnmjgzE2Pun5yLlBuLWxC7dpImZBcE6ZPsJ1NUX4Y9cw9cGRg55PNSg
        AcOK2yA53ZTyq8vAdIrhJZuL9ILUxVI=
Date:   Thu, 8 Aug 2019 19:30:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808172955.GM20745@zn.tnic>
References: <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
 <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
 <7ba45ead-186a-8802-2da6-6fa9fa00b36a@intel.com>
 <20190808163849.GL20745@zn.tnic>
 <91eefbe4-e32b-d762-be4d-672ff915db47@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91eefbe4-e32b-d762-be4d-672ff915db47@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 09:54:53AM -0700, Dave Hansen wrote:
> On 8/8/19 9:38 AM, Borislav Petkov wrote:
> > On Thu, Aug 08, 2019 at 09:30:49AM -0700, Dave Hansen wrote:
> >> Could someone also add some "how to add an entry to this file" in the
> >> top of that file?  We seem to have the same, tortuous conversations
> >> about one-line patches each time.
> > There is some doc at the top:
> 
> HOWTO Build an INTEL_FAM6_ definition:
> 
> 1. Start with INTEL_FAM6_
> 2. If not Core-family, add a note about it, like "ATOM".  There are only
>    two options for this (Xeon Phi and Atom).  It is exceedingly unlikely
>    that you are adding a cpu which needs a new option here.
> 3. Add the processor microarchitecture, not the platform name
> 4. Add a short differentiator if necessary.  Add an _X to differentiate
>    Server from Client.
> 5. Add an optional comment with the platform name(s)
> 
> It should end up looking like this:
> 
> INTEL_FAM6_<ATOM?>_<MICROARCH>_<SHORT...> /* Platform Name */

LGTM. I'd take it in a patch form. :)

Btw, according to this scheme, this new model should be

INTEL_FAM6_ATOM_TREMONT

yes?

Even though the model number is higher than the Jacobsville, i.e., the
server one?

Or

INTEL_FAM6_ATOM_TREMONT_EHL

?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
