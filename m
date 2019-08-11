Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7BE891B8
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfHKM6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 08:58:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfHKM6f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 08:58:35 -0400
Received: from p200300ddd71876477e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7647:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwnQS-0000xO-SI; Sun, 11 Aug 2019 14:58:21 +0200
Date:   Sun, 11 Aug 2019 14:58:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Salvatore Bonaccorso <carnil@debian.org>
cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [Linux 5.2.x] /sys/kernel/debug/tracing/events/power/cpu_idle/id:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
In-Reply-To: <20190811094630.GA18925@eldamar.local>
Message-ID: <alpine.DEB.2.21.1908111456430.7324@nanos.tec.linutronix.de>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de> <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de> <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de> <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
 <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de> <20190811094630.GA18925@eldamar.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Salvatore,

On Sun, 11 Aug 2019, Salvatore Bonaccorso wrote:
> On Sun, Aug 11, 2019 at 08:22:35AM +0200, Thomas Gleixner wrote:
> > On Sat, 10 Aug 2019, Paul Menzel wrote:
> > > For the record. It is also reproducible with Linux 5.2.6, and trying to print
> > > the file contents with cat already fails.
> > > 
> > > ```
> > > $ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > -r--r--r-- 1 root root 0 Aug 10 23:05
> > > /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > $ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > > Killed
> > > ```
> 
> This seems to be related to https://bugs.debian.org/934304 (in
> particular https://bugs.debian.org/934304#29). The mentioned patch
> features/all/lockdown/0031-tracefs-Restrict-tracefs-when-the-kernel-is-locked-d.patch
> is a backport of https://patchwork.kernel.org/patch/11069661/ with
> only change that it is converted back to the non-LSM lockdown API.

So that's a debian kernel specific issue?

Thanks,

	tglx
