Return-Path: <linux-pm+bounces-35053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9709CB8A7E4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8AB7C07D4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5F319618;
	Fri, 19 Sep 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/m7cRDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rafcmRrv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e/m7cRDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rafcmRrv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DC3168E7
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297872; cv=none; b=Dfk/v1I+OT4LKtAfEohIz9yHptw3UZrswP+7y15bhY6gaLUIJcnCWLnC7+7+NmjXJMRPf36iIDOz9+dKqLKy+uo2V+zELPdcMRtxl7hbqLC1gpHHF5/C615v9IajPvnd8B8hDiFiAETXYL8PvSpWV/QsKX2cwpXGLjg1h1kqMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297872; c=relaxed/simple;
	bh=r6NK2BAemXY25aDHotG8smnDnwn0lTyADTzuFOjBryk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIVYI/k85VmdfSKnSEClwqKymD/qFTXz2U1qDgZrDCW7qzLsmmS7Lk7k74TmSUWDwsPX9ngWwRvjoz7lSyQfaq23IlPa1srVNfeDqycKw/Hrgi8ZhTHmitwTYdvOTRYyHz++h+MHi1XO79TVe4Ujl2y+YlT2sj0R2A06koW9v/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e/m7cRDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rafcmRrv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e/m7cRDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rafcmRrv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 826AE1F7E0;
	Fri, 19 Sep 2025 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758297868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuDboom0l+Msi6/6GAWj2FO7+GPHBxBKmOS/oynw9Y=;
	b=e/m7cRDs5+y7v0YZeMIQlDnXE+jlKYFklnJsVtPtz6QEDnVldNc64dYyr3Xevx8J1XoB7F
	BmO4pmqCPUGAdninBOfo9VdhNedsqygLyxHms1GWiMPRvd0rHNyuBLCLGM8AZ1ExrBfq1T
	F8ZraQPl9PnnkLsa4fho6u+gaXNsAkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758297868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuDboom0l+Msi6/6GAWj2FO7+GPHBxBKmOS/oynw9Y=;
	b=rafcmRrvxS7KuZsvrUPvKfkh/5X7wqBd3qe6/GoHInxnHFnDctcCztwSQaKcFYcPgHVOXv
	kZO4bqfXoYOOYgBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="e/m7cRDs";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rafcmRrv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758297868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuDboom0l+Msi6/6GAWj2FO7+GPHBxBKmOS/oynw9Y=;
	b=e/m7cRDs5+y7v0YZeMIQlDnXE+jlKYFklnJsVtPtz6QEDnVldNc64dYyr3Xevx8J1XoB7F
	BmO4pmqCPUGAdninBOfo9VdhNedsqygLyxHms1GWiMPRvd0rHNyuBLCLGM8AZ1ExrBfq1T
	F8ZraQPl9PnnkLsa4fho6u+gaXNsAkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758297868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QuDboom0l+Msi6/6GAWj2FO7+GPHBxBKmOS/oynw9Y=;
	b=rafcmRrvxS7KuZsvrUPvKfkh/5X7wqBd3qe6/GoHInxnHFnDctcCztwSQaKcFYcPgHVOXv
	kZO4bqfXoYOOYgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF4A13A39;
	Fri, 19 Sep 2025 16:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2dnSFAx/zWijSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:04:28 +0000
Date: Fri, 19 Sep 2025 18:04:27 +0200
Message-ID: <87a52q8m44.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <CAJZ5v0ggvL420OmU2G=0kEGeiJct3hiBPTHCn5wFwwLkQpugCw@mail.gmail.com>
References: <878qimv24u.wl-tiwai@suse.de>
	<CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
	<87jz1uao65.wl-tiwai@suse.de>
	<12751070.O9o76ZdvQC@rafael.j.wysocki>
	<87ldma8sq1.wl-tiwai@suse.de>
	<87jz1u8sn9.wl-tiwai@suse.de>
	<CAJZ5v0ggvL420OmU2G=0kEGeiJct3hiBPTHCn5wFwwLkQpugCw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 826AE1F7E0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Fri, 19 Sep 2025 17:49:16 +0200,
Rafael J. Wysocki wrote:
> 
> On Fri, Sep 19, 2025 at 3:43 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Fri, 19 Sep 2025 15:41:42 +0200,
> > Takashi Iwai wrote:
> > >
> > > On Fri, 19 Sep 2025 15:05:04 +0200,
> > > Rafael J. Wysocki wrote:
> > > >
> > > > On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > > > > On Thu, 18 Sep 2025 22:41:32 +0200,
> > > > > Rafael J. Wysocki wrote:
> > > > > >
> > > > > > On Thu, Sep 18, 2025 at 10:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 18, 2025 at 1:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Sep 18, 2025 at 9:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > > > > Rafael J. Wysocki wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > Sorry for the delay.
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > > > > Takashi Iwai wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi,
> > > > > > > > > > > >
> > > > > > > > > > > > while I worked on the code cleanups in the drivers with the recent
> > > > > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > > > > > > > > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > > > > > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > > > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > > > > >
> > > > > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > > > > > > > >
> > > > > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > > > > >
> > > > > > > > > > > > Then one can use it like
> > > > > > > > > > > >
> > > > > > > > > > > >       ret = pm_runtime_resume_and_get(dev);
> > > > > > > > > > > >       if (ret < 0)
> > > > > > > > > > > >               return ret;
> > > > > > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > > > > > > > > > > >
> > > > > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > > > > > > >
> > > > > > > > > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > > > > > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > > > > > > > > macros, e.g.
> > > > > > > > > > > >
> > > > > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > > > > >       struct device *var __free(pm_runtime_put) = (dev)
> > > > > > > > > > >
> > > > > > > > > > > It can be even simpler by assigning a temporary variable such as:
> > > > > > > > > > >
> > > > > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> > > > > > > > > >
> > > > > > > > > > Well, if there's something like
> > > > > > > > > >
> > > > > > > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > > > > > > {
> > > > > > > > > >         int ret = pm_runtime_resume_and_get(dev);
> > > > > > > > > >         if (ret < 0)
> > > > > > > > > >                 return ERR_PTR(ret);
> > > > > > > > > >
> > > > > > > > > >         return dev;
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > It would be a matter of redefining the FREE to also take error
> > > > > > > > > > pointers into account and you could do
> > > > > > > > > >
> > > > > > > > > > struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> > > > > > > > > > if (IS_ERR(__dev))
> > > > > > > > > >         return PTR_ERR(__dev);
> > > > > > > > >
> > > > > > > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > > > > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > > > > >
> > > > > > > > No, it is not used only for auto-clean, it is also used for return
> > > > > > > > value checking and it represents a reference on the original dev.  It
> > > > > > > > cannot be entirely anonymous because of the error checking part.
> > > > > > > >
> > > > > > > > The point is that this is one statement instead of two and so it is
> > > > > > > > arguably harder to mess up with.
> > > > > > > >
> > > > > > > > > But it's all about a matter of taste, and I'd follow what you and
> > > > > > > > > other guys suggest.
> > > > > > > > >
> > > > > > > > > FWIW, there are lots of code doing like
> > > > > > > > >
> > > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > > >         mutex_lock(&foo);
> > > > > > > > >         ....
> > > > > > > > >         mutex_unlock(&foo);
> > > > > > > > >         pm_runtime_put(dev);
> > > > > > > > >         return;
> > > > > > > > >
> > > > > > > > > or
> > > > > > > > >
> > > > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > > > >         if (ret)
> > > > > > > > >                 return ret;
> > > > > > > > >         mutex_lock(&foo);
> > > > > > > > >         ....
> > > > > > > > >         mutex_unlock(&foo);
> > > > > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > > > > >         return 0;
> > > > > > > > >
> > > > > > > > > and they can be converted nicely with guard() once when PM runtime can
> > > > > > > > > be automatically unreferenced.  With my proposed change, it would
> > > > > > > > > become like:
> > > > > > > > >
> > > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > > >         pm_runtime_auto_clean(dev);
> > > > > > > >
> > > > > > > > For the case in which the pm_runtime_get_sync() return value is
> > > > > > > > discarded, you could define a guard and do
> > > > > > > >
> > > > > > > > guard(pm_runtime_get_sync)(dev);
> > > > > > > >
> > > > > > > > here.
> > > > > > > >
> > > > > > > > The case checking the return value is less straightforward.
> > > > > > > >
> > > > > > > > >         guard(mutex)(&foo);
> > > > > > > > >         ....
> > > > > > > > >         return;
> > > > > > > > >
> > > > > > > > > or
> > > > > > > > >
> > > > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > > > >         if (ret)
> > > > > > > > >                 return ret;
> > > > > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > > > > >         guard(mutex)(&foo);
> > > > > > > > >         ....
> > > > > > > > >         return 0;
> > > > > > > > >
> > > > > > >
> > > > > > > I guess what I'm saying means basically something like this:
> > > > > > >
> > > > > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > > >
> > > > > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > > >
> > > > > > > and analogously for pm_runtime_get_sync().
> > > > > >
> > > > > > And it kind of makes sense either.  Do
> > > > > >
> > > > > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > > > > if (IS_ERR(active_dev))
> > > > > >         return PTR_ERR(active_dev);
> > > > > >
> > > > > > and now use active_dev for representing the device until it gets out
> > > > > > of the scope.
> > > > >
> > > > > Yes, that's what I thought of as an alternative, too, but I didn't
> > > > > consider using only pm_runtime_resume_and_get().  Actually by this
> > > > > action, we can also "clean up" the API usage at the same time to use a
> > > > > single recommended API function, which is a good thing.
> > > > >
> > > > > That said, I like this way :)
> > > > >
> > > > > It'd be nice if this change can go into 6.18, then I can put the
> > > > > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > > > > this change is definitely safe and can't break, per se.
> > > >
> > > > OK, do you mean something like the patch below?
> > >
> > > Yes!
> > >
> > > An easy follower is the patch like below.
> >
> > Err, I forgot to refresh before generating a patch.
> > The proper one is below.
> >
> >
> > Takashi
> >
> > -- 8< --
> > Subject: [PATCH] PCI: Use PM runtime class macro for the auto cleanup
> >
> > The newly introduced class macro can simplify the code.
> > Also, add the proper error handling for the PM runtime get, too.
> >
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/pci/pci-sysfs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5eea14c1f7f5..87c2311494bf 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
> >                 return count;
> >         }
> >
> > -       pm_runtime_get_sync(dev);
> > -       struct device *pmdev __free(pm_runtime_put) = dev;
> > +       CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> > +       if (IS_ERR(pmdev))
> > +               return PTR_ERR(pmdev);
> 
> This error will propagate to user space AFAICS and some of the values
> may be confusing in that respect, so it may be better to return -ENXIO
> here.

Fair enough.


thanks,

Takashi

