Return-Path: <linux-pm+bounces-15547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE299AB1F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3511F2212C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E11C5796;
	Fri, 11 Oct 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsilXVIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA3183CA5
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672068; cv=none; b=RHjT3mTcGJLERFqkrCUCOXIh3OxLgZHdeKS31zQVNrMJfzWWx3NpIKiu5/2rjMVS0Zj2gcOX7lTjQFC3w2ro7Gqhkq7GN1SH76GqfF+eTdx79L0CLehE97QtfJh0AzHOMF/PE+rSA8kabTPN20Xy5kv9VoiAG3YVXZ/0bkNtnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672068; c=relaxed/simple;
	bh=OYPzkxrisAe1+OBZh9iGHpol9D2PJu++6Y5NI4FLO2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hws+iAXd6hSGZZDXUbD0y62kghLDT6pkJkmeNdWiGvIBSVcbNMykKHNJOMH0aoOc5NOR3aBe3odL2CKP5P+R5dCXsw5EULm/B2n9h0WPf8pr7Lk+r6U2YpwHmHKYSZvzdmL8r1MDA2u+mbm92eQuTn7oHI2k7rlwskSBKHVvsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsilXVIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E22C4CEC7
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728672067;
	bh=OYPzkxrisAe1+OBZh9iGHpol9D2PJu++6Y5NI4FLO2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KsilXVIHLQ5yWZrAGPZFpZ5uIoA5MdoiasheRmFd1cpege+HLWkSwxerRnTKtnMhs
	 y6uGcaQIOzDX2mbq8KXYv3mayxll4Qd7Msa+z4FVOcYqR4YK2O0B1AP9g1eFjNoHjt
	 pVifk7DKvLBBszbjBfLg2Hqy5rr1W2PlMK3J2dL4hNGTHy9zYAAz/QhsjGZasdUaW8
	 JgtT4BGrxZi9AE3hcUOpk0ijrGdJEy56a+3Smfwh3iSUYOfVP0MWFLUCgH2EY8O07I
	 kWKVm7JTPlkLHT2MSkyjlc8xidm0gumGuTXVoWBalQyQ6pxUetjTa54J+NaofLdQfB
	 fkxBCZ1+82Nwg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e3e7ada8c7so1409645b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 11:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxZfRUF36kneOGgz3ntdx3oh+vqGAX7QJT7Ca2BHsgax9pws4WeSa62dr5JsBmHbCwR/k1wb9KJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFflEP7CAmTpfMRD8x59CrkG7YTm7HuQzloNolMd0Rz7PiJNv
	2dz597rxGVJ1vJ8LHu34bUnLSvdSBhEBh63Y7Rn8ZRrDpWyITD9YMv/SW0+C6QEt0f7bblyHvHF
	U5FSxHWZi8Vkyun2rgelpF57Zfpc=
X-Google-Smtp-Source: AGHT+IGNrGusJCTBUruE+GglwhrbqLpZVAvP11yURJHXDCE2CahKySV168Cb7ppfQsjtj+iUDQ6g7g03JGTfKh4MpFw=
X-Received: by 2002:a05:6808:19a7:b0:3e4:d698:3ef4 with SMTP id
 5614622812f47-3e5c912d342mr1969223b6e.46.1728672066833; Fri, 11 Oct 2024
 11:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ec4ff18a-ae7e-4a29-9961-8b53dc8a3acf@amd.com>
In-Reply-To: <ec4ff18a-ae7e-4a29-9961-8b53dc8a3acf@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 20:40:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWznNuVY02AQtdpX=UW24t275k9gPkxy6eWos0kxMv_Q@mail.gmail.com>
Message-ID: <CAJZ5v0hWznNuVY02AQtdpX=UW24t275k9gPkxy6eWos0kxMv_Q@mail.gmail.com>
Subject: Re: amd-pstate fixes for v6.12-rc
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:36=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d=
7b:
>
>    Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.12-2024-10-10
>
>
>
>                                      for you to fetch changes up to
> c10e50a469b5ec91eabf653526a22bdce03a9bca:
>
>    cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> systems (2024-10-07 11:32:05 -0500)
>
> ----------------------------------------------------------------
> Fix an issue with changing amd-pstate modes at runtime on shared memory
> systems
>
>
>
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (1):
>        cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> systems
>
>   drivers/cpufreq/amd-pstate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

