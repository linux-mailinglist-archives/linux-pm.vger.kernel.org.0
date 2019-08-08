Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833D48683D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfHHRnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 13:43:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHRnY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 13:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c9tst/1Hpix6358J7WwQaapmfPHH96A9BgkfjX++cBc=; b=gtY9E+gQR2KRXv92LwrgTZInW
        26M9ottTkPFxjD/2wZcAsaLatph3UN3cvbmY/hWPXTa4Bn9+Y+IDdTR8uXj/wSdCZL6DUiZtK5IG/
        TJ/VeDJC2bLsWZtRtji+HnYx5H0d8ZCNczDtnOrZqj91JkgB/V5V7qSAE09AiwzAKB2BD7ETu5igl
        m2JIypzVFd0uFjLgNHBDhA8LJBu82ThskA/QAUpFv/xWrUNqngH1BnppfcyubdzfSftU8m7AWqtKo
        74ZGqBaMDDGLgAF+LYjMk5c3R5jOCl2PRk4Veh06mjz3KdxMB9TAs8BlTEC8UGqggRhXsgyFQ57Aa
        +uemlPfYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvmRb-0004K4-DQ; Thu, 08 Aug 2019 17:43:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A97E330754B;
        Thu,  8 Aug 2019 19:37:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E332520C4860B; Thu,  8 Aug 2019 19:38:16 +0200 (CEST)
Date:   Thu, 8 Aug 2019 19:38:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808173816.GO2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
 <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 12:27:34PM -0400, Liang, Kan wrote:
> I think only the name of microarchitecture should be good enough,
> INTEL_FAM6_ATOM_TREMONT.
> We usually don't add the platform's acronym to the name of CPUID.

That works.
