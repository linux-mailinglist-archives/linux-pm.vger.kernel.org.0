Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4171865B8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfHHP2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 11:28:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39808 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHP2L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 11:28:11 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E6E81EC09A0;
        Thu,  8 Aug 2019 17:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565278090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RK1JxZ6gkJ7+aGdr69g9wPEa/Ga0QZ2t9+0l6TrpFk8=;
        b=LSFdNUpTjHV4nADqJ/X1pTB2widCs+9jANhv+/O1FkbearlZy3cIAQkKZlaWbouzAqJKAR
        QZK2ghEANuhWnhKLnMENE4rSXnbB+JoTRhFSkHovVWYBc2DxGZE6HYGP0T+C4QmaKpUxnb
        x8CnC2Lyoo7WFWAG3dFCIfpfSew8C1g=
Date:   Thu, 8 Aug 2019 17:28:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808152859.GK20745@zn.tnic>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808152326.GL2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 05:23:26PM +0200, Peter Zijlstra wrote:
> Neither. WikiChip says it is the successor to Denverton, which is a
> server chip. If this is true then:
> 
> #define INTEL_FAM6_ATOM_TREMONT_X	0x.. /* Elkhart Lake */
> 
> is what it should be.

There is already:

#define INTEL_FAM6_ATOM_TREMONT_X       0x86 /* Jacobsville */

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
