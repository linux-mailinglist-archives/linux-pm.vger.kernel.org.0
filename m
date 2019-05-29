Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B62E769
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2V1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 17:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2V1j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 May 2019 17:27:39 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0370A2420F;
        Wed, 29 May 2019 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559165259;
        bh=M+oN3qPu6KCA48XyfQGiOutkaERPZU5fGB3p67QrFd0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RAZk4/kIXPzQbx/Ae3zdb76/qj3VpvrboTtv0COqRF3VjS/hvDbBi3hblTK1QXP/4
         17QvLs7jgcX3VesxTpX0cQa6ZtA8CHDnLcMUfeKUrnLDgH2PJ7gwwrBHk1vjgzTFwM
         snW0LMJD4cmWGKZAQnBrqEw8DXR6TppOyJIGz8zw=
Date:   Wed, 29 May 2019 23:27:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
In-Reply-To: <20190529212519.GA15104@amd>
Message-ID: <nycvar.YFH.7.76.1905292327080.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <nycvar.YFH.7.76.1905292223500.1962@cbobk.fhfr.pm> <20190529212519.GA15104@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019, Pavel Machek wrote:

> > As explained in
> > 
> > 	0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > 
> > we always, no matter what, have to bring up x86 HT siblings during boot at
> > least once in order to avoid first MCE bringing the system to its
> > knees.
> 
> 
> > Cc: stable@vger.kernel.org # v4.19+
> > Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> > Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> But I'm less sure if this is -stable material. Is reverting
> 0cc3cd21657be04cb0559fe8063f2130493f92cf in -stable an option?

Well, without that commit, first MCE to come kills nosmt system.

-- 
Jiri Kosina
SUSE Labs

