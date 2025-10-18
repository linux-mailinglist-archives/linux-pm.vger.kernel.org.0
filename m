Return-Path: <linux-pm+bounces-36387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366EBECFAC
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1619C4AAC
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487752629F;
	Sat, 18 Oct 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFhaQ3mh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C541E511
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791566; cv=none; b=Hz+gI4H2n+QvyC+DCItJkVIay/KFNxbVZSbr+yMUyp2XOTXfyVfr6rZNkV+Cvbpr4yFxM+Sh/jJU/dtG5BEL93oFnKj6/UvJvArmHVAnvItXxGOzKTpGkRhS3YSD2j/YXbAqJMrd23E5gsIiSilI0fWJdRPd71t5zAeumDaZSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791566; c=relaxed/simple;
	bh=5CvGyDqWDRTx3VLJ9mep3i1a9JbmLCK8sxTiWncNzgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmUdFpIwCAIVeKT0wtmwSZItiZ4W9PBFhOAJJQ8xkyeBcLZn/ejUNdS2HHmUTcF4rPMQmsw7uwknvsqVyKGRJnlt0RTumHAO6V7HIh28JqE2//pJ24gdV1GFKcb6Qjv1wQN+YU1Hak5BTbR7xyMBOOdpLDTqrhJSZcFmX5ymZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFhaQ3mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AABC4CEF8
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760791565;
	bh=5CvGyDqWDRTx3VLJ9mep3i1a9JbmLCK8sxTiWncNzgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lFhaQ3mhYIhPspzae2kq7NEvdDXHsBCy7jDdlSlQEwDlOBgx5eAH/xC+veg0RlYwh
	 lKdQU0FQuCEfnW2Y5eczEbjr7OIAiE4Z9WWi+5qqOMLvsUxXxhnKea25WkWHuCEU9i
	 muOxmZgteflTU66WFLS6XnEnOwTngAAx/IPNYLKQQvL2ftruCI5Oy2cD3drMkxko1O
	 Q1wYzHkYbjrpPMsVfYfoJZzLKNOOUw4oAq/tdpV3UCGGkRIAynZIsKeUNGr7SMb2Xx
	 XYc59V28OIWIJaL0lJ9kxDWp7KKpm9Womxum3+TXYxhF4zjQP8tkWbA0ms+D1+8To7
	 CWtFlgtI04H1Q==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-444b94983f7so59006b6e.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 05:46:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHJ15PoDEwmXzsWXLT/ZYzIsMtZjarbJK91xzuSsWxGzbECPpb7BiEizkvLsibNbyeydcrK9IqaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAiVgKJ9HVNW7S35AZBwx0DBroH8ptb7PQLwhtQfKy3Cok0j+
	+t43Vn9XUiLHszFm8s7MTVzewU2L1F1UyzwVF0rym45wPWQ0IVrsdZFeLmSgpXZwJuULMOYTaco
	aKFYaQ+2JQyLCWx9CcM9UfZmBZJh2A80=
X-Google-Smtp-Source: AGHT+IEg0FSBD2fJTLr4qIR9b02Ws1m7HoFKrpIHixLOHQscZuTo1XXx4xu+hvHp+PDZsszEaRza9X+lcNuF+aqEA8Y=
X-Received: by 2002:a05:6808:7003:b0:439:af2f:d1da with SMTP id
 5614622812f47-443a2e73172mr3138336b6e.14.1760791564942; Sat, 18 Oct 2025
 05:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84493df4-850d-42f6-8adc-b45ae743c5f3@kernel.org>
In-Reply-To: <84493df4-850d-42f6-8adc-b45ae743c5f3@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 14:45:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-iZheqhZ6zXyOfno4+CRr54L0pCPL2+WHcRMktKPXyg@mail.gmail.com>
X-Gm-Features: AS18NWD5Q1yBOnCX8g7-m5sJYMHokjEljpbEZ2wiMd7pgY6meyVOEY03kgseack
Message-ID: <CAJZ5v0i-iZheqhZ6zXyOfno4+CRr54L0pCPL2+WHcRMktKPXyg@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate 6.18 content 10/15/25
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:24=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df567=
87:
>
>    Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.18-2025-10-15
>
> for you to fetch changes up to 85d7dda5a9f665ea579741ec873a8841f37e8943:
>
>    cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibernate
> (2025-10-15 08:21:16 -0500)
>
> ----------------------------------------------------------------
> amd-pstate 6.18 content 10/15/25
>
> Fix for EPP value in wrong state after S4
>
> ----------------------------------------------------------------
> Mario Limonciello (AMD) (1):
>        cpufreq/amd-pstate: Fix a regression leading to EPP 0 after hibern=
ate
>
>   drivers/cpufreq/amd-pstate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Pulled and added to linux-pm.git/fixes, thanks!

