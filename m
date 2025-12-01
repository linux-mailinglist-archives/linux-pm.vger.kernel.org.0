Return-Path: <linux-pm+bounces-39004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664CC98EBB
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04CE03454AB
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101302459E7;
	Mon,  1 Dec 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwHMptJe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63F20DD75
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618819; cv=none; b=XmPUL7fxWE2V9VmnM2KV1ybQBYsbDNJWKAn8JZOV2flN0JrVj4H946zdbjaD6x3hreNIxjAMUsRJlfs1D0DP+CKaQJcQNB0K5nR2Wdi1razdSoulE+CuC786e97nq7TwB3eUiqnKEpDPu1nRzhFkrRnJ4wWgqnEE7QjuEdNtGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618819; c=relaxed/simple;
	bh=1HrhHt6gn29T0T/ouuUN10UGrdDw0tebaPpk/cOIK58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b92caqQBpAi9hkLwjCUP6jmlu6bNKtA4O1Ti7/jErVaH4vJw4G18IWfAsVb6Peneg+7Q6kOHcuERu+3pxdJo4DzthwoESJGJhmj6tPiT/U0WW1xYypxFYQdf2QQ1sIxzyH0oZp4CCw43if/1Ci/HgnjoF+UUlbPvJBRtyhX8Mw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwHMptJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA62C4CEF1
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764618818;
	bh=1HrhHt6gn29T0T/ouuUN10UGrdDw0tebaPpk/cOIK58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kwHMptJeakHYLgDG1+X6WER5Khd2FGVnyb5pL/ukC4BugT51SoBuE3RnkbJOwlRum
	 1w9ydqLtaV0pPjA0kCIXjV9T2Z3zzAG/jQWAAM6rXkEKP2CKHmz2KDcPpZPmZRFKC1
	 M1Jf2AV8rjFVbKvtKnEknmNf9ttHdAWoq+QPJz8tNvpFqCciVU4e3v2M2ag0D43EKe
	 zxMuRk3+5c6es/ahkkaCliNdwTfMOd7ujGGYol+d05R4fC8j6XJc9PvcyGGSlbY5aY
	 4B9S68rqr4OJdgwx60ltbe+8gnlBllvkhH1kCo9+h5nk+g4nBzog9zQX5puGMPa/JV
	 TJv66oFmk3Wcg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e8317b1262so4964927fac.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 11:53:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyjuVVPmvrXqgG78qs02zSoeyfYA+u+xVleOSSlOmjTgp+YCE8q
	yrKP2OveHfoFMzPHjuSYz04pLOPhvOlLepkb5YP6F2iDN+Md8Fa9UaMt+vtXD2Dit078/Agt6Pi
	GAjg5hnyKtuiS8YZqc7ENRMj6+1x7+D8=
X-Google-Smtp-Source: AGHT+IHNyyNFvyO4Dzq1M5Mv33IkGq03zBsHpv+LLFT8ybzVx/3SOQdmyPD9X/+Jf8Xa4Ugl08zAAjQYMnzbzmXYNwk=
X-Received: by 2002:a05:6808:c144:b0:44f:946a:c9f1 with SMTP id
 5614622812f47-45115cb7dc5mr18232246b6e.64.1764618817966; Mon, 01 Dec 2025
 11:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
 <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com> <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
In-Reply-To: <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 1 Dec 2025 14:53:28 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
X-Gm-Features: AWmQ_blUiTF-yklxmsM-4l_EpR4uG0mQ1Cg-Qklaf8vM_SR4ndynQcCJw3KtXwc
Message-ID: <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> ...add_msr_perf_counter() returns -1

good.  and then add_msr_counter() succeeds because...

> rdmsr returns zero for MSR_IA32_APERF and MSR_IA32_MPERF.

Your patch is a good suggestion -- though it checks for APERF only and
not for MPERF.

We already ran CPUID and cleared has_aperf, so I'm thinking we should
be heading this off earlier.  Let me send you a test patch later today.

thanks,
Len Brown, Intel Open Source Technology Center

