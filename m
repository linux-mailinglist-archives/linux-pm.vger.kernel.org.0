Return-Path: <linux-pm+bounces-15156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AF990A26
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 19:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A4328436B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888450A63;
	Fri,  4 Oct 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPQtlM4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA71E377E;
	Fri,  4 Oct 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063145; cv=none; b=sXvoWmMmzxlpKs5j4hzVly8O9d+ZyrLSTgrJgft/fdKR9YJ7RU6gPE/VxwHQafozzf1f2q03T/22HUOI1+U+GUPtXytLqwkrngXXfoqhlwRopVulIT4wDKbmZH9RRn/K1wznr5k0eZ8D3U/M1pYpUa22HQoYKbQj9P1Rej1nBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063145; c=relaxed/simple;
	bh=E6S4j7kNJ7OyTao/Wjv70tgLWVBOOpujPW8O3b7G7tM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L83ASl+yfaeuL/Qy+D1y3GF0A0F/Xq1F9JCKXjImXjEbSUrqmz52DVaXtxO+i2+FaBsWY1HLyxYW0u/rnswVwMRnTrSUFcdVVk5ANjssFc4lgBnuOW8z0Oj/qp4qy5iFCI8a1ztnChr27Z1VIhFaOLZG9tN8a787UM3sH9M6OCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPQtlM4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857E5C4CEC6;
	Fri,  4 Oct 2024 17:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728063144;
	bh=E6S4j7kNJ7OyTao/Wjv70tgLWVBOOpujPW8O3b7G7tM=;
	h=From:Date:Subject:To:Cc:From;
	b=tPQtlM4rOwj/9Eb58xcc9TeEnHFnU3hfED2wQpb16gUcPhv1SjrK/Pv8Pr6pbc1Bc
	 QYTiEJLln6bXr6qU8eKWHiVeEDZDA0wYB9HKoMRHaIDjb5fA9r8IezKL2HHvg0w6Cx
	 41ehrNyWHrf56fXPnmUDF6hXEw8cFdXTvzSd88TcxFXb8q70X/++dpbGgXcCAbpEf4
	 sKTuNoRBpeLZCudkRXB7K7qipu+sKmabwMI/u8D8We4oWGLwqMafhUv3C74Mn/hnaw
	 Ozd+r5rmbjj34BT2dCDxaENzlNrH/tSIQuCaj0+yXMtg8R+h3js87u9KpFDFWRS7dp
	 hhozDIBIAPj3A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5df9433ac0cso1165467eaf.3;
        Fri, 04 Oct 2024 10:32:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5oCVD0/v1KvFjovLaC4xjaKXPWrPt/cgzijN2mrv96l8QgB0eFINq5JRiXww4re7vx88irp5opQZ0SlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hcCB8IBW5QlfMfqf5qfCZsIsrr7aGBZGD01GLaHElw6Dc4qP
	5idBhI4QnsYOBvlZrXr00FIdniDdfw2UAsMc9Q9yxP+jA4lZFxHFamoeEKX3V3oTC+HvM0cFeBP
	GmpzBt853k/kbp8aCHLonctbI2Co=
X-Google-Smtp-Source: AGHT+IGAyQO8qUNhkUPZ12OHT/Hq1MUggQt/sYBnNIRdMTza4a0E4NWaRbjRQFkReje4txYlLc/NcKB7sOJFmzX7yWY=
X-Received: by 2002:a05:6820:513:b0:5dc:cdf8:21c8 with SMTP id
 006d021491bc7-5e7cc0e7d66mr2622375eaf.4.1728063143860; Fri, 04 Oct 2024
 10:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 19:32:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivLPtX6F3Le9dR6sh+JLHcP7NFVuZpB5ZU8cXz6EcWvg@mail.gmail.com>
Message-ID: <CAJZ5v0ivLPtX6F3Le9dR6sh+JLHcP7NFVuZpB5ZU8cXz6EcWvg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.12-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc2

with top-most commit c0f02536fffbbec71aced36d52a765f8c4493dc2

 cpufreq: Avoid a bad reference count on CPU node

on top of commit 9852d85ec9d492ebef56dc5f229416c925758edc

 Linux 6.12-rc1

to receive power management fixes for 6.12-rc2.

These fix two cpufreq issues, one in the core and one in the
intel_pstate driver:

 - Fix CPU device node reference counting in the cpufreq core (Miquel
   Sabat=C3=A9 Sol=C3=A0).

 - Turn the spinlock used by the intel_pstate driver in hard IRQ
   context into a raw one to prevent the driver from crashing when
   PREEMPT_RT is enabled (Uwe Kleine-K=C3=B6nig).

Thanks!


---------------

Miquel Sabat=C3=A9 Sol=C3=A0 (1):
      cpufreq: Avoid a bad reference count on CPU node

Uwe Kleine-K=C3=B6nig (1):
      cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock

---------------

 drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
 include/linux/cpufreq.h        |  6 +-----
 2 files changed, 9 insertions(+), 13 deletions(-)

