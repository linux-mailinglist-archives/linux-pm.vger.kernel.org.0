Return-Path: <linux-pm+bounces-18941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356759EB9CD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF281674E7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D232046BB;
	Tue, 10 Dec 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZieEOc4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F652046AE
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857600; cv=none; b=l8QWUgjkJtR/izDY0rb/hWLyXBhzlfY7XT9vJ5a4i3VTWOb6OigThctOHkuyYhDfQLMxJ8+8wAYHw+jVqnmPD0hCBzvbDixHN1yrC+c9FeNctlLHA+ZLwcResL/zmtQsGvHY3axn/qJjPSdDqZ9kIjNObu4j/doazcZl5tdfVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857600; c=relaxed/simple;
	bh=bg3qDfQE0vN50DaaZPRwJJc/vWdcF907WITtedF3LL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEWiqr3A+ruSi0VPPQ8FykWq2bpaRn3ZTI+f+lbEt6TZkO/jmEU2o+Qm9u+bfFfsON4X1JS+u7Tf6ZSs7eM5hcyVx7UVXwP9Cgg/YS91IrYKlaDXm5Kwn8rsvbee98WGj6xBBL9gDbEgf7Smv0KFwRCABf3i/UaUHOFwFSfmgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZieEOc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18298C4CEDF
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857600;
	bh=bg3qDfQE0vN50DaaZPRwJJc/vWdcF907WITtedF3LL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZieEOc4trr/cGGMKvEqPLFdPg1in3u8eDoFofqRNTDkYbC6baQiNngBOZy3A0rFv
	 Rps8kL8Tk+SKFIoK2iGayuYiuJMB4gRUx0Et6xTrsGacpm/X7dYvTDyCsGdL/Xg6hc
	 3Mtk8nC6BeeX6lqmSR6JZEYiVGF/ZWTfCUo+VNah+seKoFMN+Ab3hmPrpRgnDJ/ADU
	 /kOyUznI2PWIx9eqX+6hs3Yp0FoK04h11Dgggux2z4eyavLdLYxTxU4uMV2zft57wa
	 IcZHzc0f2S4/UASnoZ6niENRFpARz9sTk8u1KqM7JW/sQgv4wynMlOmTLVlPa95kel
	 Y0IfGBE2LYZpQ==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71decc7de4eso712617a34.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 11:06:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWREyq9HKQsaRxEseRiCPCDkIayPihJW186aavHLO/WQX/6LEPMBkZ2BNJ6wV2MV7saIJwqys9cBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1+DqDfQQevGl7peWGwbns227EIkvhNhz69JB6cy67uVVsBac
	aqm97wMe2MthIAdEXRftfG2pRyOCvV49wqotHJjEcET4JUV1MzUpzvK56Ko013Znb0E/7JDJvfu
	Uh1n4e0Ne7jdbrjDWGs6KzPjJWOs=
X-Google-Smtp-Source: AGHT+IHZ89WLW2w1ljNHkgStLGdAAZXqBbPeBCUhskWu2mQp9x0hi/a0zRoRMzxVtEVMwUpEzAmi6LK2b6KIHIZrARw=
X-Received: by 2002:a05:6830:650b:b0:718:1163:ef8f with SMTP id
 46e09a7af769-71e1979c23amr21994a34.2.1733857599407; Tue, 10 Dec 2024 11:06:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203130306.1559024-1-artem.bityutskiy@linux.intel.com>
In-Reply-To: <20241203130306.1559024-1-artem.bityutskiy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 20:06:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jMXOUQD1AR7GHFZzc0SnvtdNj6fEq=NQ_ei5MR4YC2wA@mail.gmail.com>
Message-ID: <CAJZ5v0jMXOUQD1AR7GHFZzc0SnvtdNj6fEq=NQ_ei5MR4YC2wA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Clearwater Forest SoC support
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:03=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Clearwater Forest (CWF) SoC has the same C-states as Sierra Forest (SRF)
> SoC.  Add CWF support by re-using the SRF C-states table.
>
> Note: it is expected that CWF C-states will have same or very similar
> characteristics as SRF C-states (latency and target residency). However,
> there is a possibility that the characteristics will end up being
> different enough when the CWF platform development is finished. In that
> case, a separate CWF C-states table will be created and populated with
> the CWF-specific characteristics (latency and target residency).
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Note: the patch is against the 'linux-pm' gree.
> base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index ac4d8faa3886..23d0cd27a581 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1651,6 +1651,7 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,     &idle_cpu_snr),
>         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,     &idle_cpu_grr),
>         X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,   &idle_cpu_srf),
> +       X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,    &idle_cpu_srf),
>         {}
>  };
>
>
> --

Applied as 6.14 material, thanks!

