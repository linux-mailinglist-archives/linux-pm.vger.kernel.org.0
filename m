Return-Path: <linux-pm+bounces-10758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD91092A03B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7291E1F22B04
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95B7E10B;
	Mon,  8 Jul 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzA3KY9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974127D3E4
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434558; cv=none; b=mFST5fSaPW/zFsYIXOVQICwQWZZZv1I8DfcGhDVHOJL+Ol1kNuDYuSSt3QemJTTgTfBJ1tJB+ePR75mtu7G9rTqYQysNzSMsDwB2pAh6lUtrGoGJNu5520/PXajp05a7JQry/wwMJFeddENV/ay+sr7njnlGY1/ExqfrIA2MXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434558; c=relaxed/simple;
	bh=QdPCHkKSPXJuaDd64bIhxiRIePqZpZZuLA3yebj7XM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/NY4mODU8LN0y0OFT2JjmlPpa/jiMEMGDB7/1V18bLryEjw7mm20+qlhcrklnWWjN6K7pIltm6CIN2++g9lZo/NC76WzhXxLb3U7O9SpqfzCIaEqsfn0ykbMmXM6BPNLB9Ps1T07BDqVL/ZhIXmReChie36YHBtbHZG6DBH01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzA3KY9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24352C4AF0C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720434558;
	bh=QdPCHkKSPXJuaDd64bIhxiRIePqZpZZuLA3yebj7XM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DzA3KY9zeXdNFLVvf0NItcEOtDqRflyKihl/tWDomNp0U1HpNpu/0PhjC9yM77SlM
	 +L0XZuotd+tSv3syoRwCBGwTkL58HMz/wzOoQeMD6r1L+8qMWYPsU0wiWxeqIXNCLV
	 JjMd97lBDlTC7TUfXrjEetzUyemI/Nig/9IRc7feu+TU1XDuOPpaLO8oDW4ee/fg9T
	 8GdyqA46S8gkOzMX24MCeNJHi2c7DB4hYXUc9S7AvbzFOzZwkxe+9wmg19tLiRJYnW
	 0J1ao3T/uZe6zHubxBtZKTs9WkirNmeZkjR/knHNNA4VoLIZw1eJ7wIVeo8rOWAMIk
	 4ASWDZXv8HA+A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c66797e197so42519eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 03:29:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQyaShCGGppGgDbYxAwk6cNtUcaTVo4IjfmmqmMpxvzWCVT+SkQJcUZRITT7JCZ13FSp/H2agrxt7OqSK2bY5ZAxPsXCCWYBQ=
X-Gm-Message-State: AOJu0Yz2q3XR21q1ZCAQgyHYlwMuV89QENWcUwVjknK3tlv3UK2t3oD4
	DypNSgn0Fu0xFeVST0RNTai+URGbeoMPwZxtcLYOrUdoRHKEW/P+j7YijkKoSZU8S4lj4ZlOlOP
	PlqLRyJP0vxtyYh+LWg4jXE4E05Q=
X-Google-Smtp-Source: AGHT+IG68gI1eMPZFKK0eQDw9Iwz9HHxC6BpZ7aNyVwFBtch+i1wFPL7THGxJWvdMbhixNHGyJrW5T2+gXiUtJO5Fn0=
X-Received: by 2002:a05:6820:228a:b0:5c4:7895:93b8 with SMTP id
 006d021491bc7-5c646ecb3c8mr13544163eaf.1.1720434557376; Mon, 08 Jul 2024
 03:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <144c8309-c355-447b-9106-1396a0169bb2@amd.com>
In-Reply-To: <144c8309-c355-447b-9106-1396a0169bb2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jul 2024 12:29:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ib1nAn_egXGg3+Jcpn40Aiajdi4b9qYMjYQUyuuoPCug@mail.gmail.com>
Message-ID: <CAJZ5v0ib1nAn_egXGg3+Jcpn40Aiajdi4b9qYMjYQUyuuoPCug@mail.gmail.com>
Subject: Re: 4th set of changes for amd-pstate on 6.11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 6:04=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 6d588891a90c5a946aaac11a93d06edd89ed90=
54:
>
>    Documentation: cpufreq: amd-pstate: update doc for Per CPU boost
> control method (2024-06-26 15:48:21 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-07-07
>
> for you to fetch changes up to 738d7d03571c7e38565bd245c0815a2c74665018:
>
>    cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared memory
> CPPC systems (2024-07-07 10:32:48 -0500)
>
> ----------------------------------------------------------------
> Fourth set of changes for amd-pstate in 6.11
>
> This adds fixes for setting scaling max frequency on systems
> without a dedicated MSR for setting CPPC requests.
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (2):
>        cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparis=
ons
>        cpufreq/amd-pstate: Fix the scaling_max_freq setting on shared
> memory CPPC systems
>
>   drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
>   drivers/cpufreq/amd-pstate.c    | 43
> +++++++++++++++++++++++--------------------
>   2 files changed, 30 insertions(+), 25 deletions(-)

Pulled and added to linux-pm,git/linux-next, thanks!

