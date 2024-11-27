Return-Path: <linux-pm+bounces-18176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA419DAD32
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C69B21182
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080C32010E6;
	Wed, 27 Nov 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO4fxDVy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7D1BC3F;
	Wed, 27 Nov 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732732507; cv=none; b=VWqvw2EFOQmJN75YiJ0O5sURsxI9VRXx6zXQKYkiUvEBdB9baGVYAoBAaTWucHMFgtt8CplNT7xwTSizC5Ox/aohMMDY4XFWOstV0iP6QdncTjJ415NERkmmGJj1dGctjcFnmYmgck5kbafh6b4WyxuDZNbL4ogoXdXO/B3SabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732732507; c=relaxed/simple;
	bh=/mMvaV0aHwY/gsD1R8j4w0XmyEzMyEII6eygRRQQY2Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JtEWn6FwlOufCQogKVvc0o7Df/55Df9KmBxJM6WvBiLYIdWV8lBhW8oayCEWpv5XUdREiPL28plHatfOsTkqsCiQhJolct8dL5WcSosRxpUkItyVqrLoaN1Y8Xv00izzoFkFPNHuBX+JpgDyO6HIhYUGiwhk+bhAxPxdMKInKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO4fxDVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8702C4CED2;
	Wed, 27 Nov 2024 18:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732732507;
	bh=/mMvaV0aHwY/gsD1R8j4w0XmyEzMyEII6eygRRQQY2Y=;
	h=From:Date:Subject:To:Cc:From;
	b=YO4fxDVyp791lbXJ9jHhDFWEopWsjM+FSxksMVJNdRZ9JwWQyawGGCi0QBZy9xksG
	 csikGcqJsZZH3sE2IdcucG0LdERrZBXpntDQNeBIH31pvo6T1DDyETI57+qPXW00A9
	 NOrgxhk29mi8UNQXTYMviYe4oyTQ+nztKqFHC5dosrjO9qyCvA0k56FwezcdQbcBcR
	 CreFntHLVrlO+bEJaSn6o2up9iKGERgedowT5rIbEGWpnzEyah4krpK+Cz1bPGuji8
	 tm+MssG3uHeNRRqsh649Vz+j8gL1CM2huBy0qrMgwjxOrZ4vz+VbCVHMG/kVmT7H2n
	 F6hAs5mRMaZyg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-296b0d23303so52842fac.2;
        Wed, 27 Nov 2024 10:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNURJ0mSGIRft5i/VQbJEJCyc3dHC/IQhE+OL9pxs2eGjBBiPUMP9aHjbxT3kHkS+vcxhA+o9bdZYkScE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaptPlALNSEG/39rQmm+UCWE/u4J1TUXqA9Lyxle3+Xu+pkXVP
	QbyEtACy4HM4CRYH1UXZJlX9hO7P/KAsU28/vZdkCwSeKIw8oTvH52d9BPWjBBSbIXJLuqfciHG
	WvnQ1ZXZDw1663AiKQoAfhBcqgdw=
X-Google-Smtp-Source: AGHT+IFm7XploE6REnShpmAAhLH7Sjn/TChvw2z8TfyL00YhL6PMkfFtMZ1QuzTg8AXkXKDW6y7fU1RGu94ESDLctwk=
X-Received: by 2002:a05:6870:3313:b0:278:22d3:53 with SMTP id
 586e51a60fabf-29dc4006fc9mr3602538fac.12.1732732506933; Wed, 27 Nov 2024
 10:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Nov 2024 19:34:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gpH46U5bJ5OvZ6JXAvFkzb3P6+=N3zBOPSvQNjgmCHDg@mail.gmail.com>
Message-ID: <CAJZ5v0gpH46U5bJ5OvZ6JXAvFkzb3P6+=N3zBOPSvQNjgmCHDg@mail.gmail.com>
Subject: [GIT PULL] Additional thermal control updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.13-rc1-3

with top-most commit 4dc333c6c28c49943a571f09c3868e5058552016

 Merge branch 'thermal-intel'

on top of commit eb78332b1067776ca4a474ccfd92460014e8d8e3

 Merge tag 'thermal-6.13-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional thermal control updates for 6.13-rc1.

These fix a Power Allocator thermal governor issue reported recently,
update the Intel int3400 thermal driver and simplify DT data parsing in
the thermal control subsystem:

 - Add a NULL pointer check that was missed by recent modifications of
   the Power Allocator thermal governor (Rafael Wysocki).

 - Remove the data_vault attribute_group from int3400 because it is only
   used for exposing one binary file that can be exposed directly (Thomas
   Wei=C3=9Fschuh).

 - Prevent the current_uuid sysfs attribute in int3400 from mistakenly
   treating valid UUID values as invalid on some older systems (Srinivas
   Pandruvada).

 - Use the cleanup.h mechanics to simplify DT data parsing in the thermal
   core and some drivers (Krzysztof Kozlowski).

Thanks!


---------------

Krzysztof Kozlowski (6):
      thermal: of: Simplify thermal_of_should_bind with scoped for each OF =
child
      thermal: of: Use scoped memory and OF handling to simplify
thermal_of_trips_init()
      thermal: of: Use scoped device node handling to simplify
of_thermal_zone_find()
      thermal: qcom-spmi-adc-tm5: Simplify with scoped for each OF child lo=
op
      thermal: tegra: Simplify with scoped for each OF child loop
      thermal: sun8i: Use scoped device node handling to simplify error pat=
hs

Rafael J. Wysocki (1):
      thermal: gov_power_allocator: Add missing NULL pointer check

Srinivas Pandruvada (1):
      thermal: int3400: Fix reading of current_uuid for active policy

Thomas Wei=C3=9Fschuh (1):
      thermal: int3400: Remove unneeded data_vault attribute_group

---------------

 drivers/thermal/gov_power_allocator.c              |  7 ++-
 .../intel/int340x_thermal/int3400_thermal.c        | 18 ++------
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |  7 +--
 drivers/thermal/sun8i_thermal.c                    | 11 +++--
 drivers/thermal/tegra/soctherm.c                   |  5 +--
 drivers/thermal/thermal_of.c                       | 50 +++++++-----------=
----
 6 files changed, 34 insertions(+), 64 deletions(-)

