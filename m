Return-Path: <linux-pm+bounces-41685-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIwsJ0dAe2nECwIAu9opvQ
	(envelope-from <linux-pm+bounces-41685-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 12:11:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A3BAF75B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 12:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF04530265BC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE88385533;
	Thu, 29 Jan 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Svs+sTXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1C33D4F4
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684734; cv=pass; b=r+RqhA98EOm3+viaSgj3irb2MVQEMk13qnBoxLseLQ5v6gG9SFWJr/bmjhLWVtKZXT109VHzXiMZygIjuTucpjqurGckAiGWssAxfJRj/2Pdt8Bxm0s29r31pcBwvPXpM6b9i/gZV37GdUclc2kC4YhVS0y1vDw8UczDWAfpAmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684734; c=relaxed/simple;
	bh=7yuu1JYviO1djzSP1BaansbjSfUAuA4UNxhrWftwtzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7Pf58tR/jRszX35AuJ0R8PZ8b6AjRJUF+iYo7rj08huBSsS4XSvqd0jiTqWNK0YCgA+auws1+6UTNvPK7ZGt19HgFvS0orDVmxMMH0Fm+aaAgZN0ixQx+atH1aia13aKp1OZt3CT+MXffd2vD0qTAmimKOcCLwETSwlb+nuxUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Svs+sTXI; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dd54b1073so906079e87.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 03:05:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769684730; cv=none;
        d=google.com; s=arc-20240605;
        b=bo91kCKhtr7Fr0qgNbMsTgjWkbuzwT7OMbA6jgv4uXp7hSbfZzInU/dyOXSkklzucr
         YqALv5q1r5E2eXt1h7KCeWkE3nkqvYj2lgGcZUEn1s23gvoM544/FyYjCLhIIBd5V1W6
         wokuywqgQtypuwoIB7CCeUmDlbEodrHqF4SYkxdSMNewXV1byB9D8wGRohwwLKs0iIK9
         bq6eT9y2B0cZ7vWoM7Edj8BSzYICkA4qEq4wrmj6BhXi80VsQwe87OzQFdMvD0AKNLAa
         otMxmxA+4qMDi264BFUQvynkcNRNn4FQiPGxxhhjKk/YJy7Gwlke9b6qTrEU3kMURfK2
         3Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vwPpr9zqDAkQy/uNtJh3bTp13liqZQrowkluMGHo3tc=;
        fh=1KEE95fg/qqYLzFRGnc6itm70i2ycR99OXECdm1D8x8=;
        b=AyPiOxn+ieX6fHzT53aysF147OpX1ni3iiaBGFWqNFxFpu/X9yPY4sk4npWDiiQHjk
         xgQIk9Abd84l8niGbNIynZTw3WGxnJPhaOmxKQhZEik70+ixnpRLKmpT/tj+LoFaslcI
         mEt7rh+ZnI23dNB1ToXEFpEceEnCJFi1ZdnazZNouXqNZHVt/BPSWNGmMnYd+0H03JXi
         D2kuCfruZL6yvnit94T9Cox1w6q3IAo3Sc6IXqb6rB2/yTFVT9wfMxYoPfMVLMb8Hz3i
         GmGrfCsU7Ravc62xJlQMZFhg+HEl0Kb9zHMaTd71JuLIG9NhxXzoeKebD6Cd0kd01my9
         zVYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769684730; x=1770289530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vwPpr9zqDAkQy/uNtJh3bTp13liqZQrowkluMGHo3tc=;
        b=Svs+sTXIOyVrxDy6DMvmPfSf2CV9eUZjn/Mcl/k5scqOcVcgifALAIPhpE6J1bXoSe
         rllf3PSB/AQpNEygo5yTozYrWwZDO/rCEe14nCnSdT3kxT/iATFiUa4+5AlKgok/7WS3
         ACvHlYSvTqzS7Mab/8TeOFMknC1mwW6n9D+H6IXV8cNSVYkzwZy6g8ohLoyP7wqO4jnw
         1nTpcjqLRL+Gjr0x7VlreZiaW0iDNTnBXbxPm+glqtrIOhdwCS3kL08JCVjBlcqBnCqO
         JF/S+x7VDO3itdouqesgi2BNSX6YfWG+y8UGWPsPgzNeiJ+LLdtjOQ0BKnnMJ4tWpUk8
         KXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769684730; x=1770289530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwPpr9zqDAkQy/uNtJh3bTp13liqZQrowkluMGHo3tc=;
        b=bGR1h/w+XY/BQx+Piel3fffhBcLf1kVJIMkQwGA+Aw57l/rwxs8G8EBF4zu/H67I6e
         jem9ICFwysdp79CnEENsPtYn6mkNsEIaMqeUwujmA6vIxMv2TUVwIPETdq4D2ACK5ORY
         iOl89E/r2tFFB/OSvFoiMYZAA1XXFqT2H5IR4l/sxxIpiOzpCb1U7snlqrBgPyBKtoxq
         IxqDr3CeAzDbKV7KVAXxt0unZT9/l0IcByI/TdBTmItpo/zKNDc+HSJDTgp55EKF0Pw4
         rVG9paqevh3INIRcJOxeclqWugRkpruEXGyOg0iNVw9sS5t0cQe3uSX+Qd1YWFaob4Yl
         2Fdw==
X-Forwarded-Encrypted: i=1; AJvYcCVawAr2Qe0+RjHYP6bCkVC8AxXrhZPvwZCsxtPlNQMAjes0PXgCEyuejQxQrqjB957A65o+mEvW3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0udW59yZrEyXE1TKcC6JBXoRCz5MuRJkku5C3Ulvz4Qtvxiq
	yRMkmU5/H+19J7b9wN17aqlscH1JggDh/g2CwXTekRsob99kaZUVHERkzNqFANoPOs6W1stJBx3
	5A1b0I0vM6Z9PM22NUZzdLxZ7IG80k8ltImGcZJKl+w==
X-Gm-Gg: AZuq6aJaSATK7eVvHxhu+odGv6iT6a+kPtNmOE2op1F6QD4B5eVe4KwxU1q7WlaowZl
	rc+MtsHxu9g2b68tAmocU1U9TodqUxiBrRpXiAn/pfwvxO/4hlfaZfSd43NFNzMwQy1gwtiBoLn
	B1vfC5xga9VufYfXHUqEbtZI9ez3ZqHXmymCo7PAiPttVGcq9qObU1YVfFhm+QlaUh2mU3Bvz/h
	FSVXW1Tp9lWlpWX2MTv/WgCBMlxFne8RzUT2UAWoHxy/xIl0Jbg7pP/Lh2M0gjjlVLTQ5m85xxs
	gAeJIA4=
X-Received: by 2002:a05:6512:3d91:b0:59d:f474:656b with SMTP id
 2adb3069b0e04-59e040297damr3473133e87.42.1769684730455; Thu, 29 Jan 2026
 03:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <CAPDyKFr+OjWLnzxBOhfJaMZb1GY7axgyeUAPinQTXMB6Ngpz8w@mail.gmail.com> <7hh5s547ot.fsf@baylibre.com>
In-Reply-To: <7hh5s547ot.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 12:04:53 +0100
X-Gm-Features: AZwV_QiNPN-kjHzKdxLc8KSBlB74s99MMDHxVx-RGZX2m45DwdtabHb6-YOHPXE
Message-ID: <CAPDyKFoxbYtPTs+Egsn=2pJYdsw8g+yXfFjy-NAyq+X2ohyEhA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41685-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,linaro.org:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 18A3BAF75B
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 00:51, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Hi Ulf,
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
> >>
> >> Currently QoS resume latencies are only considered for runtime PM
> >> transitions of pmdomains, which remains the default.
> >>
> >> In order to also support QoS resume latencies during system-wide PM,
> >> add a new flag to indicate a resume latency should be used for
> >> system-wide PM *instead of* runtime PM.
> >>
> >> For example, by doing this:
> >>
> >>    # echo 500000 > /sys/devices/.../<dev0>/power/pm_qos_resume_latency_us
> >>
> >> dev0 now has a resume latency of 500000 usec for runtime PM
> >> transitions.
> >>
> >> Then, if the new flag is also set:
> >>
> >>    # echo 1 > /sys/devices/.../<dev0>/power/pm_qos_latency_sys
> >>
> >> That 500000 usec delay now applies to system-wide PM (and not to
> >> runtime PM).
> >>
> >> If a user requires a different latency value for system-wide PM
> >> compared to runtime PM, then the runtime PM value can be set for
> >> normal operations, and the system-wide value (and flag) can be set by
> >> userspace before suspend, and the runtime PM value can be restored
> >> after resume.
> >
> > That's sounds complicated for user-space to manage - and causes churns
> > during every suspend/resume cycle. Why don't we just add a new latency
> > value instead, that applies both to runtime PM and system-wide PM,
> > similar and consistent to what we did for CPU QoS?
>
> First, I don't think it will be very common to have different *device*
> latency values between runtime PM and system PM, because the reasons for
> device-specific wakeup latency will likely be the same in both cases, at
> least for all the usecases I've thought about.  The only real distiction
> being whether the latency should be applied to runtime or system-wide
> PM, which the new flag provides.
>
> Second, this doesn't have to be in userspace at all, that's just the
> example I used to illustrate.  In fact, today not many latency
> constraints are exposed to userspace, so this can be acheived by the
> kernel API for setting latency values & flags, which I think is the more
> likely usecase anyways.  For example, for a driver that is managing a
> wakeup latency constraint, it could update it's own constraint and set
> the flag in it's ->prepare() and ->complete() hook if it needs separate
> values for system-wide vs. runtime PM.

Right, as long as the use cases can be managed by the kernel itself,
then this should be fine. So, I guess the question is, if we should
consider use-cases that requires user space involvement at this point?

Also note, patch1 do exposes a new QoS sysfs file, to allow user space
to manage the new QoS flag - so this becomes ABI.

>
> Third, adding a new QoS value for this involves a bunch of new code that
> is basically copy/paste of the current latency code.  That includes APIs
> for
>
>   - sysfs interface
>   - notifiers (add, remove)
>   - read/add/update value adds a new type
>   - expose value to userspace (becomes ABI)
>   - tolerance
>
> I actually went down this route first, and realized this would be lots
> of duplicated code for a usecase that we're not even sure exists, so I
> found the flag approach to be much more straight forward for the
> usecases at hand.

I understand your concern and I agree!

However, my main issue is the user space ABI part. Is the QoS flag,
that patch1 exposes, future proof enough when considering user cases
that needs to be managed by user space? In my opinion, I don't think
so.

Kind regards
Uffe

