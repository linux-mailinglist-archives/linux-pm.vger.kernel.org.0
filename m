Return-Path: <linux-pm+bounces-37141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092BC22185
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47CF189CD62
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054CE333437;
	Thu, 30 Oct 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU/BtFOa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48033328F8
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854247; cv=none; b=t/an9PkI43LkOx/hZhYwHobSSNNf7VcYHCaePPwDjEMa1SGct6g8OQt3+/JisH9Z6yGRTbKCJUDYM5krxINg8IbRVtwvMLCSx/+ogLVwpENPVc2OP9rqYUzasxSyPvTu24H9+2RJiambp9UVVl17JNdDlNCzFYbNMmJBk0Xgtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854247; c=relaxed/simple;
	bh=OBpdvl/BtoQiGvtNgbEFbsYPKZFMiSxUgYLc3AyFoHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YilAdq5KkZjX34FObRToFjraW7lJKvA8+FN0H7XnWbYOc282qLLL+YwLNTzrBMoUwC1iLN24x89gxewRNNgI5rj9swUM61KwYgUfCsEEPpvQSfufNeEIN3iuDIBiAjFog7PJ4U+gVFu1fSEYysAx/ctoSgl06PmHP9YS3mCXWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU/BtFOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83681C4CEFF
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761854247;
	bh=OBpdvl/BtoQiGvtNgbEFbsYPKZFMiSxUgYLc3AyFoHw=;
	h=From:Date:Subject:To:Cc:From;
	b=RU/BtFOa4rVNsPWEDaqyPDOJCVzaDGpiGvWA3bLqKJx06dLINFUHRriYCWR5xvXrQ
	 Lbe+HV1jNP5bZWYe5tOvzyPab4CiDPP24+xHY4n7QB5tQJJVax/2c9POXJyp27c+Fd
	 hG/FLvzKmx1nINbCH45QoCOI7fiiR/t8EwQTOFIfyqoM1T2zJyNpqIlzwdfGwPPm8L
	 62echcKQ/16bkOFVbvHKnLYh9ncjzPwlvKgkMCRkdT++mI0I+phU4QWWM1iV+y5/gl
	 XyUJNUsinLxNjbLOM0KfyOlgnba6fvAMb3Yp2LTwMBqKb1ICX7v41zIWJllujy1Wqn
	 B/h7tWNzJdL1w==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-650317ae979so492120eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:57:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmtSCgGaVdZbk77CscCraK39CDXaz+rJz+Ti+s6hFedn/sjA1e
	n1FXYUhaiZvTL8RU5IWGCSlt1kmV4jXc85fjCO4BR3VhR4sj8Hs8z5WooybNkwiKTdIbnRoqylK
	0uVbdYbHvZR8HVMO/dVj1YSR8tUyfUsY=
X-Google-Smtp-Source: AGHT+IEgyAlZtg0wuRPXPbyZZfEUOj6/ocGllOrporuhj6LQp5k7NHPMaK65lYNywn7H/qfPn8flTVIMFo4N7dTlHbI=
X-Received: by 2002:a05:6820:201:b0:656:735e:9eff with SMTP id
 006d021491bc7-6568a69fb65mr481386eaf.7.1761854246775; Thu, 30 Oct 2025
 12:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 20:57:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i1FFbZZeqtk__gKMy2dc6HREtqm7aBmNpXeFTKz2Kbvg@mail.gmail.com>
X-Gm-Features: AWmQ_bk8FcC0Qg8pO5IW6wFP9AIitODCZAxiDdkGcJLxjLHOaulumleUatoSV_c
Message-ID: <CAJZ5v0i1FFbZZeqtk__gKMy2dc6HREtqm7aBmNpXeFTKz2Kbvg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.18-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc4

with top-most commit 590c5cd10675a6ae49f6019502dec5c87aba07e4

 Merge branches 'pm-cpuidle' and 'pm-sleep'

on top of commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa

 Linux 6.18-rc3

to receive power management fixes for 6.18-rc4.

These fix three regressions, two recent ones and one introduced during
the 6.17 development cycle:

 - Add an exit latency check to the menu cpuidle governor in the case
   when it considers using a real idle state instead of a polling one to
   address a performance regression (Rafael Wysocki)

 - Revert an attempted cleanup of a system suspend code path that
   introduced a regression elsewhere (Samuel Wu)

 - Allow pm_restrict_gfp_mask() to be called multiple times in a row
   and adjust pm_restore_gfp_mask() accordingly to avoid having to play
   nasty games with these calls during hibernation (Rafael Wysocki)

Thanks!


---------------

Rafael J. Wysocki (2):
      cpuidle: governors: menu: Select polling state in some more cases
      PM: sleep: Allow pm_restrict_gfp_mask() stacking

Samuel Wu (1):
      Revert "PM: sleep: Make pm_wakeup_clear() call more clear"

---------------

 drivers/cpuidle/governors/menu.c |  7 +++++--
 kernel/power/hibernate.c         |  4 ----
 kernel/power/main.c              | 22 +++++++++++++++++-----
 kernel/power/process.c           |  1 +
 kernel/power/suspend.c           |  1 -
 5 files changed, 23 insertions(+), 12 deletions(-)

