Return-Path: <linux-pm+bounces-8018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D68CAAE3
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A9E282196
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178E5E22C;
	Tue, 21 May 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8wsZLv2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96875B69E;
	Tue, 21 May 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284226; cv=none; b=BWGHCwalHGjSmyU9o7g7UL8tctWlVq/8D0e9saeq1ScCrwkUVthJCd4RZRRBwQ6i/mjzCB2dXvh5tzzD5ZRMqVYGL5Zu4oNmLdrGlg3G8B2qLTGbGmD1lKG5+EDGk/Qw3Ae5HqpeciIA2wDmBvRWMgUDx+f6Q6t2bvE2jdVuaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284226; c=relaxed/simple;
	bh=51eR1Mm32okdNkVftwRrT3s8ijpMtFpB600/Wy9e8jM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YgYkiAlqWVdNpnFmDRjZAvq52ObO45syn4FUCOeEUwZEdKFGCta0Eqtxcvk3UktEyT28MowSv7W/nL+be5VLwA5Udj4YlQ66J/Gck8EOr+rgevlpUnyLOsKMA3Vm13Az6/XT5NnAjvwGuwcZu8LVy1daZCk+CEhlA8TxF2CAUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8wsZLv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC28C4AF09;
	Tue, 21 May 2024 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716284226;
	bh=51eR1Mm32okdNkVftwRrT3s8ijpMtFpB600/Wy9e8jM=;
	h=From:Date:Subject:To:Cc:From;
	b=h8wsZLv2bDLAhYjUOE0CqDonwDDXxZZtn9ZeSKtgF6yN1RLJ/y8lffMiDF13s1k3R
	 oMByAhyJSUUflABe7C4b03DLAtXtBrEbEdmfl+pBQlMDB8hJxAZi6WNJGAyVMngJjn
	 FG60t7NYdx/tVKdr5piea7nB+9gz/YT8/7BS04PcX6COIa5U0UKCcUod+jYuzQrwUl
	 HuSKANVBkLkvpM9kJokYTSVwperXLZ1OdQmU7BB+oX2uLtznfdgLwi5iPfiDzuU29N
	 EMGZ4XfkvjBecX6quAQkHzKBsjYYICkOtxkwQGz/Cv6oT+z5Mb1tjq6DVcsPNWcx/N
	 Y+IiwRJ7XYTVQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b2dd35212fso422549eaf.3;
        Tue, 21 May 2024 02:37:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3ozokHULznuDUY8nZHfnAM2DiPkO8CreA+7QnTjJ6e+UFH6KOY7hOpq6faMlnlr/qtpCqULQGXQOgCZCODn0Qe+wkjyAEzKoadIsU
X-Gm-Message-State: AOJu0YwC+9PHvut766CbLnJEB9znZV+vVtR2OxIwAyqP1PWhWQo5GeMO
	pQjlvY3QMAIJPYZ8tL9B4IVW4tYwWM15+sw618HVIa5mkNzT7KybZYXt30ieO84XiOelSO+osF/
	aSOweOJX4TWrqeOwq6eQm9r3P+9c=
X-Google-Smtp-Source: AGHT+IGXlS5rTx7M4oSu+lw61Mytxa0MGjdd/IfXU6OK5sxzxwkUlSLRJUjT5KtyKpxVihYTtI8IRMgKrhLelG4UQBM=
X-Received: by 2002:a4a:de14:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b28193cc74mr32764113eaf.1.1716284225360; Tue, 21 May 2024
 02:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 May 2024 11:36:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irEVCJcq=x6FXEpRh_KW2NwFD6At=2KU-Jc-Qs_se5jw@mail.gmail.com>
Message-ID: <CAJZ5v0irEVCJcq=x6FXEpRh_KW2NwFD6At=2KU-Jc-Qs_se5jw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.10-rc1-2

with top-most commit dee8f20e61aea655a43b74e5b65bcc6fbc69df7b

 Merge branch 'pm-cpufreq'

on top of commit 0c181b1d97dc4deaa902da46740e412c0d0bf9fb

 Merge tag 'pm-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 6.10-rc1.

These fix the amd-pstate driver and the operating performance point
(OPP) handling related to generic PM domains.

Specifics:

 - Fix a memory leak in the exit path of amd-pstate (Peng Ma).

 - Fix required_opp_tables handling in the cases when multiple generic
   PM domains share one OPP table (Viresh Kumar).

Thanks!


---------------

Peng Ma (1):
      cpufreq: amd-pstate: fix memory leak on CPU EPP exit

Viresh Kumar (1):
      OPP: Fix required_opp_tables for multiple genpds using same table

---------------

 drivers/cpufreq/amd-pstate.c |  7 +++++++
 drivers/opp/core.c           | 31 ++++++++++++++++++++++++++++++-
 drivers/pmdomain/core.c      | 10 ++++++++++
 include/linux/pm_domain.h    |  6 ++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

