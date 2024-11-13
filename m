Return-Path: <linux-pm+bounces-17520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639C9C7CB3
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 21:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123FEB2B801
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A82064E9;
	Wed, 13 Nov 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDsArfkf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9C205AD0;
	Wed, 13 Nov 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528854; cv=none; b=NYPe5W3v6TSzyfm9pwxB6qw2gb4RIf7jVeoWM2iwO/qCp/zM/+p4iooSVTkJjKq4c9YLWatFjlMJM2ABW60pvVsTwdcCiS6/PSu37yw7wZOGcNAL0s01UYOT2ONfRfU2s5A/Vsl/Gf2Fq8y54Qz2knryDbxjRJNMWjYXg7dcp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528854; c=relaxed/simple;
	bh=O5m3EjtOgzq+sfOC+2EL4Tg8uOOpfMYbwnysVQWyOQg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cK2+MRz+p43npRLr9g7UxgX6SbRTGDsC16WF9+3++vh3DkJoovwNDU15mF4bwPUBYEfqqv7MIXV4ZbBxZpKqRG0FxYcXMtg3qHYvatW+QJRY32U0l5UHqWzOLY9GVeEgADRfcuLsNVBOnUnAr1pt5rUuFKl+WnEf2qrOrqIebTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDsArfkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B579C4CEC3;
	Wed, 13 Nov 2024 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731528854;
	bh=O5m3EjtOgzq+sfOC+2EL4Tg8uOOpfMYbwnysVQWyOQg=;
	h=From:Date:Subject:To:Cc:From;
	b=WDsArfkfBzHvsGEyuUzy+6z9ZgXPnGzE11PuV9CBt2HekdhpiYLf8K+zY0iuPrHc6
	 vSjLOEcnQtTUqO+TPponsRg3hqoHvlDIAHQ/rR7ixBeslUnAulHie+bdNpp4afEyCJ
	 2v9mVwq5STBgYvK7vMLWrm+jeYYVZhb7phlN103+LFN42K4xJAQQnpCMxduslOT8WH
	 Ro+0H69nQoJ6UPXx+5e3Idaqei1NCGPUXpTQQESgaXZB49XX7f4HStToULOlGSk586
	 ijnxS4VQN3LVosu2HmqwJAOyjoIn6hMGknUvKmcTcaB8EDbCAWCF/yypLuzzY0qqsy
	 91ZJW9i+oe3cQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2958ddf99a7so3147164fac.2;
        Wed, 13 Nov 2024 12:14:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeTlJ60v8061VKr9HyDM8Q6+cXx7b5BuMO/FjP4943OjJ9xsjpE6yEJ6g/95VWnVJsxiGZmkJfRoSSM2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAf3JIeh1hkgjVZCUjRatY1RVXJdmvYj4yCvLw+/WGvCUn6E3
	TarSgH6z4y6IqyO6lrYBD9BkUHzf3MZzAZflD2qEE2LlOGgyY4ALOXr0E0IBdnOp0Td8euBCjma
	Mnffb13XTuuX8VMqyvXNVIKqJYJs=
X-Google-Smtp-Source: AGHT+IHjXfI91anaQFLJymLdLVrjGiR/j7Fc/eL4Efz6BfDcUb223L08Oo24ea9jSGyyypeZkhmCDZM2IbNxjCzaWG8=
X-Received: by 2002:a05:6808:e8a:b0:3e5:df4b:bf4f with SMTP id
 5614622812f47-3e7946a6f83mr21647294b6e.24.1731528853719; Wed, 13 Nov 2024
 12:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 21:14:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jF0bGP5Pb4s6gSiEmoUBNDqBLJMCpgNPmyQRxuO18C1g@mail.gmail.com>
Message-ID: <CAJZ5v0jF0bGP5Pb4s6gSiEmoUBNDqBLJMCpgNPmyQRxuO18C1g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.12 (final)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc8

with top-most commit 1a1030d10a6335bb5e6cdb24fc9388d3d9bcc1ac

 cpufreq: intel_pstate: Rearrange locking in hybrid_init_cpu_capacity_scaling()

on top of commit 92447aa5f6e7fbad9427a3fd1bb9e0679c403206

 cpufreq: intel_pstate: Update asym capacity for CPUs that were
offline initially

to receive a power management fix for 6.12 (final).

This fixes a locking issue in the asymmetric CPU capacity setup code in
the intel_pstate driver that may lead to a deadlock if CPU online/offline
runs in parallel with the code in question, which is unlikely but not
impossible.

Thanks!


---------------

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Rearrange locking in
hybrid_init_cpu_capacity_scaling()

---------------

 drivers/cpufreq/intel_pstate.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

