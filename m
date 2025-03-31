Return-Path: <linux-pm+bounces-24663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BFA76D89
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B069166BD7
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293E213244;
	Mon, 31 Mar 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r80VaeSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAD40BF5;
	Mon, 31 Mar 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450083; cv=none; b=nxo4TXmLIb9gWNZHd9SqzoncvCbEMFxoIam16mgNU347ZQoT7jHQSJI/SbGjUqAMoq4Z1pwVCBLeSiUClHf/3sGVaD2np+UR5F0dFffx1CnG5A44eKWf3CKq0jwHjbhp3qQ2FtdaedZD7D/DPEXXbUNYboZoXwJp5dC6U4YHlQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450083; c=relaxed/simple;
	bh=qaWL4TU0Awb1LTT6HDl5So4Xv8h9NicvGNB/pMEd/k0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sYukBjWS/KBrLm/AuYRx9mrASTI74l2cHtwSH4QVG/cSTEC+Ip7IH8lFzbq4OkHp8X4wNFDvODojPOSnZ5SfGLVqG8t/UdK7vX5I3Wm+GdIwPx/zuZBzTUqxvxW/UT4AvwpSjFwmt4N5iaWieM+4JjP9qYsiLVXlzhZDv3/lzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r80VaeSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EE7C4CEED;
	Mon, 31 Mar 2025 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743450082;
	bh=qaWL4TU0Awb1LTT6HDl5So4Xv8h9NicvGNB/pMEd/k0=;
	h=From:Date:Subject:To:Cc:From;
	b=r80VaeSqlVlYn4OF9yw5WhU5uiMQvsns3toGGPJYgCWX6I2dTPHA5Ero/fGWVsJIR
	 OJGrY5drvTPFGzOdF0Gw79TM2MZLo8HLCAwaOoptYsMoxgWrH7uwIJZOB8XOYlMkEu
	 i5HaqqoweChvt1YtgMlZc+Fx7GqYZPX+ZVCdsWBtOCWtzvolLIpZ4vDQo7/NOQSzE4
	 Dwpdk25W3HdI8peybvDEOkxtWbRX8xMYhn8LLSInYK7sF72TpybwD4F/dFc2fqqlh4
	 KiUWpIRsDYLOy0tgEbgfziQ3lxj6oh0JhjxUYqdSFIab0IyZpVAl0MQt64P9UCC9qf
	 mBG33MCpGLcjw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c72cb91e9cso3352538fac.1;
        Mon, 31 Mar 2025 12:41:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNyNYbTc+JfhbY/3aJar7ahYfD31g2x8kAVZbdhhIQ86jLrGoMI/Q+1pKXEK/MRPYnmO8aDLLKTaZP5t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZefWzvO3an5dQl25m6F8BWdAX55u91FA3B6IlRHo9O7QJ3R98
	BoGJdGzuLfn2/qweWB1qMYnffJE6sum0rKVnOuC5oIkJOTLdupl8P3/mc8A5Noj32/JBq0ZS0ua
	8zzG2h0IdpMJhCHQAsrN81n/tVQ8=
X-Google-Smtp-Source: AGHT+IGx89IjAu/cI0Yd8gBWcTB/iKUw0LRONE6jnU8EfLZJsM9VhOZjti/ziTOb46kRv3H8OBWjXEwYk3TYwO0EoHQ=
X-Received: by 2002:a05:6870:798c:b0:2c1:d516:66c1 with SMTP id
 586e51a60fabf-2c870e3510amr8155263fac.12.1743450081641; Mon, 31 Mar 2025
 12:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 21:41:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZdrpxXC8e=-uiJaHx2irYAgkW=kZ6OqSfOK2Fxc6=JQ@mail.gmail.com>
X-Gm-Features: AQ5f1JovMZRXBLS27hQ2Tudg5erIgYV-yZ5PqSnMPui_fqxeqPhFODi-emCQG1g
Message-ID: <CAJZ5v0jZdrpxXC8e=-uiJaHx2irYAgkW=kZ6OqSfOK2Fxc6=JQ@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.15-rc1-2

with top-most commit 12da0fee4543ffbd50ff01b16153cc6ca2f7453a

 Merge tag 'thermal-v6.15-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit c3b659b74541f4564f9f5a39f65e625c47e77e21

 Merge branches 'thermal-core' and 'thermal-misc'

to receive more thermal control updates for 6.15-rc1.

These are mostly assorted updates of thermal drivers used on ARM
platforms:

 - Use dev_err_probe() helpers to simplify the init code in the Qoriq
   thermal driver (Frank Li).

 - Power down the Qoriq's TMU at suspend time (Alice Guo).

 - Add ipq5332, ipq5424 compatible to the QCom's tsens thermal driver
   and TSENS enable / calibration support for V2 (Praveenkumar I).

 - Add missing rk3328 mapping entry (Trevor Woerner).

 - Remove duplicate struct declaration from the thermal core header
   file (Xueqin Luo).

 - Disable the monitoring mode during suspend in the LVTS Mediatek
   driver to prevent temperature acquisition glitches (N=C3=ADcolas F. R. A=
.
   Prado).

 - Disable Stage 3 thermal threshold in the LVTS Mediatek driver
   because it disables the suspend ability and does not have an
   interrupt handler (N=C3=ADcolas F. R. A. Prado).

 - Fix low temperature offset interrupt in the LVTS Mediatek driver
   to prevent multiple interrupts from triggering when the system is at
   its normal functioning temperature (N=C3=ADcolas F. R. A. Prado).

 - Enable interrupts in the LVTS Mediatek driver only on sensors that
   are in use (N=C3=ADcolas F. R. A. Prado).

 - Add the BCM74110 compatible DT binding and the corresponding code
   to support a chip based on a different process node than previous
   chips (Florian Fainelli).

 - Correct indentation and style in DTS example (Krzysztof Kozlowski).

 - Unify hexadecimal annotation in the rcar_gen3 driver (Niklas
   S=C3=B6derlund).

 - Factor out the code logic to read fuses on Gen3 and Gen4 in the
   rcar_gen3 thermal driver (Niklas S=C3=B6derlund).

 - Drop unused driver data from the QCom's spmi temperature alarm
   driver (Johan Hovold).

Thanks!


---------------

Alice Guo (1):
      thermal/drivers/qoriq: Power down TMU on system suspend

Florian Fainelli (2):
      dt-bindings: thermal: Update for BCM74110
      thermal/drivers/brcmstb_thermal: Add support for BCM74110

Frank Li (1):
      thermal/drivers/qoriq: Use dev_err_probe() simplify the code

Johan Hovold (1):
      thermal/drivers/qcom-spmi-temp-alarm: Drop unused driver data

Krzysztof Kozlowski (1):
      dt-bindings: thermal: Correct indentation and style in DTS example

Niklas S=C3=B6derlund (2):
      thermal: rcar_gen3: Use lowercase hex constants
      thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4

N=C3=ADcolas F. R. A. Prado (5):
      thermal/drivers/mediatek/lvts: Disable monitor mode during suspend
      thermal/drivers/mediatek/lvts: Disable Stage 3 thermal threshold
      thermal/drivers/mediatek/lvts: Disable low offset IRQ for
minimum threshold
      thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
      thermal/drivers/mediatek/lvts: Only update IRQ enable for valid senso=
rs

Praveenkumar I (2):
      dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
      thermal/drivers/tsens: Add TSENS enable and calibration support for V=
2

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

xueqin Luo (1):
      thermal: core: Remove duplicate struct declaration

---------------

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  48 +++---
 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |   1 +
 .../devicetree/bindings/thermal/imx-thermal.yaml   |  40 ++---
 .../bindings/thermal/imx8mm-thermal.yaml           |   8 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  18 +++
 drivers/thermal/broadcom/brcmstb_thermal.c         |  11 +-
 drivers/thermal/mediatek/lvts_thermal.c            | 103 ++++++++----
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
 drivers/thermal/qcom/tsens-v2.c                    | 178 +++++++++++++++++=
++++
 drivers/thermal/qcom/tsens.c                       |   8 +-
 drivers/thermal/qcom/tsens.h                       |   3 +
 drivers/thermal/qoriq_thermal.c                    |  47 +++---
 drivers/thermal/renesas/rcar_gen3_thermal.c        | 107 ++++++-------
 drivers/thermal/rockchip_thermal.c                 |   1 +
 include/linux/thermal.h                            |   2 -
 15 files changed, 409 insertions(+), 167 deletions(-)

