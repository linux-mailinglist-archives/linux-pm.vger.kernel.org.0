Return-Path: <linux-pm+bounces-31019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCDB09194
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90B3B983F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6A2FBFE8;
	Thu, 17 Jul 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYxc3fER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA60145346;
	Thu, 17 Jul 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769197; cv=none; b=dPNN2/oEYbhaVAmvmyGEPaFz131MuAhWbJZPBElSOYevjSp1MbR6wfhwpY0Orjg1xKtrIwNjxNDYflYkMNiWg9x/0VkoPjxiqPQVQ9VC01aDROivoPW1baf9CGPC6Emdm3YONxvClWFDRtToqvgyDfS26MygCLONIrJ4Ga3u7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769197; c=relaxed/simple;
	bh=+4LCQYFgagsp07CeF/hAV/umbNEl6K6FJwmZLTdae8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bh0wrSyxk5CVm/GjujWBwc+UQ+y5/ETUT2ryiZwHDe4NKLivsQStYOMXWFegxANxaY5XYx23htXF5LPugANZZQ0Ba4DsPvNr1FrGhliUqtuAgFP/JpsoWssoVFF2dSQFtPRsf2Z3x3C7Hz5clF3VsnQwbfyXHVGuBuQilkLgBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYxc3fER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE5C4CEF0;
	Thu, 17 Jul 2025 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769197;
	bh=+4LCQYFgagsp07CeF/hAV/umbNEl6K6FJwmZLTdae8A=;
	h=From:Date:Subject:To:Cc:From;
	b=SYxc3fERcNvgvNz8wcAj5JS8+e+k481hRPuiEGLvjZPm/5rdNM8yyKhlvHXnmitH3
	 +QuEiJ9k1moPoL681tKV7cjqLxg0iCmoYt6faYm1NvlZUNGsRhfcZO0ZyWX1PfFek+
	 h9GzeHqayNVaaPnwUZe+QWSdfcahtjprEMWSNFPANvSt4i5GedINQ7ra1O70BWNX8J
	 qoWnACOS6FOtcwvQ7xrXqR+P297amvxJsfqezp+/TCyO0EDeEfAexSyNT3c5A3dikQ
	 JrLkrDC/uluFSJIW+JpglONJizLBk23rp0S5kJuS8Is7/7kQoRD+pCQHEfMvpvZijs
	 JXYtV7/TRurVA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61208b86da2so328490eaf.2;
        Thu, 17 Jul 2025 09:19:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0jFC13RvxQBFYHlJXlNWCwbWIp0An5oZEXFaiDUpvyJ5rSpfk+db+T0ZTE7mJeNs2XqouLQSRmGmyt0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJplcqQUWza86GGcLBlk/7L/LpEnG+rmuf2lo33XPaYj/A5fnk
	rylARdZyyenh/+n2dUBt0dmqiAAZhDGFe0UXmFMwt7sqngJ5vXg/vm2yy/QDsTMww9lnR3bbM2C
	WgDTRPkAMQ6vcKxKUkdrMCRk/Fdw2C8c=
X-Google-Smtp-Source: AGHT+IGZ2vl3jDTKnMkPOHGs/ayhsRrEwojeTvoE+jTzWm+YUrmstwqEwJ7fzk3oAOZGvCrcT2E7LE0yLgZWYLWCOc4=
X-Received: by 2002:a4a:e90d:0:b0:615:a91b:8e7b with SMTP id
 006d021491bc7-615a91b909bmr4296814eaf.4.1752769196562; Thu, 17 Jul 2025
 09:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 18:19:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gX0Tj5GYLu6rPj2iWfep1shMAZbV740_wr=Gss928CXA@mail.gmail.com>
X-Gm-Features: Ac12FXytljNEdTzgaJ52nkTptnM8CcDeacP-wV1pey2q6oONUxLd6iQek3_yQlU
Message-ID: <CAJZ5v0gX0Tj5GYLu6rPj2iWfep1shMAZbV740_wr=Gss928CXA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.16-rc7

with top-most commit ebd6884167eac94bae9f92793fcd84069d9e4415

 PM: sleep: Update power.completion for all devices on errors

on top of commit 347e9f5043c89695b01e66b3ed111755afcf1911

 Linux 6.16-rc6

to receive power management fixes for 6.16-rc7.

These address three issues introduced during the current development
cycle and related to system suspend and hibernation, one triggering
when asynchronous suspend of devices fails, one possibly affecting
memory management in the core suspend code error path, and one due
to duplicate filesystems freezing during system suspend:

 - Fix a deadlock that may occur on asynchronous device suspend
   failures due to missing completion updates in error paths (Rafael
   Wysocki).

 - Drop a misplaced pm_restore_gfp_mask() call, which may cause
   swap to be accessed too early if system suspend fails, from
   suspend_devices_and_enter() (Rafael Wysocki).

 - Remove duplicate filesystems_freeze/thaw() calls, which sometimes
   cause systems to be unable to resume, from enter_state() (Zihuan
   Zhang).

Thanks!


---------------

Rafael J. Wysocki (2):
      PM: suspend: Drop a misplaced pm_restore_gfp_mask() call
      PM: sleep: Update power.completion for all devices on errors

Zihuan Zhang (1):
      PM: suspend: clean up redundant filesystems_freeze/thaw() handling

---------------

 drivers/base/power/main.c | 19 +++++++++++++++++++
 kernel/power/suspend.c    |  5 +----
 2 files changed, 20 insertions(+), 4 deletions(-)

