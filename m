Return-Path: <linux-pm+bounces-38617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C1C85E18
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2AD3B38D4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6FC2264CD;
	Tue, 25 Nov 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFEh9N57"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAB22D4C3
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087014; cv=none; b=e+HFp0Jn3XvunL09/Dddli55dlik1BChoLN4a0nh9cWAJ59srKlggd+Oc5WRgAIoI+a3xj+7P5JcpsclK7kbvHHzW0cnO5pEHUi1EXiBDZfVGabHnux7HSswXxmALKMYlzo7+hAg2q9GPQE+s1uiIEdeQxGaDOcrpVDLqydefqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087014; c=relaxed/simple;
	bh=DkMFAXncqVs7yHI0H/MAH2wEPMydZbhL/jPtK+KRCuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ox60iw9yrfuoSWMTURM/KzlsxE7guFLy6c1ZEUm76DsPjDEhw2CDBvenDFaXjjn7Gr/VKManbWK2cpXNR74VynJJOAe9fKTMLtXCJq5+sJL9DkgQ8rLsTIFPHzT1taHBvLD/u6A6tYUIpw+L//aeGlyUDawTx1t48uPtaINgvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFEh9N57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12DDC116C6
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764087012;
	bh=DkMFAXncqVs7yHI0H/MAH2wEPMydZbhL/jPtK+KRCuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hFEh9N57rfr+pZ+78DvlqAZ5YAYNzUpJu4o6uleR2oqiWUU8+5ZORRlW3GjEjYJNm
	 7+qWlHUlzBXZIecz1z+/kJqstX+olP0aWVnQtFYCK/SXIbMAgmTFBnzVWM9zAmaJti
	 5WvoZRaIrQwkuzSxfCeg8zRzarBXYntkEfRI3BBzH5lyP/YEIjfrQUXCtgh1Bs0eD6
	 DwLgc3Xv9XAnhChj6C/DZpn8GdcSPb7w1KWevhufXLVsPSjaTQe9lMag0ma1rBgA9A
	 7/tuL7nK6yrYaaMkZJE/Kx0MRFBZ5D0lcOHt57PHvcuaLAK6TnT+A60m5t0QKTuHzz
	 BsPMjs/QIfWOA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-65745a436e6so2272706eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXERO43CGBsjZ20SjnkYRBexw144uxcaeiXp8Ee8e5ccptMLpUwzAIPaJ6nBM9XM44ZStBhte6FTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gt+divNdSJ8WnxjYvXmxKi69VZ6A1O8ajHueOaXOJWZcmIWP
	T48M+KuHJDKXn1ilTYAxarIkUt6Sm4+iwUslzajTYMe7MywlAXmxQTYCSNnYBFJcSAMEhZIb79n
	R1wFFshAKx/GaRmkWyyYGO0cZ/xlRbPk=
X-Google-Smtp-Source: AGHT+IGL4bQv1TODkVJ68/ezdMU1UFTdVyV9cBrnkLeKG5LNN96W62n8RE41ZAtpvhuco4BOS9sb9HXpQMrXm2RyT9I=
X-Received: by 2002:a05:6820:1507:b0:657:5629:2cef with SMTP id
 006d021491bc7-657bddc0372mr1182047eaf.4.1764087012112; Tue, 25 Nov 2025
 08:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gypfpu4vlircby4x7oyaydeihzmcnuifym6qeui7w33qh3jbke@ekpc5xijbdvl>
In-Reply-To: <gypfpu4vlircby4x7oyaydeihzmcnuifym6qeui7w33qh3jbke@ekpc5xijbdvl>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 17:10:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hLi9W5FbyWwRV6bj-H7t3Zff1W1vWH2-DJ4=z9he3tvQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnTBW92UqMjiniQICkhQ611jB-NDovMQoE4JjWBe80y_Y9W0Bt8K8Xcmrc
Message-ID: <CAJZ5v0hLi9W5FbyWwRV6bj-H7t3Zff1W1vWH2-DJ4=z9he3tvQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.19
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Nov 25, 2025 at 8:47=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 211ddde0823f1442e4ad052a2f30f050145cca=
da:
>
>   Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.19
>
> for you to fetch changes up to 33ffb0aa8ce8b18aaa65e0f9346d52b4e314ad7d:
>
>   rust: opp: simplify callers of `to_c_str_array` (2025-10-23 20:51:17 +0=
530)
>
> ----------------------------------------------------------------
> OPP updates for 6.19
>
> - Minor improvements to the Rust interface (Tamir Duberstein).
>
> - Fixes to scope-based pointers (Viresh Kumar).
>
> ----------------------------------------------------------------
> Tamir Duberstein (2):
>       rust: opp: fix broken rustdoc link
>       rust: opp: simplify callers of `to_c_str_array`
>
> Viresh Kumar (1):
>       OPP: Initialize scope-based pointers inline
>
>  drivers/opp/core.c |  69 ++++++++++++++++++++++++++++++++++++++---------=
----------------------
>  drivers/opp/cpu.c  |  16 +++++++++-------
>  drivers/opp/of.c   | 125 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++----------------------------------------------------=
---
>  rust/kernel/opp.rs | 114 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++-------------------------------------------------------
>  4 files changed, 176 insertions(+), 148 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

