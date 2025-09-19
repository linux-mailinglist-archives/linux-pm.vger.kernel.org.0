Return-Path: <linux-pm+bounces-35018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34308B88328
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 09:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094823B425D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7152C0F7D;
	Fri, 19 Sep 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWQJQVtT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WtIq+78k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZWQJQVtT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WtIq+78k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261732BF000
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267438; cv=none; b=Fg85eWnRKSCTXLQ2QRMG9jrHR0ZT/8TAL9Q84rIPGAgbdPDrN6kZIo6pXvr78vMu+znjF1b1xzzyBL9slJGuQMpmaFP2YhWKBsLZxtNbyFNn1X0ulj7jk5suv4fqP47Ys7P6AnWUMN63srta+Rfu8VS1jh31y1ivOw0GGe9YcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267438; c=relaxed/simple;
	bh=umsbZFp3ysEk6cX5detYcgTyjViVyfN3apysifuXvZ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIxUpruMi/gRDrswmHSB1vqAhPoUKpvLmBPWzC0Oo8YSABWogTEByPedlkvXXFh64pOmCWipXn9zxdT5sdbDhYPGJVI35cGieJIGMM+GW+1xdddcmrwx8EnF/iK6e/CG+yYhST09BlgHpSUydm2G0NWmi9a+8CH98Slf7LgWs0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWQJQVtT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WtIq+78k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZWQJQVtT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WtIq+78k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F47C336BC;
	Fri, 19 Sep 2025 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758267427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Im1BpbmmZjRUANhcuvyHkY2BviST+CpyeQ5DUgpNrc=;
	b=ZWQJQVtTqwoySL7LZx8GZzQnZqugbDSErL5HaX5+vE6CYnCIXCg0DUp+WZPQ5QpSXzTMT3
	ut/rfWeq8XfF84hAsaayTvwJPHuuYZjQohgzWRk3F3saZd6zgrYOI2blwlKVMD3wfzEGM6
	5ji8p8HLu+u8szzFmAjpy5ReC+8kGMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758267427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Im1BpbmmZjRUANhcuvyHkY2BviST+CpyeQ5DUgpNrc=;
	b=WtIq+78kZgEl4q8rSJYBC32gu2jp1QaQcbJi2LvQkA1dpIgaqN4Qgum+wM0WDPco4nryor
	qWvJf7yEm89wMhDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZWQJQVtT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WtIq+78k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758267427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Im1BpbmmZjRUANhcuvyHkY2BviST+CpyeQ5DUgpNrc=;
	b=ZWQJQVtTqwoySL7LZx8GZzQnZqugbDSErL5HaX5+vE6CYnCIXCg0DUp+WZPQ5QpSXzTMT3
	ut/rfWeq8XfF84hAsaayTvwJPHuuYZjQohgzWRk3F3saZd6zgrYOI2blwlKVMD3wfzEGM6
	5ji8p8HLu+u8szzFmAjpy5ReC+8kGMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758267427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Im1BpbmmZjRUANhcuvyHkY2BviST+CpyeQ5DUgpNrc=;
	b=WtIq+78kZgEl4q8rSJYBC32gu2jp1QaQcbJi2LvQkA1dpIgaqN4Qgum+wM0WDPco4nryor
	qWvJf7yEm89wMhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F10413A39;
	Fri, 19 Sep 2025 07:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d2PLCSMIzWjPEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 07:37:07 +0000
Date: Fri, 19 Sep 2025 09:37:06 +0200
Message-ID: <87jz1uao65.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
References: <878qimv24u.wl-tiwai@suse.de>
	<87ikhptpgm.wl-tiwai@suse.de>
	<CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
	<87tt10b5hq.wl-tiwai@suse.de>
	<CAJZ5v0hUTByfxkE=-SGSHDDd=mPw694yD7PuuJ1LLRjp-H4=uA@mail.gmail.com>
	<CAJZ5v0jafoG--WrZNjt+euY0gtQSTqSDH2_cWotf92ziq5wdUw@mail.gmail.com>
	<CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5F47C336BC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 18 Sep 2025 22:41:32 +0200,
Rafael J. Wysocki wrote:
> 
> On Thu, Sep 18, 2025 at 10:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 18, 2025 at 1:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 9:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > Rafael J. Wysocki wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Sorry for the delay.
> > > > >
> > > > > On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > Takashi Iwai wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > while I worked on the code cleanups in the drivers with the recent
> > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > > > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > >
> > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > > >
> > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > >
> > > > > > > Then one can use it like
> > > > > > >
> > > > > > >       ret = pm_runtime_resume_and_get(dev);
> > > > > > >       if (ret < 0)
> > > > > > >               return ret;
> > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > > > > > >
> > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > >
> > > > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > > > macros, e.g.
> > > > > > >
> > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > >       struct device *var __free(pm_runtime_put) = (dev)
> > > > > >
> > > > > > It can be even simpler by assigning a temporary variable such as:
> > > > > >
> > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> > > > >
> > > > > Well, if there's something like
> > > > >
> > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > {
> > > > >         int ret = pm_runtime_resume_and_get(dev);
> > > > >         if (ret < 0)
> > > > >                 return ERR_PTR(ret);
> > > > >
> > > > >         return dev;
> > > > > }
> > > > >
> > > > > It would be a matter of redefining the FREE to also take error
> > > > > pointers into account and you could do
> > > > >
> > > > > struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> > > > > if (IS_ERR(__dev))
> > > > >         return PTR_ERR(__dev);
> > > >
> > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > auto-clean stuff, so it could be somewhat anonymous.
> > >
> > > No, it is not used only for auto-clean, it is also used for return
> > > value checking and it represents a reference on the original dev.  It
> > > cannot be entirely anonymous because of the error checking part.
> > >
> > > The point is that this is one statement instead of two and so it is
> > > arguably harder to mess up with.
> > >
> > > > But it's all about a matter of taste, and I'd follow what you and
> > > > other guys suggest.
> > > >
> > > > FWIW, there are lots of code doing like
> > > >
> > > >         pm_runtime_get_sync(dev);
> > > >         mutex_lock(&foo);
> > > >         ....
> > > >         mutex_unlock(&foo);
> > > >         pm_runtime_put(dev);
> > > >         return;
> > > >
> > > > or
> > > >
> > > >         ret = pm_runtime_resume_and_get(dev);
> > > >         if (ret)
> > > >                 return ret;
> > > >         mutex_lock(&foo);
> > > >         ....
> > > >         mutex_unlock(&foo);
> > > >         pm_runtime_put_autosuspend(dev);
> > > >         return 0;
> > > >
> > > > and they can be converted nicely with guard() once when PM runtime can
> > > > be automatically unreferenced.  With my proposed change, it would
> > > > become like:
> > > >
> > > >         pm_runtime_get_sync(dev);
> > > >         pm_runtime_auto_clean(dev);
> > >
> > > For the case in which the pm_runtime_get_sync() return value is
> > > discarded, you could define a guard and do
> > >
> > > guard(pm_runtime_get_sync)(dev);
> > >
> > > here.
> > >
> > > The case checking the return value is less straightforward.
> > >
> > > >         guard(mutex)(&foo);
> > > >         ....
> > > >         return;
> > > >
> > > > or
> > > >
> > > >         ret = pm_runtime_resume_and_get(dev);
> > > >         if (ret)
> > > >                 return ret;
> > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > >         guard(mutex)(&foo);
> > > >         ....
> > > >         return 0;
> > > >
> >
> > I guess what I'm saying means basically something like this:
> >
> > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> >
> > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> >
> > and analogously for pm_runtime_get_sync().
> 
> And it kind of makes sense either.  Do
> 
> CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> if (IS_ERR(active_dev))
>         return PTR_ERR(active_dev);
> 
> and now use active_dev for representing the device until it gets out
> of the scope.

Yes, that's what I thought of as an alternative, too, but I didn't
consider using only pm_runtime_resume_and_get().  Actually by this
action, we can also "clean up" the API usage at the same time to use a
single recommended API function, which is a good thing.

That said, I like this way :)

It'd be nice if this change can go into 6.18, then I can put the
driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
this change is definitely safe and can't break, per se.


Thanks!

Takashi

