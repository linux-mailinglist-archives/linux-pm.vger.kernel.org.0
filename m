Return-Path: <linux-pm+bounces-39343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D03CAFC96
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015DE3020351
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B332D24B7;
	Tue,  9 Dec 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlZRyWrV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0622288C27
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280140; cv=none; b=achYeubAuoLJ9MSRnQXQg6+nWKL2OAhM6nDpb30LF3jlPATPni28wDkCfLsYIuTcBGyZyYC2V/PJV7HBeFrPMYwmrLBSLZhrgHEsDvwQR1CSoCN6IAnJEHJBOyuJPdjNsptGqo1Apkuz4j8mWvNRAZKtwb0/Ii0Y3wnJGYXy8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280140; c=relaxed/simple;
	bh=v8npctYpvGX4CBErXX+OEIlvdM00kLYgMZzuz/QNabY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R4EReNHNYloe4HcdJGXstBXz9fDfzNqbU47qMa2zATRnBDDPfq45zXt2obcoxmf5vfAEv/mrVQ/ZVOrji38Ma/WeAe7HBzzIGzRzqqAJ55PXJvxnrsEe3Iz8VPqz0UFThT3c6AIoifKwKRyFuC9ZSneqiqUe8c7Xvg9ICA3XMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlZRyWrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FF9C4CEF5
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765280139;
	bh=v8npctYpvGX4CBErXX+OEIlvdM00kLYgMZzuz/QNabY=;
	h=From:Date:Subject:To:Cc:From;
	b=jlZRyWrVZtMD+BNp1GlI4clncyPOn5zx2I5zbFnJ1xDOCeihnDYKdU1R1PJrY9eta
	 CDlmZM3eTJ6ZVuZP7Q9HZm7dpS228gGO1ftepEBnkKS4lHvXcV5j2BoYgBqMxI7mmg
	 5tpvO2ocUo9+YF/GnHRI99Uu+ZW3dgTrqWOFZLXrsXE+suyOwUiDOV3VhwZbYZf8ah
	 Gc7lXY6Ox0FuwbVCCylopNxdjo+RVrf41w6gqXzwCtWZ95i0PfqfbVepYqqzyWxvW3
	 VxAG5BsL1RAeInsluX2mx0wzLouX/mNKRd/xEbSw1z3fM2qfHtBXZ+PTT0KUWCgxc6
	 1kGpB69WlKNJw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65745a436f7so2998917eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 03:35:39 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7VS0ztG5aGV15nnZuL+gP6i8qLDR2lOnaJjGMZen8I2AQb+PE
	uMM0c8V9uL0ZYbxaYbOIRw28mxjvTsSHc7xoIkh/4O8oEDd5dF0EgsYJsPIbYMk+Hry2B3DYWF+
	6cxliKl0VGgzdoRGel/AYEK4aSj2mWec=
X-Google-Smtp-Source: AGHT+IFkayyMEtnSxiedolMZygWkEQLUJN0i6DVFLdFwjop81Gpw+lszVNxQtZ3fyVJ4rHIL7wO364/fKkbuCMvF0fw=
X-Received: by 2002:a05:6820:1795:b0:659:9a49:8f5f with SMTP id
 006d021491bc7-6599a92cc3emr5100231eaf.36.1765280138904; Tue, 09 Dec 2025
 03:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Dec 2025 12:35:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hok19sojJzv6rScSxoVezJ4U815zmKXEX_c0jnK-09QQ@mail.gmail.com>
X-Gm-Features: AQt7F2rLD5hCZpstot1qLwRlk0CcKuk6s_0sXIFxwA4_ljp_brm6DheS4cdIsMU
Message-ID: <CAJZ5v0hok19sojJzv6rScSxoVezJ4U815zmKXEX_c0jnK-09QQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.19-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc1-2

with top-most commit 316f0b43fe0131af869a5a58e20ec6e0b6038fa8

 coccinelle: Drop pm_runtime_barrier() error code checks

on top of commit d348c22394ad3c8eaf7bc693cb0ca0edc2ec5246

 Merge tag 'pm-6.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates fix for 6.19-rc1.

These fix a runtime PM unit test added during the 6.18 development cycle
and change the pm_runtime_barrier() return type to void (Brian Norris).

Thanks!


---------------

Brian Norris (3):
      PM: runtime: Stop checking pm_runtime_barrier() return code
      PM: runtime: Make pm_runtime_barrier() return void
      coccinelle: Drop pm_runtime_barrier() error code checks

---------------

 Documentation/power/runtime_pm.rst      |  6 ++----
 drivers/base/power/runtime-test.c       |  8 ++------
 drivers/base/power/runtime.c            | 14 ++------------
 include/linux/pm_runtime.h              |  4 ++--
 scripts/coccinelle/api/pm_runtime.cocci |  1 -
 5 files changed, 8 insertions(+), 25 deletions(-)

