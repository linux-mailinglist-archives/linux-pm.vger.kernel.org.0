Return-Path: <linux-pm+bounces-41236-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIHyD9gAcWmgbAAAu9opvQ
	(envelope-from <linux-pm+bounces-41236-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:37:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A36059FE9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B9018AF5A7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E343D4FB;
	Wed, 21 Jan 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CkhAf3dP"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBD40F8E2
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008262; cv=none; b=GeS+zWX4rfci0c8F5ElKfE3nnqrnA5vyy15Y8/LxK5taRQ4dLu6I5/zTlDStR0WwZX1UOAqv7bdYpYtWnq84vMzjFzQAoY2C5yVO4kUfyxDblE5e4jCMz73p79V9Vf8sgVpFNxtqXxgiTLEKS50Hhkyl3BO7h6rlrcsNIPhcsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008262; c=relaxed/simple;
	bh=lCDxlM+yqCQMKmrEqArUSKF4KYldS3/T92SOB6whHEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogCUv27f+94Pic4GdUNxYoKYyLTtQQQSnFuKcurcTYDB+gki23Rcq8PK2xZzs6bbwLbdyKiBMsIjBmIPurZBgVC4VScDRy71aFiLSN2VdVEYIfttutwDRp+SogsmevLG3Fht+yNVwxvQBWlrJE+vOFU9ukV5BY3lXGaH9vpIbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CkhAf3dP; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9be645d1-4de2-4ff2-890e-6f0149b07c57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769008257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+iZ9dhXRVI9aGNccTo0SytDWA0FNnDAw0/vu2LGl1o=;
	b=CkhAf3dPb/NK3Ul9GJ4ZPtGWVzFOtb0gdNapXOOeOODIXxNJhGeSs2e0nCN+KaQrYkbvet
	eiuxJyabKa7chIRNI8Gl0U2z+uehJu0u7Um2N/2pjPWYpWqVID1ppn+XEH6JYzoGfovFyn
	JyQJ+sphbSJhR52Bt2I26x/3F8PqMYM=
Date: Wed, 21 Jan 2026 16:08:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 lgirdwood@gmail.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
 <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
 <aW+/J7id+7GhD9T9@opensource.cirrus.com>
 <74596131-4d06-449e-8ba9-30b35e0e2064@linux.dev>
 <aXDPAjgEgHvrezVz@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <aXDPAjgEgHvrezVz@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,vger.kernel.org,opensource.cirrus.com];
	TAGGED_FROM(0.00)[bounces-41236-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre-louis.bossart@linux.dev,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 3A36059FE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>> You lost me with this sentence:
>>
>> "
>> For SoundWire itself the soundwire host resumes all children
>> before a suspend, which dodges the direct complete.
>> "
>>
>> If the direct-complete optimization is not used, then do you
>> actually see a different behavior with this NO_DIRECT_COMPLETE
>> flag set?
> 
> The flag is applied to the auxiliary device children of the
> soundwire device. The direct complete doesn't affect the
> soundwire device, but it it does affect the function devices
> children.

Ah ok, yes the host only resumes devices one level down, so the function level isn't affected by the .prepare logic.

I guess I was confused by the 'class driver' title  but the change is not in sdca_class.c but in sdca_class_function.c...

The change looks good, so here's my 

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>


