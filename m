Return-Path: <linux-pm+bounces-41655-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGJaMBmhemnZ8gEAu9opvQ
	(envelope-from <linux-pm+bounces-41655-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 00:51:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F8AA0BA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 00:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0E46300A617
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D333BBBD;
	Wed, 28 Jan 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RSpVi+PC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C452D6E75
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644310; cv=none; b=Eoi48mTV6GlUSFBYvMlFsPSeNOe8EsYIw5AojJ/PDOQrUk6a/ErQ5juKfrijCxWBRJOA66G9nSsFLW+0TMFz2+DE2fxBWkpP4X87kgL5sKwbr9sInIRu/nh2BNKgJXHH8Ba+cVES26CC2lpGyWDdRLNNNkaxAJmBQAQHCRH6sZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644310; c=relaxed/simple;
	bh=SNnWGRxtwRaXMgkJWx8mnXztZQGfXNSAxvSbqw6z/YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRgwyaIhy9+dq47tLUXimNQ9Mm0+5+q6iOIDmj2o463CN3uVDINUkQ9WEjRvYIQHSeKjIlWi7MW92nykVX8Ld4ra3PjBWKBuyh3/6Fkz/6otBG8CJ/LlU2sgF/Dnu6jQap7IOKVCSmc58fHI1EaeIpSF0rpKOu5a9hvupepjvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RSpVi+PC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so2424265ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 15:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769644308; x=1770249108; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EznR4U20DzXv1n4K0tPEIv8qaghM500zv7iNQ5zGtc=;
        b=RSpVi+PCyR7ESwvM7F4RcgiouTN0K9odi4ttFJ8Jk8XxgXd/mEI7QxrQ94ElxRLY76
         GhT/xWuJtuNl22y4bFbUF+T7oW+aqwCdTp+tGSPICJXePYJNnziCaXWRFEdlq04tooIh
         Wp46OvE/M2JmF7TydkcUhS6O8JVmITfGKWNGQiZD1/O/CJz44Eqhf7TEdkD7ZZOmYjox
         dMPTpuUi8ShzzO6zChgAmiXubESRoGDLwlHr/zq6M2wUJntFYl5HekgCf95bP2mn8y1Z
         xKCuLOXcY5fXxwZ7GfFEBTh6MdNrdhljgiiDjc0B6g5nBTfVoIZ/4RN2YLNrHDszn2t7
         5Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769644308; x=1770249108;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EznR4U20DzXv1n4K0tPEIv8qaghM500zv7iNQ5zGtc=;
        b=p+rNCCE+AbgQ0gT0z21qFQqx3vciMRPEYexHm9UbO8uCHKDtdPCzziq267fH+O9BKt
         p/2Ko1cymlT1cX5oo0rqJY7AWlcAOdVit6vK2ztM8wCmJ4spNOt/+ymdBqDVwntdRb9c
         XSGLPipFulFDEH7iaFiUMkTvUiuBzzp8yNHIBx2EdDTBa5oDKY4xWRWWu0Ts/Mv14gn4
         ENKg4zHTDmh4Fav2PU3wsRGhEEpdY2Ce+KSk6OGkjcj/caW/LEVMp2N6GXmMUxB8tWOq
         jTmn6OMVg2E91zYAqAI3t9/IRS4TAA6341NERxFLFsn2LRXFMQEGaXVo0VAE4rczd3qa
         g8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAtfViPvWSbm9VlpCpQAziWu6TxmoM+2jqeTP2HnKX/KyRXydFdi/vix7gDE1TchC5xSrgRjVBgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIyA2C1G6UyLK1+sYBiKW64IxWVe7MxlSpOk60IoOTkMmz+qo
	xhGmIuur7XpmknTWz8yIcTLlpMdg8HUDjpq2K08QR+ibBJtJZesOh13eIZ8/jidFHeo=
X-Gm-Gg: AZuq6aLVi0vjc8LorVz66kbRPGJevb3EWM7aPZqwUx385pBnqJOq6jcDxXJMF0d8HDi
	QK2VU1Dv/EPAbr5g3ugKw/P/w+i6QVHCUAgTSJxfOGisMrlaZ4AOA/siVqK69Pn0/AgTS76V+gP
	IJ6VMArwRqFe0lj9kASmAhpmwGfzqxiODEtuCnErbfLB0y+9TsKtdvuRsSuyqPRet28cL0eJie9
	YIDsn9wKPKGVxu0r7ticb5UAM7cBujQCMTMRS+3RmTcELKvP0u8KZWMr4Fvi+h81+nmLWgYVjjZ
	9XHmToySkMhur4QIsyTU4JXOHWl8kIggz4VJoqWLJ4pybXXW9miSD7aFysTypIRxrtobWDgjO6o
	3OvIqpkANspqobKIe9DCcJGJZIsxkFqGE+tN3EvmrgGE95PmBwWbBMuYF3OeW33mFRAr/oQsT4e
	9UqodensVv
X-Received: by 2002:a17:903:2f87:b0:2a2:bff6:42f5 with SMTP id d9443c01a7336-2a870d334bfmr52735505ad.8.1769644307921;
        Wed, 28 Jan 2026 15:51:47 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c4665sm33664905ad.64.2026.01.28.15.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:51:47 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
In-Reply-To: <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com>
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com>
Date: Wed, 28 Jan 2026 15:51:46 -0800
Message-ID: <7hh5s547ot.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41655-lists,linux-pm=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A5F8AA0BA
X-Rspamd-Action: no action

Hi Ulf,

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>>
>> Currently QoS resume latencies are only considered for runtime PM
>> transitions of pmdomains, which remains the default.
>>
>> In order to also support QoS resume latencies during system-wide PM,
>> add a new flag to indicate a resume latency should be used for
>> system-wide PM *instead of* runtime PM.
>>
>> For example, by doing this:
>>
>>    # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us
>>
>> dev0 now has a resume latency of 500000 usec for runtime PM
>> transitions.
>>
>> Then, if the new flag is also set:
>>
>>    # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys
>>
>> That 500000 usec delay now applies to system-wide PM (and not to
>> runtime PM).
>>
>> If a user requires a different latency value for system-wide PM
>> compared to runtime PM, then the runtime PM value can be set for
>> normal operations, and the system-wide value (and flag) can be set by
>> userspace before suspend, and the runtime PM value can be restored
>> after resume.
>
> That's sounds complicated for user-space to manage - and causes churns
> during every suspend/resume cycle. Why don't we just add a new latency
> value instead, that applies both to runtime PM and system-wide PM,
> similar and consistent to what we did for CPU QoS?

First, I don't think it will be very common to have different *device*
latency values between runtime PM and system PM, because the reasons for
device-specific wakeup latency will likely be the same in both cases, at
least for all the usecases I've thought about.  The only real distiction
being whether the latency should be applied to runtime or system-wide
PM, which the new flag provides.

Second, this doesn't have to be in userspace at all, that's just the
example I used to illustrate.  In fact, today not many latency
constraints are exposed to userspace, so this can be acheived by the
kernel API for setting latency values & flags, which I think is the more
likely usecase anyways.  For example, for a driver that is managing a
wakeup latency constraint, it could update it's own constraint and set
the flag in it's ->prepare() and ->complete() hook if it needs separate
values for system-wide vs. runtime PM.

Third, adding a new QoS value for this involves a bunch of new code that
is basically copy/paste of the current latency code.  That includes APIs
for

  - sysfs interface
  - notifiers (add, remove)
  - read/add/update value adds a new type
  - expose value to userspace (becomes ABI)
  - tolerance
  
I actually went down this route first, and realized this would be lots
of duplicated code for a usecase that we're not even sure exists, so I
found the flag approach to be much more straight forward for the
usecases at hand.

Kevin

