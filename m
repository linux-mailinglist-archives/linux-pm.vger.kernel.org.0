Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4A42DB83
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJNOaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJNOaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 10:30:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB0C061570;
        Thu, 14 Oct 2021 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWBQfk1iLdKpELGt/qdUWn4KNZxoLSLIiDkZWLgKqtY=; b=IRMmEGeV6uQYDPk4q4aRRoK8oA
        Q6h8pwuJ0IEY7b2/TNKjpsko+eXuIZwHepatAtQALymBCVjwtrCcDAaBDYFyk7lViD60fxhZvvVNx
        lNUHSvi/kx4ZPxZSBtjetptMiWcYTVWG/6ALAxHQcH4Kd5B+BKyfQWbzEnu3K42n8r7ZmM//jpwiv
        39+gXDKtYYaelFbYwW6fGTcAqAbOr9x0WxgNoTsghECJRzsrjBaWN7WyLFIj230wQeqsIWyv7hciA
        Nl0j/6gj7Oe44Tu3xyQCix1N+1ZEXcvORK0wLcUhyF9kLTjjruyq56wWolaFsOzGADOzS33/fHavV
        Bcr71R8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb1i8-009qi2-DH; Thu, 14 Oct 2021 14:27:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F02043004E7;
        Thu, 14 Oct 2021 16:27:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE1E82CF42A20; Thu, 14 Oct 2021 16:27:55 +0200 (CEST)
Date:   Thu, 14 Oct 2021 16:27:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] ptrace: Order and comment PT_flags
Message-ID: <YWg+a6PPD5Mpr4c/@hirez.programming.kicks-ass.net>
References: <20211009100754.690769957@infradead.org>
 <20211009101444.971532166@infradead.org>
 <20211014093121.GA8239@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014093121.GA8239@willie-the-truck>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 14, 2021 at 10:31:22AM +0100, Will Deacon wrote:
> On Sat, Oct 09, 2021 at 12:07:57PM +0200, Peter Zijlstra wrote:
> > Add a comment to the PT_flags to indicate their actual value, this
> > makes it easier to see what bits are used and where there might be a
> > possible hole to use.
> > 
> > Notable PT_SEIZED was placed wrong, also PT_EVENT_FLAG() space seems
> > ill defined, as written is seems to be meant to cover the entire
> > PTRACE_O_ range offset by 3 bits, which would then be 3+[0..21],
> > however PT_SEIZED is in the middle of that.
> 
> Why do you think PT_EVENT_FLAG() should cover all the PTRACE_O_* options?
> Just going by the name and current callers, I'd only expect it to cover
> the PTRACE_EVENT_* flags, no?

Because PT_EXITKILL and PT_SUSPEND_SECCOMP are also exposed in that same
mapping.

Ideally we'd change PT_OPT_FLAG_SHIFT to 8 or something and have the
high 24 bits for OPT and then use the low 8 bits for SEIZED and the new
flags.
