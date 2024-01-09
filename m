Return-Path: <linux-pm+bounces-2014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAC4828A6F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE8E1F26624
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B43A8C4;
	Tue,  9 Jan 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmOD/fiE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4W0r6zM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TmOD/fiE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4W0r6zM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747138DFE
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54EC21F809;
	Tue,  9 Jan 2024 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704819007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yIDqFZVq5nXgVpCJHbzlalX+SDZjWi27C8hNKtf+oA=;
	b=TmOD/fiE7ptC4FOcZHOWpSnTC2/wiqMn/S3gN/tApLaaSdtB5ZPP9Lg0rojzmIyJCIL7FR
	YlUvrDncND/oAvPCLD7T9KbZfwUzVzjmf2JdgDCwJIDObqteTq8lqM2Sse3v1DS+X0cWJF
	3PvaJSRh8aglB2MUFSBEf8gvcTOYriU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704819007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yIDqFZVq5nXgVpCJHbzlalX+SDZjWi27C8hNKtf+oA=;
	b=P4W0r6zMS7KdHQD0ihC1tCinn2nJ67JBNWu+UFPn1UoBJk2Mb6x3OKG5FHdvR5v4Xm27kD
	oHzCEGNfAGSn9ZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704819007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yIDqFZVq5nXgVpCJHbzlalX+SDZjWi27C8hNKtf+oA=;
	b=TmOD/fiE7ptC4FOcZHOWpSnTC2/wiqMn/S3gN/tApLaaSdtB5ZPP9Lg0rojzmIyJCIL7FR
	YlUvrDncND/oAvPCLD7T9KbZfwUzVzjmf2JdgDCwJIDObqteTq8lqM2Sse3v1DS+X0cWJF
	3PvaJSRh8aglB2MUFSBEf8gvcTOYriU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704819007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yIDqFZVq5nXgVpCJHbzlalX+SDZjWi27C8hNKtf+oA=;
	b=P4W0r6zMS7KdHQD0ihC1tCinn2nJ67JBNWu+UFPn1UoBJk2Mb6x3OKG5FHdvR5v4Xm27kD
	oHzCEGNfAGSn9ZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFBB2134E8;
	Tue,  9 Jan 2024 16:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hbh/KT55nWXnCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Jan 2024 16:50:06 +0000
Date: Tue, 09 Jan 2024 17:50:06 +0100
Message-ID: <878r4yqwn5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org,	"Rafael J. Wysocki" <rafael@kernel.org>,	Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com,	Jacek Lawrynowicz
 <jacek.lawrynowicz@linux.intel.com>,	Stanislaw Gruszka
 <stanislaw.gruszka@linux.intel.com>,	Jani Nikula
 <jani.nikula@linux.intel.com>,	Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,	David Airlie
 <airlied@gmail.com>,	Daniel Vetter <daniel@ffwll.ch>,	Lucas De Marchi
 <lucas.demarchi@intel.com>,	Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>,	Paul Elder
 <paul.elder@ideasonboard.com>,	Alex Elder <elder@kernel.org>,	Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH 1/2] pm: runtime: Simplify pm_runtime_get_if_active() usage
In-Reply-To: <20240109133657.111258-1-sakari.ailus@linux.intel.com>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
	<20240109133657.111258-1-sakari.ailus@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.intel.com,ideasonboard.com,intel.com,gmail.com,ffwll.ch,linuxfoundation.org,perex.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.08)[87.97%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.38

On Tue, 09 Jan 2024 14:36:57 +0100,
Sakari Ailus wrote:
> 
> There are two ways to opportunistically increment a device's runtime PM
> usage count, calling either pm_runtime_get_if_active() or
> pm_runtime_get_if_in_use(). The former has an argument to tell whether to
> ignore the usage count or not, and the latter simply calls the former with
> ign_usage_count set to false. The other users that want to ignore the
> usage_count will have to explitly set that argument to true which is a bit
> cumbersome.
> 
> To make this function more practical to use, remove the ign_usage_count
> argument from the function. The main implementation is renamed as
> __pm_runtime_get_conditional().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/power/runtime_pm.rst      |  5 ++--
>  drivers/accel/ivpu/ivpu_pm.c            |  2 +-
>  drivers/base/power/runtime.c            |  9 ++++---
>  drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
>  drivers/gpu/drm/xe/xe_pm.c              |  2 +-
>  drivers/media/i2c/ccs/ccs-core.c        |  2 +-
>  drivers/media/i2c/ov64a40.c             |  2 +-
>  drivers/media/i2c/thp7312.c             |  2 +-
>  drivers/net/ipa/ipa_smp2p.c             |  2 +-
>  drivers/pci/pci.c                       |  2 +-
>  include/linux/pm_runtime.h              | 32 +++++++++++++++++++++----
>  sound/hda/hdac_device.c                 |  2 +-

For sound/*,

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

