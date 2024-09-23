Return-Path: <linux-pm+bounces-14545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D868B97E4A7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 03:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C528102B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB810E9;
	Mon, 23 Sep 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg0GCbif"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE21FA5
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055427; cv=none; b=oMSncRAl8za4OYYOtaBRHGvqCcVP5gYDB9kv2dcJx6r49llTprDRMwTRNj/v8P76NJZf0kqtT3rsZFOHQUFQbLQL8AM3kq9jeFPBdZms2wB3EnyKrT8eROwQnEyPPhhDHVIRr8bysaeCTrXM+7x7dkSPJTWuoRB5DLFHwkMA7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055427; c=relaxed/simple;
	bh=ToohoVVZblsFWocL7tFoZKQLIf7QMKSNE0hT12g9lig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABWRHVnzzjH1TEhaZZbRoHR3l3UAkxzndhCwgm36HpDL4V1sg9aMVGbiUp/IXoMQdK8qt2jlotJHXh5ApA5oavSzu+6ffcWVnHHrUXnPICPawUo6Fl5JuY5cSEgmP/TvQrio/Xypf2wnwrn6V1fwoYcClpyv6MXxlEvVbZX1n6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg0GCbif; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7197970e2aeso2592024b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 18:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727055425; x=1727660225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToohoVVZblsFWocL7tFoZKQLIf7QMKSNE0hT12g9lig=;
        b=jg0GCbifDJ1UD7Upn2nY8FfolLwfVXz1vhErglUM7sH0uzeUuHJnLUa4Ki4gE8b3X+
         yVsYvDZDoNuWLF7TxxJLQ7SfKjYs/ca5Pomrh7F8V/kUtt01W6WLWy+aTf/bUdXpBnVc
         P/qKvQ4KyAqi9yNRK5SN/goXOkCucCeUP3Ka6mviLDutHRm6VWJazAT7Crj+/b8y3VC7
         M9dZ9o8No3nKnUWJGKPohvzbOIzcGxOJfDo7gLUK9/5X5pPx8nrZufsRocSXxATDj5fw
         1RBrxW+Df1LFPhh26OxigG34vDAKjcjtiqV7joSB7ixmcs1i6iAEOpHIyycqR4HXjZcf
         vhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727055425; x=1727660225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToohoVVZblsFWocL7tFoZKQLIf7QMKSNE0hT12g9lig=;
        b=FzYwzbQhq6uNMmF7AylD+CFXSdjzJIUbs6UZBlk6Ib6Nu1Y4OGCWu2EGs/gyCGTngQ
         Y+zi33s/YeIxAKc57j7zJ8AMz5vPefckUSvl8DwA1h5KuI/saDheKOYjN5PKZRykMtaf
         AsiGXmJBDOlzNN8tFjayn4f2harZchhzsZ0cga4Aep4ZjiY7W+WUbniO83rEBHAILATx
         X6FB28KhgvJ7nnPqlsJamabGLTHrmfL4stAl6f6mD3/7E1KjWVwn8ZDH9sysRfEAoS6p
         xCaBkeVbGNiiKO2sauLLhvDBuPKpHEjZghpPMCS/wWYlJRHdCNm1QU07P1814ldoNRZQ
         0ALw==
X-Forwarded-Encrypted: i=1; AJvYcCXmqjWqXBjon240KHCJQCzCZvBDCo+qrtfsgoGiDxpTQd7S4Ot3QvKDDVRmm+ocAhdau/arCdrwdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgStyudKtpqVZdIYu2ebMSGzM/WrpEp63NjO39xcHxhB2H0V8j
	fxl5srAp5Et0eyaseKnT4lOk/0D0H10IGtlJ391sbZMOFIECEFfh
X-Google-Smtp-Source: AGHT+IHDifGxpxw841/ppAVZCx/5SoBNQQSwZAysWanCTON8r8C95b2wOB+ckF60hZWe+FjQ7cRL5A==
X-Received: by 2002:a05:6a00:1823:b0:718:d5f4:6e95 with SMTP id d2e1a72fcca58-7199c97ce0dmr13971128b3a.3.1727055425458;
        Sun, 22 Sep 2024 18:37:05 -0700 (PDT)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b18csm12926372b3a.100.2024.09.22.18.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 18:37:05 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Luke Jones <luke@ljones.dev>,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	linux-pm@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside suspend (fixes ROG Ally suspend)
Date: Sun, 22 Sep 2024 18:35:59 -0700
Message-ID: <20240923013657.7464-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
References: <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Derek,

Hello

> It is ok you have upgraded both of your units. We have plenty of
> contributors and users that are not on the experimental firmware you
> are on and will provide ample testing for probably the next half year.
> As the update will need 1-2 months of validation and it is very
> difficult and painful to update firmware from linux.

> As I am tired, allow me to quickly jot down some thoughts so I can
> enjoy my evening.

> I only got my Ally X unit 5 days ago, so I cannot say I spent
> thousands of hours collectively but right now, I am pretty certain of
> the issue that was happening in the Ally units.

> It is the combination of three cascading issues:

> 1) Display On/Off calls are not part of the suspend sequence in
> neither WIndows or Linux currently. In Windows, they are called before
> suspend, and in Linux after. This is a large deviation that completely
> breaks the controller of the Ally. The previous solution was to insert
> a second call to those functions in the middle of the Linux suspend
> sequence, and then collectively spend months fighting with random
> racing conditions. Patches 1, 2, 4 refactor s2idle to make sure that
> never happens again, for any device, including the Ally.

> 2) The Ally Controller has a choreographed sequence with which it
> fades its RGB during suspend. This happens during the Display Off
> transition of Screen Off in Windows. In all of my testing in windows,
> Screen Off lasts AT LEAST 10 seconds, if not more. I had to stand
> around looking at that power light to turn off more than once. If
> Linux cuts off its power supply before that, it gets confused and
> restarts after suspend. If that restart happens during the resume
> sequence, see (1,3). Patch 3 fixes this. This flourish is an important
> part of user experience, so adding a delay here is required, even if
> firmware updates.

> 3) Finally, the Ally Controller, when it boots up, is sensitive to
> commands for 1-2 seconds, which will cause it to restart. Even with
> this patch series, this remains an issue on my device with powersave
> on, while the device initializes. asus_hid (or hhd) will instantly
> send a command to the device on connection, which causes this issue
> and then combines with 1 + 2. My patch series does not fix this.

> 1 and 2 will always be issues for the Ally, regardless of firmware
> updates and probably for other devices too. N3 I will solve through
> userspace + with distribution help, and it is not something that will
> take that much time. Patch N5 adds too much delay unfortunately,
> especially after resume. I would like to see it go, at least for my
> users.

I'm going to be somewhat brief here as I don't like repeating myself, you are
working from incomplete information and from that you are inferring incorrect
assertions. Due to NDA the full slate of information that would clarify this
cannot be released here, but I will be clear: I am not sharing my opinion, I
am stating facts. What you have described here is a missinterpretation of the
symptoms and is not correct. The _DSM call is not relevant to the proper fix,
the sequencing you observe is not applicable to Linux, and the sensitivity of
the controller is another symptom of the Windows quirk behaving badly in Linux.
Furthermore, the RGB "flourish" as you call it works as intended with the new
firmware and no kernel changes required.

What I can provide is information on a test we did that should hopefully
elucidate the issue more clearly for you. We included a patch that allowed us
to alter the delay in asus-wmi on the fly by writing to an attribute in sysfs.
In addition, we pushed the _DSM calls as early as possible in the suspend
sequence. We were unable to find a timing for this that would work consistently
on different configurations. The same issue exists in your patch set and the
testing bears this out with Denis still getting spurious wakes when using it.
The problem with your approach is that you aren't listening to us despite our
much broader understanding of the issue at hand. If this worked we would have
submitted it ourselves nearly three weeks ago.

> Your solution of making kernel changes for newer firmware + custom
> firmware + kernel changes for newer firmware with quirks somehow seems
> more convoluted to me than just cleaning up a bit of the s2idle
> subsystem to benefit all devices, with a little, firmware agnostic
> delay, for some flourish.

> Antheas

Our solution doesn't require any kernel changes for newer firmware, as I
already stated the solution from ASUS fixes the root cause of the problem. Your
attempt at a solution attempts to outrace the symptoms of it. Please don't
mischaracterize my statements.

Derek

