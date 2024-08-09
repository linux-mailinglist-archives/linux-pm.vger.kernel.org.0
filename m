Return-Path: <linux-pm+bounces-12052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0AB94D533
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE11C1F21E74
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB539851;
	Fri,  9 Aug 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2Sa4pzF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253738384;
	Fri,  9 Aug 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223250; cv=none; b=Q739Kd+obvMDJ9xgCVuOs3YjB+54WEpb/eS/WNvjHS4IPrbLvJzOcq0VxHt92sZvGmS3IpSU+E+Q4eYemt8fUR9M/izgMq58/gLlNP0RyR0TesaxXONMQQEbmIBa/YyKn/2EHj2+EV1Tw5oAGW7ASQhjF1lmcQrdpuvgfP+Hwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223250; c=relaxed/simple;
	bh=D87Xvv5zzjUUJIAShTieZ41cpIJJJC3gxx7ySPgrPAY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JMOMVNgYiYyuHI7twYWkBfIdJNJRqvu0EJcQ+QVXa2vwxVJFqeVZKkxuHUJDrYBJa27ZKqEa+6kTiP5Zotxq4HKYnO079ihlaMGX9Uf9ljiu4nOKAEZC9p9ECxT/UHZ3nWWp31PErG0SgS51KPgKmNffpMNjDsiVqQx1Lwk7flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2Sa4pzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8517C32782;
	Fri,  9 Aug 2024 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723223249;
	bh=D87Xvv5zzjUUJIAShTieZ41cpIJJJC3gxx7ySPgrPAY=;
	h=From:Date:Subject:To:Cc:From;
	b=h2Sa4pzFFFaDHf3OGLhaLhjrMivavcHLEpsgWNhXeKSHtYELKTKVAMMEdnMzGFY7Q
	 5PvsiO5BeLxAjVineP59WbuD6qsmiUu7GJCx0sOntIGm9jn96Sthroll2VH2ynwOj2
	 C7YsnJq68E8lzJ2NObZ2ZbYaT26DxI3hisOimm9yt7QTYixH7ZYZuEVVbwEzSGxXQt
	 bQ22BjKKy1Nzh3N7zVvJqvZ4YB9hvWnoZprsui5LPy4UuvlV9B/ELpbC50Bmo705e+
	 I4K2IxR4YtjaFjqdZqdfeuxjorqsPYYP/euIvr+y5H9RWm6siPAVc30tx8zGYBjy+O
	 S/5U468qkIpzg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2635abdc742so203795fac.2;
        Fri, 09 Aug 2024 10:07:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAVrQH0bjrWyqca2DmAAdHPL7Lude2m78nHyN/EW3V+Dc/SJtCiwb9zUTkvQTUaAClETHDPIFGOYEbqXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/Mz16ugzkeDiCdbxqx3UfoP2z3mERiEuLfxdUa5/WrHyyQJ5
	jZ8XJdUESfBVlsA0NhMLCglrPal5AX0ti9MYl6ox5PdkVSN7JiCIY8eHlnZWOvVXtnz/yaI3qWX
	KNCQRC2PMelzI+jqOu6ZAXJKHOos=
X-Google-Smtp-Source: AGHT+IEMaQckbjFpW4mzMm19HAYdTOGyW0qGqJCz+MCxd4kUg1qZb3VGrsbmcNOLgaQ4HDWnAhB5TlXYbxyTxL422lw=
X-Received: by 2002:a05:6870:b015:b0:260:df6a:28ca with SMTP id
 586e51a60fabf-26c62f1e92emr1713774fac.5.1723223248920; Fri, 09 Aug 2024
 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Aug 2024 19:07:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQ3O7E3ygvFKbzjkJbx7pddyD9Qc+rE4EFYzJS12oTMg@mail.gmail.com>
Message-ID: <CAJZ5v0hQ3O7E3ygvFKbzjkJbx7pddyD9Qc+rE4EFYzJS12oTMg@mail.gmail.com>
Subject: [GIT PULL] Power management update for v6.11-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.11-rc3

with top-most commit 64a66f4a3c89b4602ee1e6cd23b28729fc4562b3

 cpufreq: intel_pstate: Update Balance performance EPP for Emerald Rapids

on top of commit 8400291e289ee6b2bf9779ff1c83a291501f017b

 Linux 6.11-rc1

to receive a power management update for 6.11-rc3.

This changes the default EPP (energy-performance preference) value for
the Emerald Rapids processor in the intel_pstate driver which should
improve both the performance and energy efficiency (Pedro Henrique
Kopper).

Thanks!


---------------

Pedro Henrique Kopper (1):
      cpufreq: intel_pstate: Update Balance performance EPP for Emerald Rapids

---------------

 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

