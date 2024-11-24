Return-Path: <linux-pm+bounces-18009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A719D776D
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F8D282845
	for <lists+linux-pm@lfdr.de>; Sun, 24 Nov 2024 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841084039;
	Sun, 24 Nov 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="byv2sAVv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB9537E9
	for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473605; cv=none; b=eSpofyjFFsghhUOzlg5yDSN1sEhLXLGS0SsADpfCAKObyJZJEyCCM5q206wiCP3HH9gYP+Pv5BeK1eXYZeySo+E9Vm4Tq3DJfKfyXL74SMXzrd/T9E1XxpGen3CtNwdN/oIMitXQOjnQdTIydU1GB0xZmejbXgdquWLASsHoJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473605; c=relaxed/simple;
	bh=BGL3W5/vBeaWVUeah9ZPAA4KJNY1J0bBjTQbSfqNak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKARJKz056OIeNw2bq9Qb854q1tE2r5P8c2RAsCi/xjqUVVmRxcmJ0mfNj4dnZlwfuxF5d8RbINYi8KPKpY5BnbV8k1+K9KWYJdZYr3a4AYrFgLhJQkwKpQG+SqYpsK7DiUUTiHB/efdL1ouu6I8+4wSckfkiU54f1Etd8wDRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=byv2sAVv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa5366d3b47so153084266b.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732473601; x=1733078401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkxiM7l3p1ivkyG0qCTypzyS+m2SdBc5MUujdpoYpWs=;
        b=byv2sAVvhHlsHP96CoIamB4MEIHM/k1ikF7HrfevwtiineLmbWxZlFgBPBjB99aZt2
         aZaZ6WUuYZBfOVcLJZtu4zsPPl27qU6NHw3ZEaxu0EEeUA01pUph6bl6Dp7LcCJVSWWt
         qw+dLD4keSUOgG3CuBX7CojgTSH07poYb/aq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732473601; x=1733078401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkxiM7l3p1ivkyG0qCTypzyS+m2SdBc5MUujdpoYpWs=;
        b=vm094c3LLLBiE4yYv7s3Mb7YASVdvgbImZS67p2LhDjWF/ME6O1+LeI7tXYnJCFJ+J
         1BEDjqCNgd18EyzCPFCoNxLnf8GsuJK2onOKpisdY7EUtDCRHt3WZuS5tKObhN26Dl0z
         Kfl8pgppeoMN0dcm2mangze88ks/x5c/sH6Yr7jVmt3r1koExD1S88squJdvToLhMvJz
         nkM4YEpKekGc5+pKu2hU2F7hwvsXwxYeJV66XdEb42bcVwnvOJbn3fUwnofItxzAMofa
         sgUgsorfRXKN7McViRC9NodKOtYBftB0gs1m11Dy2g89oDgsgWsQL/WVMbSz5+QNa7Lr
         cftA==
X-Gm-Message-State: AOJu0Yx2aT9E3jzBscIK+s+vt3FNynOLxM2ItqaqctTWaDwyK5TLy9Qc
	MsEJ4NE0gaBPPS0NlscTTJscgYYhOXacogWnPxwnsU78GYqqBWNZozyGRIzgO4GiQ8HqFTPnMtN
	3YL/O4w==
X-Gm-Gg: ASbGnctGIqEbIGVM+A8g756KLy/RKRut84830QxyQBc6pFjRA7ihPpZqWbqNoO7nMCG
	kl19/JJkUGdz+hNPRn2z0krvDUNArEN2wxSMhA3IETRTiIZohYNCiqN8Mausfg7hEk2SDY/f/o/
	va2ky47j7s7N7ssjK9Trr3ICA2ijpR3PionoX/bQf5afOaypYJE/xS10hLFH4PhW8EhOKj4w/CZ
	0O+lGGfG69UpAcbV6CdsatzQ/3I+2bvCSwKF7PHOOS+n+0fdgjdW8PfsDvTP9z0E3ow7evwkgU/
	2jYKnYWuk43HXThhaqGsvGly
X-Google-Smtp-Source: AGHT+IHl6V5/uXq2CZC/OkmLbR8wxS8hC/5vXJ13is9x3GJzCYfQpx0aK1RMu4nziETqzQbrwV4qvA==
X-Received: by 2002:a17:906:2182:b0:aa5:3af9:fae7 with SMTP id a640c23a62f3a-aa53af9fd4dmr425848666b.43.1732473601139;
        Sun, 24 Nov 2024 10:40:01 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm374193266b.187.2024.11.24.10.39.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:40:00 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so2939720f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 10:39:59 -0800 (PST)
X-Received: by 2002:a05:6000:178e:b0:382:4a66:f4ff with SMTP id
 ffacd0b85a97d-38260b5782emr7356389f8f.13.1732473598964; Sun, 24 Nov 2024
 10:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0imu3DZbUb6P=UGP5G9ffxS6MbnRb-2zx7pXNTrxS1Z1A@mail.gmail.com>
 <Z0NeGF4ryCe_b5rr@sashalap>
In-Reply-To: <Z0NeGF4ryCe_b5rr@sashalap>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:39:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
Message-ID: <CAHk-=wje48UTJPEpriFX9A-XjfRUiqeDyEbUEMBnsCJ_KQK-rA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.13-rc1
To: Sasha Levin <sashal@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 09:10, Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Nov 18, 2024 at 11:23:46AM +0100, Rafael J. Wysocki wrote:
> >Hi Linus,
> >
> >Please pull from the tag
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > thermal-6.13-rc1
>
> Hi Rafael,
>
> After merging this PR into linus-next, KernelCI started reporting boot
> failures on a few platforms:
>
> [    6.921489] [00000000000000d0] user address but active_mm is swapper

This is an odd arm64 way of saying "NULL pointer dereference in kernel".

The NULL pointer is in the user space address range, so it
superficially looks like it's trying to do a user access.

People are more used to the x86 page fault error reporting (and
honestly - they are a bit better worded in this case too).

If I did the disassembly correctly, the code disassembles to

        cbz     x7, 0x168
        mov     x5, x7
        stp     x6, x7, [x20, #24]
        mov     w19, #0x0
        ldr     x0, [x5, #208]!      <--- faulting instruction

which does match that address 00000000000000d0 does match "x5+208",
since x5 is NULL.

Matching it up manually with my build (different config, different
compiler, so different register allocation), it's this:

// drivers/thermal/gov_power_allocator.c:527:   if (last_passive) {
        cbz     x6, .L177       // last_passive,
.L134:
// drivers/thermal/gov_power_allocator.c:595:
list_for_each_entry(instance, &td->thermal_instances, trip_node) {
        mov     x5, x6  // _21, last_passive
// drivers/thermal/gov_power_allocator.c:529:
params->trip_max = last_passive;
        stp     x0, x6, [x21, 24]       // first_passive, last_passive,
// drivers/thermal/gov_power_allocator.c:593:   int ret = 0;
        mov     w19, 0  // <retval>,
// drivers/thermal/gov_power_allocator.c:595:
list_for_each_entry(instance, &td->thermal_instances, trip_node) {
        ldr     x0, [x5, 208]!  // __mptr, MEM[(const struct
thermal_trip_desc *)prephitmp_29].thermal_instances.next

so it looks like it is that

        list_for_each_entry(instance, &td->thermal_instances, trip_node) {

with the 'td' being NULL.

The code seems to do that

        const struct thermal_trip_desc *td =
trip_to_trip_desc(params->trip_max);

So apparently params->trip_max is NULL.

That's where I stopped looking. It's almost certainly due to  commit
0dc23567c206 ("thermal: core: Move lists of thermal instances to trip
descriptors") but I don't know the code.

Over to Rafael and Lukasz,

                Linus

