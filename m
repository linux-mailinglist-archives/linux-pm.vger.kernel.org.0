Return-Path: <linux-pm+bounces-20440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C494A111BD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEE416803E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E6208983;
	Tue, 14 Jan 2025 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR3why6V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596561FC0F9;
	Tue, 14 Jan 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736885544; cv=none; b=BF6Hp7//K98JWMQhb8oGB1DL+OVm94qWaLMZmaXkCrCSUa74Zp8SMRjhCuHmGnr7eQmogzAZSYVlnscFa3LB49n1aGk/6knSw3wiHcEwW4M0OiwPk7AfGwgElV9Yk5CJI3Ls8BKOLcL1LRXe9/wyms4Eg4ZltSOKq9bwkULr+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736885544; c=relaxed/simple;
	bh=xL15pMpHBJFr71Y3LN9z9oZF+sH3txjyNiiSsieHxO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwwUUpe2R6W7ExEvXxnufQPn2SyHN73VofuHqzGnnVXt/3ytqcUZogkPgwOvuF9+UyukqDPkigzpUIw+M5tOVE90bP3LcLUXdss5tl50dmWEmKwLv0vfjq1m4fNv5QJOl2/DHBz9o4cjVHmr2ne7E1ITZdTRnXKyIOvwblvXNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR3why6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C98C4CEE0;
	Tue, 14 Jan 2025 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736885543;
	bh=xL15pMpHBJFr71Y3LN9z9oZF+sH3txjyNiiSsieHxO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LR3why6VZ92YLb/7xJptM0V8EuqxFOsPDMMLEDCRpZaI2I2LdiQLQEHSoW+BJ79fG
	 wMzTbd/kzTHL8N1LbdVjjM1JuuhBS+wsTrqEbsSvJESyMwe+qdg9AtHO57/RJqGj4w
	 C7J3PyshmiIO6jddnnu8A/4YRd7udFT2eOxJrfVqcbs9kOQfyXD98fHB0SwuDBqytA
	 S4PQ1wWxUjGc2CR7KXUORT8Ybal6D0RqPzGrYsVaRUjS4tfqzJw09kdYQDB/JB5JTa
	 CLeOG/YIIPOx1f8MMPxe5zIqo71fwsxb8l8+AI+i0D+N4b/Toib6P7HYRTPXWiHF7H
	 AycWoKpM1mrvQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ebb2d8dac4so3081154b6e.0;
        Tue, 14 Jan 2025 12:12:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKyqgdA7z5FaKORjoPrTs5qnfYGj94BpWs/cFnyYrk5aNbleZUoXNREleBwgsVfo8uqbu9Fx22Vcs=@vger.kernel.org, AJvYcCXQyZ4XYUzzOY023kQtFui1B9ypCcn6zBLO7NqEvOfiNCkNGaWtzdkN/ksNH3oEJXm9KcK7NXppNDFTrbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0C70+gbCMg2e9sDy6q0Eql4U+9rb50HwUrq8GnKLV2S6CTKhe
	sq0FmLypp5/aRrMPrHZKuSV6r9dYiPEI/5IZfpgZ+Qn6sGVAvkBlMtEz7xRRCPuJwxvmJezWDpQ
	9eAGVhh48Ua5mFhv+wCbA+4eq1ZU=
X-Google-Smtp-Source: AGHT+IHAkWmj7RWT3ZyvuPB2+GRiopm9vAgKSio0zp1BkA/P53eLiGh6Fgh/0ufRVg3C4fqGCGfNAoVeabgqyccVsaQ=
X-Received: by 2002:a05:6808:1315:b0:3e7:9f1f:b84a with SMTP id
 5614622812f47-3ef2ec9074cmr15017039b6e.21.1736885543113; Tue, 14 Jan 2025
 12:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113044107.566-1-gautham.shenoy@amd.com> <98bcf90d-0bbc-4bb5-b678-67296e476680@amd.com>
In-Reply-To: <98bcf90d-0bbc-4bb5-b678-67296e476680@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 21:12:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iA-mV=unGYsxYhcG_gRZE3VRhNzCB=-9_Lbem8D-z_uw@mail.gmail.com>
X-Gm-Features: AbW1kvarO4C3y8VmC0k2m86wdr504CUaLWhS0nL5KYx3YaG6bqBU4x8T6Mgb8rs
Message-ID: <CAJZ5v0iA-mV=unGYsxYhcG_gRZE3VRhNzCB=-9_Lbem8D-z_uw@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix max-frequency computation
To: Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adam Clark <Adam.Clark@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 3:23=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/12/2025 22:41, Gautham R. Shenoy wrote:
> > commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover
> > boost frequencies") introduces an assumption in
> > acpi_cpufreq_cpu_init() that the first entry in the P-state table is
> > the nominal frequency. This assumption is incorrect. The frequency
> > corresponding to the P0 P-State need not be the same as the nominal
> > frequency advertised via CPPC.
> >
> > Since the driver is using the CPPC.highest_perf and CPPC.nominal_perf
> > to compute the boost-ratio, it makes sense to use CPPC.nominal_freq to
> > compute the max-frequency. CPPC.nominal_freq is advertised on
> > platforms supporting CPPC revisions 3 or higher.
> >
> > Hence, fallback to using the first entry in the P-State table only on
> > platforms that do not advertise CPPC.nominal_freq.
> >
> > Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover b=
oost frequencies")
> > Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.14 material, thanks!

