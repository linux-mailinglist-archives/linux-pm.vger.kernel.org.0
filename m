Return-Path: <linux-pm+bounces-34160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE4B491BD
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 16:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF7D443D56
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A930ACF5;
	Mon,  8 Sep 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUgkLoti"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DC259C9A
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342082; cv=none; b=eRlUnoYXR9YKej0T8e1LY2BMXzrFhUMmBBO056FGm3FeKZ/5mYvO07U/+SYgmWWra2csPzhvN4eBfBu/ESdasY1dRN7hN5zbcOpfvWapbzbJu4sy4jF8vqbRgMOKExNpBwNluL7+VaUrSJSNt1i94f1VIitpwHKKXmiQSUetlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342082; c=relaxed/simple;
	bh=3GY0OWpWOHNsJGdcAJ4fivcqkTY5vb2bek3L/u8Tk0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGeQfeSGgNEaMPcQm5GYP87Jt6oa4v7U+hwWUx6yKfsOnX52zmAS0nz0iIf148Mj7eFtrGZ2lekuZlLE1Uc2nTciyPnW0vIDM8u57H4C/Qfy80PDRwbOSmSMTFgKAjSBfJDLSgHNVgBMhLYB/gIdEPXDUNNKimwNXIbsb9ZLBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUgkLoti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84427C4CEF1
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757342081;
	bh=3GY0OWpWOHNsJGdcAJ4fivcqkTY5vb2bek3L/u8Tk0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZUgkLotiIP5HrV1vbcHgxwBQiUxNSjRg4OWKmTBEAD7cJzMLWfnev5/K4OYh8Z1Xg
	 59Y9RB0e5gr7nPV5bcbnNwEaWjMWUDUV1tJX7+j2745JDnOz8QgqPXwa8KcAdB45F3
	 IVJP8Xgk41+Ty8ftV+oNvS4mi1++9aGJnbgJX0WtN/tJ6yaK+XIPb6UOpxhecKN0A6
	 HpWC1li4nL6VrTVL1bBV1sYNQhakDWFndDwXm9Il8ul6OMYm1oR1Srvi5SK7l6koQU
	 knLb8YgiSzcdYwlOcrm75hVmCUQRgVoPYtfFziEk1b3ydRI4kiNy0/M3q0g8/hQLZT
	 X1/MkFw6xtXdQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-62184a28eaaso229914eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 07:34:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgm9Ur8NWzETdRCG9LdpBBWh4C1Q+WEBsnch1E3TJl4HKW9lzNoWGDtdSOkWtuXV8b2nbbDOe/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08piaJWXzt81UADf+2WZL6hGFOWJRaEvooiLuAiR745HxsYvl
	IcdTSNxhTXrlM4gAvOzbqOb4zmXy6fGcMb8buCYL12w1v28BM4wE5FDGlpw2qETIOu2dvNr2TAf
	OsGfHZkRf1np/1ujqiWbbrwdYBcuwOz8=
X-Google-Smtp-Source: AGHT+IFNVfI9YGG851YsjJRO+kyV/XJNAivOYSJeMYOdb757VPNUouYbtH3jfMbVwG157PI70ZBvA7LpJTzDwKmxu44=
X-Received: by 2002:a05:6820:1c83:b0:621:8ca4:f07a with SMTP id
 006d021491bc7-6218ca4f376mr1928578eaf.1.1757342080791; Mon, 08 Sep 2025
 07:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ae3e51b-b6a1-49fe-8969-7cb60937215b@kernel.org>
In-Reply-To: <2ae3e51b-b6a1-49fe-8969-7cb60937215b@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 16:34:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gffxnGcNzO_m0b=2FQ6m4uZVjuAJ9jg9XSBV1wWqpASg@mail.gmail.com>
X-Gm-Features: Ac12FXw1pxVvNyqJUSCfjBB5QFJ5EUKzroUKZTH3qgFy-FHnHKJPY97KVnFPKZU
Message-ID: <CAJZ5v0gffxnGcNzO_m0b=2FQ6m4uZVjuAJ9jg9XSBV1wWqpASg@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.17 (09/04/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:36=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>    Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>
> are available in the Git repository at:
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.17-2025-09-04
>
> for you to fetch changes up to ba3319e5905710abe495b11a1aaf03ebb51d62e2:
>
>    cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume
> (2025-09-03 09:17:34 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.17 (09/04/25)
>
> Fixes for regressions found from refactor around
> EPP handling at suspend/resume and minimum frequency
> while using the performance governor.
>
> ----------------------------------------------------------------
> Gautham R. Shenoy (1):
>        cpufreq/amd-pstate: Fix setting of CPPC.min_perf in active mode
> for performance governor
>
> Mario Limonciello (AMD) (1):
>        cpufreq/amd-pstate: Fix a regression leading to EPP 0 after resume
>
>   drivers/cpufreq/amd-pstate.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

Pulled and added to linux-pm.git/fixes, thanks!

