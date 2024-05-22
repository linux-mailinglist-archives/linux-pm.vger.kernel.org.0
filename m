Return-Path: <linux-pm+bounces-8034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8AF8CB8B2
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 03:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A4F283BA9
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664128EA;
	Wed, 22 May 2024 01:53:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C894C6D;
	Wed, 22 May 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342792; cv=none; b=l8ltJlx7Ans5eYWCgXJziW8hMxV9gFVeWK3h+Y7pHQuuk3XoNH8Dh+ElzuhsawAx9/jOur3zpD8vc/83YVs6Cr5ViWZF663/fKDtfb+eVIJ7oRJmXCXPH1K/8wLGclCunU9jgoLXynXPBU3GdkSMOgcS0YizInkXnu1b/oGe6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342792; c=relaxed/simple;
	bh=QzOuKU9c0vwtW/Ze84nja4TaK9d5djDTqJ5gKBV6pYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNzzLhgHDOHYQc59KX2/gPpygusgNw9khmIcesN/KPe840YrBxwlAyZaQJt8wrr2D9HdKuGllVJ3YTc5/ouH0qANLhrtM/eaE8wxAcxt+z+TEV4qhPhYNXcJNYOoBuYqd29Mbyq4TBfs1MzdxoWa5SFjemN0GfI7BjjrGHnKluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0f252db4dso2302096a34.0;
        Tue, 21 May 2024 18:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716342790; x=1716947590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt27wWUkwaxGWYZV4sI8tjk/fi7z2Y6g09AK4Fz8+fE=;
        b=FvUXLu+beIH9llgTVX7B1psKZzUZBUrDXPd/rDj2WMYXq4hmalxEXpIAwujvt6HOI2
         MVT/plS7bz0XxzqUqTxJ3NOrllnjeF/oBKuhBpwJ5zbJ+Xacgw9JbA7lACEMmuqDpyl0
         s1UThm54sWJxvBhjTfb0pS17/8LkE65YG5zXvX7IRznpNwPGCxb3he6PSSGmTNRIch8T
         SjUvAdhXO1rLCDyDNCP3PenbdCisxVIIl8BUFjnaxpKMci3FP+iqGiMxz14brSfDBZU1
         sq4ehRqj7OM1Ahu9z6j+6JqONqPX5kO1oR2+OL/JEgTYCaxHBlNb00mtFfADz92NMIA2
         hb9w==
X-Forwarded-Encrypted: i=1; AJvYcCU8TTGzvYWcqTFlKWyy2M4X/ER19UuAkORLzOlCS9gP6NHBywvJXt03tAykQY5lbxtstFfQHhU92A2o045CvLWvjTzISmND/MYxZHzrMQ3sgWqJV1cEu1S7xVTIJW26aaM8hBr7pPQ=
X-Gm-Message-State: AOJu0YwkM99APTcmlrIGZs9gDOJexS+thIuDQO9lm1X/hwvyd19U9OlS
	UWO3fdaCu1dlgbT9J1vvqRkRdwzajeABZzorKNtssttHzvcrMJA7YbrV2KNTQzM/Z+oUXnoqWMV
	iuXNngRf0zBPhmyCR6VuTz/i8lcA=
X-Google-Smtp-Source: AGHT+IFLPPilD8pOX77mCzYXmqAPEniDSoE51Dy0+JK+Jl8X4dJbi8em/Dj4jvKF/wF/djjnPMRM9wEBWBapzTKsvEw=
X-Received: by 2002:a05:6870:1605:b0:22e:9e53:3fd2 with SMTP id
 586e51a60fabf-24c68ba6e36mr870443fac.28.1716342790655; Tue, 21 May 2024
 18:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87o79cjjik.fsf@kernel.org> <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local> <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org> <874jb0jzx5.fsf@kernel.org> <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
 <87msoofjg1.fsf@kernel.org> <35086bb6-ee11-4ac6-b8ba-5fab20065b54@intel.com>
 <871q60ffnr.fsf@kernel.org> <CAJZ5v0iHoU7dHxzL5ryehZT7unZiapoiBzPo1d=wsffNGqcS7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHoU7dHxzL5ryehZT7unZiapoiBzPo1d=wsffNGqcS7Q@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 21 May 2024 21:52:59 -0400
Message-ID: <CAJvTdKkR2HarKaU6rnS281=HYNuOpsyBFBdUSNNLzKpWDZ7Lyg@mail.gmail.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 3:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > [  449.061525] rtcwake test 31
> > [  449.176854] PM: suspend entry (deep)
> > [  449.179072] Filesystems sync: 0.002 seconds
>
> This means that ksys_sync_helper() has run, so it blocks somewhere in
> enter_state() around suspend_prepare().
>
> Can please echo 1 (as root) to /sys/power/pm_debug_messages and retest?
>
> This should allow us to see more in the log.

also, it would be interesting if you can reproduce with "rtcwake -m
freeze" rather than "-m mem".

For we have a NUC8 like this in our lab, and we gave up on running
ACPI S3 on it a few years ago
because the BIOS just was never that good at ACPI S3.  However, it has
been running freeze/s2idle
like a champ, thousands of cycles per week, for years.

Len Brown, Intel

