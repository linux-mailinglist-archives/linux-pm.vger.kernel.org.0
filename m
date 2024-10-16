Return-Path: <linux-pm+bounces-15797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7939A1424
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE6C1C22046
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C32144C3;
	Wed, 16 Oct 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZYa5g+i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79982F9C1;
	Wed, 16 Oct 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111068; cv=none; b=VhDvxB8qJidDIY9daNC2+dCRSEXyRig8FuAZYsv2moPKL3zlm8TIXYdzoCWAM6UnSW/WBwhQDPmnFYsLXszNZJSTFSHPOX18tbrD/T4okDVG79e6Ab2rpqawJTsi6aeKVRJA/TQbrfABbf0/w1ycyNN7WcjXOI4YeoAhaQBzixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111068; c=relaxed/simple;
	bh=a22KOg6/0QhVhl9Q7ie8IX+K0Lw+hQnqXMS7D/S42Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NukGL1EOmW9tANXgEIlko1WT2ucf0JX1tLh+is8NNgWbCVw1BhL3ycoEvCNM+kFvw1Q76kEOmV9G602OPmaobC6bixbuIfNVb3pT7t2TxqhLzyvEXF5hr3rXTERdgveCtvXtpjt5GIWMgm3sNH5PF/A4pcYeCM02i++ejCG8+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZYa5g+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00961C4CEC5;
	Wed, 16 Oct 2024 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111068;
	bh=a22KOg6/0QhVhl9Q7ie8IX+K0Lw+hQnqXMS7D/S42Rk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PZYa5g+iSMaI4H5wmQ4oSvbR9hp8rIEufxOAoRfsbcY5gJNfndqb2PnXBF4SUWpqN
	 OBfa2fFvLfw+9/bEBB9vfg3kkZKvmeOARtxOk7wLhZK8cLK0xJFiB0/z7clyH1Xn5W
	 7s5aNSjwslLWsyaRb9d82bQtWkWZD+9XQQ3zCoZYvLFP4zR22K/iEiJQ0CW+BxeeaH
	 T5+iUuk8t2Tb5GfV2h5Pcb802WrBUflLDa4X3ytbVMw+qT/KeIiaK40Fytfhnygd1g
	 sa9N/UtvGqRqDX7V/cL/1FTgykQFkl6KmjURsFKFcyo2uY/pRk68y+NDyKV49zQqdS
	 9ABV+14ola9Og==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7157c2aca3eso125101a34.0;
        Wed, 16 Oct 2024 13:37:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmrVbTBAwuEgPP/XCKb1JMPk3nE+QfAmkYIJp0sDXCBXK8hS2ClXxWnoI4VXQy79M5KxjKw7ojdBk=@vger.kernel.org, AJvYcCVlX3KATGsy3oIV8gnHEyAEFMVuhOp4NLozmR5xFl4dgzIG/TYiZ1yyPD/zrtR0Ngg/j+hDm3Y+wcaYz/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVpXqXELx5U8gtEHaGV51+PdtADiUUyNIfIY1CWq8vjCySF9O
	6hM2rOVN0R50R2yv98GyNJjhBa9AuOxAb7zWHWqjsNO66D2z9L+SckvBsOcLpbwC9gvPleIhYJA
	Oey4fxSmuf6rT7SJL3dNQYEUPgBY=
X-Google-Smtp-Source: AGHT+IHo0sXK0iP3u2ux2CHT2+gWa5VRrHGENK7IhQm+2J1J7nU3kp/59ByTRPw2WRaI7ITK0nLwVjoGKyiz3l03lEw=
X-Received: by 2002:a05:6870:56ac:b0:260:ee13:e665 with SMTP id
 586e51a60fabf-288edfb72e6mr4523159fac.37.1729111067309; Wed, 16 Oct 2024
 13:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016154851.1293654-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241016154851.1293654-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Oct 2024 22:37:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDH6w-gjE+cr-c4Dp1ekZnMgjjSgyo5f_qfQQ9OpT99w@mail.gmail.com>
Message-ID: <CAJZ5v0gDH6w-gjE+cr-c4Dp1ekZnMgjjSgyo5f_qfQQ9OpT99w@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl_msr: Add PL4 support for Arrowlake-H
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:49=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add PL4 support for ArrowLake-H platform.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index 1f4c5389676a..cbe07450de93 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -148,6 +148,7 @@ static const struct x86_cpu_id pl4_support_ids[] =3D =
{
>         X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
>         {}
>  };
>
> --

Applied as 6.12-rc material, thanks!

