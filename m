Return-Path: <linux-pm+bounces-40781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800BD1CD25
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 08:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62FC530703D1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641736164C;
	Wed, 14 Jan 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsy3RiMK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC163612F3
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375650; cv=none; b=HnCaonqYoOb1valZv+cSN3JYjks2B+1LrF28GCxSU4m4L6fAGBVLpee2CkKo8ZpM8VyaqvjTSdXjZ9Hu5ojzwqI8mohXpSJpKqyY3QGaLoaXelEIC48nkDS6NlBjv02vvXmMAidxQrWPmnWCzPkTgiHolIvSGQ1PnvX/wgsjpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375650; c=relaxed/simple;
	bh=DQUeirNpPP89aLFHeqsLAGeTASvH8cy8TfogQVOev1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+4wiMW063YqPVzkHlTRAW/GZ4oU1LL4ZSu42rAIa1jcJPIb4jMk/2jVPvUtrQTaSCe9itgUB8aMLnE5IG+tvFXhdb00II1s6Smw3WiRQKgHxNz4iy8432ip7XqShsDIRN6ANrF7P3kK6fAejP+SqZnqU1PN8V3DSQoElwukEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsy3RiMK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43246af170aso296340f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 23:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768375643; x=1768980443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iatfbkb039XtZtG7yO5eMvoMHygvxkVJOdhG6yXVCuE=;
        b=Jsy3RiMKatD5gGcBzlt8vZgyZbSjtRMF8NHUerUpH4iSTn7cmUTXXg40ZxLiDVI4S+
         lMU6+0a3Vml9Oh4ebjleWnz1bjJDztZ9k3iAHceao/RIIQyE4Ou6Ago20/rDN2s6xZIV
         2Y0ZC61ca89sSy/eNeTN6tZqpAw4QSkuZX2X3u0JXIndZIppyAP0uZfg4T86VCjy1Mdz
         1GdJif+MPFpHCjjdnTsWlw9oWTmDkgiDNW25tQ5iwWjdEcBTtD9BuycYum9dGuJ1QRVX
         spcA1/CUW1fgVL2W14ffZsgyTWT07+WrJ+qsiNDoScL7QtD8/yR1kDToKCNvB1KFN9wh
         6/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768375643; x=1768980443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iatfbkb039XtZtG7yO5eMvoMHygvxkVJOdhG6yXVCuE=;
        b=sE96y5bCxWpSd/NhrOdMLHK+PmP092rjB5aYbS10efC4kcgwGGsD3W4MpiHTbN/zyX
         GOXHJJzKJwQ24ZXfG/IEAyPpboqX5I3Gzv8x3bFGwlsLzZED0UU8z0iGj2cX8o1ZcyBD
         bxmoqNVizrX7RkeGCtBYqeIFzYtuH1jkPa0O6pc+67cxxt2xtuwjQ1uWX3kKtA7QdYlS
         LB2ioAKckCRSO5pnAwDj8hARck7L94/IaA3UwAwvKwqPnezcya9sZbRkAFbTX9k0aFVa
         T61fOEjhJeJ2u8VzVRPIa+6bthYVuIuuB9Gz6l+VNHhLqGFSsot0+vNW69Sz5UNsldWp
         PHnA==
X-Forwarded-Encrypted: i=1; AJvYcCVEHVs8ANULn6gxm4ATB68ExJt2ZGGO9lfMur5Kpo1WzRW3GCZrwzA5DbBJ6b/C0l/kfN/jRfI69Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmy5NmjdM/Rgtf0E2hGAZ4gwa2IJVHsHfb0u/RDgNoGKyFNzW
	GuVt0/wdMypfkTMqEXI7gXqp+leaQjQD3bBcuClevBD4MGnGJ00FX6tG
X-Gm-Gg: AY/fxX43wkDqBujjtnIt5TNzjU+i8ZQAtr9NiM4dDqddoehifijCuZzpHZfRAsbdfIw
	jUgRZNCiMfy1FSjI7Z+DDk+6l2hkza6H5g1neEgXF+Cj/Tl0ZMO2UrjmwDvFV6DYGK1ztfCUmBF
	OF9i0Lq7zaGC9UX8f6UDedAqwwtqe61Z1SabkiADXaBpuS2CgpTf+IraZWx9t6cCgAE/aNzIhK0
	75kTAGSGlHRNV+eECLuQvf7pO0bh04qfYA1+aZxqGLAjY5GATEX5FS31ev39NxjEk69TqsoNw9x
	acZ2sKJWM+vhZonc+sQiWWx5NJpyZ/qn7Y0FXP5rnDK6pgJtD0l2N2Lv2Yp5prTS3/riao2CTmj
	d6G4dRSpyc9SZPbI4lsCcHyT+jkFN6ny8dszSgkBpXO2GU+GgSwkC2oAyy+J5e6wZY3h8+O7FuM
	sNmq8M2Nk=
X-Received: by 2002:a05:6000:402c:b0:431:66a:cbda with SMTP id ffacd0b85a97d-43423d4709emr6998700f8f.0.1768375642965;
        Tue, 13 Jan 2026 23:27:22 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-432bd0dacd1sm47532193f8f.4.2026.01.13.23.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 23:27:22 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Wed, 14 Jan 2026 10:27:05 +0300
Message-ID: <20260114072705.2798057-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
References: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> Askar Safin requires swap and hibernation on the dm-integrity device mapper
> target because he needs to protect his data.

Now I see that your approach is valid. (But some small changes are needed.)

[[ TL;DR: you approach is good. I kindly ask you to continue with this patch.
Needed changes are in section "Needed changes". ]]

Let me explain why I initially rejected your patch and why now I think it is good.


= Why I rejected =

In your patch "notify_swap_device" call located before "pm_restrict_gfp_mask".

But "pm_restrict_gfp_mask" is call, which forbids further swapping. I. e.
we still can swap till "pm_restrict_gfp_mask" call!

Thus "notify_swap_device" should be moved after "pm_restrict_gfp_mask" call.

But then I thought about more complex storage hierarchies. For example,
swap on top of some dm device on top of loop device on top of some filesystem
on top of some another dm device, etc.

If we have such hierarchy, then hibernating dm devices should be intertwined
with freezing of filesystems, which happens in "filesystems_freeze" call.

But "filesystems_freeze" call located before "pm_restrict_gfp_mask" call, so
here we got contradiction.

In other words, we should satisfy this 3 things at the same time:

- Hibernating of dm devices should happen inside "filesystems_freeze" call
intermixed with freezing of filesystems
- Hibernating of dm devices should happen after "pm_restrict_gfp_mask" call
- "pm_restrict_gfp_mask" is located after "filesystems_freeze" call in current
kernel

These 3 points obviously contradict to each other.

So in this point I gave up.

The only remaining solution (as I thought at that time) was to move
"filesystems_freeze" after "pm_restrict_gfp_mask" call (or to move
"pm_restrict_gfp_mask" before "filesystems_freeze").

But:
- Freezing of filesystem might require memory. It is bad idea to call
"filesystems_freeze" after we forbid to swap
- This would be pretty big change to the kernel. I'm not sure that my
small use case justifies such change

So in this point I totally gave up.


= Why now I think your patch is good =

But then I found this your email:
https://lore.kernel.org/all/3f3d871a-6a86-354f-f83d-a871793a4a47@redhat.com/ .

And now I see that complex hierarchies, such as described above, are not
supported anyway!

This fully ruins my argument above.

And this means that your patch in fact works!


= Needed changes =

Please, move "notify_swap_device" after "pm_restrict_gfp_mask".

Also: you introduced new operation to target_type: hibernate.
I'm not sure we need this operation, we already have presuspend
and postsuspend. In my personal hacky patch I simply added
"dm_bufio_client_reset" to the end of "dm_integrity_postsuspend",
and it worked. But I'm not sure about this point, i. e. if
you think that we need "hibernate", then go with it.


-- 
Askar Safin

