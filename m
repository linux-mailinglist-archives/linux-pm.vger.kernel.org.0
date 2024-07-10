Return-Path: <linux-pm+bounces-10921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A992CFE6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F791F2257E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB617BB20;
	Wed, 10 Jul 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cij2auqH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD83C39;
	Wed, 10 Jul 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609049; cv=none; b=K1EvNYIW7cTJ2Mb/vGtFTjaB5XaoaEenvT2zLVcffWMrniSHexWAtc1/9lK2Kie1LYSaMpEFMf1y9oUwwc3XM9RJ0dTkJMinTzXf8vJMVQ1mrRqdubDkaww/SwErTCueX1XkLU1ycKwyicYpHUjiNl3GafdJTIQeJG4tlrRvVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609049; c=relaxed/simple;
	bh=w3ZT/mgC5/A+eD4EiFJycno0IK3QogPOTkzowOc8qQ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a0ALhDl6cCY9HINoUi8w5GQqPEEQFyWkoc+mufwXXS5LYuJyRxaQ4SKKNu8mJwwrQyJYV2B/qosHpEhlBxX+2crqz4y0rKi/T/yJFxINbbgV5vizqhGSrsPjwXMJ/DXh+2pejYsh/kS+hbbAq2YkcmY3QsIw83heJTrFP9lbkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cij2auqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC474C4AF07;
	Wed, 10 Jul 2024 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720609048;
	bh=w3ZT/mgC5/A+eD4EiFJycno0IK3QogPOTkzowOc8qQ4=;
	h=From:Date:Subject:To:Cc:From;
	b=Cij2auqHVOaXGtk5HTFD8rp6ZHrn+S9O/XESRFlfZzTOScZK+iWgr9LsnemyacYOq
	 GXrwrRpibB7tWFvnXHLkiFEe8NpTT3zH7hB2FkE/sxiFUmQu3rD9OYiRcdh5pYvsF2
	 /FfhLt7eRKxvbZh17fSeDBCTVlFSPkiz/92Tj2fpmlYaXT6Ev1fULvqUOhD/0XzjDc
	 GWinhNOcmjlFIoTEefqp760++DArXfilmAQVf2WDxVSWS6ymK85Z1fiJ2a+bkLc6XU
	 DxUdr3Zl7r68oIHtoyp1NTXC1Oz8Nkg87Z1u/ZeF8msy8wuAoJoZiXDbwfSn0T8v70
	 V3Gv42YYiwQfg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e55d0f551so430383fac.0;
        Wed, 10 Jul 2024 03:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+VGu2ESq6Oz2En8GWZYYw2moWj7TvEROvH9OVqtyLi9Rwr7aKS+2fIUPUPbqN4ij95UQDiCJSpaGSCTxFuOFjqIxThAIa6ICH3X/b
X-Gm-Message-State: AOJu0YzwNHO5LfW6PyqBHDvaZUYfxPfqbpAyiKB8zvyOTmcnIJX5P7J6
	1thYEaqQRqqtAiHMJ985DbKS8Trd6cUBJOM3ELyDbtYrmCojmAtLsnayA/XobugniacsDvkTHEE
	phQYqTqC4iikiZLd4khHzwjZhxfI=
X-Google-Smtp-Source: AGHT+IG+GCw0Ch+EoPTwGaC0PwtVGvSwHqkgcyv8XyHAtsf3lhsfNK4IRMk/vDmCgA/12OA367OYbpjDVu4G95VTBW4=
X-Received: by 2002:a4a:b6c3:0:b0:5c7:b126:10c0 with SMTP id
 006d021491bc7-5c7b12612ecmr1836595eaf.1.1720609048146; Wed, 10 Jul 2024
 03:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 12:57:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iomX7aKU5c9-uBiRoVKonwRdCvoT9xNih8401ef7ShuQ@mail.gmail.com>
Message-ID: <CAJZ5v0iomX7aKU5c9-uBiRoVKonwRdCvoT9xNih8401ef7ShuQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc8

with top-most commit 94eacc1c583dd2ba51a2158fb13285f5dc42714b

 thermal: core: Fix list sorting in __thermal_zone_device_update()

on top of commit 22a40d14b572deb80c0648557f4bd502d7e83826

 Linux 6.10-rc6

to receive thermal control fixes for final 6.10.

These fix a possible NULL pointer dereference in a thermal governor, fix
up the handling of thermal zones enabled before their temperature can be
determined and fix list sorting during thermal zone temperature updates.

Specifics:

 - Prevent the Power Allocator thermal governor from dereferencing a NULL
   pointer if it is bound to a tripless thermal zone (N=C3=ADcolas Prado).

 - Prevent thermal zones enabled too early from staying effectively
   dormant forever because their temperature cannot be determined
   initially (Rafael Wysocki).

 - Fix list sorting during thermal zone temperature updates to ensure
   the proper ordering of trip crossing notifications (Rafael Wysocki).

Thanks!


---------------

N=C3=ADcolas F. R. A. Prado (1):
      thermal: gov_power_allocator: Return early in manage if trip_max is N=
ULL

Rafael J. Wysocki (2):
      thermal: core: Call monitor_thermal_zone() if zone temperature is inv=
alid
      thermal: core: Fix list sorting in __thermal_zone_device_update()

---------------

 drivers/thermal/gov_power_allocator.c |  3 +++
 drivers/thermal/thermal_core.c        | 15 ++++++++-------
 drivers/thermal/thermal_core.h        |  6 ++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

