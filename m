Return-Path: <linux-pm+bounces-39678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54CECCD758
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 128143058DC7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102292C0266;
	Thu, 18 Dec 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tafhUpVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9D2BEFED
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088228; cv=none; b=gzz1aGR7p4ADWBUyWhYMeo0XftebVCUQL8A8cnzT+4DD9YPJrCwBPyCPNKZm0otm4RENwwUfiOhFOBHFE0GFT3GWZpAoq7CfU9ANyGS1P2958EhH/0lE3kMB/GrBY0f6UHdr9BTWtNtmUWkfb/YjxV8lWTLGdGv+e3x6emndLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088228; c=relaxed/simple;
	bh=Z4GjH66to/MfPQjd9zYghVaX18oLNYc86Ih0AGtNMHM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bCrivXWYKOdndHiIW7Gn/RLUoiGqGkHABkRUPcDCGzUi5KjwzDflILsgtu7B3oWTuxsM663RJMnrL5oNKwm4cnsXYATJopr7Nc+hFGXQlzs2YFBlQAQHvrjnPn4oHRR9sLfA+SpqIZNEuxm37EEbe8HRmtK4qpbSJXgZplVyudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tafhUpVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED0C4CEFB
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088226;
	bh=Z4GjH66to/MfPQjd9zYghVaX18oLNYc86Ih0AGtNMHM=;
	h=From:Date:Subject:To:Cc:From;
	b=tafhUpVYq599WjCT3SdxUaCaktHNsXXIXI2dPkA5ptOp6TNItO5ETTMRVz3ARm4Nw
	 QlpimhvWLx50anMcPQx5+aRQHgtP33J3YioGEXAcjhzaWpi5hYZCtuZZlDl5kb+Gys
	 FGvftaAdCW51XUBqJOTSIdXYhvTV5SXGlYgZX7rkyfCu2ACfH3hif97bYGlFcH7rLe
	 EeVL2ockcwxR6jlraX3/GgDqdHVHc7i6OYtLEV8zIggH59W/07unJTc09EpFiXUXIK
	 txOuYhzuDxhnrFunzxTzp/VUNQEJOiuFIYXodJbweV5BEL/LhYYpTu8tS4v/iG/clg
	 jaKlNIkVlN4AQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-657523b5db0so302988eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 12:03:46 -0800 (PST)
X-Gm-Message-State: AOJu0YyRZDJg8cI81YjV1NIPC6hQGLO6huOqnSBKAPWwY7km/nK+U5Tb
	OXtJwXVh6CZGxFxq/bPMfeqhn6sC4iU/3Wlj9PkiyhuqhhvY0MSPof7tNg1yrjlPa8C7rx9n5Tq
	IBuEPlVVwU2+6k13g3NK03DWnTf/go7Q=
X-Google-Smtp-Source: AGHT+IFB3j9XgbBE9NUQXOeJY+3dIvEzP3N+Fa1fgAjTvaYjkNrTVMm7hVQ2qbrQfx+WNLnIp2WclRDrQLM+4bneWuk=
X-Received: by 2002:a05:6820:2229:b0:659:9a49:8de9 with SMTP id
 006d021491bc7-65d0eb1f829mr269945eaf.43.1766088225581; Thu, 18 Dec 2025
 12:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Dec 2025 21:03:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0grcSP=+3LZha+CDUJM4w_bou8y3d=y9x3xVsAKh5p1pA@mail.gmail.com>
X-Gm-Features: AQt7F2r0Pf824bPPoOxpFPPWPpoxm7xuWxfe9C9rSHVqClGR2a7t8EYcpvQq85U
Message-ID: <CAJZ5v0grcSP=+3LZha+CDUJM4w_bou8y3d=y9x3xVsAKh5p1pA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.19-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc2

with top-most commit 277141a897c715e787f6c51e5db32f2ca90b00dc

 Merge branch 'pm-powercap'

on top of commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8

 Linux 6.19-rc1

to receive power management fixes for 6.19-rc2.

These fix three issues in the power capping code including one recent
regression and a runtime PM framework regression introduced during the
6.17 development cycle:

 - Fix CPU hotplug locking deadlock reported by lockdep after a recent
   update of the Intel RAPL power capping driver (Srinivas Pandruvada)

 - Fix sscanf() error return value handling in the power capping core
   and a race condition in register_control_type() (Sumeet Pawnikar)

 - Fix a concurrent bit field update issue in the runtime PM core code
   by only updating the bit field in question when runtime PM is
   disabled (Rafael Wysocki)

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: runtime: Do not clear needs_force_resume with enabled runtime PM

Srinivas Pandruvada (1):
      powercap: intel_rapl: Fix possible recursive lock warning

Sumeet Pawnikar (2):
      powercap: fix race condition in register_control_type()
      powercap: fix sscanf() error return value handling

---------------

 drivers/base/power/runtime.c         | 22 ++++++++++++----------
 drivers/powercap/intel_rapl_common.c | 24 ++++++++++++++++++------
 drivers/powercap/intel_rapl_msr.c    |  4 ++--
 drivers/powercap/powercap_sys.c      | 22 ++++++++++++++--------
 include/linux/intel_rapl.h           |  4 ++++
 5 files changed, 50 insertions(+), 26 deletions(-)

