Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A768673C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHQiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:38:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHHQiG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 12:38:06 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 724091EC026F;
        Thu,  8 Aug 2019 18:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565282284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0KzvZcFqQziL1pixiFZzARQhx/IwvtFXCJHz0vF16g0=;
        b=ooBGWDEyLZMZbXxCDA91fmpg3pTQc1UiAIlat/XakqBW8659Et5gImfjCFRQWxS803kV67
        Ywr3d5F6Wte9Wpcp6b9si5ua/lbEbpfMHd6nNm1nYuFaf9d4PC+/YAlgPUHwhGFLOKS6m6
        EJZeto4wS3brtOsrsIxLuagtRin6Akc=
Date:   Thu, 8 Aug 2019 18:38:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        bp@suse.de, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808163849.GL20745@zn.tnic>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
 <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
 <7ba45ead-186a-8802-2da6-6fa9fa00b36a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ba45ead-186a-8802-2da6-6fa9fa00b36a@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 09:30:49AM -0700, Dave Hansen wrote:
> Could someone also add some "how to add an entry to this file" in the
> top of that file?  We seem to have the same, tortuous conversations
> about one-line patches each time.

There is some doc at the top:

/*
 * "Big Core" Processors (Branded as Core, Xeon, etc...)
 *
 * The "_X" parts are generally the EP and EX Xeons, or the
 * "Extreme" ones, like Broadwell-E, or Atom microserver.

but that nomenclature doesn't seem to pan out here.

We could call it

	...ATOM_TREMONT_C

or so to mean client, similar to the _X thing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
