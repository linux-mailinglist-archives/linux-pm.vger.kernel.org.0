Return-Path: <linux-pm+bounces-25607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278FA91567
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBABA1642A5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F322218821;
	Thu, 17 Apr 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kcg77EO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB8++XD7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kcg77EO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB8++XD7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CB1DE3AF
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875465; cv=none; b=Gsau6HnMv2VVNKvovlzWdxhVyqBEvYftbX60J5X2EMasTu1Ndj71HT0qoh+3IGzk5EFV5ka3pM6PkoAjyYZ+/epOpqrJGWSLCCVjVmagM1BwSqp/nhm2KmI41BjojGzcCJjFeVhx/IpIUxxi4MQHB3cn66uWqsExmfxr9qx1mtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875465; c=relaxed/simple;
	bh=5Up4c2ec9bz9tNPVJsSQs5s0U01bmRiYXnnnXA1OJnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9cGAwG43NXD3rOmoK/YF9aUTUCPrwibFBAG90bAAdUiy6M/YAeP/3uOzyJF1YRgo8VCa64HCpPB7jcY5mpal/ULpnN2T85MuyicgBB0jX54+lYEh1Cm4nyU/PeBTRVRhAxapr16MqN8Aq9kU2vfcM0BHG3X0C+BJTtwoJzM6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kcg77EO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB8++XD7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kcg77EO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB8++XD7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1A651F391;
	Thu, 17 Apr 2025 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744875460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=Kcg77EO3YAvi3HHRtM1Cey2oVHNpiVx3hiYEP98iylnJRFWwPUHIb9H1mI1smmR8ybJJxo
	FjJXvkvqG2nDpcBaW5HkZOe34jdpT6Qn/xFVHhX54UaOXXjqRLj9GYGueNHKCdNkwCyx6h
	hn/5k3YjS56pBH7tWTpmCh2tEgg4dGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744875460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=NB8++XD7+6MTY1UqStY6otFYnkHR3M/lSsdJ6i/cRggvxxLI3slt0egetza22uxF/YQhPJ
	4cW9TVm7SUKrOXDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744875460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=Kcg77EO3YAvi3HHRtM1Cey2oVHNpiVx3hiYEP98iylnJRFWwPUHIb9H1mI1smmR8ybJJxo
	FjJXvkvqG2nDpcBaW5HkZOe34jdpT6Qn/xFVHhX54UaOXXjqRLj9GYGueNHKCdNkwCyx6h
	hn/5k3YjS56pBH7tWTpmCh2tEgg4dGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744875460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY/upZ4RRyv+Af/uq37XK2KMVfUJ5EV6Iwrz5O78PcU=;
	b=NB8++XD7+6MTY1UqStY6otFYnkHR3M/lSsdJ6i/cRggvxxLI3slt0egetza22uxF/YQhPJ
	4cW9TVm7SUKrOXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2EE6137CF;
	Thu, 17 Apr 2025 07:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y45ZK8SvAGixUgAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Thu, 17 Apr 2025 07:37:40 +0000
Message-ID: <7a2c79fd-cad2-4685-9da2-a12f089be13d@suse.cz>
Date: Thu, 17 Apr 2025 09:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ACPI: processor: idle:
 acpi_processor_get_cstate_info() cleanup
To: Zhang Rui <rui.zhang@intel.com>, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250409005026.1932637-1-rui.zhang@intel.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <20250409005026.1932637-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed Apr 9, 2025 02:50, Zhang Rui wrote:
> This patch series does further cleanups for
> acpi_processor_get_cstate_info() on top of
> https://lore.kernel.org/all/20250328143040.9348-2-ggherdovich@suse.cz/
> 
> thanks,
> rui
> 
> ----------------------------------------------------------------
> Zhang Rui (2):
>        ACPI: processor: idle: Set pr->flags.power unconditionally
>        ACPI: processor: idle: Remove redundant pr->power.count assignment
> 
>   drivers/acpi/processor_idle.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Thanks a lot Rui for this cleanup.

To the series:

Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>

