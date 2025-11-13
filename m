Return-Path: <linux-pm+bounces-37998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21FC59F00
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED37B3493AC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3230E82A;
	Thu, 13 Nov 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z67UAL/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96821FF30
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064952; cv=none; b=rDtBLXyyl7GBfsdh2gipJSrW2qF9Y+gf9PXvTdaaG2jXQd/Q0ARejjJsoBEUVPFM8cSXQ+/uRJvpTnNr9qLnLCmpLDnSoLj5endDlQtKjvrNcHlFXlGil578Y123rUVvXAiu7T/+tyjFGJqI4ABYv7dOiJc4mB2R43Rol+NRatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064952; c=relaxed/simple;
	bh=XpkM3VNwy4BZrLgTs3KmGGaOnJF4jw0aCet7AJtT++M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bSvO0EovlWG+jd1F4PyN/19Q5K0xVNLZgeOrv8dFLiiTLw712ukzSiznNp1bLTa3iVzSUjn6e8GLAnMZuLrrPpJYcZ8sooFMrDL82c5K4kDDan7Z99zsxcGRN8GkU9KChMQ04CNMsEYPpdcANcTS42fOFgQGpRBQZO3aDWDejTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z67UAL/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A432BC16AAE
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064951;
	bh=XpkM3VNwy4BZrLgTs3KmGGaOnJF4jw0aCet7AJtT++M=;
	h=From:Date:Subject:To:Cc:From;
	b=Z67UAL/ze61vcht+kbOOifGOL8NquSHgnxR+LgfhMxAnNcXV2iz5Zlw6urkMCojbd
	 M9nzURzotHSx7itkTwxV8RKf2MLv84WgPBmsIHaAijE4Ni3PNzLSPhXnj4nm+hbF6K
	 77Fzg7agzFZTJwckoxEOvkGYoBSC4LUDhpE9LQqsPbcI55emkhvMcyso8h3fFODt80
	 mTzGC8x5BTMQRUvlIchP0GZzuCSSvAtrlttWKZCpV9UaiadtHKiA7w9XsdO7TyS/FV
	 ht6MacOJD6+aX/df1elCndQSJIgW+WK1YKAlV3DJ2xMXMVQpPVa/EQlQno3aVi84QF
	 CGlqoC55NGMZg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6da5e3353so937437a34.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 12:15:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yxh/GeAiOY/tls/8KttKeHcfvpwakY8tNIB+MGb6UKxD9YQWFLZ
	08MdhfHlWM8K2O1DqiOO0z6JZn680whJWRImZZbZ4Da/9r8vsGsBRaKVKJ7aaJB9A9X4nApzfqr
	cWF6QEqzbUYe9yD9bP7rDvcpYHiTW7OE=
X-Google-Smtp-Source: AGHT+IHL0LnnhkJP/tBeSILjl9G9kfrlZF/KTYxv1KL/mcSTdE3JwcN1i4jeHpE0fXdV3kKkflzzAPrkTcQ7go5YeTg=
X-Received: by 2002:a05:6808:d4a:b0:450:438a:dcd0 with SMTP id
 5614622812f47-45097403fb9mr325389b6e.19.1763064950996; Thu, 13 Nov 2025
 12:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 21:15:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ijgzoEZZvPwBG7wYxst+WYuJWZdaOGCF1Y-a7rn51bjQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkYTcz-a4WP-PvThTn1iZIMflYlZL9WGvTvG4sGXGrs1LrsI2qGlGnru34
Message-ID: <CAJZ5v0ijgzoEZZvPwBG7wYxst+WYuJWZdaOGCF1Y-a7rn51bjQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.18-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc6

with top-most commit 161284b26fb17093bad3c7b25d76459e11d3142f

 Merge branch 'pm-sleep'

on top of commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c

 Linux 6.18-rc5

to receive power management fixes for 6.18-rc6.

These fix issues related to the handling of compressed hibernation images
and a recent intel_pstate driver regression:

 - Fix issues related to using inadequate data types and incorrect use
   of atomic variables in the compressed hibernation images handling
   code that were introduced during the 6.9 development cycle (Mario
   Limonciello)

 - Move a X86_FEATURE_IDA check from turbo_is_disabled() to the places
   where a new value for MSR_IA32_PERF_CTL is computed in intel_pstate
   to address a regression preventing users from enabling turbo
   frequencies post-boot (Srinivas Pandruvada)

Thanks!


---------------

Mario Limonciello (AMD) (3):
      PM: hibernate: Emit an error when image writing fails
      PM: hibernate: Use atomic64_t for compressed_size variable
      PM: hibernate: Fix style issues in save_compressed_image()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Check IDA only before MSR_IA32_PERF_CTL writes

---------------

 drivers/cpufreq/intel_pstate.c |  9 ++++-----
 kernel/power/swap.c            | 22 +++++++++++++---------
 2 files changed, 17 insertions(+), 14 deletions(-)

