Return-Path: <linux-pm+bounces-41772-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +InsGFOTfGkQNwIAu9opvQ
	(envelope-from <linux-pm+bounces-41772-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:17:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0547B9FA3
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 447F33091185
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C437C11C;
	Fri, 30 Jan 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqc5EVyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541037B41F
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771496; cv=pass; b=Dgq8+buZZ1D/Me30nAghULD6nku5X5C93QDlCC8sS5Pq8amj79FJJaDv50HN6YR3r0SxC7eaxbZlDALx3H007LIDI4lJFcHozJUqbtiKwQTHpOOZfcEmr9okzKLlw+/yOepMQ5uq/I/sAS9E9qurgCwEBc2YRASC4D4yTHVziVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771496; c=relaxed/simple;
	bh=8tsjSfYdDpz3lJBYpKFP87YLnGQibzxcSj05UqvqWK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPvYw+eMxYNX3yKNa3z3YyqoPiZnwBZJJPrjTME/ROhZjfRddrbc6gc0PAMBZiWwjxokvtZ5j5/q20YWNv10xz/LJ+Az4AQSCitSugFXDDBTbxpLvrNv3vnKjE8+e0ZEB6YlauS03bsk2ea7CJ19iGSRD0YIkjWyiwgrHvSpNnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqc5EVyr; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso2339848e87.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 03:11:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769771493; cv=none;
        d=google.com; s=arc-20240605;
        b=KJVIBLcn/j212oON9kcKP7nGeFniZSCdxdsagLT20zWHejQcg6Nnf9DkDOmkaImugJ
         YopBmqpbxroVx7DNXiffLHntWIBZks+CHH0yjLVMWNlfkFWcLdWTIU0TwOLwErzp08Iq
         obO7V5NAYqcs/EgyKLMYVx8aSGJvbEIm92Og7SK6TqOOXOpGnpiQ7KAnMKwxMTK/RoVg
         ZIZKzAWqCJ1K1AsF552bQ6wqZfvPj+DS+8D13jJdJkAocIHMhZEBldKaCP0HaLCQV9Az
         2PmcEATvFFt8IivUc8MjFcQSw7Kmj3IwWvzNAHVvG8Dv18P6F9t3RW+1Kk+neiIn4HjO
         gEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/t19w9yng3Ho9XpYiqa5eLQ7rawC3KufLSOGn8wHW+M=;
        fh=OLuV6OTAHBst+uzzoL4pTXPTwmVQBTKNbz3rCmgP5xc=;
        b=FP/QlQ4VOewaa1sE9SQlBf3E4NM5+GaNNmfacP+6uUzh3JNM0DViKhQnc8+lEwfApS
         hIJCb/58mqFpX3nF8JSXvXldkySm+BnpKYK2PM+yZbq+HDzYTYb+OR0athSsBqacA9Qe
         /wv20/hoFdy43Mk5PoXYGq8g/eFxQJj3XQbO5A8fy4IiMItDFIOabFN8NrYDgwOo58Qe
         Ifr2PQrYtPKqF/gU8NpDXIRmOxesNKCR5Mfq2wFzxN6WaDdsRQAVRCGiWAEsxre5IEXD
         xVGF8L2qy9Zc1UTgifng0JqmytMLy6uRy4oMGMvKeoTdjSlnQP+VhcWZNd4FoUUoSYeV
         lOYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769771493; x=1770376293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/t19w9yng3Ho9XpYiqa5eLQ7rawC3KufLSOGn8wHW+M=;
        b=cqc5EVyr96ndsWuybeADT17EO5guDGmgQ2uWO2/oS1QkoFfT1MyCM3O7Xv6/3Ew+CP
         fd4D7fEX/pCB4Ztm7iOSqc7Jd9+BVqFTO1p2CYV2gDe5IW51tDU1g2R5DbQUawlxDA4G
         jMKXscDUvsQWLsRwL5UUCTmyOpQ2mOoYG92QoOh0PJypAUCUilyekLrVkK7eL6dLzhwF
         1HIe1UF55N9LoO+fn2gvbdKhnz5IwvZymtlaKYcRRbUTm6o+1N5YF2wf6iP2cxVxgXVN
         5eU3Oc4vhBT+XXf176N6HGnOJgpMGyDboKhstb1U31ylZLRtldaMVgKRZB7RLK8pAwg2
         qkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771493; x=1770376293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t19w9yng3Ho9XpYiqa5eLQ7rawC3KufLSOGn8wHW+M=;
        b=sNaRiu/Z9hA2/gXdemlPoficNZaOnwpBURbDlS4wwZg9jpo+66XkBTu7skFD1Ksp3c
         MPGEgXRS04tIm31nlFV1KahXsgHclAtnwPvguXyoCWwj+R8vXQ4r2vlTKHMKX/JxL66C
         QrVMqkWulLhafBoZ+B7AYAUTJ2+fxDbycGDE/QPU/nDTQ/+A4/YcBvSsHDbh1YqRmIUF
         S3pX47BxFMle1k83F+gD9WvC+V10EZqFgnBd20DfLUCYIQr5YzJpsRTgEZ7qEe5sqxzJ
         MWJ1OR3Iv5LtqJlHiCOgDM9peGwTWpy1/2Tm3XvMCPFnW2JrQNBXKIBwgMpK9llqHqmz
         XFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0TD99v09oF5Dip0ujAYMuXaD6qYlhChn9Iu0jOwN3v+qxq/QKAeSvoVAiFnIXaBp7Vmy9WxBTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DqSacaz5MA0lBWQYVMUMDmXIcXcJblPnGluFTG1vMB9Uf+B3
	9R+j7GUhy44g4THgtFl/Ueis78gI5yrzUyC1++wSH6feQi0YW3f4M8Ll7p7e0/+GM/ZYKx6YeAF
	fQjgoLwuhrjgKgtU4To5QHoK8xIIEV619cVXgNtFZVQ==
X-Gm-Gg: AZuq6aJD5sh8gCGvd+wD/IG/vbonuflBbAv3gUl0YdMmVCA5pmV1aQG/JRz4//kCw3r
	cABJv6PzTCj7Z6zjgkE59TpZvYm3x5m45kg+kN3+4vSrWzegr+qbaxRNHj51qLGOLIwMAfS8ZUu
	AKzerfwPrvJHNLZ1cFwSEQVODEfxKldAUC/tHAkvlfHDsKYgIbqymFrdG7iYdZf+L7OU6Npgrds
	mcMXgFYxdypVnDbB2n38lx/L6iDG7e+Rcd5zZ5Ea014RDJp2RhHMCdizxun4fyT8HLBpCsN
X-Received: by 2002:a05:6512:39d4:b0:59d:d661:7918 with SMTP id
 2adb3069b0e04-59e16433cf6mr871435e87.33.1769771492684; Fri, 30 Jan 2026
 03:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com>
 <7hh5s547ot.fsf@baylibre.com> <CAPDyKFoxbYtPTs+Egsn=2pJYdsw8g+yXfFjy-NAyq+X2ohyEhA@mail.gmail.com>
 <7hbjic46in.fsf@baylibre.com>
In-Reply-To: <7hbjic46in.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 12:10:56 +0100
X-Gm-Features: AZwV_QgBiU0l20zE65m0HeDrALYh6z2hkj4hkDOuJ6obYVUMvWOmYd9LVKj60_U
Message-ID: <CAPDyKFq5rP71svqcgruF7cFWWXrNawMW_VEkSsy3vJGwnp4vgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: QoS/pmdomains: support resume latencies for
 system-wide PM
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41772-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: D0547B9FA3
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 19:29, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Thu, 29 Jan 2026 at 00:51, Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Hi Ulf,
> >>
> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
> >>
> >> > On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
> >> >>
> >> >> Currently QoS resume latencies are only considered for runtime PM
> >> >> transitions of pmdomains, which remains the default.
> >> >>
> >> >> In order to also support QoS resume latencies during system-wide PM,
> >> >> add a new flag to indicate a resume latency should be used for
> >> >> system-wide PM *instead of* runtime PM.
> >> >>
> >> >> For example, by doing this:
> >> >>
> >> >>    # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us
> >> >>
> >> >> dev0 now has a resume latency of 500000 usec for runtime PM
> >> >> transitions.
> >> >>
> >> >> Then, if the new flag is also set:
> >> >>
> >> >>    # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys
> >> >>
> >> >> That 500000 usec delay now applies to system-wide PM (and not to
> >> >> runtime PM).
> >> >>
> >> >> If a user requires a different latency value for system-wide PM
> >> >> compared to runtime PM, then the runtime PM value can be set for
> >> >> normal operations, and the system-wide value (and flag) can be set by
> >> >> userspace before suspend, and the runtime PM value can be restored
> >> >> after resume.
> >> >
> >> > That's sounds complicated for user-space to manage - and causes churns
> >> > during every suspend/resume cycle. Why don't we just add a new latency
> >> > value instead, that applies both to runtime PM and system-wide PM,
> >> > similar and consistent to what we did for CPU QoS?
> >>
> >> First, I don't think it will be very common to have different *device*
> >> latency values between runtime PM and system PM, because the reasons for
> >> device-specific wakeup latency will likely be the same in both cases, at
> >> least for all the usecases I've thought about.  The only real distiction
> >> being whether the latency should be applied to runtime or system-wide
> >> PM, which the new flag provides.
> >>
> >> Second, this doesn't have to be in userspace at all, that's just the
> >> example I used to illustrate.  In fact, today not many latency
> >> constraints are exposed to userspace, so this can be acheived by the
> >> kernel API for setting latency values & flags, which I think is the more
> >> likely usecase anyways.  For example, for a driver that is managing a
> >> wakeup latency constraint, it could update it's own constraint and set
> >> the flag in it's ->prepare() and ->complete() hook if it needs separate
> >> values for system-wide vs. runtime PM.
> >
> > Right, as long as the use cases can be managed by the kernel itself,
> > then this should be fine. So, I guess the question is, if we should
> > consider use-cases that requires user space involvement at this point?
> >
> > Also note, patch1 do exposes a new QoS sysfs file, to allow user space
> > to manage the new QoS flag - so this becomes ABI.
> >
> >>
> >> Third, adding a new QoS value for this involves a bunch of new code that
> >> is basically copy/paste of the current latency code.  That includes APIs
> >> for
> >>
> >>   - sysfs interface
> >>   - notifiers (add, remove)
> >>   - read/add/update value adds a new type
> >>   - expose value to userspace (becomes ABI)
> >>   - tolerance
> >>
> >> I actually went down this route first, and realized this would be lots
> >> of duplicated code for a usecase that we're not even sure exists, so I
> >> found the flag approach to be much more straight forward for the
> >> usecases at hand.
> >
> > I understand your concern and I agree!
> >
> > However, my main issue is the user space ABI part. Is the QoS flag,
> > that patch1 exposes, future proof enough when considering user cases
> > that needs to be managed by user space? In my opinion, I don't think
> > so.
>
> Well, I think we have the same problem with the alternative proposal
> (creating a new QoS value) because we simply don't know the use-cases
> that need to be managed by userspace.

I agree!

>
> That being said, I'm fine if we drop [PATCH 1/2] for now, and just manage
> this from the kernel API while we start using this feature and and
> whether it needs to be used from userspace at all.

Seems reasonable to me too, let's revisit the user space part later on.

Still we need the QoS flag to be defined in some patch, but I guess it
can be part of patch2 as well. Anyway, I will have a look at patch2
shortly and let you know what I think.

Kind regards
Uffe

