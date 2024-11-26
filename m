Return-Path: <linux-pm+bounces-18124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E29D96FE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F968B29BD8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739981BD9DF;
	Tue, 26 Nov 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8QUjS93"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478321A260;
	Tue, 26 Nov 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622705; cv=none; b=N0ZrmMePkkCPGslQDmBRaSCpnDcryZyYyj7f2CbhduXQKwNJVM0sy3wZa4pOm3Hc0ya2iIfAkUOn5Q4Ixta8NyU9eHZjRQtFNCsHNZTj4KYlctOjl1l6mrQ1MDTSBdsr6xHVgbX0Am/mZsrFhwMAnv19FI34LwXziLp9R8gunCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622705; c=relaxed/simple;
	bh=ixYsko9FNATKwd1BbIBMn/KEfxtTvnWT3vwfn3kXOiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX7S9cWljqWD0IBaNepGKAdQ0y7C6OU0aOm7CBmN/QXSysPFs+kCIRZn9QcsKZWQF/E+VUUL0Dzdj3wfhVTHjVhenLpQU9lQ0fnt3aSYC+sCGmZxzKr9TtOcfqsCag6bpJJH1sk2MrUD4C9y1StnX6PQOOaT/aZgM2WcdMJGuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8QUjS93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4DCC4AF09;
	Tue, 26 Nov 2024 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732622704;
	bh=ixYsko9FNATKwd1BbIBMn/KEfxtTvnWT3vwfn3kXOiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q8QUjS934NKKn33HbdQRDjS86JTvNPuy/qfmy0FTQ6RBzbUFSTnP0OoM39lzdWGHf
	 YY/9kjxAiEGsE3Bf5t9j2sAVS0H+sUkaNp/wDKKkVSHnb8iGzva7BwByVBloF8mBLV
	 hsJQI6YoCeCY9JT4UumNxM8HZYR0Yyz+1XU+Dx0ucKTSTJiAoTAy7p1thcPb87Rrmg
	 Cjo4b0rw0MS6BFmvfv/y9WKdbE/FFwSqxqH5y82Vuac5q4/Hz4vMUOxIdyt4CBITBE
	 nkrL8xgM8B2zAXjRCV/ne3X0PyNTrs3V9eE/CdI6nB6mjVYxio6z1G7cP64meeHa2g
	 yp8aZbLjm820w==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-297078d8eaeso3739277fac.1;
        Tue, 26 Nov 2024 04:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4LvRZUzpgS4jeE5v9iJXMR0rFeGYLD2ENvIvx42IVSgrCpDXzLxHd4eFzGzaBcCe5mtKsdUv8iZwxXvc=@vger.kernel.org, AJvYcCUtw1RNdMAbhKmpSGJ3alr3GCLaoj8M7EF82F28jpTBY9h8KcslpRybJ84LszTTadrQ+k9SRyQ7gSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQD97ZOZcBQP5Hy/zJaYJWH8G7D606Vf2pCuR+zKkG1nvPGP07
	TgY7G3fUp13ApXMHcTXD3/vQ1MeDkIf5EqGHZnhjD3B0LYA+5yAIRVldUJy59fUnL548Kib7wK8
	Isr8+R6lhPdjRmvU7j33NAkUf1uI=
X-Google-Smtp-Source: AGHT+IH/DFq6/c2TqMFz5Gv/miKzQztO1F0pPOZDULXGqlHivzUaYMP3dA4FuaAuQAcUeomf0N+pj2Wey1XvNCQW+9k=
X-Received: by 2002:a05:6870:670c:b0:25e:e6d:5247 with SMTP id
 586e51a60fabf-29720cef3dcmr13413112fac.14.1732622704108; Tue, 26 Nov 2024
 04:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com> <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
 <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com> <CAJZ5v0hZ8ajccb=B7P5g1+KJ+tsw5vP-e9ix7j_65WgT34H1XQ@mail.gmail.com>
 <a8d53d86-d658-4e18-bfd6-b37a2656b180@linux.intel.com>
In-Reply-To: <a8d53d86-d658-4e18-bfd6-b37a2656b180@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Nov 2024 13:04:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iA==dmnPbs6BNV_taDD9hRWbwOhiCWsi0BjKzVVdihdg@mail.gmail.com>
Message-ID: <CAJZ5v0iA==dmnPbs6BNV_taDD9hRWbwOhiCWsi0BjKzVVdihdg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:56=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> >>> If you first make intel_idle provide :enter_dead() for all CPUs on al=
l
> >>> platforms and implement it by calling mwait_play_dead_with_hint(), yo=
u
> >>> won't need mwait_play_dead() any more.
> >> Crossed my mind, but because mwait_play_dead doesn't filter on Intel
> >> vendor specifically,
> >
> > In practice, it does.
> >
> > The vendor check in it is equivalent to "if Intel".
>
> Actually, what about INTEL_IDLE=3Dn?
> We might hit acpi_idle, which would call mwait_play_dead_with_hint() now,=
 but
> if we don't, don't we want to try mwait_play_dead before hlt or is it too
> unrealistic to happen?

In that case the hint to use would not be known anyway, so
hlt_play_dead() is the right choice IMV.

