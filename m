Return-Path: <linux-pm+bounces-41709-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJGaOQene2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41709-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:29:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15BB394A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58F6D30154A8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95322F7444;
	Thu, 29 Jan 2026 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OVuhTfGa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DA2F690D
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711365; cv=none; b=QpkCpLhEDUHZDtOP8VcHR6NU0PNm34x/ltPNMZOb2U3XbwgtZ5KvW0vSc8geJUtUTDTAvlwTx3JiJ+drcgyLncU7DAd2UU0ZVsP9H3y9GSjUi63Wq0pNtk/rZv8Q5KVU2fws5Aj4EaLOc2xBepr7nXdquoGToUrIHF+lChK0sBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711365; c=relaxed/simple;
	bh=s9cyBAx523IF+w7+uTG0ioM4KyoCJ4gol0oHmNarFvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhmnQBfXUSGW16+OU1ZlEfHhrmZ/cgzfTodDi2ECzJxBXEMP0v4Op8peeZEE91Req3jBecp+POGrA6fyeAKScKfghvnlOlZWNqqu4rgN+sTtSDjr/QUb0pwL7CaA5N7EXGK+cwuXKOJOFS3bFdPL48CMih84rEEz9+h1n00+yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OVuhTfGa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7786d7895so9494965ad.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769711363; x=1770316163; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/bgjJsIT5xznnALKdHvfKbvj/wc+CMZK/BWvtb0BD48=;
        b=OVuhTfGaEw3Nt7NIo7oUke5CT5noSltbwGmGg/SgEvwrSy3IM2UkYd2kcn/vcGdNsU
         rk8hGjavybVmIqfLKwgJSVZCKwnnNm0/ck6v0+hyNCAyqIdNyVVp3DMD+Y0idoAGdupz
         PoZpJC0hMRiSgURLlbod8JjNXlVrfswgl/5vK4eQ0VlYSvOrdvPxYXn6gArKBGZh2bKX
         G3VXkQ4AumD2jf/1Eqnw1dqIH56HbzQXd4tOINPzg2MXa/pTnOK9d7rEv1PgaTK/H/o0
         G5+rB5PzvoKu5b553JUAtpNx1EzSq/5RwoZxIvNLXr0+qjPE4VnZYbmMODRZf3V8DH/l
         UnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711363; x=1770316163;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bgjJsIT5xznnALKdHvfKbvj/wc+CMZK/BWvtb0BD48=;
        b=GkbkdsEoyDNwmWk7o4tBotK9u5fGPRhE+fMy/ydgafOz5po9fDHvU0OMZNHKpgXLhr
         RwhSdcp99oDkLxnmPkQHZNxwDtTX9vAirHS97uxhWopEueSbgZXYnNDZQRND7SFY90tz
         B7Eg9uqnPwZn5QtZpOruqher8jVsBDTgJrNKTGubbEKAdmjC+ZMnQTCTnTlz53YoMUGx
         c7783wJFXepM1j1OmMn8Ho1sfW9faIQ2Jz9Wnx5aNf2TBqXdq97aeD9zSzK4VcxjK7LB
         2baPB1kDyIC2RDrrMdHTlND/RtHSdCOiJSuEGxugMKQEwl1b3qfNPuMdHVqYTV00eUZo
         E7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK1T2O+LuB+VYa6pZXfXWlh28aVjbmy2vMFb4Ca/o6KhKKsiowutZBpf1c1jDgU7GV/+f69SDuGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6cKpsNt7ayWyqxkn/U7Gua3vx8blZ6wmCeNhaP4hvrjw5fUV
	GX/20dNP3dt4oD5HHjyJfYAW8WEc9P66JCRTkyX5AfhWX//F6lDV4mBkwYBu8COqhUA=
X-Gm-Gg: AZuq6aILQ45umAbz8QMB6NXKucuUOuddOsVMqlxz6DsjUPWrEE2iTcQwYSPJIkz0IcX
	mzZqKRCCCsV9gZMbWDITU6jEO4G6He7DCQGv+sCkMpZtrgX1sBNqMMxrQLo+Dy8gg+n+w0DkQXV
	tvRiUh9hM5SaVuT83WKclkD6WGkgAYi65HafhV4/oCXHAE2v2p3vpjCmy5jtz7jOfl42/JSphiJ
	XdM0ZHpQLq53r8nXu+a5dmzSUxuofxCPlw4kTZU/Mfcx74IbuBkuwNlYB0eCD4zc1oO2uJFHDyk
	T/d4G8eAfz5Pmr6MPGEU/OeDaCnfLsvTY6dQ1RnYmWmc5R9MuKDngm1KXrjR5Y5QInfx9gjMAC3
	LXRrmzuEB2YG4XRgnk5VwEf4jqlmihg3Zhp3kLAj2/CS1QkHVJQRe8D/KvJgTtekXlkPb7q3jnl
	Z4PC8lvd0j
X-Received: by 2002:a17:902:ced0:b0:2a0:8e35:969d with SMTP id d9443c01a7336-2a8d990beccmr1186465ad.39.1769711362830;
        Thu, 29 Jan 2026 10:29:22 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3b08sm56001275ad.59.2026.01.29.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:29:21 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
In-Reply-To: <CAPDyKFoxbYtPTs+Egsn=2pJYdsw8g+yXfFjy-NAyq+X2ohyEhA@mail.gmail.com>
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com>
 <7hh5s547ot.fsf@baylibre.com>
 <CAPDyKFoxbYtPTs+Egsn=2pJYdsw8g+yXfFjy-NAyq+X2ohyEhA@mail.gmail.com>
Date: Thu, 29 Jan 2026 10:29:20 -0800
Message-ID: <7hbjic46in.fsf@baylibre.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41709-lists,linux-pm=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 5E15BB394A
X-Rspamd-Action: no action

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Thu, 29 Jan 2026 at 00:51, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hi Ulf,
>>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>> >>
>> >> Currently QoS resume latencies are only considered for runtime PM
>> >> transitions of pmdomains, which remains the default.
>> >>
>> >> In order to also support QoS resume latencies during system-wide PM,
>> >> add a new flag to indicate a resume latency should be used for
>> >> system-wide PM *instead of* runtime PM.
>> >>
>> >> For example, by doing this:
>> >>
>> >>    # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us
>> >>
>> >> dev0 now has a resume latency of 500000 usec for runtime PM
>> >> transitions.
>> >>
>> >> Then, if the new flag is also set:
>> >>
>> >>    # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys
>> >>
>> >> That 500000 usec delay now applies to system-wide PM (and not to
>> >> runtime PM).
>> >>
>> >> If a user requires a different latency value for system-wide PM
>> >> compared to runtime PM, then the runtime PM value can be set for
>> >> normal operations, and the system-wide value (and flag) can be set by
>> >> userspace before suspend, and the runtime PM value can be restored
>> >> after resume.
>> >
>> > That's sounds complicated for user-space to manage - and causes churns
>> > during every suspend/resume cycle. Why don't we just add a new latency
>> > value instead, that applies both to runtime PM and system-wide PM,
>> > similar and consistent to what we did for CPU QoS?
>>
>> First, I don't think it will be very common to have different *device*
>> latency values between runtime PM and system PM, because the reasons for
>> device-specific wakeup latency will likely be the same in both cases, at
>> least for all the usecases I've thought about.  The only real distiction
>> being whether the latency should be applied to runtime or system-wide
>> PM, which the new flag provides.
>>
>> Second, this doesn't have to be in userspace at all, that's just the
>> example I used to illustrate.  In fact, today not many latency
>> constraints are exposed to userspace, so this can be acheived by the
>> kernel API for setting latency values & flags, which I think is the more
>> likely usecase anyways.  For example, for a driver that is managing a
>> wakeup latency constraint, it could update it's own constraint and set
>> the flag in it's ->prepare() and ->complete() hook if it needs separate
>> values for system-wide vs. runtime PM.
>
> Right, as long as the use cases can be managed by the kernel itself,
> then this should be fine. So, I guess the question is, if we should
> consider use-cases that requires user space involvement at this point?
>
> Also note, patch1 do exposes a new QoS sysfs file, to allow user space
> to manage the new QoS flag - so this becomes ABI.
>
>>
>> Third, adding a new QoS value for this involves a bunch of new code that
>> is basically copy/paste of the current latency code.  That includes APIs
>> for
>>
>>   - sysfs interface
>>   - notifiers (add, remove)
>>   - read/add/update value adds a new type
>>   - expose value to userspace (becomes ABI)
>>   - tolerance
>>
>> I actually went down this route first, and realized this would be lots
>> of duplicated code for a usecase that we're not even sure exists, so I
>> found the flag approach to be much more straight forward for the
>> usecases at hand.
>
> I understand your concern and I agree!
>
> However, my main issue is the user space ABI part. Is the QoS flag,
> that patch1 exposes, future proof enough when considering user cases
> that needs to be managed by user space? In my opinion, I don't think
> so.

Well, I think we have the same problem with the alternative proposal
(creating a new QoS value) because we simply don't know the use-cases
that need to be managed by userspace.

That being said, I'm fine if we drop [PATCH 1/2] for now, and just manage
this from the kernel API while we start using this feature and and
whether it needs to be used from userspace at all.

Kevin


