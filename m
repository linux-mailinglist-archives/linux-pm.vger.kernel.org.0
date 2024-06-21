Return-Path: <linux-pm+bounces-9754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075C2912608
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E4B1C23AC8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F407142620;
	Fri, 21 Jun 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks9YuL2h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B95374CB;
	Fri, 21 Jun 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974448; cv=none; b=vCTO/3x83SpYUOSciVYTUYlUFBFe8Ek2wAYHFSmRjWbGhpH+grl95NY/8yXddMAvneqY/RHiYW3aNLVAXuNNeSrZt+CZIZ8IzhCiM3D7IxmDopCPlR+voWTNV8Pio/DkO9t3biQMPHBumgMqVRJG09CA0nSnq9jZsOeDLsiHTyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974448; c=relaxed/simple;
	bh=w1jh+HLbyWAzgkDNucoAeQoWSYieKUB9rPjj8XkNJX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa0hTu3IzN1HxT2PIA0obCv+5iss+LW8aZrG5k7BskOyAYGPHpbThx8NkEwV5jX6Q6YRDdxyYAHS6Ug3POzJxdG9LYRQf6RrHpPvrLVa5X2B8lQEMTNrv0+OD+LZ4JM5ConbC1cSqbsxD1B9Zzio1GLxIf81jwIk8KdmeFhYa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks9YuL2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7552FC4AF0B;
	Fri, 21 Jun 2024 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718974447;
	bh=w1jh+HLbyWAzgkDNucoAeQoWSYieKUB9rPjj8XkNJX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ks9YuL2hm+PkKNksQAPAqpNa4ELTcDEavsx9FMH7xpqWztHHK/YcGef2XJNpUSmyt
	 eyEF7B2io68bqUZfzPhzmwP4dGQWnxRkgoFal/kXSrt6r5ef1Ssd+UgGuES4fPz/RR
	 knVOYA9LEQOg551LuGpQq5hChX6aGrTTQC967btwvMgeNUAPSL/Zslnr+wqeN4X79T
	 IBAeHowp793/xlSuEdreR6N34qdUPpeQkVHEu5T+GTNdBdr8i9w1lTNn7hpDwixQuJ
	 c1hNtHFacBHjR3+zMVGyj+/j+pKOQ6zObhI2QCqWCy4aD9m2iX+YF4wbkQUevi4F9H
	 qj/sN/2i8XCdQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d22323a3ccso124732b6e.1;
        Fri, 21 Jun 2024 05:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLrWkarEsvL1YJ8W7o6ogIJb2xa7/N0Lh4PE6tSeZM2ZeFBtVhbKihv1tCytxkufEtm9dXAAaSae7Gsgr142gbwi0WHwSaW5VgWraa8f1pA0GEn1j5ZmZR65gZuwYWDopmKAb5Qj4=
X-Gm-Message-State: AOJu0YzlZVbr5LAzOvatySj786h+58M2x4AanpYBvkAyoxuHSJuzDEXt
	F5s+CTtnkmrtn7bGGmRE5OV+GdBxRFpqNeVJn5egSDt0XPS6bbyeJz5m3VNyafk0W9TK6i1vngb
	z8Vxu2WtqIMPC7zptTXzTiNM+mMc=
X-Google-Smtp-Source: AGHT+IEFB/UDQhiA6ZYJjdkM37zM6Itgk5SEPD9qYYIKNkg/Ngu5ALkJ9MzEDmhElqbY7w/4ZLjVVWKyJ4zj8jZix/Y=
X-Received: by 2002:a05:6808:180d:b0:3d3:a23:8815 with SMTP id
 5614622812f47-3d51b97dcfbmr8954193b6e.2.1718974446605; Fri, 21 Jun 2024
 05:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614211606.5896-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240614211606.5896-1-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 14:53:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5LQeBqHrnESgthmvN8EM8yTs6b5XcaaArSerxr9NrvA@mail.gmail.com>
Message-ID: <CAJZ5v0g5LQeBqHrnESgthmvN8EM8yTs6b5XcaaArSerxr9NrvA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] drivers: thermal: intel: Use model-specific
 bitmasks for temperature registers
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 14, 2024 at 11:10=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> Here is v3 of the patchset to use model-specific bitmasks to read TCC
> offset and the digital temperature readout of IA32_[PACKAGE]_THERM_STATUS=
.
>
> You can read the details and motivation in the cover letter of v1[1]. V2
> is here [2].
>
> Changes since v2:
>  * Dropped patch 3/3 ("hwmon: (coretemp) Extend the bitmask to read
>    temperature to 0xff") as it has been merged in v6.10-rc1.
>  * Used the new X86_MATCH_VFM() macro. (Rafael)
>  * Added Reviewed-by tags from Rui. Thanks!
>  * Rebased on Rafael's testing branch (based on v6.10-rc3).
>
> I have tested these patches on Alder Lake, Meteor Lake, and Grand Ridge
> systems.
>
> These patches apply cleanly on top of the `testing` branch of the linux-p=
m
> repository.
>
> Thanks and BR,
> Ricardo
>
> [1]. https://lore.kernel.org/linux-pm/20240406010416.4821-1-ricardo.neri-=
calderon@linux.intel.com/
> [2]. https://lore.kernel.org/all/20240425171311.19519-1-ricardo.neri-cald=
eron@linux.intel.com/
>
> Ricardo Neri (2):
>   thermal: intel: intel_tcc: Add model checks for temperature registers
>   thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for
>     TCC offset
>
>  drivers/thermal/intel/intel_tcc.c         | 177 +++++++++++++++++++++-
>  drivers/thermal/intel/intel_tcc_cooling.c |   2 +-
>  include/linux/intel_tcc.h                 |   1 +
>  3 files changed, 174 insertions(+), 6 deletions(-)
>
> --

Both patches applied as 6.11 material, thanks!

