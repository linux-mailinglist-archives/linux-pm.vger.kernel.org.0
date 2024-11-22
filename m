Return-Path: <linux-pm+bounces-17971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08409D64E0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 21:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760A9B21EA8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B57186E34;
	Fri, 22 Nov 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWccrsvr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E216EBE8;
	Fri, 22 Nov 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307324; cv=none; b=LePlS4ID8NoSF/zCpYjx0wM61A7vbgE4oL6jcncdifIxDQF3MhrakOoS3F40JQsu82FAcC7NLMJi6SHPjveNYFpLn7Q/yEOsnDCLnPbrmxQjfDPYrjGzGfq3429WEZPkIgkXyoRqgiQkaCRq0SlAgaqE4t7pV6SJsV27ZGnqlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307324; c=relaxed/simple;
	bh=8pbwFD1pXlTE4I3rHgjDYEJfrvrrakHNiScBBGhMdMA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B/SS3jT79eIp2QW03VL/HAmeCXXNlvVk3tdQvxlTyQkttULfZoC0pyrfW8P6PijMUlGbGn86ijUdQrLTqVGzIYhn5FQ0ZyKCvg2dBVVJMPn0/h9S4PokxUyS3Egae7nZCNoBb5H3DpySe1hdjsSVxMDMF9Zy72OQ3ddt4KXh49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWccrsvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1C6C4CECE;
	Fri, 22 Nov 2024 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732307323;
	bh=8pbwFD1pXlTE4I3rHgjDYEJfrvrrakHNiScBBGhMdMA=;
	h=From:Date:Subject:To:Cc:From;
	b=jWccrsvr9rcszHkzM5Rm3GZHGDkoVMHO7VR5JBJzRq4qxUopepSUB6VGSutR+v76s
	 IgrMKxc8Naz1sQVp143jlaGoSu8wjOrijCTjC7JkHk5gbQbnLw2PGuv+Yd6yjdYsrq
	 cwz7kJ8bgcRhhTOGbyjt7YLoxWYgqZ7M8qzrNe8lmiFyY/pcv439MdrZD8Gs44e0CW
	 qvtGZm2lU5BcwWa+pEIvnwErZnRxxacdvKf+zwdHTPoJtXD0ImIZ8qWBBwPafQb+jU
	 g61nU7KyySvJKGOcDSABnhxG4+hcTdEgoHkYziJgvJJ+KRHMkd+EIQvaomRczf3ELK
	 +t4XKH9n3A6mw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2965e65ce89so1703666fac.3;
        Fri, 22 Nov 2024 12:28:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEhmDtGzvTF8Qo5VZoHKeXo9Hq7dPuZV2a+vy76FTYIchIJWkLMkT3iWkvoo77AbinJ8B1qfnLBPDgIj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOW8XThed/SoxONKHtcpqlJOl8Eke0b5oTR5RA16BEIf4L1wic
	Y3tsWLwTij3vIZpvA0dykjELCJy8+95V+jMvQvcG2pFx+kKuf7E5cbWkFUY+3Zrfbkl0dSBnTfO
	2LkZOM92FFxXVDMCwqoCcZGsuZZc=
X-Google-Smtp-Source: AGHT+IHHkuyFgu/8v41hqXbGWTQCaboHziVlllWNlj9zUOFing2gQnfgfHe3cytPQfsC645WdqmOvpdbkZ6xrJSztQU=
X-Received: by 2002:a05:6870:d90c:b0:277:d8a7:f63b with SMTP id
 586e51a60fabf-29720e60fb8mr4191795fac.39.1732307323146; Fri, 22 Nov 2024
 12:28:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 21:28:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gm1JRjTCqNSmjTJ_xXhXMLyk4BJc97SxbAeopocDqc5A@mail.gmail.com>
Message-ID: <CAJZ5v0gm1JRjTCqNSmjTJ_xXhXMLyk4BJc97SxbAeopocDqc5A@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.13-rc1-2

with top-most commit fef664fd73c12c11a4c4a40bd38beb8542505573

 Merge tag 'thermal-v6.13-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit cd7fa3e1b0bc9c210eba23edbe8d6884f0368281

 Merge tag 'thermal-6.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.13-rc1.

These update a few thermal drivers used on ARM platforms and thermal tools:

 - Add SAR2130P compatible to DT bindings in the QCom Tsens driver (Dmitry
   Baryshkov).

 - Add static annotation to arrays describing platform sensors in the
   LVTS Mediatek driver (Colin Ian King).

 - Switch back to struct platform_driver::remove() from the previous
   callbacks prototype rework (Uwe Kleine-K=C3=B6nig).

 - Add MSM8937 compatible to DT bindings and its support in the QCom
   Tsens driver (Barnab=C3=A1s Cz=C3=A9m=C3=A1n).

 - Remove a pointless sign test on an unsigned value in k3_bgp_read_temp()
   in the k3_j72xx_bandgap driver (Rex Nie).

 - Fix a pointer reference loss when realloc() fails in the thermal
   library (Zhang Jiao).

Thanks!


---------------

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (2):
      dt-bindings: thermal: tsens: Add MSM8937
      thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens

Colin Ian King (1):
      thermal/drivers/mediatek/lvts_thermal: Make read-only arrays static c=
onst

Dmitry Baryshkov (1):
      dt-bindings: thermal: qcom-tsens: Add SAR2130P compatible

Rex Nie (1):
      thermal/drivers/k3_j72xx_bandgap: Simplify code in k3_bgp_read_temp()

Uwe Kleine-K=C3=B6nig (1):
      thermal: Switch back to struct platform_driver::remove()

zhang jiao (1):
      tools/thermal: Fix common realloc mistake

---------------

 .../devicetree/bindings/thermal/qcom-tsens.yaml     |  2 ++
 drivers/thermal/amlogic_thermal.c                   |  2 +-
 drivers/thermal/armada_thermal.c                    |  2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c          |  2 +-
 drivers/thermal/broadcom/ns-thermal.c               |  2 +-
 drivers/thermal/da9062-thermal.c                    |  6 +++---
 drivers/thermal/dove_thermal.c                      |  2 +-
 drivers/thermal/hisi_thermal.c                      |  4 ++--
 drivers/thermal/imx8mm_thermal.c                    |  2 +-
 drivers/thermal/imx_thermal.c                       |  2 +-
 .../thermal/intel/int340x_thermal/int3400_thermal.c |  2 +-
 .../thermal/intel/int340x_thermal/int3401_thermal.c |  2 +-
 .../thermal/intel/int340x_thermal/int3402_thermal.c |  2 +-
 .../thermal/intel/int340x_thermal/int3403_thermal.c |  2 +-
 .../thermal/intel/int340x_thermal/int3406_thermal.c |  2 +-
 drivers/thermal/k3_bandgap.c                        |  2 +-
 drivers/thermal/k3_j72xx_bandgap.c                  |  4 ++--
 drivers/thermal/kirkwood_thermal.c                  |  2 +-
 drivers/thermal/mediatek/lvts_thermal.c             |  6 +++---
 drivers/thermal/qcom/tsens-v1.c                     | 21 ++++++++++++++---=
----
 drivers/thermal/qcom/tsens.c                        |  5 ++++-
 drivers/thermal/qcom/tsens.h                        |  2 +-
 drivers/thermal/renesas/rcar_gen3_thermal.c         |  2 +-
 drivers/thermal/renesas/rcar_thermal.c              |  2 +-
 drivers/thermal/renesas/rzg2l_thermal.c             |  2 +-
 drivers/thermal/rockchip_thermal.c                  |  2 +-
 drivers/thermal/samsung/exynos_tmu.c                |  2 +-
 drivers/thermal/spear_thermal.c                     |  2 +-
 drivers/thermal/sprd_thermal.c                      |  2 +-
 drivers/thermal/st/st_thermal_memmap.c              |  2 +-
 drivers/thermal/st/stm_thermal.c                    |  2 +-
 drivers/thermal/tegra/soctherm.c                    |  2 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c          |  2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         |  2 +-
 drivers/thermal/uniphier_thermal.c                  |  2 +-
 tools/thermal/thermometer/thermometer.c             |  7 ++++---
 36 files changed, 62 insertions(+), 49 deletions(-)

