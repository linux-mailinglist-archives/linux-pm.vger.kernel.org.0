Return-Path: <linux-pm+bounces-15416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71764997289
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AE11F22F89
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C75188917;
	Wed,  9 Oct 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRHtkKJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645976026;
	Wed,  9 Oct 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493394; cv=none; b=UAtaVBcDgTA2d+5HhALPQ4C/oGbuofm3Rx8ZES7a3ltK4MbI4m7Dv2wa16hiTEKExQQET0L2z7Gy27HBU0BNUr2+q2ukux3+ZvHNXbxMdbCd7WCaFdLN5meBKDfYOK1ZDAKFPXQNVW+S7lJJVBKtx2p7PT4X0lfn/kgrJEJGea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493394; c=relaxed/simple;
	bh=UgK6pJLf1ERG7XQHDvEFtGSLVGz7aD5S0uQBp9C2OaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFMS9GESRWj8/kxrg9YYOFsFle94ZI0NAhl4c/WjM4iyk4/5QcpQ79J1RISWVmB7ML28O5Z7x4SdoqTidoWyGyfQeSKuE0xJj7vTkYSisCG2Uhurew7/BuQniET6Nd8Jys7AQPHBM4bW7yVSsUQ2dqbhEjWn3etLRZzCMjv6dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRHtkKJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC4C4CED3;
	Wed,  9 Oct 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728493394;
	bh=UgK6pJLf1ERG7XQHDvEFtGSLVGz7aD5S0uQBp9C2OaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dRHtkKJM1D9VsHVmCkUyccCOmZttdlLVzr48sk2aDHEo8rba15rsbdOysUO77qp42
	 3NSAglZSI910X6884v7+vsnDe5zgRCX9cbHYEreSFnn5oz9IrNWENA0sYc+LXGkiAW
	 7JT2ffYqwOpq40u09xW2dscN2wQpgD+AdwVrLPTVumFgKhb3Ao5nWNJ+tEjxrPr/Ad
	 oDftAm4AnkTTZHJHNAsjA9FPhQsr+7PcTA7FMN3NPDFNc0Z+Uf0AhkfreG5c60krqR
	 k02NHp0ugFyD8l4yVtQA2LcRDL79qllky1SMDRJP7L3FDkT2EIxghuMVGKXMalrRM/
	 WEHuM7B4R3lOg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-716a5c58506so9970a34.2;
        Wed, 09 Oct 2024 10:03:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGbL3V2cbCSBvPelWnp4oq4XvuWabOrldsCQ8PG9wAjbRmPESISiB/NS2/Duy8unF5h7QGFEm+j+Y=@vger.kernel.org, AJvYcCWOL3xy6lp4ApWsCca72Qaq2QijxmlcSs5EIv4PQYDkSrK1MCuEl885tfUGsrWrEMsvWKrulbK+/6jdY/g=@vger.kernel.org, AJvYcCXOjit01gY7wHUb3SnGOCVh6VIF1yjSAXXlbrBTuj7Z+YM8Sk0pu7Quf/gjIkVGqU96wKyfV8dI@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUMZ780VzzCq0HAQV3RsN7LbnKudu0P25Qk8rc+csbm5cDkIi
	h31k+fOKzFg0TUVMC3HBK8+YPHBf+X/3+TKbOEcj5ovf0UpyAqT91G8ILsvtVZyIBDloUNRZfbq
	KlHslZUazaszTbfZC1vvILVyK7Ys=
X-Google-Smtp-Source: AGHT+IGnvG1JA9bGvqb7FznEPF+8+hBsbYv2jdcGhxDLU8SAtGhti/j9l64R/uy0x8yNAwXccUn/tLbF436E3DOKzGs=
X-Received: by 2002:a05:6830:3697:b0:703:7827:6a68 with SMTP id
 46e09a7af769-716a4199fe9mr2927977a34.6.1728493393380; Wed, 09 Oct 2024
 10:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com> <CAJZ5v0hVhYhKbiNc_DAqbZqRNe=MAmS9QCiL4uAw-m-U19M=2A@mail.gmail.com>
 <1a91fc10-58f3-4d1f-9598-df5267774874@intel.com>
In-Reply-To: <1a91fc10-58f3-4d1f-9598-df5267774874@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 19:03:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jryxPs4HichjNscsLvvDzSGsRa88dtcjeAdEijx-cV=A@mail.gmail.com>
Message-ID: <CAJZ5v0jryxPs4HichjNscsLvvDzSGsRa88dtcjeAdEijx-cV=A@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, 
	linux-pm@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/9/24 04:24, Rafael J. Wysocki wrote:
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > x86 folks, this is quite nasty, so please make it high-prio.
>
> How much linux-next soak time do you think this needs?  We'd ideally
> like to give it a week in x86/urgent.

That works, a week in x86/urgent should be fine.

Thank you!

