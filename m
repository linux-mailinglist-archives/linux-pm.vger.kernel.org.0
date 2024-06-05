Return-Path: <linux-pm+bounces-8657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF88FD47C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 19:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886011C21C8A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8293194AF1;
	Wed,  5 Jun 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2L9VbUp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F945194AE7;
	Wed,  5 Jun 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610258; cv=none; b=AASIqix5AKmVfRjNaZARJJREq6mKe7IqLGlQXnqa3wP7z8o/9v3z/Ad1uhwDbvxk8X8QDEqbLNsnM5qkdLhs+sGdTXFy3/O/5TJtKv9tT6xRIOY4/5aFUHVwVtFCBz4yqR3Ck3LNJchxeYiBSUqv8UiReeb70TtulJf4Yamtec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610258; c=relaxed/simple;
	bh=5xiole/Tr3AD+9b0Q/wOoCRfWiyuQJRvDEkgUsd3gyg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jl34vOlFsOuMjtXuH+FWpUwf/mHNG3w67TntDfFqmrRz6XFSNDlDXHqdREi4CcfJq9KhekUOsWcsfSxH4zk9Od4aO3QHkKGOfKU7kmz5X06D49QNQccfJxeppZdPNzw6KrpoI+th0rJNWGUfcNWnZCDEXK8cGWWMTG4QUA74FkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2L9VbUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112AAC32781;
	Wed,  5 Jun 2024 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610258;
	bh=5xiole/Tr3AD+9b0Q/wOoCRfWiyuQJRvDEkgUsd3gyg=;
	h=From:Date:Subject:To:Cc:From;
	b=S2L9VbUpLkXkuWlvuw1svpdrFnnMRmPY7V5Lum1aOxruIyiBsWztC1GlZsSa3dwAj
	 qo5aKN4zHZrBVXd3R+1e/a0m8+0PNQgkKb0OthrcBwvBZKX1nrO+nL6XGxE6mWBuef
	 iGY9kUeKLlp7Ts0zZQLNmMT0fGUB/31psNycdKv3tHP1qNYjwc0b8W8/pbJdcbBIHr
	 aIhZQEBrfpdE5eRYql4LYLIcAbQYPTQHm6zcMWbb+7a7IhJvY5WQGd4Vj5vYqigzkZ
	 rzSTJIM2Zv5/LD2XmRkWI8tiToe+EJ9HJJKJpP/Wrlzg3ygaOTkAbOaWxCYQjc48ps
	 BSRQ6CJ7YumXA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f9391798eeso4631a34.0;
        Wed, 05 Jun 2024 10:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIGJ1MN+rOjPVg/QZbWCGRONzN4sn7rSXgXUUouBjn7Y4/81caWJ6G+ggBvMLWxjIaI3jBLCMFpeRiarET+rEoKw/qhMemYyQtIFE1
X-Gm-Message-State: AOJu0YxR1c35o7DpQhqtynFKXznIztE3MEo54J5V+5oWXck6bA56ilRu
	mqJbk5VSk4uPD1jgvsj7zAKIXVLVRUjRgOzkM0mNDypbw4IuxIVU3l9WP5Ec4ce/zUaDMUXbBGW
	x5ZmLCMJSumYFbQtTAzWhGvohT8A=
X-Google-Smtp-Source: AGHT+IHdcc9QK+373wV85FKkZ3g8ff5pvF1JaFH9USZN2Kbj0yVAXLKtMjxReXDt7gT7jiivWctxeXO4YduU9zV9Y9g=
X-Received: by 2002:a05:6870:c6a2:b0:24f:cabc:4fa3 with SMTP id
 586e51a60fabf-25121872124mr3693741fac.0.1717610257244; Wed, 05 Jun 2024
 10:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Jun 2024 19:57:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5oMnhKttGUxwxAXWC8Q+_0e6HUjTFCumk8WLk9zNRRA@mail.gmail.com>
Message-ID: <CAJZ5v0j5oMnhKttGUxwxAXWC8Q+_0e6HUjTFCumk8WLk9zNRRA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc3

with top-most commit 9b7e7ff0fe44bc6e571ecddbd76fcea7498033c1

 Merge branch 'pm-cpufreq'

on top of commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

 Linux 6.10-rc1

to receive power management fixes for 6.10-rc3.

These fix the intel_pstate and amd-pstate cpufreq drivers and the
cpupower utility.

Specifics:

 - Fix a recently introduced unchecked HWP MSR access in the
   intel_pstate driver (Srinivas Pandruvada).

 - Add missing conversion from MHz to KHz to amd_pstate_set_boost()
   to address sysfs inteface inconsistency and fix P-state frequency
   reporting on AMD Family 1Ah CPUs in the cpupower utility (Dhananjay
   Ugwekar).

 - Get rid of an excess global header file used by the amd-pstate
   cpufreq driver (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      cpufreq: amd-pstate: remove global header file

Dhananjay Ugwekar (2):
      tools/power/cpupower: Fix Pstate frequency reporting on AMD
Family 1Ah CPUs
      cpufreq: amd-pstate: Fix the inconsistency in max frequency units

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix unchecked HWP MSR access

---------------

 MAINTAINERS                                     |  1 -
 drivers/cpufreq/amd-pstate-ut.c                 |  3 ++-
 drivers/cpufreq/amd-pstate.c                    | 36 +++++++++++++++++++++++--
 {include/linux => drivers/cpufreq}/amd-pstate.h | 33 -----------------------
 drivers/cpufreq/intel_pstate.c                  |  3 ++-
 tools/power/cpupower/utils/helpers/amd.c        | 26 +++++++++++++++---
 6 files changed, 61 insertions(+), 41 deletions(-)

