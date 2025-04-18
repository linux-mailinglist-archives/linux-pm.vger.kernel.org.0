Return-Path: <linux-pm+bounces-25730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C9A93E50
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FF7AB545
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629E222594;
	Fri, 18 Apr 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5GOc5Uq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A921B9F6;
	Fri, 18 Apr 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004894; cv=none; b=pUPnIaphco8c7xfLGGHaiuaZNI+9lJG2VYyFAjcMUE2+eA8r5/e06eINEeYJG1dGhPJc2IFhepeGezrIMdrhPtILoAHQGC8c5+yCtY1LdY8odGctommr+ciJHePX3ATXaR05XFOAucVF5J7bypLq9L+tSj9/C4K/4dOGmYnR+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004894; c=relaxed/simple;
	bh=D8m5IPnuunszki8NJ2mw+YgYF9sNi9cD+xFlnwIoFPk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tdzSKe+uQQdfboIbkRpOKg04/GH+ZZxQHEhP7jJM8Xs8CwH6gLeEEhn6dG0Rejv6ZxbykLJqkEfvLW8qw3YwlcufHGuNIbMLoeZjHhrQfUieGJicYL9bgBvf+0z0aopBRIJOxM+dFnGbU8dEigrk5d/SYa97hQ+EuAuQEPdO2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5GOc5Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE2CC4CEED;
	Fri, 18 Apr 2025 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004894;
	bh=D8m5IPnuunszki8NJ2mw+YgYF9sNi9cD+xFlnwIoFPk=;
	h=From:Date:Subject:To:Cc:From;
	b=s5GOc5UqpbAZJ6yeoeLm2p5YBjwHZzDz3FWEValVns6Pq03bSGo8675YkItmnqSJu
	 9EJ54yuXHDTUAz46wYeHHQMU628RoGEodMpuPfJbBTGFZgDrKSGyTe7Zj6zwI6KfNs
	 chLa1hPe21Rj+fLIpdGQZ+f/fOC8vS95tQIyoSRWpvN8omQVwgm860DU5wxpruDczl
	 g2uOUvs+/mLIYvikTC/JxjnnO0V6otQG33vSovcMGCHLrvj22q/HmSCwuRTs9VH/ML
	 h7aFz5LVokqIbYTeV5Zp3sqPX6K+RH757alKlbQeP4P4PzUgc5Gdl88V8T1On0UHXQ
	 jYAVf/MUjI1pQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d4cefac09dso1119378fac.1;
        Fri, 18 Apr 2025 12:34:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXhXHu6hO8a4Ku+C1+CmX9KIYdA/npky4IxHT4J/VVcmE803KmiGeiC2ygpxg5ge59BXBQeWP/Oo0Q/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ytBeNYEJ3+meQeluV5pIcuvD8S09j8z0sZwBOAUu0uWizsll
	KjTnFTT8VnhYjh5O5yEESLw0UatF4h8DH3xHQtopAfrWA8AiWOuU8VSAwMEENZlAG/uXlgztc/d
	kLr2LwzQuvCpscxjkka7NOHP7Iww=
X-Google-Smtp-Source: AGHT+IHW3iP4kJAr/pcDAM/ZZvmI/9RtNQMnecYdqqE4hxOh3pu1WQOqTPn9/BXCQJTBaSYjsKZc4Kngg+tuAuXyVYk=
X-Received: by 2002:a05:6871:7a0c:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2d526e0ffc6mr2325277fac.35.1745004893459; Fri, 18 Apr 2025
 12:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Apr 2025 21:34:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imoR19gyH+DKR2CXtLeQEdbKYNWkur_7tjf4a4NQRLMg@mail.gmail.com>
X-Gm-Features: ATxdqUGmbx4Zd3KgG-eOxX6uBlHak2_8hTfeIr265Mhr7I0Wz-uUusofoDF-qkc
Message-ID: <CAJZ5v0imoR19gyH+DKR2CXtLeQEdbKYNWkur_7tjf4a4NQRLMg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.15-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.15-rc3

with top-most commit 00c5ff5e9a55dca2e7ca29af4e5f8708731faf11

 thermal: intel: int340x: Fix Panther Lake DLVR support

on top of commit 8ffd015db85fea3e15a77027fda6c02ced4d2444

 Linux 6.15-rc2

to receive thermal control fixes for 6.15-rc3.

These add missing DVFS support flags for the Lunar Lake and Panther Lake
platforms to the int340x Intel thermal driver and fix DLVR support for
Panther Lake in it (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (2):
      thermal: intel: int340x: Add missing DVFS support flags
      thermal: intel: int340x: Fix Panther Lake DLVR support

---------------

 .../int340x_thermal/processor_thermal_device_pci.c |  7 +++--
 .../intel/int340x_thermal/processor_thermal_rfim.c | 33 +++++++++++-----------
 2 files changed, 21 insertions(+), 19 deletions(-)

