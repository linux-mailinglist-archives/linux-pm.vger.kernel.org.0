Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305861B5525
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDWHF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 03:05:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgDWHF5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 03:05:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2910AE38;
        Thu, 23 Apr 2020 07:05:54 +0000 (UTC)
Date:   Thu, 23 Apr 2020 09:05:54 +0200
Message-ID: <s5h368uy94d.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, Roy Spliet <nouveau@spliet.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: Unrecoverable AER error when resuming from RAM (hda regression in 5.7-rc2)
In-Reply-To: <20200422232127.GA24666@google.com>
References: <s5h8sinxlfz.wl-tiwai@suse.de>
        <20200422232127.GA24666@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 23 Apr 2020 01:21:27 +0200,
Bjorn Helgaas wrote:
> 
> On Wed, Apr 22, 2020 at 11:25:04PM +0200, Takashi Iwai wrote:
> > On Wed, 22 Apr 2020 22:50:28 +0200,
> > Bjorn Helgaas wrote:
> > > ...
> > > I feel like this UR issue could be a PCI core issue or maybe some sort
> > > of misuse of PCI power management, but I can't seem to get traction on
> > > it.
> > > 
> > > > Then the display freezes and the system basically falls apart (can't 
> > > > even sudo reboot -f, need to use magic sysrq).
> > > > 
> > > > I bisected this to "ALSA: hda: Skip controller resume if not needed". 
> > > > Setting snd_hda_intel.power_save=0 resolves the issue.
> > > 
> > > FWIW, the complete citation is c4c8dd6ef807 ("ALSA: hda: Skip
> > > controller resume if not needed"),
> > > https://git.kernel.org/linus/c4c8dd6ef807, which first appeared in
> > > v5.7-rc2.
> > 
> > Yes, and I posted the fix patch right now:
> >   https://lore.kernel.org/r/20200422203744.26299-1-tiwai@suse.de
> > 
> > The possible cause was the tricky resume code that both HD-audio
> > controller (the parent PCI device) and the codec devices used.
> > 
> > At least the patch above seems working for the reporter's machine.
> > Now we need a bit more testing before merging, but it looks promising,
> > so far.
> 
> Great, I'm glad you figured something out because I sure wasn't
> getting anywhere!
> 
> Maybe this is a tangent, but I can't figure out what
> snd_power_change_state() is doing.  It *looks* like it's supposed to
> change the PCI power state, but I gave up trying to figure out where
> it actually touches the device.

Not really, it merely updates the internal state field stored in the
sound card object, see in include/sound/core.h:

static inline void snd_power_change_state(struct snd_card *card, unsigned int state)
{
	card->power_state = state;
	wake_up(&card->power_sleep);
}

The sound API blocks the operation while suspend/resume explicitly
with this card top-level signal.


thanks,

Takashi
