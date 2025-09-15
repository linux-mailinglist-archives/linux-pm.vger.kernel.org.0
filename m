Return-Path: <linux-pm+bounces-34688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C079B58322
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA2E2A33E6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B72C3272;
	Mon, 15 Sep 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoJByf5d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475428B7DA
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956403; cv=none; b=oj0J6uP+v4HxwZA6UIVBXlMnNogpwzw2pZw5BikzPMF0Ls2IHH4tZXCHtI9SQPGj4HMmK3dFHyz2kNAzOfS2dfksKt0A11F5KEnuphQBEvZ0SaPrKwYnGFclNAHG+odtzBXNkVXqx7e1LZ07yLcETVukhjUDmqq0fnjkGbV1tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956403; c=relaxed/simple;
	bh=1oSp1s0dFry3KNYp3t9vHFsIxz86SXd/EE0jv4U2ShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvcE2DAFNBc6Yqke116ra26NkqeM2NiG/5F3v3a2PPRwsCUWtC01qZQ/YaCrpCQ27pZWV0Rq9YsKwwqvkfOwDPlR0qGclhBl1kbGRDf/RlgwyCd3Uj486i7uACSCkypd0QKw/meLRCql+bsZg/PcFCvwlNwKlU6GEyuH5q8D6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoJByf5d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so403608a12.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757956399; x=1758561199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVk/IwWAagDw/u1je9emE3yqPayy79NxUJ1XU+JfvRM=;
        b=xoJByf5d4GagcSUYVtcl7PhxMZ6j2dVqBXHnQ0zSJHMG2fO761p7IPpyJ794c7F7Ff
         /4vn2/Idmq0QMqv+g5zHC+X1L51ns47VP+qhGiX6X7nozvoeXvkKS3hAtwPz2RRyjv1e
         eIfZ3QHDu8wBxuAtDD96JBVfww6FTtYy99x4NEquo+qnaS/3Xti89TOJVGP8lgYl8rTu
         cA68XVwGJmSqyD8ggnLRQcGSHsUwjg/oCbd+4X7/UmCL5fJefipDnBy+kChALQrWpwJJ
         lkVI267JgIPx7hUattrxdtQljUve1GXe8tQS90OelY9FVplM3wzVheJn2e7xy7F8Pwvg
         IYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956399; x=1758561199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVk/IwWAagDw/u1je9emE3yqPayy79NxUJ1XU+JfvRM=;
        b=XmsSIbAR7gYv2D933dtakAUTUrWRsI+Bijnmry37t6L9c7kZXUmz4KNT4tAImw34yC
         NggYDn89Qa6bm1/bfQV1Oi8z/F9VjqGvNCGQ25VprQGEJ+5LsbVRo7GsmDn5LsyMmi21
         r6wnZeY7OEKTvZRZUFTWprRzLj5K8cmpzItzkV7TRCe0pyUPUE+0q/UJ77if8S5eHiYk
         IFl/6FAZ5eWYLVuVeFP9Vn+kdy7ucMyVK0cC+ySVWpp68XYBkSKBYBOeosxeVF0/6fMR
         1djeNYsXE8yNSgYtDGP36hXD039ZKKdMHDmg6Auvbk0oZteW5P3hMseWx0uy1X7BB1Ok
         NT9g==
X-Forwarded-Encrypted: i=1; AJvYcCXNwFCntj1RpZcxWbEay9mekyo/5Vfs/G5tiI6h5t1DuFOBDhF6Ho3HtLCEnWySsBpHgbYuAQYJdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dg4+y0R5xSGWb0zBD5FtQOIWUE2bapfydgRwEoV1SlWk5bu1
	5QiFM9a8Nd8ijlW3NJwAYcyyrpqXzvelWNYKnjgK/PSFtvBo3bqbmNVntXYA2b5SLYCpGSuRh3e
	yi7jt9kUP4O7ZitcAietgUNqDjYVTjaky+rdUD36b
X-Gm-Gg: ASbGncuDBQ1u6DFjeL0d3z8L8aZ60GmEwp073fNa0doOKuJ9MpcfKRWVg0dnWKSnI1v
	2EET9byYayBlFs1xE/BoHlWg/TjXu1ImDOgiZ6D92x0vmglMFasRTs91fJx3GmkVhLxPJ84ilb7
	NXzdlLjg6gin/vZ8D3WPqkT1s5noEoc4FIo8oOvVymeYiTIjFwoMt0ZNYHWYPlFWu4yYfaY5im/
	Dix66Hl2M132kV9g2dVcN02qgA9qA7bki9XtrxvKkNHeTe2Al0qSdyiGkBUrIGj/A==
X-Google-Smtp-Source: AGHT+IE9e1EULEJI4AgWzyYm2QJwTZpaG4jJtqmkHHf2fi6cZM9VIHvmyy6TtgCQIkqVmW1MbSDhcupuqSDyBvZva/A=
X-Received: by 2002:a05:6402:3587:b0:62f:2ac2:af41 with SMTP id
 4fb4d7f45d1cf-62f2ac2b11amr5417351a12.38.1757956398793; Mon, 15 Sep 2025
 10:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com> <CAJZ5v0hShKgPB42p4dOgKoRuMCkGhe+ZHMeAuFQO0Soa1ty_LQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hShKgPB42p4dOgKoRuMCkGhe+ZHMeAuFQO0Soa1ty_LQ@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Mon, 15 Sep 2025 19:13:07 +0200
X-Gm-Features: AS18NWCkhZDDdsM_oejLGVUXgZHAFu-N6GJOxDZIp7NmOXFFGPj3C2juSnvyHaI
Message-ID: <CAF3aWvHTXiODVE72Q33KDS51j4QA7gXVSsvdRnvsHdBv4NzCfw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] ACPI: DPTF: Move INT340X enumeration from DPTF
 core to thermal drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

First of all I would like to apologize for the late reply and thank
you for your comments.

On Mon, Sep 1, 2025 at 10:49=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, Aug 30, 2025 at 7:34=E2=80=AFAM Slawomir Rosek <srosek@google.com=
> wrote:
> >
> > The Intel Dynamic Platform and Thermal Framework (DPTF) relies on
> > the INT340X ACPI device objects. The temperature information and
> > cooling ability are exposed to the userspace via those objects.
> >
> > Since kernel v3.17 the ACPI bus scan handler is introduced to prevent
> > enumeration of INT340X ACPI device objects on the platform bus unless
> > related thermal drivers are enabled. However, using the IS_ENABLED()
> > macro in the ACPI scan handler forces the kernel to be recompiled
> > when thermal drivers are enabled or disabled, which is a significant
> > limitation of its modularity. The IS_ENABLED() macro is particularly
> > problematic for the Android Generic Kernel Image (GKI) project which
> > uses unified core kernel while SoC/board support is moved to loadable
> > vendor modules.
> >
> > This patch set moves enumeration of INT340X ACPI device objects on
> > the platform bus from DPTF core to thermal drivers. It starts with
> > some code cleanup and reorganization to eventually remove IS_ENABLED()
> > macro from the ACPI bus scan handler. Brief list of changes is listed
> > below:
> >
> > 1) Remove SOC DTS thermal driver case from the ACPI scan handler
> >    since its dependency on INT340X driver is unrelated to DPTF
> > 2) Move all INT340X ACPI device ids to the common header and update
> >    the DPTF core and thermal drivers accordingly
> > 3) Move dynamic enumeration of ACPI device objects on the platform bus
> >    from the intel-hid and intel-vbtn drivers to the ACPI platform core
> > 4) Move enumeration of INT340X ACPI device objects on the platform bus
> >    from DPTF core to thermal drivers using ACPI platform core methods
> >
> >
> > Slawomir Rosek (12):
> >   ACPI: DPTF: Ignore SoC DTS thermal while scanning
> >   ACPI: DPTF: Move INT3400 device IDs to header
> >   ACPI: DPTF: Move INT3401 device IDs to header
> >   ACPI: DPTF: Move INT3402 device IDs to header
> >   ACPI: DPTF: Move INT3403 device IDs to header
> >   ACPI: DPTF: Move INT3404 device IDs to header
> >   ACPI: DPTF: Move INT3406 device IDs to header
> >   ACPI: DPTF: Move INT3407 device IDs to header
>
> Please avoid sending multiple patches with the same subject,
> especially in one patch series.
>
> Thanks!
>

The subjects are quite similar but they are not exactly the same.

Originally the ACPI bus scan handler was added in 3230bbfce8a9
("ACPI: introduce ACPI int340x thermal scan handler") to prevent
enumeration of ACPI device objects in range INT3401~INT340B
and only the INT3400 master device had their platform driver added
in 816cab931f28 ("Thermal: introduce int3400 thermal driver").

These days, however, each of INT3400~INT3407 device ID, representing
a different kind of thermal device, has its own platform driver.
Most of them, depending on X Lake generation, can also be enumerated
on the ACPI bus using INTC1XXXX device ID. In addition INT3408~INT340B
and some of The Wildcat Lake device IDs are not supported by any
platform driver.

To make the review process easier and minimize the risk of mistakes
I decided to create separe patch for each ID in range INT3400~INT3407.
The INT3400, INT3404 and INT3407 device ID can probably be renamed to
Thermal Core, Fan and Power device ID, respectively, but I am not sure
about the others.

Alternatively they can be squashed into a single patch which moves
all INT340X device IDs to the common header.

Please let me know which way is better.

Thanks, regards
Slawek

> >   ACPI: DPTF: Move PCH FIVR device IDs to header
> >   ACPI: DPTF: Remove not supported INT340X IDs
> >   ACPI: platform: Add macro for acpi platform driver
> >   ACPI: DPTF: Move INT340X enumeration to modules
> >
> >  drivers/acpi/acpi_platform.c                  | 27 +++++++
> >  drivers/acpi/dptf/dptf_pch_fivr.c             | 10 +--
> >  drivers/acpi/dptf/dptf_power.c                | 20 +----
> >  drivers/acpi/dptf/int340x_thermal.c           | 76 ++++---------------
> >  drivers/acpi/fan.h                            | 10 +--
> >  drivers/acpi/fan_core.c                       |  2 +-
> >  drivers/acpi/int340x_thermal.h                | 76 +++++++++++++++++++
> >  drivers/platform/x86/intel/hid.c              | 41 +---------
> >  drivers/platform/x86/intel/vbtn.c             | 30 +-------
> >  drivers/thermal/intel/Kconfig                 |  1 +
> >  .../intel/int340x_thermal/int3400_thermal.c   | 12 +--
> >  .../intel/int340x_thermal/int3401_thermal.c   |  5 +-
> >  .../intel/int340x_thermal/int3402_thermal.c   |  5 +-
> >  .../intel/int340x_thermal/int3403_thermal.c   | 12 +--
> >  .../intel/int340x_thermal/int3406_thermal.c   |  5 +-
> >  include/linux/platform_device.h               | 17 +++++
> >  16 files changed, 161 insertions(+), 188 deletions(-)
> >  create mode 100644 drivers/acpi/int340x_thermal.h
> >
> > --

