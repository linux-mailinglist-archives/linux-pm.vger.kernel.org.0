Return-Path: <linux-pm+bounces-34371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38947B518AD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F6F1C85EE9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC7322747;
	Wed, 10 Sep 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bDEftgiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TCt5bNgn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bDEftgiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TCt5bNgn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BA321F54
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512823; cv=none; b=m+8BnGheR/q7/kNZos8xONotuxFmW6zK1k6LRMr3BBIBL4isrL7MbLSxWvP1enYzNRUgLnAXHAzMIvG6H4NVkLtqw0FE9Fp0Zc2onEijBJgCqIT7s+yv+65MGLPmzXOLSRVfP96K9Gs5+6DF6B0zFPqcTwM9M9AZzdG3R6zSVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512823; c=relaxed/simple;
	bh=hZzGcVcN94ly8O32Q1TmwTv1UwiqYFdSbdl8QWFm9rw=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=nwg3UWSmDw2L4/dnkMu3lkSAIisjfzIwt4O4TcE4qSe2uyOR/+e23HvfoZm3newkYEJOWdvGW+T47s3TilGl2RgWIN2RVWyTlpOJVb3M6hjQJsdtVzWHnQAz5WVGu/TBXe3gSeUlnN4mC0vzCf7laBD1+FydKGRvchJQ2X6uvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bDEftgiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TCt5bNgn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bDEftgiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TCt5bNgn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55FF233D63;
	Wed, 10 Sep 2025 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757512818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kq8QN4/X28sVm2xdbMZ4oxDIMpObhAfGbFK4PDlt4ZE=;
	b=bDEftgiun6y9bqu+murGJTQublN0iEdZSMxvylAHBMjtcjClORUnBp8gG7C8i6VdjffgNX
	VvIMcjppMJAW8C0JJrwUwr44rpEO1aEIHWptlFBbjBEcJC2KAgtpjvuIzZdXixcRwo1liK
	b4NQxLLUCu6Z5+DEN29DmcY2t3PTxKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757512818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kq8QN4/X28sVm2xdbMZ4oxDIMpObhAfGbFK4PDlt4ZE=;
	b=TCt5bNgnO+bQ3aChUvBC7dT2G6y37tYzM4h2VQ1+oazYmJ5GJnb4lQ9JhhfsPa2y7vyhXh
	78NH3oem6+g2+wAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bDEftgiu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TCt5bNgn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757512818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kq8QN4/X28sVm2xdbMZ4oxDIMpObhAfGbFK4PDlt4ZE=;
	b=bDEftgiun6y9bqu+murGJTQublN0iEdZSMxvylAHBMjtcjClORUnBp8gG7C8i6VdjffgNX
	VvIMcjppMJAW8C0JJrwUwr44rpEO1aEIHWptlFBbjBEcJC2KAgtpjvuIzZdXixcRwo1liK
	b4NQxLLUCu6Z5+DEN29DmcY2t3PTxKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757512818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=kq8QN4/X28sVm2xdbMZ4oxDIMpObhAfGbFK4PDlt4ZE=;
	b=TCt5bNgnO+bQ3aChUvBC7dT2G6y37tYzM4h2VQ1+oazYmJ5GJnb4lQ9JhhfsPa2y7vyhXh
	78NH3oem6+g2+wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386C513310;
	Wed, 10 Sep 2025 14:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jAtkDHKEwWg3GgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 10 Sep 2025 14:00:18 +0000
Date: Wed, 10 Sep 2025 16:00:17 +0200
Message-ID: <878qimv24u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PM runtime auto-cleanup macros
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 55FF233D63
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

Hi,

while I worked on the code cleanups in the drivers with the recent
auto-cleanup macros, I noticed that pm_runtime_get*() and _put*() can
be also managed with the auto-cleanup gracefully, too.  Actually we
already defined the __free(pm_runtime_put) in commit bfa4477751e9, and
there is a (single) user of it in pci-sysfs.c.

Now I wanted to extend it to pm_runtime_put_autosuspend() as:

DEFINE_FREE(pm_runtime_put_autosuspend, struct device *,
           if (_T) pm_runtime_put_autosuspend(_T))

Then one can use it like

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	struct device *pmdev __free(pm_runtime_put_autosuspend) = dev;

that is similar as done in pci-sysfs.c.  So far, so good.

But, I find putting the line like above at each place a bit ugly.
So I'm wondering whether it'd be better to introduce some helper
macros, e.g.

#define pm_runtime_auto_clean(dev, var) \
	struct device *var __free(pm_runtime_put) = (dev)

#define pm_runtime_auto_clean_autosuspend(dev, var) \
	struct device *var __free(pm_runtime_put_autosuspend) = (dev)

and the code will be like:

	pm_runtime_get_sync(dev);
	pm_runtime_auto_clean(dev, pmdev);

or
	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	pm_runtime_auto_clean_autosuspend(dev, pmdev);

Alternatively, we may define a class, e.g.

	CLASS(pm_runtime_resume_and_get, pmdev);
	if (pmdev.ret < 0)
		return pmdev.ret;

but it'll be a bit more code to define the full class, and the get*()
and put*() combination would be fixed with this approach -- which is a
downside.

All above are an idea for now.  Let me know if I should go further
along with this, or there is already a better another approach.

(And the macros can be better named, sure :)


thanks,

Takashi

