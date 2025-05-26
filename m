Return-Path: <linux-pm+bounces-27651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A2AC3E01
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D35318976FC
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6781F582A;
	Mon, 26 May 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJr/37iJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF81F4CB8
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256303; cv=none; b=itDibOIlfBvEiPlGqeia2HWmdxL2TpciEfCf5dTyvpqxTrM93fPqnsQB3PegNC2Z7pn5/H4AyUxIXCuH9Q8J6xRpKHU4k5EmtfN02Ho0XUT3VgTFBeT+62rfbHtHHtz/ttFV+XtV2R05Q7TGl8hlezs8XuRO/KvmGeCdgsuhA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256303; c=relaxed/simple;
	bh=jqaMg616BhstWmDS8XPA9yURNdhIMKlspazlXf+Mz04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS97XS+4ntiS6Yei0+Uf6uGaRT2NQx3qSjAZErULu3pFb8afHmSC2RFN5YkLz74Ymydh8HHwxf05U+hzsmKtDgqn7i6/JJZz1UQC9KFNMMJ1eVrIGp3JwrUFaDBr7tanuyOQwns85AR+smsUgRi580evzrnHR8UtlSeFD7qLskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJr/37iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7402DC4CEE7
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748256303;
	bh=jqaMg616BhstWmDS8XPA9yURNdhIMKlspazlXf+Mz04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tJr/37iJ34IQfS9IpGcTF3eJ1ueDZXdoyGwgrd506t8sTE19I1ukV6EolFR1t/1V5
	 v09X/yk8bH/PG7BPN7RUbP2wCbVZmpXmd+656i4M8ekxt9BHCdeywCs2E+zKKTKsVr
	 dMgl5cqBqKqSF3MLTKNDup+U315fmhOcO9EqOXQxQ71JMrIqO+dMId5DbQ3koQYyDe
	 De3C88ediBkPlJorFJb0kTxuSx7JPFYeyh9FNK6qQ7PUpOeR+gNWxuuKVHFyG/GT2r
	 JfJ4YDYxim+ojhJ62dFQga9/1BQ/IRnuYmtDjgtJCeFJ/16fGDE+yQ/ekoo7XdZY2P
	 963r4Hw4Qa95A==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f94b7bd964so1259100b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 03:45:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRab/t0Klg/2YaQxriE3oKNsiL/Da3xkuKXjGJyjGd8WFefmmF4xtl2TtVSXNlDU5s0pfcVcskjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywdon7D7L0CPb1z20Zw+xZXEf+Mr+8w6CHGiRQG6j/kVY+RvuI
	8ML7BXE6IGAGthUMCnf6mo7KGD5ld0OtwQPr3ofH5Ea4JtjWVQo3E5tcuMlCykALpS3CU796biO
	di7ra3+V7V+GWCxSVw18zO+qMNYcBg60=
X-Google-Smtp-Source: AGHT+IEIYvxf+h6LQCqnIpg/EsJ+9iST6pwxFN/hoeyWKHOppsdB7FjMMdXR4AVaKuSlo+pBQkM43mPM3keNHPTGa2k=
X-Received: by 2002:a05:6808:80c3:b0:404:ed12:453 with SMTP id
 5614622812f47-4064682bebcmr4930416b6e.19.1748256302813; Mon, 26 May 2025
 03:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526063647.ydi7vlqdiguf7cof@vireshk-i7>
In-Reply-To: <20250526063647.ydi7vlqdiguf7cof@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 May 2025 12:44:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEts2_SBPi4gV5TzUP0K-9-Fy09qBJ+V75E9U+SCyPMw@mail.gmail.com>
X-Gm-Features: AX0GCFtPiI2DEjsaSj72KqwhmKEAhAP4xqBEFO4VF6-h5vlMuesujp0XeQJxUbc
Message-ID: <CAJZ5v0iEts2_SBPi4gV5TzUP0K-9-Fy09qBJ+V75E9U+SCyPMw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.16
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 8:36=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.16
>
> for you to fetch changes up to 03eadcbd981b4c9b10ec89a046deeccb115c98b3:
>
>   OPP: switch to use kmemdup_array() (2025-05-19 15:37:53 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.16
>
> - OPP: Add dev_pm_opp_set_level() (Praveen Talari).
>
> - Introduce scope-based cleanup headers and mutex locking guards in OPP
>   core (Viresh Kumar).
>
> - switch to use kmemdup_array() (Zhang Enpei).
>
> ----------------------------------------------------------------
> Praveen Talari (1):
>       OPP: Add dev_pm_opp_set_level()
>
> Viresh Kumar (6):
>       OPP: Remove _get_opp_table_kref()
>       OPP: Return opp from dev_pm_opp_get()
>       OPP: Return opp_table from dev_pm_opp_get_opp_table_ref()
>       OPP: Use scope-based OF cleanup helpers
>       OPP: Define and use scope-based cleanup helpers
>       OPP: Use mutex locking guards
>
> Zhang Enpei (1):
>       OPP: switch to use kmemdup_array()
>
>  drivers/opp/core.c     | 428 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++--------------------------------------------------------------=
-----------------------------------------
>  drivers/opp/cpu.c      |  30 ++++--------
>  drivers/opp/of.c       | 205 +++++++++++++++++++++++++++----------------=
---------------------------------
>  drivers/opp/opp.h      |   1 -
>  include/linux/pm_opp.h |  32 ++++++++++--
>  5 files changed, 262 insertions(+), 434 deletions(-)
>
> --

Applied and added to linux-pm.git/linux-next.

I gather that it doesn't depend on the Rust material, so it will be
included in the first PM pull request for 6.16-rc1.

Thanks!

