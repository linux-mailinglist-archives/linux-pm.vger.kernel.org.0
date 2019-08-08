Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73B8659C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfHHPXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 11:23:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55012 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbfHHPXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 11:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e+WLABQSEvudtBhRvp48KjGSk7qKJrGZg7QzvP4lg/E=; b=XaW9CetQyLkgYvfBTfTRlC0zx
        3sHAJ0eMz/AAwJWm1N5leSxL5cngzsyhSPjawUq7HHSv4ZAPSnXS1CLv0oVcsFSajzrDTixgGOZnT
        6oLxagRPmAQZ5rYhleg6dAGHAIPjTUY20FZsI51qi0ecyuq7mqkqppi/b/pxwG8RQ0BiUbNq0wGjz
        n2Cw6aByJYezLOvZVH0ihhQO0BezegQJ0j3UL7J4+ErTR5dRu2nNFZED6D2vIFUNLiWKWAhvaheuD
        FB8dHqFoUB9DI3MFrycyuDBI15n7eLLapljNtvn/30DcVz01RolW7vaAliy9b0Ql1dpt+H85ApvqS
        UNfeehK4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkGF-00030x-VB; Thu, 08 Aug 2019 15:23:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 008A13035D7;
        Thu,  8 Aug 2019 17:23:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AA44201B313E; Thu,  8 Aug 2019 17:23:26 +0200 (CEST)
Date:   Thu, 8 Aug 2019 17:23:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
Message-ID: <20190808152326.GL2369@hirez.programming.kicks-ass.net>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 08:40:49PM +0530, Bhardwaj, Rajneesh wrote:
> On 08-Aug-19 7:44 PM, Peter Zijlstra wrote:
> > On Thu, Aug 08, 2019 at 09:19:23AM -0400, Liang, Kan wrote:

> > > Usually, we should use the code name of microarchitecture for the name of
> > > CPUID.

> > Oh yes, very much. A quick google seems to suggest these are in fact
> > Tremont cores. So then the naming should be:
> > 
> >    INTEL_FAM6_ATOM_TREMONT_xxx
> 
> Sure, I feel INTEL_FAM6_ATOM_TREMONT_ELKHART_LAKE may be too long so is
> INTEL_FAM6_ATOM_TREMONT_PLUS a better name?

Neither. WikiChip says it is the successor to Denverton, which is a
server chip. If this is true then:

#define INTEL_FAM6_ATOM_TREMONT_X	0x.. /* Elkhart Lake */

is what it should be.
