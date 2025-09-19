Return-Path: <linux-pm+bounces-35054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A7B8A7F9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3A016150A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A531A543;
	Fri, 19 Sep 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNzOav2N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hlvBFp6z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNzOav2N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hlvBFp6z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB323C4F3
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297984; cv=none; b=J1xI14JNUBDQQtdkrzqI+jsmIlG3nyuXJbT6XfDvFo/o8KYlg2ukD8ajAtKZC3oIRsA22WVd6qJBGcqUP1MQptiVdUJtgQ9RitSvh4Bibv7fd2XMc4u2xmnX9QqF53+Bgd7dwlHNZIHAnH/bTy+QA9pE+CXMcQmYkNTsTOn5zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297984; c=relaxed/simple;
	bh=DMj2fKg23DwYf73juw4+Sr+8OGK4EW7M3Y7RF9KL8qs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkd/CEV0x1beeSCdKAi+JG0Cn4oo8+BWNRxkHS8sN+8tC6tg0egz/MU3Svo7FF17ywgeFBZkjugd3MYLdDUsxF7Ge+ciw0mJu/pkX880elCK6qJDUrniErQhBJ7we+JGisBkH+T67Fd7JwXxudjD05MlpGiB+nlOOCFceHpVK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNzOav2N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hlvBFp6z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WNzOav2N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hlvBFp6z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5B79220B2;
	Fri, 19 Sep 2025 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758297980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucOqcRQjLG2lr6EznCJzeShpyd167oEDoWFpYd0D44g=;
	b=WNzOav2N9oHYhUjdb2XJ7x4svGgDrWCn+IUEJqTVaKr95gIq5At0uTZhIT7BQtGsk7pd5U
	p2RwMkck0hzm9wPv1mDPLOkArtWEfAeCUw5ULXfyXC9+jlOyLqqMCNqcVzfxbf6vXUYIpt
	fh2NGV6lhSprvPGysxcGOK//XvQGjvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758297980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucOqcRQjLG2lr6EznCJzeShpyd167oEDoWFpYd0D44g=;
	b=hlvBFp6zC8G+6HxvoyBR1yoIuIvuMiguYTeH556FulJ59zEC5dq4SNZmc8bTP1Sijk+bq7
	97PapnG2RKbnqaDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WNzOav2N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hlvBFp6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758297980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucOqcRQjLG2lr6EznCJzeShpyd167oEDoWFpYd0D44g=;
	b=WNzOav2N9oHYhUjdb2XJ7x4svGgDrWCn+IUEJqTVaKr95gIq5At0uTZhIT7BQtGsk7pd5U
	p2RwMkck0hzm9wPv1mDPLOkArtWEfAeCUw5ULXfyXC9+jlOyLqqMCNqcVzfxbf6vXUYIpt
	fh2NGV6lhSprvPGysxcGOK//XvQGjvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758297980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucOqcRQjLG2lr6EznCJzeShpyd167oEDoWFpYd0D44g=;
	b=hlvBFp6zC8G+6HxvoyBR1yoIuIvuMiguYTeH556FulJ59zEC5dq4SNZmc8bTP1Sijk+bq7
	97PapnG2RKbnqaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A9313A39;
	Fri, 19 Sep 2025 16:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WZdQHnx/zWglSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:06:20 +0000
Date: Fri, 19 Sep 2025 18:06:20 +0200
Message-ID: <878qia8m0z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAjrzY_w2n8A@mail.gmail.com>
References: <878qimv24u.wl-tiwai@suse.de>
	<CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
	<87jz1uao65.wl-tiwai@suse.de>
	<12751070.O9o76ZdvQC@rafael.j.wysocki>
	<87ldma8sq1.wl-tiwai@suse.de>
	<CAJZ5v0jJjYoTceD2_pgvKgKuPypo+8osnAuCefgAjrzY_w2n8A@mail.gmail.com>
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
X-Rspamd-Queue-Id: A5B79220B2
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

On Fri, 19 Sep 2025 17:52:32 +0200,
Rafael J. Wysocki wrote:
> 
> On Fri, Sep 19, 2025 at 3:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Fri, 19 Sep 2025 15:05:04 +0200,
> > Rafael J. Wysocki wrote:
> > >
> > > On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > > > On Thu, 18 Sep 2025 22:41:32 +0200,
> > > > Rafael J. Wysocki wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 10:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 18, 2025 at 1:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 18, 2025 at 9:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > >
> > > > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > > > Rafael J. Wysocki wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Sorry for the delay.
> > > > > > > > >
> > > > > > > > > On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > > > Takashi Iwai wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > while I worked on the code cleanups in the drivers with the recent
> > > > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > > > > > > > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > > > > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > > > >
> > > > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > > > > > > >
> > > > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > > > >
> > > > > > > > > > > Then one can use it like
> > > > > > > > > > >
> > > > > > > > > > >       ret = pm_runtime_resume_and_get(dev);
> > > > > > > > > > >       if (ret < 0)
> > > > > > > > > > >               return ret;
> > > > > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > > > > > > > > > >
> > > > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > > > > > >
> > > > > > > > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > > > > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > > > > > > > macros, e.g.
> > > > > > > > > > >
> > > > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > > > >       struct device *var __free(pm_runtime_put) = (dev)
> > > > > > > > > >
> > > > > > > > > > It can be even simpler by assigning a temporary variable such as:
> > > > > > > > > >
> > > > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> > > > > > > > >
> > > > > > > > > Well, if there's something like
> > > > > > > > >
> > > > > > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > > > > > {
> > > > > > > > >         int ret = pm_runtime_resume_and_get(dev);
> > > > > > > > >         if (ret < 0)
> > > > > > > > >                 return ERR_PTR(ret);
> > > > > > > > >
> > > > > > > > >         return dev;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > It would be a matter of redefining the FREE to also take error
> > > > > > > > > pointers into account and you could do
> > > > > > > > >
> > > > > > > > > struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> > > > > > > > > if (IS_ERR(__dev))
> > > > > > > > >         return PTR_ERR(__dev);
> > > > > > > >
> > > > > > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > > > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > > > >
> > > > > > > No, it is not used only for auto-clean, it is also used for return
> > > > > > > value checking and it represents a reference on the original dev.  It
> > > > > > > cannot be entirely anonymous because of the error checking part.
> > > > > > >
> > > > > > > The point is that this is one statement instead of two and so it is
> > > > > > > arguably harder to mess up with.
> > > > > > >
> > > > > > > > But it's all about a matter of taste, and I'd follow what you and
> > > > > > > > other guys suggest.
> > > > > > > >
> > > > > > > > FWIW, there are lots of code doing like
> > > > > > > >
> > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > >         mutex_lock(&foo);
> > > > > > > >         ....
> > > > > > > >         mutex_unlock(&foo);
> > > > > > > >         pm_runtime_put(dev);
> > > > > > > >         return;
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >         mutex_lock(&foo);
> > > > > > > >         ....
> > > > > > > >         mutex_unlock(&foo);
> > > > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > > > >         return 0;
> > > > > > > >
> > > > > > > > and they can be converted nicely with guard() once when PM runtime can
> > > > > > > > be automatically unreferenced.  With my proposed change, it would
> > > > > > > > become like:
> > > > > > > >
> > > > > > > >         pm_runtime_get_sync(dev);
> > > > > > > >         pm_runtime_auto_clean(dev);
> > > > > > >
> > > > > > > For the case in which the pm_runtime_get_sync() return value is
> > > > > > > discarded, you could define a guard and do
> > > > > > >
> > > > > > > guard(pm_runtime_get_sync)(dev);
> > > > > > >
> > > > > > > here.
> > > > > > >
> > > > > > > The case checking the return value is less straightforward.
> > > > > > >
> > > > > > > >         guard(mutex)(&foo);
> > > > > > > >         ....
> > > > > > > >         return;
> > > > > > > >
> > > > > > > > or
> > > > > > > >
> > > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > > > >         guard(mutex)(&foo);
> > > > > > > >         ....
> > > > > > > >         return 0;
> > > > > > > >
> > > > > >
> > > > > > I guess what I'm saying means basically something like this:
> > > > > >
> > > > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > >
> > > > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > > >
> > > > > > and analogously for pm_runtime_get_sync().
> > > > >
> > > > > And it kind of makes sense either.  Do
> > > > >
> > > > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > > > if (IS_ERR(active_dev))
> > > > >         return PTR_ERR(active_dev);
> > > > >
> > > > > and now use active_dev for representing the device until it gets out
> > > > > of the scope.
> > > >
> > > > Yes, that's what I thought of as an alternative, too, but I didn't
> > > > consider using only pm_runtime_resume_and_get().  Actually by this
> > > > action, we can also "clean up" the API usage at the same time to use a
> > > > single recommended API function, which is a good thing.
> > > >
> > > > That said, I like this way :)
> > > >
> > > > It'd be nice if this change can go into 6.18, then I can put the
> > > > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > > > this change is definitely safe and can't break, per se.
> > >
> > > OK, do you mean something like the patch below?
> >
> > Yes!
> 
> OK
> 
> > An easy follower is the patch like below.
> > (It's the only user of __free(pm_runtime_*) in linux-next as of now.)
> 
> So the __free(pm_runtime_*) could be dropped after this patch I suppose?

Yes, for now it seems so.  It was the only user as far as I can see in
linux-next.

> In that case, let me send a series of 3 patches which will add the new
> class definitions, switch over PCI to using them (your patch), and
> drop the existing pm_runtime_put FREE.

OK, will do that.


Takashi

