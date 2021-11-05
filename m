Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8869A4467DF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhKER3O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhKER3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 13:29:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F3C061714;
        Fri,  5 Nov 2021 10:26:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636133188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKIhEPtrIBLVQEGlBVNklKOA/z9ASGygP+at60u3C5s=;
        b=NomZK0Xl/W6VZS1jYGUWvFlDnKuHW2010rs+wzTydZmfGPNDBt3SCR3Q8pIrvgE67Cr1ah
        dWwy0fi8EpXO4SInoNF7QJB2Uvsd94lxJx0PQCBvnt/0jSU2HPGlulte/bA87oCX7W31NJ
        nvdffNAliipXT4TZx5VGfkaZM4e2/G8KBsBTGRuFias9LHgFyMb9Bx8G4DtQgaQDBhuYwK
        UkkxQ7s2TPcR9yCCNUGh6nEjSTxTl/TZzdPusNo9sjZL0k9XiLGevHvkky2sxqC8CRnVHS
        BOp4kQBXEFzQP2DZN+Z2fOxq9xKsN8Y7u45gpfGMOiiwDHb29P3E36pHs/tnLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636133188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKIhEPtrIBLVQEGlBVNklKOA/z9ASGygP+at60u3C5s=;
        b=YMeIPvzk6jiuTJdEPWvIhR+kBGH9OCu4QTYklvPkndhZz7LilMR9f86kf3BNhyDGKc894M
        QeDK5x1NGr6FkfCg==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
In-Reply-To: <0B7F49C0-B850-45BC-BEC9-60DF3E2D88C5@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
 <20211104225226.5031-5-chang.seok.bae@intel.com> <878ry24qpb.ffs@tglx>
 <0B7F49C0-B850-45BC-BEC9-60DF3E2D88C5@intel.com>
Date:   Fri, 05 Nov 2021 18:26:27 +0100
Message-ID: <8735oa4ipo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05 2021 at 16:03, Bae, Chang Seok wrote:
> On Nov 5, 2021, at 07:33, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, Nov 04 2021 at 15:52, Chang S. Bae wrote:
>>> +static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
>>> +				     struct cpuidle_driver *drv, int index)
>>> +{
>>> +	fpu_idle_fpregs();
>> 
>> That's redundant because arch_cpu_idle_enter() is invoked before the
>> actual idle mechanism. 
>
> I think the way this series is shaped makes confusion, sorry.
>
> Since PATCH3 and PATCH4 are in debate -- which approach should be chosen, it
> was decided to post both and let just one of them be selected. E.g., if PATCH3
> is right, then PATCH4 should be abandoned.

My bad. I should have read the cover letter before complaining.

> I think PATCH3 is better. Maybe PATCH4 should not be sent together to avoid
> such confusion.

Yes. patch 3 is way better than patch 4.

Thanks,

        tglx
