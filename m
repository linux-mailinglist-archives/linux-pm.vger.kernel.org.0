Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08B457189
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhKSPU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 10:20:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:27480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233489AbhKSPU5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 10:20:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234665062"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="234665062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 07:17:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="507933158"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 07:17:45 -0800
Date:   Fri, 19 Nov 2021 17:10:18 +0200 (EET)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Takashi Iwai <tiwai@suse.de>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Warning due to "ALSA: hda: intel: More comprehensive PM runtime
 setup for controller driver"
In-Reply-To: <s5hczmwfe3x.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2111191648590.3554566@eliteleevi.tm.intel.com>
References: <d9d76980-966a-e031-70d1-3254ba5be5eb@gmail.com> <s5hczmxgnm2.wl-tiwai@suse.de> <bc281416-e28d-4c18-2475-add92d38a554@gmail.com> <s5hczmwfe3x.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, 19 Nov 2021, Takashi Iwai wrote:

> On Thu, 18 Nov 2021 23:13:50 +0100, Heiner Kallweit wrote:
> > On 18.11.2021 22:28, Takashi Iwai wrote:
> > >> snd_hda_intel 0000:00:1f.3: Unbalanced pm_runtime_enable!
> > >>
> > >> Not sure how this patch was tested because the warning is obvious.
> > >> The patch doesn't consider what the PCI sub-system does with regard to
> > >> RPM. Have a look at pci_pm_init().
[...]
> > > 
> > > Thanks for the notice.  It's been through Intel CI and tests on a few
> > > local machines, maybe we haven't checked carefully those errors but
> > > only concentrated on the other issues, as it seems.

ack on this. This did not go through our full CI, but rather I tested 
with the local setup I used to bisect this problem that was reported with 
linux-next. We specifically got the "Unbalanced pm_runtime" warning on the 
first iteration of the patch, but it was clean in the submitted version.
But yeah, a wider test round would have caught this, sorry about that.

> > Having a look at the commit message of "ALSA: hda: fix general protection
> > fault in azx_runtime_idle" the following sounds weird:
> > 
> >   - pci-driver.c:pm_runtime_put_sync() leads to a call
> >     to rpm_idle() which again calls azx_runtime_idle()
> > 
> > rpm_idle() is only called if usage_count is 1 when entering
[...]
> > This doesn't seem to happen. Maybe for whatever reason 
> > pm_runtime_get_noresume() isn't called in azx_free(), or azx_free()
> > isn't called from remove().
> > I think you should trace the call chain from the PCI core calling
> > remove() to pm_runtime_get_noresume() getting called or not.
> 
> Neither of them, supposedly.  Now I took a deeper look at the code
> around it and dug into the git log, and found that the likely problem
> was the recent PCI core code refactoring (removal of pci->driver, etc)
> that have been already reverted; that was why linux-next-20211109 was
> broken and linux-next-20211110 worked.  With the leftover pci->driver,
> the stale runtime PM callback was called at the pm_runtime_put_sync()
> call in pci_device_remove().

That probably explains it. I specifically saw runtime idle callback 
_after_ the PCI remove driver callback (azx_remove()) was run to 
completion. And this happened within execution of pci_device_remove(). But 
alas I could not hit this problem with post 20211110 linux-next.

> In anyway, I'll drop the invalid calls of pm_runtime_enable() /
> disable() & co.  Maybe keeping pm_runtime_forbid() and
> pm_runtime_dont_use_autosuspend() at remove still makes some sense as
> a counter-part for the probe calls, though.

Hmm, I was about to port this change to the SOF driver as well. But if the 
outcome is that driver can safely assume RPM callbacks are _not_ called 
after remove, then maybe we can keep the SOF implementation of 
remove as is.

Br, Kai
