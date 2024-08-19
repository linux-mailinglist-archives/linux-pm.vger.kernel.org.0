Return-Path: <linux-pm+bounces-12424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBD956BC8
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFD11C2321F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB3174EFA;
	Mon, 19 Aug 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAI7A1gj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35D174EDB;
	Mon, 19 Aug 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073625; cv=none; b=n7PIrqxYk/UTBZ1FeBPbRgugnrrMHAC5rjf6qxKgH+xlbF4NoI0SU/iLQ2hywHA4GDOoXygvjjpKTO1B/yiuH9S303XWVUWFC5RLSRLlV1bnk2wJELBzmWMZcPZFWNZUAYmN89gf7AuMzM8wkpRsybBf9hqkb32r+/BMUo/lYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073625; c=relaxed/simple;
	bh=xj7op51M45IqA/PUy/b+1Y6Rjdy7fjY9JLoKVu+9fGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs7Hs+x7bV2Z3Jf6QIlsRABzIGm4ODVhKPD4N2aZ/PQ0UuVwD/hoSP+fHArI8eyPXCW5e5f/czIwuSWhj6KXo/HkVnnT5S5DnecnrS8R+bA8bApUpO3i8dQbw7xaF7+IjKIUpdGBn2GjzzJIg7kxCz0GfXHVu+JPAH6WUHr2hJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAI7A1gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E824C4AF10;
	Mon, 19 Aug 2024 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724073625;
	bh=xj7op51M45IqA/PUy/b+1Y6Rjdy7fjY9JLoKVu+9fGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gAI7A1gjsxWTE2nIxbuLLzmGTrDULOyEpRn3hvg9hqpqp9M07erwG8ufyzQRa1Wpq
	 t7Ood3q0ExlpfK4lRVKcmiiO/h55TN+/J4imqOltWIYRYgtEI9fWDKNvH6cw3NgQcM
	 cMhc8OwalSyWQaOlmsDJxGP1MKNEKEbzHqW65VphMX1KWeUF9QjuJ1EpuKMdn8/Y+d
	 /w9A1EZF5ZjQUoIxy61jR7wXgifY59dYaQlHca0d4WdcvW+8s7cAP7lkf7bMdEcfpT
	 46Qgxtk7wQU4yumzXO2HdhRVD6K9/nevyY3cWWGR1y4KlPibo4HKXs8ci1GEsOZWjo
	 rLSWtykDOXIdA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-26110765976so589699fac.1;
        Mon, 19 Aug 2024 06:20:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEJSdVDhxG4pxR45WnxWFwEckdrpJ5HqRUgkjfXkvoMTW56GJhPp0aCw0XBVcdhmDwk32gJYBZVulKPp07Er6nGiSTIRWBo7OqY/z2TGBoiuK8+NpJOTZhGkFBDqax256U8MDW4z9gAirSMSWdmIv9YD3eqGAQa2wO+DwZaK4=
X-Gm-Message-State: AOJu0YwORhNR+mrFYOl4UC4PIzizgq1Ef/NOjg+VU7x9QB/OP1gH1UUy
	WQ0BMHm7KBa4N5JeMv1gb/y4lIZ+nkELLsn3qknCSpQR0cwOmex7lpYC/m53az03/yqr1zjrq3F
	eZ0ufoRiiX0hxolM6SpNL+bzMa44=
X-Google-Smtp-Source: AGHT+IEv4y6snKL6QJkySVGwP2N+iEGcJHQjH+kFRXSoIMYFYfRWFYvDJCo6nXOPkjHyNvWx9QbwjXO1WM8f0zj3RjM=
X-Received: by 2002:a05:6870:7b4b:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-2701c0a0273mr5816521fac.0.1724073624437; Mon, 19 Aug 2024
 06:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org> <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
In-Reply-To: <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:20:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Message-ID: <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in thermal_of_trips_init()
 error path
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:12=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> > Terminating for_each_child_of_node() loop requires dropping OF node
> > reference, so bailing out after thermal_of_populate_trip() error misses
> > this.  Solve the OF node reference leak with scoped
> > for_each_child_of_node_scoped().
> >
> > Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
>
> Applied, thanks for the fixes

Is there a place from which I can pull these?

It would be good to include them into 6.11 as they are -stable material.

Alternatively, I can pick them up from the list.

