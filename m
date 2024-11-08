Return-Path: <linux-pm+bounces-17229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBA9C2603
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 21:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8807283D62
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F51AA1E0;
	Fri,  8 Nov 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqHtF3Xd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284A199FAD;
	Fri,  8 Nov 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096134; cv=none; b=MKmFGzBDuD31xi5ify6SlqlVXKwVgF0BtnKLtFGJkoFU2ovSbH7KHST6TV/1q89imKt3YCcU+T/HDscOZG1+tZSwGmJ/Nrw9pq91ldWkVT4xgOfptHO2VjY28B0n0I8EB4M82NnUT6G/RrieE433+R0eLJwYRADHcWoTkykueQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096134; c=relaxed/simple;
	bh=IiGK0LHHX6RUybvgqV5nuFEKCrZOZl5+t0SvjIYc6vw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dpHq9wTmifTEoLjd7X2pG4i/Ny8aa17dz4UtEtmgKEBiQE5CRQ/3GrYwWLXRsXwFbKX4qGT/eoiBaSDO7NKzz12wP/xzm55Ye6vHMnOrVlPlGjzNLBHjzU3eP6lW7fF/S3QU3rYEfjZgGxyDdDfrwVOAVwc6E17jkCQZUsculfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqHtF3Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A616C4CECD;
	Fri,  8 Nov 2024 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096134;
	bh=IiGK0LHHX6RUybvgqV5nuFEKCrZOZl5+t0SvjIYc6vw=;
	h=From:Date:Subject:To:Cc:From;
	b=DqHtF3XdUU0jyifBi/N10jB00cc/s9Ea9JgcleoBWNgq1xwlsJsFiO7OqCIxTYPOA
	 SoO8/u3DFEftJV2V1CX/xoX4YdQhJ8lrhvM4cnF1GU3phTb2wvy0Q5qhiNwZDxipfL
	 +71mZRwxrGdDK4sdMXNflGcgk/FzhajFW2C/J9F7NN116HFlmsKmx8sbkLYaojxc7Y
	 vUtxKt7fNCi6tZkgLZu6iItF+VtGbc0NBOORCHnlymofHM9EPKw0p7s19fbpzcTQq7
	 vXTWPA/hjHF+2eN040Lv+A5v3hmu+DkGxcLvkVuQItuEGi/k4t9xGLbOLHUnKfl8VF
	 5Nve/05oXcSqw==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e9b4a4182dso761517a91.0;
        Fri, 08 Nov 2024 12:02:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWF+B/C8pIUeDwFbJDKvG9XJQM26XoLdI97dk/xuGNZFqxDv+rQIsJhy+itUdJq5wgO0dxAy96HK9MbkDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe58SIbXst9YY3hZXxQc9HYwlXkkFDd7Bbkr62Rqm6eL1Ay1YC
	+/xS6TZ7NQO+roc0QWDjL7ngZD9TuJa4UbEfS2HsDMG90RypEZvdIgBWcXyzvfLfkcRJSJaUcqF
	m1ZOac687fFUg4Ewve3bXAmXaJbI=
X-Google-Smtp-Source: AGHT+IHjSGMCcWX9ZXitHft468If7SJgcPpj2MGee91MKiVkKuJXCqNP8LqSOW6owU74l0Tij7EHkushPrjGie781g4=
X-Received: by 2002:a17:90b:544b:b0:2e2:c744:2eea with SMTP id
 98e67ed59e1d1-2e9b1f61091mr6651907a91.13.1731096133642; Fri, 08 Nov 2024
 12:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Nov 2024 21:02:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hNWYWG78+Y3EYSMkf4=mXB+2yS2QwNQ9Whaic48jLEAA@mail.gmail.com>
Message-ID: <CAJZ5v0hNWYWG78+Y3EYSMkf4=mXB+2yS2QwNQ9Whaic48jLEAA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.12-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc7

with top-most commit 92447aa5f6e7fbad9427a3fd1bb9e0679c403206

 cpufreq: intel_pstate: Update asym capacity for CPUs that were
offline initially

on top of commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230

 Linux 6.12-rc6

to receive a power management fix for 6.12-rc7.

This fixes the asymmetric CPU capacity support code in the intel_pstate
driver, added during this development cycle, to address a corner case in
which the capacity of a CPU going online is not updated (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Clear hybrid_max_perf_cpu before driver
registration
      cpufreq: intel_pstate: Update asym capacity for CPUs that were
offline initially

---------------

 drivers/cpufreq/intel_pstate.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

