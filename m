Return-Path: <linux-pm+bounces-15418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8029972F1
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7F1C21F94
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6859313F43A;
	Wed,  9 Oct 2024 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOyPHDv1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80D1A2547;
	Wed,  9 Oct 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494454; cv=none; b=gFz3hIJ436FquVUu37MtsZ9jM9U7tOdMjf5PhYIrU5MTVhxhm+rKA/j1B67mi4E5L1+VVeL4VfdP/p3v45iOLbGo+0lVH8RyKP3bYhjtivvpouhxSCDjYfjbaPr4kMWbbAAv/5p75B/25xyXAjuXeTToHe30x3oRjd1MJE8jLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494454; c=relaxed/simple;
	bh=pTakB2z6V4uiToCgJJtCQlYbxtbwkcxm3E81tLbKCnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alLpkMQ/2sm2AV2vwIMg68OGnRxzV9Ap8KFNb8E/FbSZnTsg3aDbIpUYrNYTAUjEy5JZ6NczKiFP+We80Vqn8g5BN2MeIHc/X8HizAiHrt1cESVNvF2RCgXYYI+M5GBCUnJbYHks5XTJ6Fh5/GVd+Ri8PwJOayvVvjohLeC8drI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOyPHDv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3740C4CECF;
	Wed,  9 Oct 2024 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728494453;
	bh=pTakB2z6V4uiToCgJJtCQlYbxtbwkcxm3E81tLbKCnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOyPHDv1QmrqRwmz6qAgLxSxWIdLod9XcWAluWqm4XHsOTEsZ3vEHW8j6uzhktKsW
	 4CH6+1XMmaiexqo502utA0OABJSNHM6vKc7/KLL2aHenOiOU8cxjtxFnaWV1ChA8j+
	 KN4mrEkqeEXht0wSFkvraxoeNVyNuRKVnL2yR6c24ikUuRyMHyh7IY8ntU0Qo3BXkJ
	 MydKU5Smi3iYx37lsWbHJZtT4tsSTxVliKPlRquVdXT92ypDtMfhWwbpVgnF0hdu18
	 co5bhjGmDqdpNF3t0Q+Bz7s8DElcoPt3BEda2GZG4atm5FZxFGZu7s2dbcr4HqwV5b
	 9K35T9aOA86vQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e3dfae8b87so33303b6e.2;
        Wed, 09 Oct 2024 10:20:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3HXj/rto7m9TyL6WK1yYFtoC+E5uCgP02I8/p1QwVShLP6SUJ5YMF8iYB+BtSYygDPoWsMHJT@vger.kernel.org, AJvYcCX5pYZh10f6QDNH2Ea5yC2NllgDqtAz34egLkWDCHV2CouFkPVK/bz/fjFNaX4+45O4Cpi5mBWY8shqQKQ=@vger.kernel.org, AJvYcCXbs6TIL9znhDXV5RSJrn6pzY+s4yb1zKvL6VHBx7mm2rubUUmgmtxSfStVlZ/TVBGoZHH9/mkLd0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6i/sGtyY2JYHavIf+sAOpTKjp6lg9b7IcXbj03xvJKJcovRKa
	Z0Rhu253Z1KSs8nJvGLGjI4qV9uK3HWKp/VpPQUHEPgrA1uu+JWA5Eug7WdqTN6OoyZ1LpyRpUm
	0Cqn/usXlrbuoG5CexIRFEhz9qvM=
X-Google-Smtp-Source: AGHT+IHC3PCSE9gREtvrXYE4GaDqSOZHeOSFGIw0ZwDYBHAUhhll2B10WHGikC79xTN91cGN+CHyfkEfNtesUXV6GWo=
X-Received: by 2002:a05:6808:201a:b0:3e0:4263:46f1 with SMTP id
 5614622812f47-3e3e66d6117mr2935298b6e.11.1728494453194; Wed, 09 Oct 2024
 10:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com> <20241009163344.GA25814@ranerica-svr.sc.intel.com>
In-Reply-To: <20241009163344.GA25814@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 19:20:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h0=cyvOw6a6nvgigS-71Q2W3pcZOsGyLRhvMucRubvxA@mail.gmail.com>
Message-ID: <CAJZ5v0h0=cyvOw6a6nvgigS-71Q2W3pcZOsGyLRhvMucRubvxA@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org, 
	linux-pm@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:28=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Oct 09, 2024 at 03:20:01PM +0800, Zhang Rui wrote:
> > This 12-year-old bug prevents some modern processors from achieving
> > maximum power savings during suspend. For example, Lunar Lake systems
>
> Two nits:
>
> > gets 0% package C-states during suspend to idle and this causes energy
> > star compliance tests to fail.
>
> s/gets/get/
> s/energy start/Energy Star/

Thanks for pointing these out!

