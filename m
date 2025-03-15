Return-Path: <linux-pm+bounces-24116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB2A62E50
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA10418954C5
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A193201270;
	Sat, 15 Mar 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSwny3M0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBF1F5829;
	Sat, 15 Mar 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742049651; cv=none; b=RW5C5JyjRUR/gXLorCXrJ4FNzjUFHhFeWJKVOBaHYx2RVFJDKbSDnnpiHxUFy6u9uL4N2mu3nBPvC3BnphZDaMX2gAv2AC4HVDqyBmRbzj0vU+UdLboRslQii7i5p3QvLQpCO9RCyWbECl4qH3UmMbL1bIQ2ExUlwH+cCnYt4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742049651; c=relaxed/simple;
	bh=jukAIyNl6zV7FQ8eFLX6hEnx9n+cyDrr7s4BAmlCCuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zrkr2K2+jwNYyImD4XBQheQHEjwJFHxHgVakbG27+0kxy2NuYQWQv8EuxFnXdLYsn+X31ibq9A0Qc3StasOk/bW0h4vA0PZkwzT6qoiXYeWTl870Ao6Xp3F26QK1/1ip487e7Qo70h0EOcXLZoOOoxguPMMKq4xAjh8NcbccS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSwny3M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DCEC4CEF0;
	Sat, 15 Mar 2025 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742049650;
	bh=jukAIyNl6zV7FQ8eFLX6hEnx9n+cyDrr7s4BAmlCCuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tSwny3M0Fy9L4SEF9o06O7gWchKf8FInavY7KvaBt0UqMwJcGvDZb/+mg/QlWzdBq
	 XyniZKc2llefHOlfDThCV7xHjoqk2jD9Y+ctNKYeoC3GAvdFb+TLX/k0PC41bWp5eT
	 gfAB7T+rmYHlHgEgJPhUQjewpf2uWwbT71XTL3766WChXkDDUFAkEJELTOAbFC6x4k
	 wuravzjpeMqnWGJqFqEVq1lidAoCnq6sXujNarGxKSb5kkO04F1w04Q3Z/vnk8Ac49
	 rxVtxt9ZM9ePnqyyVp1GtyzOtHutBpwbOgtH1heHe0olf24Ik4blxRj/6z9Zb4i1hN
	 o9+jDbsHYByCQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2bcbd92d5dbso1665633fac.2;
        Sat, 15 Mar 2025 07:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwJjescGEjZ3ZsspRmAbIMgxvRKyDzS78oer2B3QMjIl9dh5Kh19fGyxu1NWbjcVapF8xeaE6lbjAAx+ev@vger.kernel.org, AJvYcCV3YB5hEnVdQq6FSOZ3GwpoHTUfXTXs48En0l/EILgKUhJGFAWSkbrbfkmtYoSC8HZeYkYxjX+/iu0=@vger.kernel.org, AJvYcCVnt0yvkLBFEYr6ZIbpM++K67ahRYauVva62y+qUE7snv5IAEvJEuEz8sJPjaYYnL0pdiLJViBZ5JQ0@vger.kernel.org, AJvYcCWjLaBweURmIuivgjrJC/ebKqDnTXO0a29Aez1RBxZqhOZJ49C3zKTFH6EG4HelnpeMshJgw18nXU1tD6WpPw+da+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgTeXuNu2dFWXg9+eWtAZmjgPdW7OeM5RKlgrnx4fMcPRo330
	+3A1syex5bwkdKRwaCtTMynAV3Tunbgjhz2wL2NWk2DdVTO20KtTHgXCZQz8QjPnFlSVPE+UnvS
	w6crnHnasUBRBv+dulbKdKNWN1AU=
X-Google-Smtp-Source: AGHT+IHik3WQQoX9zF5tpYBAQvaTiEqRAZgWWvK14P5mWp9ukc+dySow79iOHU/fbGpqaKacY4VYneA6saIrQxgTb/s=
X-Received: by 2002:a05:6870:80c7:b0:2c2:542b:bcdb with SMTP id
 586e51a60fabf-2c690ec423amr3207224fac.1.1742049649762; Sat, 15 Mar 2025
 07:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 15 Mar 2025 15:40:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jBeJqSoSzfKLZ6oSDFEU43u1HZUVd3dH_vrbHjo0Kx9w@mail.gmail.com>
X-Gm-Features: AQ5f1Jrwc1Zf-QXqmckFCMck3yH4PHI7ibYOMynl9qIg3YCFIP5fQlhd2k7H5PE
Message-ID: <CAJZ5v0jBeJqSoSzfKLZ6oSDFEU43u1HZUVd3dH_vrbHjo0Kx9w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, niklas.soderlund+renesas@ragnatech.se, 
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, magnus.damm@gmail.com, 
	claudiu.beznea.uj@bp.renesas.com, devicetree@vger.kernel.org, 
	john.madieu@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 1:13=E2=80=AFPM John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> This patch series introduces a new thermal cooling driver that implements=
 CPU
> hotplug-based thermal management. The driver dynamically takes CPUs offli=
ne
> during thermal excursions to reduce power consumption and prevent overhea=
ting,
> while maintaining system stability by keeping at least one CPU online.

So as far as I am concerned, this is a total no-go.  CPU offline is
not designed to be triggered from within a driver.

> 1- Problem Statement
>
> Modern SoCs require robust thermal management to prevent overheating unde=
r heavy
> workloads. Existing cooling mechanisms like frequency scaling may not alw=
ays
> provide sufficient thermal relief, especially in multi-core systems where
> per-core thermal contributions can be significant.

What about idle injection?

> 2- Solution Overview
>
> The driver:
>
>  - Integrates with the Linux thermal framework as a cooling device
>  - Registers per-CPU cooling devices that respond to thermal trip points
>  - Uses CPU hotplug operations to reduce thermal load
>  - Maintains system stability by preserving the boot CPU from being put o=
ffline,
>  regardless the CPUs that are specified in cooling device list.
>  - Implements proper state tracking and cleanup
>
> Key Features:
>
>  - Dynamic CPU online/offline management based on thermal thresholds
>  - Device tree-based configuration via thermal zones and trip points

So DT-only.  Not nice.

>  - Hysteresis support through thermal governor interactions

I'd rather not combine thermal governors with CPU offline.

>  - Safe handling of CPU state transitions during module load/unload

Are you sure that it is really safe?

>  - Compatibility with existing thermal management frameworks

I'm not sure about this.

So one of the things that CPU offline does, which you probably are not
aware of, is breaking CPU affinity which is a very brutal thing for
user space if it is not expecting that to happen.  Also it migrates
interrupts between CPUs that also may confuse things.  So don't do it
from the kernel, really.

Thanks, Rafael

