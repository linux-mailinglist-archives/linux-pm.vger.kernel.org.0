Return-Path: <linux-pm+bounces-35032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433CB89B93
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFDC1894664
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C02BE622;
	Fri, 19 Sep 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yb8b5ghb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B86za+iP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yb8b5ghb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B86za+iP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3F1C862E
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289307; cv=none; b=qrleeQTf2KEJyCK/zqLguKDK/ezvOEJ5C6oMrGJN3rm/D9lFa9jb6QQ3WR+cO/eNaoKODab3pS2HBlWekAaPXW4QD97uVo6wuh7qvtbK6wV216KeBkuom1HAm6mm3B3xgOb8QaCZ8rTu4hJ8ZsiAKtwnkbOFLVz1Aws43qi7F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289307; c=relaxed/simple;
	bh=BM5n++gOYpgKPE9pvJWiUj7CHuY8m0QatizpGz0RCjE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUlN0hf5rbJVQu7PD3t7dCiNM3NB+PpJGobzGPqBXhVoNMX3bE0ELIAVA3HjGZMC+F2SsXCCUoHq9DuOo1c2y+iX9TahMsKgXG7LbtrSMP2EvvwCjWOhH0RpYI1/9cpptm5S/Dal9twXix4V2vfSLeRfb9nCg1ADTj33b3oTf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yb8b5ghb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B86za+iP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yb8b5ghb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B86za+iP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91F5E3368D;
	Fri, 19 Sep 2025 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758289302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEWuh8VBWqeV5cndgrKDjIm0OR+61Z5x6A9dTDmLFxc=;
	b=yb8b5ghbmr96k2s5GAAr3ZYL72pQiLlDCWZhkfozmaIAzbMBjKg54s5V1m54kNgB+yeKxv
	3SBkHwfQPYOEJnxK4NzhUu9+pfVkcR02RuIRnirIHB+FnCgSPW6Y3x5zQFu829IuIbI2U7
	gFNqbsuWa+73EkL9xupQIC5lwYkZUN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758289302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEWuh8VBWqeV5cndgrKDjIm0OR+61Z5x6A9dTDmLFxc=;
	b=B86za+iPRsqxhJIk2zRRDaNvBzOefZ73Kf8uyI7ftGPCdp1USE2a0GOxcJM2Gak1X6An5R
	ojGkigNVm85+13BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758289302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEWuh8VBWqeV5cndgrKDjIm0OR+61Z5x6A9dTDmLFxc=;
	b=yb8b5ghbmr96k2s5GAAr3ZYL72pQiLlDCWZhkfozmaIAzbMBjKg54s5V1m54kNgB+yeKxv
	3SBkHwfQPYOEJnxK4NzhUu9+pfVkcR02RuIRnirIHB+FnCgSPW6Y3x5zQFu829IuIbI2U7
	gFNqbsuWa+73EkL9xupQIC5lwYkZUN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758289302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEWuh8VBWqeV5cndgrKDjIm0OR+61Z5x6A9dTDmLFxc=;
	b=B86za+iPRsqxhJIk2zRRDaNvBzOefZ73Kf8uyI7ftGPCdp1USE2a0GOxcJM2Gak1X6An5R
	ojGkigNVm85+13BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C2F813A78;
	Fri, 19 Sep 2025 13:41:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T3HyGJZdzWjDGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 13:41:42 +0000
Date: Fri, 19 Sep 2025 15:41:42 +0200
Message-ID: <87ldma8sq1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <12751070.O9o76ZdvQC@rafael.j.wysocki>
References: <878qimv24u.wl-tiwai@suse.de>
	<CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
	<87jz1uao65.wl-tiwai@suse.de>
	<12751070.O9o76ZdvQC@rafael.j.wysocki>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 19 Sep 2025 15:05:04 +0200,
Rafael J. Wysocki wrote:
> 
> On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > On Thu, 18 Sep 2025 22:41:32 +0200,
> > Rafael J. Wysocki wrote:
> > > 
> > > On Thu, Sep 18, 2025 at 10:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 1:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 9:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > Rafael J. Wysocki wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Sorry for the delay.
> > > > > > >
> > > > > > > On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > >
> > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > Takashi Iwai wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > while I worked on the code cleanups in the drivers with the recent
> > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > > > > > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > >
> > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > > > > >
> > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > >
> > > > > > > > > Then one can use it like
> > > > > > > > >
> > > > > > > > >       ret = pm_runtime_resume_and_get(dev);
> > > > > > > > >       if (ret < 0)
> > > > > > > > >               return ret;
> > > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > > > > > > > >
> > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > > > >
> > > > > > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > > > > > macros, e.g.
> > > > > > > > >
> > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > >       struct device *var __free(pm_runtime_put) = (dev)
> > > > > > > >
> > > > > > > > It can be even simpler by assigning a temporary variable such as:
> > > > > > > >
> > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> > > > > > >
> > > > > > > Well, if there's something like
> > > > > > >
> > > > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > > > {
> > > > > > >         int ret = pm_runtime_resume_and_get(dev);
> > > > > > >         if (ret < 0)
> > > > > > >                 return ERR_PTR(ret);
> > > > > > >
> > > > > > >         return dev;
> > > > > > > }
> > > > > > >
> > > > > > > It would be a matter of redefining the FREE to also take error
> > > > > > > pointers into account and you could do
> > > > > > >
> > > > > > > struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> > > > > > > if (IS_ERR(__dev))
> > > > > > >         return PTR_ERR(__dev);
> > > > > >
> > > > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > >
> > > > > No, it is not used only for auto-clean, it is also used for return
> > > > > value checking and it represents a reference on the original dev.  It
> > > > > cannot be entirely anonymous because of the error checking part.
> > > > >
> > > > > The point is that this is one statement instead of two and so it is
> > > > > arguably harder to mess up with.
> > > > >
> > > > > > But it's all about a matter of taste, and I'd follow what you and
> > > > > > other guys suggest.
> > > > > >
> > > > > > FWIW, there are lots of code doing like
> > > > > >
> > > > > >         pm_runtime_get_sync(dev);
> > > > > >         mutex_lock(&foo);
> > > > > >         ....
> > > > > >         mutex_unlock(&foo);
> > > > > >         pm_runtime_put(dev);
> > > > > >         return;
> > > > > >
> > > > > > or
> > > > > >
> > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > >         if (ret)
> > > > > >                 return ret;
> > > > > >         mutex_lock(&foo);
> > > > > >         ....
> > > > > >         mutex_unlock(&foo);
> > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > >         return 0;
> > > > > >
> > > > > > and they can be converted nicely with guard() once when PM runtime can
> > > > > > be automatically unreferenced.  With my proposed change, it would
> > > > > > become like:
> > > > > >
> > > > > >         pm_runtime_get_sync(dev);
> > > > > >         pm_runtime_auto_clean(dev);
> > > > >
> > > > > For the case in which the pm_runtime_get_sync() return value is
> > > > > discarded, you could define a guard and do
> > > > >
> > > > > guard(pm_runtime_get_sync)(dev);
> > > > >
> > > > > here.
> > > > >
> > > > > The case checking the return value is less straightforward.
> > > > >
> > > > > >         guard(mutex)(&foo);
> > > > > >         ....
> > > > > >         return;
> > > > > >
> > > > > > or
> > > > > >
> > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > >         if (ret)
> > > > > >                 return ret;
> > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > >         guard(mutex)(&foo);
> > > > > >         ....
> > > > > >         return 0;
> > > > > >
> > > >
> > > > I guess what I'm saying means basically something like this:
> > > >
> > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > >
> > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > >
> > > > and analogously for pm_runtime_get_sync().
> > > 
> > > And it kind of makes sense either.  Do
> > > 
> > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > if (IS_ERR(active_dev))
> > >         return PTR_ERR(active_dev);
> > > 
> > > and now use active_dev for representing the device until it gets out
> > > of the scope.
> > 
> > Yes, that's what I thought of as an alternative, too, but I didn't
> > consider using only pm_runtime_resume_and_get().  Actually by this
> > action, we can also "clean up" the API usage at the same time to use a
> > single recommended API function, which is a good thing.
> > 
> > That said, I like this way :)
> > 
> > It'd be nice if this change can go into 6.18, then I can put the
> > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > this change is definitely safe and can't break, per se.
> 
> OK, do you mean something like the patch below?

Yes!

An easy follower is the patch like below.
(It's the only user of __free(pm_runtime_*) in linux-next as of now.)


thanks,

Takashi

-- 8< --
Subject: [PATCH] PCI: Use PM runtime class macro for the auto cleanup

The newly introduced class macro can simplify the code.
Also, add the proper error handling for the PM runtime get, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pci/pci-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..1fa329f95844 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
 		return count;
 	}
 
-	pm_runtime_get_sync(dev);
-	struct device *pmdev __free(pm_runtime_put) = dev;
+	CLASS(pm_runtime_and_get, pmdev)(dev);
+	if (IS_ERR(pmdev))
+		return PTR_ERR(pmdev);
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);
-- 
2.50.1


