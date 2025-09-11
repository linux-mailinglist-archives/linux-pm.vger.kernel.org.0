Return-Path: <linux-pm+bounces-34435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD515B529FD
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49B67B0BAA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8A26F287;
	Thu, 11 Sep 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vvOGN/QO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7uDXEcP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vvOGN/QO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7uDXEcP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02433F3
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575902; cv=none; b=aJBoS5AHn+gwbAxdE0j2ueJw/7Yf1sWXLipYauBd4MhQ27RnsQsgFxglHbd1A9Fp7GBv6+UkZRFm1ZhMKQODM6/HFOtA38ToR1IRHaL84S/ROvf+DQMKoRJc2prm7+gNriJFcjxQW4W1gsMmqv6UIDmISCe4a8Wk1LMzFzwmFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575902; c=relaxed/simple;
	bh=106kYwWz75JcHH+vZ8uGQM8hCJIay+/XEnSHUXFkcTs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1bH/buh2/r4NihzADbAyN7C4yH6LFz7ck4ILHnH/wRlBstFY8nfUUlvAdNUQ/qEYG2IQvTXBocn97U+B9+hz194rrvzS+ahzWntMRfh0rALN6cluBxWcyql5Lywbe5INmr90EJQDrBkLvAOJ+cEz3C4fJzWqCFws0Dp3jv4IDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vvOGN/QO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7uDXEcP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vvOGN/QO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7uDXEcP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0021684CB;
	Thu, 11 Sep 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757575897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDd+7jUWvK2el43OuqFvYUR8GI0VAjvKZfCbClbZiK4=;
	b=vvOGN/QOT12vylhTU62fihOaKT6pxrCGpY1aosHVpOGcWvA3nL8lLcGMHuIl2w/FmA9+1y
	kh2uaaBmul32l31BXAA/c4Y2pGwTWlKrfpFKRRJO381/ukXtjkuhNw8fow9NsYbxvxcUt2
	KhEHNNLl4krobuGYzfWwXm7toVaQXwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757575897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDd+7jUWvK2el43OuqFvYUR8GI0VAjvKZfCbClbZiK4=;
	b=t7uDXEcPWkiNFSAiVOF6B1kGzSLk7jgNY5adqynZ550d4FdK4jcUzxuJ1UA6luDoxh1fSD
	8L+C5Cs87QB79hDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757575897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDd+7jUWvK2el43OuqFvYUR8GI0VAjvKZfCbClbZiK4=;
	b=vvOGN/QOT12vylhTU62fihOaKT6pxrCGpY1aosHVpOGcWvA3nL8lLcGMHuIl2w/FmA9+1y
	kh2uaaBmul32l31BXAA/c4Y2pGwTWlKrfpFKRRJO381/ukXtjkuhNw8fow9NsYbxvxcUt2
	KhEHNNLl4krobuGYzfWwXm7toVaQXwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757575897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDd+7jUWvK2el43OuqFvYUR8GI0VAjvKZfCbClbZiK4=;
	b=t7uDXEcPWkiNFSAiVOF6B1kGzSLk7jgNY5adqynZ550d4FdK4jcUzxuJ1UA6luDoxh1fSD
	8L+C5Cs87QB79hDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFFA213301;
	Thu, 11 Sep 2025 07:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VyGfLdl6wmguXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 11 Sep 2025 07:31:37 +0000
Date: Thu, 11 Sep 2025 09:31:37 +0200
Message-ID: <87ikhptpgm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: PM runtime auto-cleanup macros
In-Reply-To: <878qimv24u.wl-tiwai@suse.de>
References: <878qimv24u.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 10 Sep 2025 16:00:17 +0200,
Takashi Iwai wrote:
> 
> Hi,
> 
> while I worked on the code cleanups in the drivers with the recent
> auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
> be also managed with the auto-cleanup gracefully, too.  Actually we
> already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
> there is a (single) user of it in pci-sysfs.c.
> 
> Now I wanted to extend it to pm_runtime_put_autosuspend() as:
> 
> DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
>            if (_T) pm_runtime_put_autosuspend(_T))
> 
> Then one can use it like
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;
> 
> that is similar as done in pci-sysfs.c.  So far, so good.
> 
> But, I find putting the line like above at each place a bit ugly.
> So I'm wondering whether it'd be better to introduce some helper
> macros, e.g.
> 
> #define pm_runtime_auto_clean(dev, var) \
> 	struct device *var __free(pm_runtime_put) = (dev)

It can be even simpler by assigning a temporary variable such as:

#define pm_runtime_auto_clean(dev) \
	struct device *__pm_runtime_var ## __LINE__ __free(pm_runtime_put) = (dev)


Takashi

> 
> #define pm_runtime_auto_clean_autosuspend(dev, var) \
> 	struct device *var __free(pm_runtime_put_autosuspend) = (dev)
> 
> and the code will be like:
> 
> 	pm_runtime_get_sync(dev);
> 	pm_runtime_auto_clean(dev, pmdev);
> 
> or
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	pm_runtime_auto_clean_autosuspend(dev, pmdev);
> 
> Alternatively, we may define a class, e.g.
> 
> 	CLASS(pm_runtime_resume_and_get, pmdev);
> 	if (pmdev.ret < 0)
> 		return pmdev.ret;
> 
> but it'll be a bit more code to define the full class, and the get*()
> and put*() combination would be fixed with this approach -- which is a
> downside.
> 
> All above are an idea for now.  Let me know if I should go further
> along with this, or there is already a better another approach.
> 
> (And the macros can be better named, sure :)
> 
> 
> thanks,
> 
> Takashi

