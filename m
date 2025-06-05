Return-Path: <linux-pm+bounces-28165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90020ACF786
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 20:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F37916B1BF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D227A102;
	Thu,  5 Jun 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQkUq8MK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303E1E2614;
	Thu,  5 Jun 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149717; cv=none; b=EO7oskaGC3TKqwK6P6HV5Ew134ohoUA0NWdd4uB5P7ieMGVqbH5f3feA7UAVt5Qu2qp0+D7yluHyM39PzzMKknjmoL9sYOA0PqZkbZF1bmoaOkNSoPR0qZ50eD2Ai5v8KFJ/CgFp+m7ZHGRDKmxlKONqKxJx6W2bkTv6Rban+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149717; c=relaxed/simple;
	bh=FYn75fjf3w/iqVKk96Y/BuTcUXG5n3zvelKIQTkV+iY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uNqNAzX7PQy+amko8Uv/3NDtGlQ2vqohrlvMAtgIG6Tfv5CqH7pCckSwZKFm0hEl+IoiSSgzsGPOM71CWlL+hMQj2YyFGrspXvi1oDakbAMSuJ4on/IY9bu5Hw40kznudX8M24ryVrUR4a3re3Rtk3cQldsfgs/WwypHWqbSC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQkUq8MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B28C4CEE7;
	Thu,  5 Jun 2025 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749149717;
	bh=FYn75fjf3w/iqVKk96Y/BuTcUXG5n3zvelKIQTkV+iY=;
	h=From:Date:Subject:To:Cc:From;
	b=EQkUq8MK7AZC2waLbrE5Po4yPc+zHQxwvuuw5gVFdOMLEjgWta7xkZuk2O/of7wb4
	 QdV5SzLfmebPD5deIZjmSYJiQyzGuuIcEi17L0MNEWPP6Gk2doapnrrlu/EDxxQrIj
	 rQnczfRDtsS6zOcNWhCpgB4BzLsx2oILkQg0T2oXIj54wLl50xRDJtr9kaBpHKNBvd
	 /fp9cAphuj7DZ7Hg5xgZQTW/sKFu8MbOTilb8pYf5csY1WFPZWICTKozkbx+ttc3mw
	 wIXCbF3+zhw/MZEvCwv8Px0LbEIBtCE0D/1anKv8KdL3NcWPPcATaPXfaVGg3WBOIz
	 qqrWbYDDbrpAA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2e8f7ca7ca3so922204fac.2;
        Thu, 05 Jun 2025 11:55:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWQi+1EvnOknbYLYAKwxxyYlcBM+5quy7tYTXy+rm/pXDDpg/XzBO+XCQ6bTaXHySk0KUa0suNab8k5tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YPkbEl7f0WFF10xNtn10VTBWVO4DuZZUyQbVcNLu4tFDgout
	756VHiRhNKn6ZWO9QjLIQA66CxKVSWQeaHxMW8XAFUqwK1snX6wgDUw5bhoh1plmB4qC9uSj7dU
	Xr13iPx+UEroXXRqU4n4JlWpl2bbIE0Y=
X-Google-Smtp-Source: AGHT+IHV4daEy3CxRB1+a4wtq4QB6viOArsu7E+tiC5V0IzCR6FAgBvaz7VslBfYFei48Sp9WZHCnGmc4Jd1W4gJcZA=
X-Received: by 2002:a05:6870:de12:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2ea011ee207mr477748fac.30.1749149716339; Thu, 05 Jun 2025
 11:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jun 2025 20:55:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBGhVuwsfQW=-MDp3nLL_5epaYYHqmPY-DY9_g6wciSQ@mail.gmail.com>
X-Gm-Features: AX0GCFvP0XIL-Evb0ogNB-akVzCgCZYFmFQ12rP8FoQ-PWOJVACsdSFDKjhNAvI
Message-ID: <CAJZ5v0hBGhVuwsfQW=-MDp3nLL_5epaYYHqmPY-DY9_g6wciSQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc1-3

with top-most commit 8887abccf8aa16795f23ef3a3b25650cb8aa804c

 PM: sleep: Add locking to dpm_async_resume_children()

on top of commit 976aa630da5b5508c278487db31b873ddf6bae8f

 Merge tag 'pm-6.16-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 6.16-rc1.

These fix three issues introduced into device suspend/resume error paths
in the PM core by some of the recent updates.

First off, list_splice() is replaced with list_splice_init() in three
places in device suspend error paths to avoid attempting to use an
uninitialized list head going forward.

Second, device_resume() is rearranged to avoid leaking the
power.is_suspended device PM flag to the next system suspend/resume
cycle where it can confuse rolling back after an error or early wakeup.

Finally, synchronization is added to dpm_async_resume_children() to
avoid resetting the async state mistakenly for devices whose resume
callbacks have already been queued up for asynchronous execution in the
given device resume phase, which fortunately can happen only if the
preceding system suspend transition has been aborted.

Thanks!


---------------

Rafael J. Wysocki (3):
      PM: sleep: Fix list splicing in device suspend error paths
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices
      PM: sleep: Add locking to dpm_async_resume_children()

---------------

 drivers/base/power/main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

