Return-Path: <linux-pm+bounces-23930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E96A5E441
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154EA189B5CE
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF20256C6A;
	Wed, 12 Mar 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqh8ubnH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A531D79A0;
	Wed, 12 Mar 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807200; cv=none; b=Ii8VdY1LS9Z768IORI9+bjHiVarHh3D0KQ7dAIbfdvj6FYklwX0OHRAqvk1szLiuSmQKhWWwxv9Y9IU82DMuxQYvddjE91vcid0lE750zkzd7qYsgkMfMNPqY268f2hMtwI6DWhN22MX7gHH2OjgfSTB7E4OgUbfmsuwpmyQ3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807200; c=relaxed/simple;
	bh=M1xnlN82E4/WT0IWUe65Rxh+WCnxZFDN8gpw4CT2uVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0/8VspJVlaq0+ssuyBEn9/TkzMK4Cy/SzSN4s5VdCl4bFvoxHfNmXC32U/R6tAATHlGajX96k6n8cJ1szx2LBmh04Zn8/jFKVpGIX0vmQXFyS1+Nv69FLnlUXxY95VDfnGzZyZ6DYcUsPcQvfvSQjRCNHtzmqP84i52d8NoWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqh8ubnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D08C4CEEA;
	Wed, 12 Mar 2025 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807200;
	bh=M1xnlN82E4/WT0IWUe65Rxh+WCnxZFDN8gpw4CT2uVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gqh8ubnHaPHoWmlEJTwIbVnB3z91lkSNMFeziufpq/7rn4BwOTIAn3NxHmaw7jQhh
	 kWL3l2qa5GYtWMajp5e5EHXPjFxEdLnZGd6aN5/S5/UhJgTUAv28WzgTunYE+ewTYg
	 MDZxvFT/DXAENZrViHuHltkNxqGtWF/6SJj4g8kbCF0+JDRkO9BFmgpbyPILZF/r8A
	 l3HSTea2JnQgbI6EzpWMFghK/1SffxuyqNKMuLj/HVfSVpwe/cwQ+KM2mXlsMpoJ4u
	 d/CiTMmT6TGMOuQj4nvmRiugBHd25QrTkCTnwK8sWg0xkgp2BBY4P3Hu9ekkv0dPz2
	 SpHY31juJ2EoQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f422d6e3b0so81796b6e.1;
        Wed, 12 Mar 2025 12:20:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0mRow7Ofp+m8VxIka7sCEG5Na8a/qCqG/VUMopu8mT4DPk6QF2DTkMLs/4HlQqkCdXYcRX/cWVmXucps=@vger.kernel.org, AJvYcCV0kuzPiR3v0hQW7KZj3vQvxxopgHNRhOA9cgRDk6Me/tkfIvQr/6uNG2RWArBEeglWQuHvadQyUp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5w9yEBC+62ye90xweTRrOWLbLp2GkUrHNK9D/Dw8G7glCAtmd
	a/3aTWfPtRbMcbo3CVh47wiE5VzKJsUjhlzY3JIkUAPNjPiGJlHfUILyIatQ7pK3H5QvUY2N8TF
	UIAmfMy9t6yK1cDwtFChpfqPQzNA=
X-Google-Smtp-Source: AGHT+IF0pBM+kfrBcBjKtZbU9C+7nkh0lSCqkvS1dJjKmL8FXVUeg5ydSvuk5QvshXLc86MYc/uqRNShq9AFX+6F3sc=
X-Received: by 2002:a05:6808:4446:b0:3f9:1fee:8041 with SMTP id
 5614622812f47-3fa29f84964mr5030153b6e.11.1741807199570; Wed, 12 Mar 2025
 12:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <826ecff6-5b43-4cf8-ba8e-3d5a44e5a318@linuxfoundation.org>
In-Reply-To: <826ecff6-5b43-4cf8-ba8e-3d5a44e5a318@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:19:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1Thtwxt52LsdmCsxp5SC0aMKsR4gmPWS3B6csPE-mmg@mail.gmail.com>
X-Gm-Features: AQ5f1Jrxd6bvf2mPb04mtTZYSI62ztypPPji7obWb8_TmY64Kw6omupTp-90dVA
Message-ID: <CAJZ5v0g1Thtwxt52LsdmCsxp5SC0aMKsR4gmPWS3B6csPE-mmg@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.15-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, shuah <shuah@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Mon, Mar 10, 2025 at 6:19=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower  update for Linux 6.15-rc1.
>
> Fixes lib version-ing, memory leaks in error legs, removes hard-coded
> values, and implements CPU physical core querying.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52=
d3:
>
>    Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.15-rc1
>
> for you to fetch changes up to fffadbdd6b5acdb6390d6d0bc3ad6d3da5d2bd53:
>
>    cpupower: Make lib versioning scheme more obvious and fix version link=
 (2025-03-07 13:58:10 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.15-rc1
>
> Fixes lib version-ing, memory leaks in error legs, removes hard-coded
> values, and implements CPU physical core querying.
>
> ----------------------------------------------------------------
> John B. Wyatt IV (1):
>        cpupower: Implement CPU physical core querying
>
> Shuah Khan (2):
>        pm: cpupower: Fix cmd_monitor() error legs to free cpu_topology
>        pm: cpupower: remove hard-coded topology depth values
>
> Thomas Renninger (1):
>        cpupower: Make lib versioning scheme more obvious and fix version =
link
>
> Yiwei Lin (1):
>        cpupower: monitor: Exit with error status if execvp() fail
>
> Zhongqiu Han (1):
>        pm: cpupower: bench: Prevent NULL dereference on malloc failure
>
>   tools/power/cpupower/Makefile                      | 19 +++++----
>   tools/power/cpupower/bench/parse.c                 |  4 ++
>   tools/power/cpupower/lib/cpupower.c                | 48 +++++++++++++++=
+++----
>   tools/power/cpupower/lib/cpupower.h                |  3 ++
>   .../cpupower/utils/idle_monitor/cpupower-monitor.c | 48 +++++++++++++++=
+------
>   5 files changed, 94 insertions(+), 28 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

