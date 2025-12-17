Return-Path: <linux-pm+bounces-39654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47753CC84C6
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 15:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A1923006FF0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6837A3FB;
	Wed, 17 Dec 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC0YyNQ9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5Nzx1ma"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35833BBBD
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765983230; cv=none; b=P/lF1j6lCS9Vpfch7UGf7wqwaQU8ZX3RUv6tWhtn78+Sy6p7HQ04pM2RrcNvXilDCF3ugvqFRYlwpdygDksB+ETy5n8Pnov3sSHGDyCCQZfh+N/nx/KExch17QNSXWTbqUBjYWC6PtFbBNXBGOBL9MfkWF2v6A3SSYPgzU7QHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765983230; c=relaxed/simple;
	bh=bpn6PnaPqjW9QoU4/thXPDyr0QvWsFZ2GeYnd3BcwnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z4HjwlByjMgGsjZr+5KfyFfRzQcj8qZ2uk07JT1yUWqSxDEzzUWUtoUi6Me0AkpobJAUJDq2X/EvEy33qZ4qgVv/vN4aJX3FkTW8YhnazyUVLfcBi0G5mMG47mx+hlWifkUmFYT7S0cgfsLSv21yN8F8x7ACgb6RaMighV+fYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZC0YyNQ9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5Nzx1ma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765983225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
	b=ZC0YyNQ9V9ZD91m1EM3CjM8Ent+utrOzxWZGEfZnzl7YgHpWWn3yfSVZq0HW4Lg1adSher
	LrfPlvRFZp8DPUy6A2cviUWN8QV+1F8D2i1k0hNeYtk9HR4w8Ffi4h/IgzBubWGlMi5GCU
	T84NqZZornPFzKXBlbW+xijjgoETSlU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-EhMlHMxvORq45MX8PexmbA-1; Wed, 17 Dec 2025 09:52:54 -0500
X-MC-Unique: EhMlHMxvORq45MX8PexmbA-1
X-Mimecast-MFC-AGG-ID: EhMlHMxvORq45MX8PexmbA_1765983173
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43102ac1da8so1939913f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765983172; x=1766587972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
        b=C5Nzx1maGLs5yDsk7rp14VAr2xazEckdDnMCe3/WhVl5h0TffB+3OvRcX33QsZXfAe
         UrmYkp6BTztJ1b4F7C9pgNPK9gyQkrxYF1WWPxFIrgXVIRzz/LqftSpU6dhlQ9p0M/Wt
         97WkWZDiv6A10ECD7OscrtwREwiiLAg7cgyVJfuSCMQIXHOP2G6dtK3GAzQXZ4QKl3J0
         4VKQcAf/ulVSoYF4P8bMMDUIhhasg+A1hqulCZbMrBZ32bESm7JW/q+XcBJs/sCBo67p
         FTwezMZM8nIKOf8xmFgN3sJmChd6iQTLXN1Jg87MoMX76FZrryKWgG1Gbd0GmMrP9Fs0
         bjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765983172; x=1766587972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwTEyD7EyX3W8awcOGf5hUhLWAjEt5Iu/15FJwOP12c=;
        b=kHQwn6Go6W64Ywg3oPON47v9ov0iBbtxaYFfUFJ3NEAmZmI49LGojpLKUMj2hbAAuR
         jDwQainiahXNHG5ZBXgACrnppUWlikffocqJT8P7lzxANiuBOecJe0s5mKHFU9oyvIDW
         n5+XyfN2aiAiGRJBCxXw4CbuskQoMcYbWIUFsQHWkBLQTDWh9v06B+islSoWj1kXjq3w
         LYLWkU/gDzYo4DU96Z0/HBf2RmjT1m+HzLNXRYemu82U6HjxlTZm+y4ExU9Wz3YQJRGX
         hqxf//GerMkR4o6z/GfjQXnLKWtetLrco0MvQAjplbP3uUSP9iAXToZjIXxeIYHBh8pZ
         /kLA==
X-Gm-Message-State: AOJu0Yz7GM2Qrj599qVAY21SjjXSGDzk+DOe5Q4uf7ABmp3WJnJWC3+U
	kYOLpzg0E783cwCIeBKzE8lcqAJgVKN5SMtuNXiy6VEqNW4d+Y6mwEHT/thWr5aKMn48MMnozkl
	ZBa+Bu9IU3M0aYC9GCnGZRazJPWfJCxrXd2DrJr6ewjOgqUXn4gZxRwmn88xSNiM9SxH0YKakY0
	q02aag3SboQiT5KgGAs9UbSYkZldmeJjQPTRzA/PqXlCl28DI=
X-Gm-Gg: AY/fxX5w3PIptU8mMmSxBCg/5BvL1q2K+9S9uou6eUlbl6A/lmoe/yX2fl3XGlerbY2
	4XxiCuU5TlYsFSaRcI+vSeEBjkch4BP2TN84OOZcafhH1ZofuBR3NdEkQjP9D0XBPH6MOnzpfdG
	ayWy9w5vqJ6yVKM9GOdULDIo5IUrAC4gL/ejR7//0aSubOocvev1qhOAvWg2n0ZL+yAmvGkz3so
	bJT/biE+M9okCaIvKdj8OMf+GjxSKqihKLzp0YgzNl+K8/DlfCet0fwHn58iBluaQv6+orfrU9O
	+WStEQOKOOc38sbMO70FVKtHnAL40n7TAJMxO6Ctw8Jm22NEP7KParUSD0M3CBabM3tab66uozL
	9X4PHlsXcjF4SZIT7OGzaDq5YmT+8wG80apeCSce+
X-Received: by 2002:a5d:5d0e:0:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-430f3ab5950mr16820309f8f.48.1765983172434;
        Wed, 17 Dec 2025 06:52:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLP/5gl/yOSrne+8o7qzbeeGelDz1lhEWbsMui55R/X+/B6Wtdik9SdMqV5CH1CuwyFBA5SQ==
X-Received: by 2002:a5d:5d0e:0:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-430f3ab5950mr16820278f8f.48.1765983171865;
        Wed, 17 Dec 2025 06:52:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ada846bsm5103573f8f.9.2025.12.17.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:52:51 -0800 (PST)
Date: Wed, 17 Dec 2025 15:52:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VIII edition (OSPM-summit 2026)
Message-ID: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
edition

April 14-16, 2026 - Arm, Cambridge (UK)

.:: FOCUS

The VIII edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. The summit will be held at Arm in
Cambridge (UK) on April 14-16, 2026.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

I   edition - https://lwn.net/Articles/721573/
II  edition - https://lwn.net/Articles/754923/
III edition - https://lwn.net/Articles/793281/
IV  edition - https://lwn.net/Articles/820337/ (online)
V   edition - https://lwn.net/Articles/934142/
              https://lwn.net/Articles/934459/
              https://lwn.net/Articles/935180/
VI  edition - https://lwn.net/Articles/981371/
VII edition - https://lwn.net/Articles/1020596/
              https://lwn.net/Articles/1021332/
              https://lwn.net/Articles/1022054/

.:: FORMAT

The summit is organized to cover three days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

- Power management techniques
- Scheduling techniques (real-time and non real-time)
- Energy consumption and CPU capacity aware scheduling
- Real-time virtualization
- Mobile/Server power management real-world use cases (successes and
  failures)
- Power management and scheduling tooling (configuration, integration,
  testing, etc.)
- Tracing
- Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

.:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation use the form available at
https://forms.gle/dR5FuzQRFNXZEQBb8.

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

The deadline for submitting topics/presentations is January 30, 2026.
Notifications for accepted topics/presentations will be sent out
February 6, 2026.

.:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 6, 2025.

To register, fill in the registration form available at
https://forms.gle/TZwvdg7196G5CWyH6.

While it is not strictly required to submit a topic/presentation,
registrations with a topic/presentation proposal will take precedence.

.:: VENUE

OSPM26 is hosted at the Arm Cambridge campus (in Cambridge, UK), in the
lecture theater and breakout area. We appreciate Arm's generous support
in providing the venue.

Although the event takes place on Arm's premises, it is fully
independent of Arm's business operations. The summit is organized by and
for the open-source community, and everyone is welcome to take part in
an open, collaborative environment.

.:: ORGANIZERS

Juri Lelli (Red Hat)
Dietmar Eggemann (Arm)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)

http://retis.sssup.it/ospm-summit/


