Return-Path: <linux-pm+bounces-34946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C353B8346C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA933B637E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C72EA752;
	Thu, 18 Sep 2025 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TwCal60E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EHCr+7k9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TwCal60E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EHCr+7k9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627E2EA49C
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179451; cv=none; b=nAnp1I5DoJjN7n44DZPHV2n9ZMJmWJc40lGrhoJ0cBimBE3of9bv7sKtFGIjTeXTT5NVbYToJvIK1wMpKEzOjQaOOiDAszIYwBBTkw/jU4XuDdaFJg64xaDi3eMtOE0Ag6vPAxYJu4d3se9Tc46mxiv4OXr+yifc84IgafezvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179451; c=relaxed/simple;
	bh=afbZiTITWiDPxpVDFuaq7hIxA4pu1Ma8IO/vh9BBM6w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAZU8aktp1Mmt4S9kPnSyKzuHJ4S63bgL+DKR97Av5IZfv7LDzUbX1k/auf/EmbHB84b/4TdZRaRWZWO6/plAjcTIPK0X6zLBD8/tlXd9KQpWLOiidCjjnM9cm1wvh4bcXi1soUin14pdW29fT8Cy33Q8cPW/wXdGZxAOyY8v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TwCal60E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EHCr+7k9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TwCal60E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EHCr+7k9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2738B336B0;
	Thu, 18 Sep 2025 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758179442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pit2StEZvDVJ127lc63LyjBnZcAyarkm35ZsvFwG3Ug=;
	b=TwCal60EKp1MDOYLxoKy6YjdPtPkSczXK7B7bK3rOpV76PRPfJMOkOowlhCljGbcUzP/cK
	j+FfczXwY+wOCeTs+OU1fDqaqcgucBb5vw44Meu9+gu/i5sockbhOqxJlksJY5HslRufD5
	vUGsrw4qdAW3MvT8hnOMyGi7qNeRQ/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758179442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pit2StEZvDVJ127lc63LyjBnZcAyarkm35ZsvFwG3Ug=;
	b=EHCr+7k9hyySXBNOFAuI8v3Jc7tuniPCQowjRMA+7x2ERLpmAcF2dz/fMsMQuaNZy5iw8w
	ovAJf6kyNBBOCyCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TwCal60E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EHCr+7k9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758179442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pit2StEZvDVJ127lc63LyjBnZcAyarkm35ZsvFwG3Ug=;
	b=TwCal60EKp1MDOYLxoKy6YjdPtPkSczXK7B7bK3rOpV76PRPfJMOkOowlhCljGbcUzP/cK
	j+FfczXwY+wOCeTs+OU1fDqaqcgucBb5vw44Meu9+gu/i5sockbhOqxJlksJY5HslRufD5
	vUGsrw4qdAW3MvT8hnOMyGi7qNeRQ/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758179442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pit2StEZvDVJ127lc63LyjBnZcAyarkm35ZsvFwG3Ug=;
	b=EHCr+7k9hyySXBNOFAuI8v3Jc7tuniPCQowjRMA+7x2ERLpmAcF2dz/fMsMQuaNZy5iw8w
	ovAJf6kyNBBOCyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3BDE13A39;
	Thu, 18 Sep 2025 07:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VzApOnGwy2irKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Sep 2025 07:10:41 +0000
Date: Thu, 18 Sep 2025 09:10:41 +0200
Message-ID: <87tt10b5hq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
References: <878qimv24u.wl-tiwai@suse.de>
	<87ikhptpgm.wl-tiwai@suse.de>
	<CAJZ5v0htMKOcCoKts-B9BaE0VpS2oc9-cp=5VnNwS2Qe2iB+Kg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 2738B336B0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 17 Sep 2025 20:58:36 +0200,
Rafael J. Wysocki wrote:
> 
> Hi,
> 
> Sorry for the delay.
> 
> On Thu, Sep 11, 2025 at 9:31 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Wed, 10 Sep 2025 16:00:17 +0200,
> > Takashi Iwai wrote:
> > >
> > > Hi,
> > >
> > > while I worked on the code cleanups in the drivers with the recent
> > > auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> > > be also managed with the auto-cleanup gracefully, too.  Actually we
> > > already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> > > there is a (single) user of it in pci-sysfs.c.
> > >
> > > Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> > >
> > > DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
> > >            if (_T) pm_runtime_put_autosuspend(_T))
> > >
> > > Then one can use it like
> > >
> > >       ret = pm_runtime_resume_and_get(dev);
> > >       if (ret < 0)
> > >               return ret;
> > >       struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> > >
> > > that is similar as done in pci-sysfs.c.  So far, so good.
> > >
> > > But, I find putting the line like above at each place a bit ugly.
> > > So I'm wondering whether it'd be better to introduce some helper
> > > macros, e.g.
> > >
> > > #define pm_runtime_auto_clean(dev, var) \
> > >       struct device *var __free(pm_runtime_put) = (dev)
> >
> > It can be even simpler by assigning a temporary variable such as:
> >
> > #define pm_runtime_auto_clean(dev) \
> >         struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)
> 
> Well, if there's something like
> 
> struct device *pm_runtime_resume_and_get_dev(struct device *dev)
> {
>         int ret = pm_runtime_resume_and_get(dev);
>         if (ret < 0)
>                 return ERR_PTR(ret);
> 
>         return dev;
> }
> 
> It would be a matter of redefining the FREE to also take error
> pointers into account and you could do
> 
> struct device *__dev __free(pm_runtim_put) = pm_runtime_resume_and_get_dev(dev);
> if (IS_ERR(__dev))
>         return PTR_ERR(__dev);

That'll work, too.  Though, I find the notion of __free() and a
temporary variable __dev a bit too cumbersome; it's used only for
auto-clean stuff, so it could be somewhat anonymous.

But it's all about a matter of taste, and I'd follow what you and
other guys suggest.

FWIW, there are lots of code doing like

	pm_runtime_get_sync(dev);
	mutex_lock(&foo);
	....
	mutex_unlock(&foo);
	pm_runtime_put(dev);
	return;

or

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return ret;
	mutex_lock(&foo);
	....
	mutex_unlock(&foo);
	pm_runtime_put_autosuspend(dev);
	return 0;

and they can be converted nicely with guard() once when PM runtime can
be automatically unreferenced.  With my proposed change, it would
become like:

	pm_runtime_get_sync(dev);
	pm_runtime_auto_clean(dev);
	guard(mutex)(&foo);
	....
	return;

or

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return ret;
	pm_runtime_auto_clean_autosuspend(dev);
	guard(mutex)(&foo);
	....
	return 0;


thanks,

Takashi

