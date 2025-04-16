Return-Path: <linux-pm+bounces-25544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A59A8B7DB
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 13:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F893A8338
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1692288EA;
	Wed, 16 Apr 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2djHsS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF5236A77
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744803939; cv=none; b=keoOKyzUgJOgj4zDKlV9T2Qn9N7BT6CW/MIcztyf6RbwzI4Z2eTb4yj20JtBV2prdRA8CU2XFAT2OzECu9KruNm0ZalL+/WFqU6+IlpYEXODJrpNIR18/RvRHn0db6YPd4RtfAe5D/NvXQzs/jp+fdthLNLLkLkKlJtRMUcRyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744803939; c=relaxed/simple;
	bh=HDnVGE+zRCpKFFkkeRATIvnVQNFupKFenPMeWpevB90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4hzYtw4vXxiUsp1LXrhz9XeNpRtnXIyNDSb5Zaai9jlw18WxTx1szS6J9EAtFNcpoxkz8YGY8x5itC/mNAViBdrTVe8mMhcmwAPjbjE9RYR90JTCDdDNjQMd2LdlRVsYCshz2rL8hqVAoiZdYI5qoWYnalS71V86gOaJMYOiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2djHsS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE99C4CEE2
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744803939;
	bh=HDnVGE+zRCpKFFkkeRATIvnVQNFupKFenPMeWpevB90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L2djHsS0/3GPGGaa6151bneoAUu6B9tUnOs8bbt/ZZMAlXZxh/uHGEllYHtYwuS3I
	 QKeMOPv3wk3ERFnp52Y9vu++SnK5/rCgooxclcNeOuXsAKDBCy3UHyxucgvksfBOZM
	 LfXkMaeTYRg68GkQQ5u4KAbbiDph6tmKHwqQ8YkVsvhMAoY+t0h4mwel0ipcmLq3i0
	 ZyhLySA9926PCFYPdkru0FTfXv6Yi50g218gOg1k8nVNVfcPsoMbOPRA0s1z/e5ZHB
	 ANlmAPK6QVIBEA9UDgU95/+G7QpNdpFw/nswxZYHvzReSD/PQiR+RIa15z3wiNfMrM
	 YReFs3QyvWSRw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6047ec0c998so756935eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 04:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa0BK6aBbPt+K2xKbvNA9rmcFg0JCp0Yu+KXZxK+dYF2WLr1P2B6ypsFCJWVniZJaaK7bKQxc1ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNplue5K9HmwOG7MOwYTNdU2vNVoF6/rrWsnSP0z/mpOM3jfKw
	CxR3BRDWNBn6wU9RvMjxmgyb2kJGcHNFH6whstvIk9foVGTq+5n5LuWLZzNNZ6YkcmoNujxcvlI
	Smh0OhNF9qCc15JYCMiRtV4GkgKM=
X-Google-Smtp-Source: AGHT+IH/QMbb5Up4DtSWYuDStG97xoj+z1MTvanJl/xHqETlR2/zN8P6OiKRdqjFwZe1pKSz2ak3rY3YSIOE9lyIvW8=
X-Received: by 2002:a05:6870:2316:b0:29f:a0b8:6f7f with SMTP id
 586e51a60fabf-2d4d2aa82aamr700811fac.12.1744803938648; Wed, 16 Apr 2025
 04:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317145430.2153013-1-dedekind1@gmail.com> <20250317145430.2153013-2-dedekind1@gmail.com>
 <bef2b554e81e60f9c88c25699989840f2ef0254b.camel@gmail.com>
In-Reply-To: <bef2b554e81e60f9c88c25699989840f2ef0254b.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 13:45:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwoR+Zw94CYmWmRbQXkkyQaz785SQ9ueOgQMmbe9FO=A@mail.gmail.com>
X-Gm-Features: ATxdqUFG_M3XOPhCTfVHF0NT_cqJ0MOnaIJc_L8lKB0I8ugy2dGqnrvZD-TxQoI
Message-ID: <CAJZ5v0iwoR+Zw94CYmWmRbQXkkyQaz785SQ9ueOgQMmbe9FO=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] x86: msr: add 'msr_pkg_cst_config_control.h' header
To: dedekind1@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Artem,

On Wed, Apr 16, 2025 at 1:20=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> Hi Rafael,
>
> I was thinking to send this to the x86 mailing list as an RFC, but I have
> some doubts still. May be you could comment.
>
> I keep the entire patch in the reply for convenience (did not strip the e=
-mail).
>
> On Mon, 2025-03-17 at 16:54 +0200, Artem Bityutskiy wrote:
> > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> >
> > There are now two places where the C1 demotion feature gets
> > enabled/disabled using the read-modify-write semantics:
> > 1. The Intel PMC framework (cnp.c).
> > 2. The intel_idle.c driver.
> >
> > Introduce a common helper function enabling/disabling C1 demotion bit o=
f
> > the MSR_PKG_CST_CONFIG_CONTROL register.
> >
> > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > ---
> >  .../include/asm/msr_pkg_cst_config_control.h  | 41 +++++++++++++++++++
> >  drivers/idle/intel_idle.c                     | 10 +----
> >  drivers/platform/x86/intel/pmc/cnp.c          |  7 ++--
> >  3 files changed, 46 insertions(+), 12 deletions(-)
> >  create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h
> >
> > diff --git a/arch/x86/include/asm/msr_pkg_cst_config_control.h
> > b/arch/x86/include/asm/msr_pkg_cst_config_control.h
> > new file mode 100644
> > index 0000000000000..3593e0fe650a7
> > --- /dev/null
> > +++ b/arch/x86/include/asm/msr_pkg_cst_config_control.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Accessor functions for the MSR_PKG_CST_CONFIG_CONTROL (0xE2) MSR, f=
ound on
> > + * some Intel processors.
> > + */
> > +
> > +#ifndef _MSR_PKG_CST_CONFIG_CONTROL_H
> > +#define _MSR_PKG_CST_CONFIG_CONTROL_H
> > +
> > +#include <asm/msr-index.h>
> > +#include <asm/msr.h>
> > +
> > +/**
> > + * msr_pkg_cst_config_set_c1_demotion - Enable/disable C1 demotion.
>
> Doubt #1: on some platforms C1 demotion is enabled/disabled using a
> different MSR. For example, see
>
> https://github.com/torvalds/linux/blob/1a1d569a75f3ab2923cb62daf356d102e4=
df2b86/drivers/idle/intel_idle.c#L2083
>
> for Bay Trail and Cherry Trail platforms.
>
> > + * @set: Enable C1 demotion if true, disable it if false.
>
> Doubt #2: OK, so here we have a boolean - feature enable/disable. No assu=
mption
> if enabled =3D some bit set or if enabled =3D some bit cleared.
>
> In general, not specific for C1 demotion: sometimes feature enabled =3D s=
ome bit
> set, sometimes feature enabled =3D some bit cleared.
>
> So far so good.
>
> > + * @other_bits: Additional bits to set or clear in the register.
>
> But here:
>   * if set =3D=3D True, other_bits will be set
>   * if set =3D=3D False, other_bits will be cleared.
>
> So if we happen to have a "FEATURE_X_DISABLE" bit in the same MSR, this n=
ew
> helper function becomes not-so-helpful: we cannot enable/disable C1 demot=
ion and
> FEATURE_X using one function call.
>
> And also it is just a subtle assumption, reducing the value of this funct=
ion.

Well, I'm not 100% convinced myself, so it's probably better to drop
this one for now.  It can be revisited later if need be.

Thanks!

