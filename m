Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17AF2F1E21
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAKShT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 13:37:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390412AbhAKShS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 13:37:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05827ACB0;
        Mon, 11 Jan 2021 18:36:37 +0000 (UTC)
Message-ID: <1610390195.24361.20.camel@suse.cz>
Subject: Re: [PATCH] x86: PM: Register syscore_ops for scale invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Mon, 11 Jan 2021 19:36:35 +0100
In-Reply-To: <1803209.Mvru99baaF@kreacher>
References: <1803209.Mvru99baaF@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-01-08 at 19:05 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On x86 scale invariace tends to be disabled during resume from
> suspend-to-RAM, because the MPERF or APERF MSR values are not as
> expected then due to updates taking place after the platform
> firmware has been invoked to complete the suspend transition.
> 
> That, of course, is not desirable, especially if the schedutil
> scaling governor is in use, because the lack of scale invariance
> causes it to be less reliable.
> 
> To counter that effect, modify init_freq_invariance() to register
> a syscore_ops object for scale invariance with the ->resume callback
> pointing to init_counter_refs() which will run on the CPU starting
> the resume transition (the other CPUs will be taken care of the
> "online" operations taking place later).
> 
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> <snip>

Thanks for writing this, Rafael.

Peter Zijlstra asked to fix this problem months ago; I started but
got stucked and never finished.


Giovanni Gherdovich
