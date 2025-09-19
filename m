Return-Path: <linux-pm+bounces-35033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59415B89B9F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F9585FA7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866E2FC03B;
	Fri, 19 Sep 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MLrBsbpf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GpbXv/qM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MLrBsbpf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GpbXv/qM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246382BE622
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289407; cv=none; b=lsLUY7hqKImbjvAALGZmPPhMcKpV694SAYgwpEQeEXx6PhGK3yeiDKY3u8kjc1/Hmic4Zx2xzpKZ330+bjoWDKYX9HEeOhEvdfiOc/8ImNOl+HSwPpekQgNm3Pl4A6XyBu/5D53dLuVABjhLWsMkq4ViLb2W32REHjTD9hYjhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289407; c=relaxed/simple;
	bh=VPvIKksjZcmxyR5EoC7YBO77AuB9ZnjpqzeayjDATHI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxe9PWF2dzR5WVZ5u6UbsbwFsnjMJGBLE+s+ssaINAeJEQfzMHtc+Beg/E0MqeE7g64QYa0xwo+6Fs0LWld+9wq5p22jEO3QumdnnvCErLQd6k9xgk5zDMVP9dtYoxhD7jCnSdGuIc3pILz/inzF12dwYOYNhq9SlYGDcfAnQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MLrBsbpf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GpbXv/qM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MLrBsbpf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GpbXv/qM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D07B1F7F5;
	Fri, 19 Sep 2025 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758289403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyqJipjmtuEMJxk5BtWIfFeokGdfY4d/vGy39K+9Wrg=;
	b=MLrBsbpfbo/d6dNsG7vRMHJjRi/XegKPDve+DeIAs0ooMjQyS5LnoiSpllUGwvNPyMH+df
	8wkXrYUlu67NbWeltJ+RioKtO1KiUsCwFaR4SGXjHcMCYa2revzTMv5zJ/Eb6ZPjAJQugg
	FI6omfL3NdA/PvIukLtCPctN7FeJXh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758289403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyqJipjmtuEMJxk5BtWIfFeokGdfY4d/vGy39K+9Wrg=;
	b=GpbXv/qMQ2JH3d9mr22Sr0rRcUDS0J02K6NU5Vc1LERTav3/rp1AtpfHhyt0oBRsVIyxT2
	33eQ0O6peNzallDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758289403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyqJipjmtuEMJxk5BtWIfFeokGdfY4d/vGy39K+9Wrg=;
	b=MLrBsbpfbo/d6dNsG7vRMHJjRi/XegKPDve+DeIAs0ooMjQyS5LnoiSpllUGwvNPyMH+df
	8wkXrYUlu67NbWeltJ+RioKtO1KiUsCwFaR4SGXjHcMCYa2revzTMv5zJ/Eb6ZPjAJQugg
	FI6omfL3NdA/PvIukLtCPctN7FeJXh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758289403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyqJipjmtuEMJxk5BtWIfFeokGdfY4d/vGy39K+9Wrg=;
	b=GpbXv/qMQ2JH3d9mr22Sr0rRcUDS0J02K6NU5Vc1LERTav3/rp1AtpfHhyt0oBRsVIyxT2
	33eQ0O6peNzallDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CAFA13A39;
	Fri, 19 Sep 2025 13:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IrR4DftdzWhOGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 13:43:23 +0000
Date: Fri, 19 Sep 2025 15:43:22 +0200
Message-ID: <87jz1u8sn9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <87ldma8sq1.wl-tiwai@suse.de>
References: <878qimv24u.wl-tiwai@suse.de>
	<CAJZ5v0hJvsuOTj5j-0Jn-c9TPnbm70wPvdBkop2hRrdweoncDg@mail.gmail.com>
	<87jz1uao65.wl-tiwai@suse.de>
	<12751070.O9o76ZdvQC@rafael.j.wysocki>
	<87ldma8sq1.wl-tiwai@suse.de>
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Fri, 19 Sep 2025 15:41:42 +0200,
Takashi Iwai wrote:
> 
> On Fri, 19 Sep 2025 15:05:04 +0200,
> Rafael J. Wysocki wrote:
> > 
> > On Friday, September 19, 2025 9:37:06 AM CEST Takashi Iwai wrote:
> > > On Thu, 18 Sep 2025 22:41:32 +0200,
> > > Rafael J. Wysocki wrote:
> > > > 
> > > > On Thu, Sep 18, 2025 at 10:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 1:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 18, 2025 at 9:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > >
> > > > > > > On Wed, 17 Sep 2025 20:58:36 +0200,
> > > > > > > Rafael J. Wysocki wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > Sorry for the delay.
> > > > > > > >
> > > > > > > > On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 10 Sep 2025 16:00:17 +0200,
> > > > > > > > > Takashi Iwai wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > while I worked on the code cleanups in the drivers with the recent
> > > > > > > > > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > > > > > > > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > > > > > > > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > > > > > > > > there is a (single) user of it in pci-sysfs.c.
> > > > > > > > > >
> > > > > > > > > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > > > > > > > > >
> > > > > > > > > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > > > > > > > > >            if (_T) pm_runtime_put_autosuspend(_T))
> > > > > > > > > >
> > > > > > > > > > Then one can use it like
> > > > > > > > > >
> > > > > > > > > >       ret = pm_runtime_resume_and_get(dev);
> > > > > > > > > >       if (ret < 0)
> > > > > > > > > >               return ret;
> > > > > > > > > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > > > > > > > > >
> > > > > > > > > > that is similar as done in pci-sysfs.c.  So far, so good.
> > > > > > > > > >
> > > > > > > > > > But, I find putting the line like above at each place a bit ugly.
> > > > > > > > > > So I'm wondering whether it'd be better to introduce some helper
> > > > > > > > > > macros, e.g.
> > > > > > > > > >
> > > > > > > > > > #define pm_runtime_auto_clean(dev, var) \
> > > > > > > > > >       struct device *var __free(pm_runtime_put) = (dev)
> > > > > > > > >
> > > > > > > > > It can be even simpler by assigning a temporary variable such as:
> > > > > > > > >
> > > > > > > > > #define pm_runtime_auto_clean(dev) \
> > > > > > > > >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> > > > > > > >
> > > > > > > > Well, if there's something like
> > > > > > > >
> > > > > > > > struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> > > > > > > > {
> > > > > > > >         int ret = pm_runtime_resume_and_get(dev);
> > > > > > > >         if (ret < 0)
> > > > > > > >                 return ERR_PTR(ret);
> > > > > > > >
> > > > > > > >         return dev;
> > > > > > > > }
> > > > > > > >
> > > > > > > > It would be a matter of redefining the FREE to also take error
> > > > > > > > pointers into account and you could do
> > > > > > > >
> > > > > > > > struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> > > > > > > > if (IS_ERR(__dev))
> > > > > > > >         return PTR_ERR(__dev);
> > > > > > >
> > > > > > > That'll work, too.  Though, I find the notion of __free() and a
> > > > > > > temporary variable __dev a bit too cumbersome; it's used only for
> > > > > > > auto-clean stuff, so it could be somewhat anonymous.
> > > > > >
> > > > > > No, it is not used only for auto-clean, it is also used for return
> > > > > > value checking and it represents a reference on the original dev.  It
> > > > > > cannot be entirely anonymous because of the error checking part.
> > > > > >
> > > > > > The point is that this is one statement instead of two and so it is
> > > > > > arguably harder to mess up with.
> > > > > >
> > > > > > > But it's all about a matter of taste, and I'd follow what you and
> > > > > > > other guys suggest.
> > > > > > >
> > > > > > > FWIW, there are lots of code doing like
> > > > > > >
> > > > > > >         pm_runtime_get_sync(dev);
> > > > > > >         mutex_lock(&foo);
> > > > > > >         ....
> > > > > > >         mutex_unlock(&foo);
> > > > > > >         pm_runtime_put(dev);
> > > > > > >         return;
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >         mutex_lock(&foo);
> > > > > > >         ....
> > > > > > >         mutex_unlock(&foo);
> > > > > > >         pm_runtime_put_autosuspend(dev);
> > > > > > >         return 0;
> > > > > > >
> > > > > > > and they can be converted nicely with guard() once when PM runtime can
> > > > > > > be automatically unreferenced.  With my proposed change, it would
> > > > > > > become like:
> > > > > > >
> > > > > > >         pm_runtime_get_sync(dev);
> > > > > > >         pm_runtime_auto_clean(dev);
> > > > > >
> > > > > > For the case in which the pm_runtime_get_sync() return value is
> > > > > > discarded, you could define a guard and do
> > > > > >
> > > > > > guard(pm_runtime_get_sync)(dev);
> > > > > >
> > > > > > here.
> > > > > >
> > > > > > The case checking the return value is less straightforward.
> > > > > >
> > > > > > >         guard(mutex)(&foo);
> > > > > > >         ....
> > > > > > >         return;
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > >         ret = pm_runtime_resume_and_get(dev);
> > > > > > >         if (ret)
> > > > > > >                 return ret;
> > > > > > >         pm_runtime_auto_clean_autosuspend(dev);
> > > > > > >         guard(mutex)(&foo);
> > > > > > >         ....
> > > > > > >         return 0;
> > > > > > >
> > > > >
> > > > > I guess what I'm saying means basically something like this:
> > > > >
> > > > > DEFINE_CLASS(pm_runtime_resume_and_get, struct device *,
> > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put(_T),
> > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > >
> > > > > DEFINE_CLASS(pm_runtime_resume_and_get_auto, struct device *,
> > > > >          if (!IS_ERR_OR_NULL(_T)) pm_tuntime_put_autosuspend(_T),
> > > > > pm_runtime_resume_and_get_dev(dev), struct device *dev)
> > > > >
> > > > > and analogously for pm_runtime_get_sync().
> > > > 
> > > > And it kind of makes sense either.  Do
> > > > 
> > > > CLASS(pm_runtime_resume_and_get, active_dev)(dev);
> > > > if (IS_ERR(active_dev))
> > > >         return PTR_ERR(active_dev);
> > > > 
> > > > and now use active_dev for representing the device until it gets out
> > > > of the scope.
> > > 
> > > Yes, that's what I thought of as an alternative, too, but I didn't
> > > consider using only pm_runtime_resume_and_get().  Actually by this
> > > action, we can also "clean up" the API usage at the same time to use a
> > > single recommended API function, which is a good thing.
> > > 
> > > That said, I like this way :)
> > > 
> > > It'd be nice if this change can go into 6.18, then I can put the
> > > driver cleanup works for 6.19.  It's a bit late stage for 6.18, but
> > > this change is definitely safe and can't break, per se.
> > 
> > OK, do you mean something like the patch below?
> 
> Yes!
> 
> An easy follower is the patch like below.

Err, I forgot to refresh before generating a patch.
The proper one is below.


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
index 5eea14c1f7f5..87c2311494bf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *dev,
 		return count;
 	}
 
-	pm_runtime_get_sync(dev);
-	struct device *pmdev __free(pm_runtime_put) = dev;
+	CLASS(pm_runtime_resume_and_get, pmdev)(dev);
+	if (IS_ERR(pmdev))
+		return PTR_ERR(pmdev);
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);
-- 
2.50.1



