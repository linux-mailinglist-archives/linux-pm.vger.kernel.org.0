Return-Path: <linux-pm+bounces-16231-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6229AB230
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ADC1C20F61
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B4139580;
	Tue, 22 Oct 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNEPGJA7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD71474C9
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611134; cv=none; b=d/XMWxkaitildS6cVkXg9NkQ2RJTjp6+sBRCAlqjLZOx7MEPnJotdRQXanzYevkvvBF4ERRXoGPm6uEilr1+HK6H1GAgeisqK6Hf+zTMLJOhonxn/UJW3NKuDBvcVY/rpVUY5DVquuAf4rFXYnNszN4rwGuOnODa5gGzMQ4pLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611134; c=relaxed/simple;
	bh=eviRLJD5wnXe1vDT34DWfFxuPGLhcOiMkf972Jfol3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6L4txPMuoAXIYZTa7rbq5/ZXFFyUS12f5SYNaEKJRfqPXiRUnnYqKyGK/o5ueXmyngPE62AQUj7iS1YkPvd9Lis6I38mbwmigyS5vjnqMSS4LOO6e/HekvvWsijHo6gyhvSJJ7biYppYmyzr9vCxyfAgKogXirgaVN0FRWf1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNEPGJA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538D5C4CEC3
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611134;
	bh=eviRLJD5wnXe1vDT34DWfFxuPGLhcOiMkf972Jfol3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNEPGJA7CpYw/l792ySQ5zwzn7izNR/5hAWugAOdRdtlKT9LpXUKOsGT400Xmgq15
	 klLMNuO8pe76eMqZII/1KnB2SkGl/K4+yQKnXbkPR2oe/qivGoFldJyLygDtyp92ef
	 z8DhDcpmfHDZBVBSMbQxifWyOLh297XOpoSdAN+eZBluJfcKEM3vkj8uQWKbj2kW3Y
	 QDTzF+fN62Y5XuklWjvGN2RgVPgX9JmT1s7lPGVcV9U2bR7CmXs1upEsXkNmF5q7sr
	 zWL/uqRpnA28LreHBaKCKXzLfj+nFRFYrbBVxRJPtSi3EEH3jeAkAOoe74G8mksAK1
	 0Pm+o4TeT7Xbw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebbfcab9f4so1399891eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUtKM1QkOpQwnCOwCT5APPL17tx3c3Cc0qk28UqLLMmRtFaOONnM+967fl9YW1pw3/r0Z+tCXwRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo8ztcpyV9OHpyr7XaUSGdQ7Hb5twLMuaVRcspRp30kXasL3CG
	0lvI9oB0ukABQQ+2TKef8LfRgdy2Mo1UD1kIkE7St3K7hXPWFW4I6QsRsFyp9hR/RHPBxFGnXff
	CTR5IihfcmQS41Ws5TT9LuOHBbsY=
X-Google-Smtp-Source: AGHT+IE+vaDSpJfGhU+LZS3kOSmCFlLiFlO+m1S94S3SQHjjvJmYGeYUxX2VCzx4Egek8+2eTxeikQpiBsA1m4s37ec=
X-Received: by 2002:a05:6820:60e:b0:5e1:ea03:9286 with SMTP id
 006d021491bc7-5ebda736279mr2403653eaf.6.1729611132993; Tue, 22 Oct 2024
 08:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com>
In-Reply-To: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Oct 2024 17:32:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
Message-ID: <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
Subject: Re: Preparing next amd-pstate PR
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Tue, Oct 22, 2024 at 4:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Rafael,
>
> As Boris mentioned we need to drop these two commits and go through some
> more review.  There's an active series under review for it.
>
>        CPPC: Use heterogeneous core topology for identifying boost numera=
tor
>        x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>
> In order to prepare the next amd-pstate 6.13 pull request, I wanted to
> discuss with you the best way to do it.  Those commits came into
> linux-pm/linux-next with this tag:
>
>      * tag 'amd-pstate-v6.13-2024-10-10' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux:
>        cpufreq/amd-pstate: Fix non kerneldoc comment
>        cpufreq/amd-pstate: Rename MSR and shared memory specific function=
s
>        CPPC: Use heterogeneous core topology for identifying boost numera=
tor
>        x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>        cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> systems
>
> Unless there are other conflicts I'm not aware of I was going to suggest
> that you just drop this entire PR, and then I'll take the other commits
> that were in that tag besides those two in an updated tag.  I would then
> do the next one based on content in linux-pm/linux-next instead of 6.12-r=
cX
>
> Does that work for you?  If not, can you advise how we should do this?

Yes, it does, no problem.

I'll get to this later today.

Thanks!

