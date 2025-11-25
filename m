Return-Path: <linux-pm+bounces-38620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8BC85E78
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667004EA545
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40A23D290;
	Tue, 25 Nov 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi4ddLNj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC323B63E
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087242; cv=none; b=C6FBtPqe4anRqlLWoOBN8luywYBsXAy5O0jUB4GjI3QTSU67Lp3zv7aRDF3b2F5wlHWRJwEcYwSdqYJfxDQ81e/cRRWKKzhTixA9q/jpB71i3op66MIsq+UUccF3WZ9ZGnvtzeuuSHSwFRSF5ryDTbY154O80YkShoPGEr4bbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087242; c=relaxed/simple;
	bh=vNq2pHrJ1bQvfpdbBq2k1MCQXj3s0ybukHB/t6PsPmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpDHa2z1xuGhMgywMVa+dUtYfv0xxegBUhd3PoMhKQ/NzuCT0aKeRTOyedUKUIB4EG+19IPvW4a+u9DhLZde1s/57NMai02boghsLrEEkoc7Hm8Xd7U+0Bi7UJNFUrD/xbPQwdRdJkZRrp1Xn7QsvX07h1SB34bEfigJW37cG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi4ddLNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB80C116C6
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764087241;
	bh=vNq2pHrJ1bQvfpdbBq2k1MCQXj3s0ybukHB/t6PsPmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hi4ddLNj8JXvYfMPO5q5mpGdSgq4bTFXTovuVvYDl7uSDQEC9yEF1YzGoxkQM3zeJ
	 lE61ucDa/y8H+V4Ma2f/l0uZkeWmRDI7Bl2bGzCWFvSIcu8GqNMYK+Rfk7v8SFnaZq
	 w0NotJ/f4G1XSAFW9BJtAnNKQGbZsejvMWKGwkXYzJnVP07zFsnXw1FWmNWBs/ItB1
	 /T2zeIrSFSm/KFMD+I1/0jAwhAwFhQsmpaLk3HRlpQ3ZMd3fR647llN4GATy2UM+zt
	 IRJyVaZmck7RL38S92QYuYOi5dIfVsKseCR2eOobUqkEogC2qJSX8Vlj4dEPcEMyFI
	 fF23MW/hp9XCQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-450063be247so1929644b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:14:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5F6OjBnY3hDwl6P/AmJ95KzzzzwGox1ps5rGNGcEXgDV8pqpmoRcHIkPpCWXnmqVgkFriqWKiDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBtK8AM2TJWdGb+xS4Icw5r2aA335DAdZwoxBibhC1la6aM4w
	vCSSU+nFB62e3g29JRLzDt8h1f/uc+m3RBiT1lA2YcRm6ifVA89HxFOUUWZCGw5gajSuSsoGqVW
	OA7vAmkx14uSqkvc/5Pe63Lv1AN2JXTU=
X-Google-Smtp-Source: AGHT+IEdk19yM6tAMmvW8aEK9hWT/WeVUb++EcbWm+RalYawE79GCXPFLdD+aNw+Rsgtcl0l2KNJI3Z8LGF4B7mh5U4=
X-Received: by 2002:a05:6808:2287:b0:450:340:2693 with SMTP id
 5614622812f47-4514e79dfb2mr1403572b6e.42.1764087241198; Tue, 25 Nov 2025
 08:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f46bc24-1a27-4f59-b082-e634f46de0d5@linuxfoundation.org>
In-Reply-To: <4f46bc24-1a27-4f59-b082-e634f46de0d5@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 17:13:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jbaC8i1PaH17ieY6d+aFgvxUpc2pjjkLmD=xrQxEm2Lw@mail.gmail.com>
X-Gm-Features: AWmQ_bm8TiAB_fRmauKY06YnL8GZYYnsHZR6QAAgpmOAuplniuR4lD80PrGLJ5g
Message-ID: <CAJZ5v0jbaC8i1PaH17ieY6d+aFgvxUpc2pjjkLmD=xrQxEm2Lw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.19-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.de>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Nov 25, 2025 at 12:39=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.19-rc1.
>
> Adds support for building libcpupower statically when STATIC=3Dtrue is
> specified during build.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df567=
87:
>
>    Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.19-rc1
>
> for you to fetch changes up to 059835bbfa282918a1e8e5e2d9628aa600093052:
>
>    tools/power/cpupower: Support building libcpupower statically (2025-11=
-05 09:56:01 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.19-rc1
>
> Adds support for building libcpupower statically when STATIC=3Dtrue is
> specified during build.
>
> ----------------------------------------------------------------
> Zuo An (1):
>        tools/power/cpupower: Support building libcpupower statically
>
>   tools/power/cpupower/Makefile | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

