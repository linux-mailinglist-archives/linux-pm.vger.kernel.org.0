Return-Path: <linux-pm+bounces-30187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE5AF9BAD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71767A8FDF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556622FAC3;
	Fri,  4 Jul 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guf8Xz4P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50F2E3715;
	Fri,  4 Jul 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660744; cv=none; b=mbWbexdnk2SrNfBtSa15cxcYvU6Le6hioPRP2K6fePTNNe+whf4V7W7398tbjd5j9RU214yyY1mm/5qGelX6kVqK3zADC7YRsN5jbR5+Oi1tNEqx/x0N6IMjE1JzeUebr2oU343dwmBpud/1ioZ3erQfr71SStEhPRCo0Xhs3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660744; c=relaxed/simple;
	bh=NmNJ9aQxw30cc9LsLrBk7MxNXLpO5iCaHvzrRvOqZsw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uE3crRzO/NnSHwchVPk0WbpUX0Cr0WQvnUbKVez8ouZOVESdaeRM7sGbkcSd4L9du8v6K0uXl0iIZ02SIE8XTB7G+VeGzE8SCD9cKsBb039sqL3ebB40ETX/Ov1SPhmqKiD4JlBbEb8HE/pv5P1dcPL5J4e/AUzAVubNaVRJQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guf8Xz4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD1BC4CEE3;
	Fri,  4 Jul 2025 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751660744;
	bh=NmNJ9aQxw30cc9LsLrBk7MxNXLpO5iCaHvzrRvOqZsw=;
	h=From:Date:Subject:To:Cc:From;
	b=Guf8Xz4PR87s4cxbyuOIH/3tmbBPQz2qL6sdPIH2Rd5VCY35wA/5vSPvawfkFReLj
	 pJLDUXPzqWthKBTeRYOpn13GbWVuBOUQzedtUBqbfSZ0+yfHBPhTev7qk6U4ALUF7p
	 /PDS3FZqVfC15xdQ/8Y0xEO4AugKX2GBZkk4Jy2iBRDsnlEkpob/RiuzTd7ROdkZ+I
	 UbKFFaJs0zmpi67AlciGusmqXj97C/iUctlZ2XXd2Xk8v9ps66jjgoRBgfqEG/qtkE
	 FHdqCUXf4r/4JWltIFlO0nVv3Lf6VSt2/FtKJtQG3bvw/QXbQ4irACV5ztz0Uf2ZGu
	 XVmx2qoegSmzg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73caf1152bdso257339a34.3;
        Fri, 04 Jul 2025 13:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8jw97Cwj/7EI+9/ol+FTTOqxr0lktSWV92OtsAPG9oaD3Tp3x3UVTQApL4IQ1ubcy5TPrmfSDNoL9Bgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr137+tlVoU9ry0lJubEAXHFUebyo3OrgMOevIvbZ60wAt8TtV
	FvaIwnnAA48e4JuAEa8Ac4nM51VVvXiMY90BCFKhETxHnPzPHmKT5pOrT4dt9Dr6H3VNTsDlXJT
	u38bxiA3Vg1d81L+Gd0bvuHBZx/i7sgA=
X-Google-Smtp-Source: AGHT+IFVtvxpRf+QWxI64qMPVkGVEyRmh5n4cjOSB06OU6eCuNu5k5mRGN8BOwCALjhjrnBP+B69S5JxPs1yBqa19TE=
X-Received: by 2002:a05:6830:6c88:b0:72b:93c9:41a6 with SMTP id
 46e09a7af769-73cb4760c90mr85122a34.20.1751660743290; Fri, 04 Jul 2025
 13:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Jul 2025 22:25:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCB4VoYh45gBmr_a_eh1tSXxu3Z5sDd4RQHzFf-Jht5Q@mail.gmail.com>
X-Gm-Features: Ac12FXyPm5Pw_CtKnxwo60cBWQ4hxat_xKwtn_RXXUL3LauAfp4NMKooZ74qAII
Message-ID: <CAJZ5v0jCB4VoYh45gBmr_a_eh1tSXxu3Z5sDd4RQHzFf-Jht5Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.16-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc5

with top-most commit 250d0579da5db2052cce2891a5eaa87450851354

 Merge branch 'pm-sleep'

on top of commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af

 Linux 6.16-rc4

to receive power management fixes for 6.16-rc5.

These address system suspend failures under memory pressure in some
configurations, fix up RAPL handling on platforms where PL1 cannot
be disabled, and fix a documentation typo:

 - Prevent the Intel RAPL power capping driver from allowing PL1 to be
   exceeded by mistake on systems when PL1 cannot be disabled (Zhang
   Rui).

 - Fix a typo in the ABI documentation (Sumanth Gavini).

 - Allow swap to be used a bit longer during system suspend and
   hibernation to avoid suspend failures under memory pressure (Mario
   Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      PM: Restrict swap use to later in the suspend sequence

Sumanth Gavini (1):
      PM: sleep: docs: Replace "diasble" with "disable"

Zhang Rui (1):
      powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit
cannot be changed

---------------

 Documentation/ABI/testing/sysfs-devices-power |  2 +-
 drivers/base/power/main.c                     |  5 ++++-
 drivers/powercap/intel_rapl_common.c          | 18 +++++++++++++++++-
 include/linux/suspend.h                       |  5 +++++
 kernel/kexec_core.c                           |  1 +
 kernel/power/hibernate.c                      |  3 ---
 kernel/power/power.h                          |  5 -----
 kernel/power/suspend.c                        |  3 +--
 8 files changed, 29 insertions(+), 13 deletions(-)

