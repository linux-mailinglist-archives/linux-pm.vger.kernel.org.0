Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36BB2E23F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 18:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfE2Q1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 12:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2Q1D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 12:27:03 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792D423D61;
        Wed, 29 May 2019 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559147223;
        bh=jpOp7EoUMeWEqkI+UWuufre8c2qL/FWHtQg28/LCXHc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dvz3s46lOxyXsLQ/D8guvasY1EuJFeDJKaTJ8GRUHAFxqgDtDireFEhObYeoThI9h
         M4aXfiEfutjr03JjlCEh9J1aXxiBR9uXSAUK/mc/IVTR69j62tvbU1+azKybFXgai4
         b/uMMuomDBYln7Brt+X3pcLw2HEWltA3kXcemm3Q=
Date:   Wed, 29 May 2019 18:26:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190529161028.a6kpywzpjazgql5u@treble>
Message-ID: <nycvar.YFH.7.76.1905291818470.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905291230130.1962@cbobk.fhfr.pm> <20190529161028.a6kpywzpjazgql5u@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Josh Poimboeuf wrote:

> hibernation_restore() is called by user space at runtime, via ioctl or 
> sysfs.  So I think this still doesn't fix the case where you've disabled 
> CPUs at runtime via sysfs, and then resumed from hibernation.  Or are we 
> declaring that this is not a supported scenario?

Yeah I personally find that scenario awkward :) Anyway, cpuhp_smt_enable() 
is going to online even those potentially "manually" offlined CPUs, isn't 
it?

Are you perhaps suggesting to call enable_nonboot_cpus() instead of 
cpuhp_smt_enable() here to make it more explicit?

> Is there are reason why maxcpus= doesn't do the CR4.MCE booted_once
> dance?

I am not sure whether it's really needed. My understanding is that the MCE 
issue happens only after primary sibling has been brought up; if that 
never happened, MCE wouldn't be broadcasted to that core at all in the 
first place.

But this needs to be confirmed by Intel.

-- 
Jiri Kosina
SUSE Labs

