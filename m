Return-Path: <linux-pm+bounces-28820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD4ADAE79
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655923A5A2E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC12C08B4;
	Mon, 16 Jun 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejCg9088"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72812BF3C3
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073370; cv=none; b=r09U/PE28BR+QNy43ImEQj1MsE/Ccp872sziF7UIGznDGPYfC9uyuPVXQigq9c6R2/4zcbySVlsMJXVOInlsz6bfy9097MTvgEhMseDldojL054ng3y/V/2B4N3kye28ALrcKZM/ZZ8qYc5XSWcNOlBbBv97Qt6kn+3cZW5uwXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073370; c=relaxed/simple;
	bh=7IjwdZcUWYBQKL9VGUCb4yBmzGb9AEWFabLOCM0HS8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcXJNRk31RW0yS8ykAuko3qTriEwx0jlzp2myg4GUrdSxVtTpa4Nu8n/gjJK129eJIz9lG5HyJbMtIY0EL7hpOfWd7Wcjee5pQiR0I0bL5WBI3IFkMJxk5SwwJn/4sg9AEGyPoaDOPp7vG07ExTjnVrLulBouRfHSsDQ1fDcZsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejCg9088; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D22C4CEEF
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750073370;
	bh=7IjwdZcUWYBQKL9VGUCb4yBmzGb9AEWFabLOCM0HS8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ejCg90886tSKSNPZCC1V30ka4kmEFXKfBRL3UltqGH7OyCuCGl9se/RmHbplngZah
	 mPOHBi8No+BoMeuAY5qEKMxtdOJEZJvIh5RsKlaiONnmwCVozp76QEaXRuGXQWDmbU
	 0GvPvonkGc+jZvQ9c4XaXL5gCJQMHAhOzIQj18pRJZxPBSelhRe9ayCXkuREDr8DDn
	 qjJdjb0M2e9tm0yjW9Py9zTygDPyfafI6llBtvqzbTlPWAMUu5D8BWcg5J+v8X9xoL
	 WKj49sh2byHno0lYEdtGNSNHAxwL9aGeoZfbVSTC+tPNErHiyWTZZ2aY4oFgeS/79w
	 YOWYSmozxAiOQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-404a5f4cdedso1080367b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 04:29:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YxvLk1wyfpvSxuHBVqEssFJjJ+hQsSuAAGf7nMS6TousgGnM8iB
	PbqNYwvfMsAXTdJryvgpu7g4ZpBQg9nyZbJOCvZB29guyhNq7JpGOpt66yx2Q5duNqdITWH/Z/a
	7LJkPjIepuYDKQvNmmZp89a+a2HIwYWI=
X-Google-Smtp-Source: AGHT+IHh96BxW9sBhS16Q0S7uBjZ+jwb2tkdLGbHxYbgm9dWeG2jbACRD6X4xdb0wn4Ycq9YvXcgmxArX2EYftESOEQ=
X-Received: by 2002:a05:6808:21a7:b0:3f6:ab0d:8dc0 with SMTP id
 5614622812f47-40a7c17942fmr5793998b6e.24.1750073369714; Mon, 16 Jun 2025
 04:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
In-Reply-To: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 13:29:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix-QWgpq_FhnKhSWN5BtBmU_fSWSMJFkr8H1OUm6qJKw@mail.gmail.com>
X-Gm-Features: AX0GCFsSh66F1s0qcDokVMmfTcT6V7Y-lqsgZK6KMMCstmewQA_zEpYxo4IBj-8
Message-ID: <CAJZ5v0ix-QWgpq_FhnKhSWN5BtBmU_fSWSMJFkr8H1OUm6qJKw@mail.gmail.com>
Subject: Re: Subject: [cpuidle] Limitation: cannot model asymmetric C-state
 latencies on big.LITTLE SoCs
To: =?UTF-8?B?6buE5bCR5rOi?= <huangshaobo2075@phytium.com.cn>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	deepthi@linux.vnet.ibm.com, khilman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:14=E2=80=AFAM =E9=BB=84=E5=B0=91=E6=B3=A2 <huangs=
haobo2075@phytium.com.cn> wrote:
>
> From: huangshaobo2075@phytium.com.cn
> To: linux-pm@vger.kernel.org
> Cc: rafael@kernel.org, lenb@kernel.org, deepthi@linux.vnet.ibm.com, khilm=
an@kernel.org
> Subject: [cpuidle] Limitation: cannot model asymmetric C-state latencies =
on big.LITTLE SoCs
>
> Hi,
>
> I'm working on an ARM64 platform with a big.LITTLE CPU topology. While pa=
rsing the ACPI tables,
> I noticed that the C-state latency and residency values differ between th=
e big and LITTLE cores,
> as expected.
>
> However, I found that the current cpuidle framework only allows a single =
global `cpuidle_driver`,
> and all CPUs share the same `cpuidle_driver->states[]` array.

Not really, see bl_idle_init() in particular.

However, on systems with ACPI on which _CST is used for idle state
description, there's only one cpuidle driver and one table of idle
states for all CPUs.

> As a result, only the first core to
> initialize (usually a LITTLE core) sets up the C-states, and the same val=
ues are applied to all cores,
> including the big ones. This leads to incorrect idle behavior on asymmetr=
ic platforms.
>
> I believe this behavior was introduced by commit 46bcfad7a819
> ("cpuidle: Single/Global registration of idle states").
>
> I understand this design was introduced in 2011 to simplify cpuidle and r=
educe memory usage:
> https://lkml.org/lkml/2011/4/25/83
>
> However, on today's heterogeneous SoCs, this global model no longer suffi=
ces. For proper modeling,
> we need support for per-cluster or per-core cpuidle drivers, or at least =
some mechanism to allow
> different idle state parameters per CPU.
>
> Has there been any discussion or work toward lifting this limitation?

No, there's not been any discussion on this so far, but why does the
platform firmware on this system use _CST for idle state description?
_LPI would be a better option AFAICS.

