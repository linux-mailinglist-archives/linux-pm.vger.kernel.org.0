Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455769C21A
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 06:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbfHYE46 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 00:56:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37146 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfHYE46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Aug 2019 00:56:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so1722399lff.4
        for <linux-pm@vger.kernel.org>; Sat, 24 Aug 2019 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BQHL8CvVc9M4HCvuZvCNX2bAAShjKVMJ2gj5Wm32J9I=;
        b=kDLLUNTvVOGATvchCEnf1gcR+YKhArXCgVqyV9zb2GOUfewH3YMIDYSr+2uTVAvESg
         ps/Hlmd04jbmA7jJM50pvpK7atpLTPlvlHD2OLJwvq1qIsa2q0I307lktvARnhbEgFGu
         Y6L1aXZnPntXsXZ4hs3o1NCMkDa0JvP1cz1cGVXPIuOv9dk/nToEmp7Msc5XSRDgm8bW
         Mgy1wo8WMYGXae1ApxmHb/4ys1CHqiy9ciaTX+n/u1FTcu/3X3Y3JoAhFRKH8TQ6GhkF
         bDkrvH+iI8EWjCG3HHUbRUOEg6QmCfrPxpoclKJIZWznug19W/aTA6Hn6Io/cNfsX1xM
         KkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BQHL8CvVc9M4HCvuZvCNX2bAAShjKVMJ2gj5Wm32J9I=;
        b=fnyvoZB+5kQbAH9oIHhC90ltISSasutADCVYkiCczQ0tjuFROYchm+Grd44radn6NL
         KHArPTLhd5nVpYAnB5cU5VH5UqW2+PN18qCio9+XFzv9+lDD8UgRq6Yq5g4lQrtEX8/6
         6Hq4MS6n5vDzTTtsIh88uCDaaW8Tt9wulHlDwjVm/zucRvupzv1tz17/TXddKE4SzbEc
         I2WYNFDQaMjBJsFsXzI0mBp6DZ3cyq3TTMJCoWrgvB/37d01RDqxqjdfmlxLsKUR9LG3
         RAftPp4ndBEGPYq7+6LFyMjcF/p64PsaxsgXGyOr/XylM6HBBwRU3XiRoBvjNgEVkAv0
         VFUw==
X-Gm-Message-State: APjAAAURZ/LfFrAdwbfucZBw9i3LPPeb3/419gNKc1zLCHHcm7zwZn5i
        w5DqOcVbHmbSkhLv2/xf3GI9Y8GFmCwf0xWMoIlEULGG+6k=
X-Google-Smtp-Source: APXvYqzGG9YvHAUnRtMkWZO/I2DvyctYnjPs8ktkxfGctJuxF87hgdIY90p/Dffk6NC48v7VQ/LkYwVW1Maoh1RIOl4=
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr6910955lfo.118.1566709015005;
 Sat, 24 Aug 2019 21:56:55 -0700 (PDT)
MIME-Version: 1.0
From:   MyungJoo Ham <myungjoo.ham@gmail.com>
Date:   Sun, 25 Aug 2019 13:56:18 +0900
Message-ID: <CAJ0PZbTpbzRmUq5gUBDr8ScGY7S-iqN9GhJJLrgB6Jqfxjw61Q@mail.gmail.com>
Subject: [PULL REQUEST for Rafael, Linux-PM] PM / devfreq fixes and driver updates
To:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

Here goes pull request from PM / devfreq with device driver updates and fix=
es.

Cheers,
MyungJoo


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1=
:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
tags/pullreq201908

for you to fetch changes up to 0ef7c7cce43f6ecc2b96d447e69b2900a9655f7c:

  PM / devfreq: passive: Use non-devm notifiers (2019-08-25 12:47:31 +0900)

- ----------------------------------------------------------------
Pull Request from devfreq to PM

This series include:

- - Tegra driver fixes
- - new Tegra devices
- - Rockchip fixes
- - Exynos-bus fixes
- - Event: add "event type"
- - Passive: notifier updates

- ----------------------------------------------------------------
Arnd Bergmann (1):
      PM / devfreq: tegra20: add COMMON_CLK dependency

Dmitry Osipenko (16):
      PM / devfreq: tegra: Fix kHz to Hz conversion
      PM / devfreq: tegra: Replace readl-writel with relaxed versions
      PM / devfreq: tegra: Replace write memory barrier with the read barri=
er
      PM / devfreq: tegra: Don't ignore clk errors
      PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
      PM / devfreq: tegra: Drop primary interrupt handler
      PM / devfreq: tegra: Properly disable interrupts
      PM / devfreq: tegra: Clean up driver's probe / remove
      PM / devfreq: tegra: Avoid inconsistency of current frequency value
      PM / devfreq: tegra: Mark ACTMON's governor as immutable
      PM / devfreq: tegra: Move governor registration to driver's probe
      PM / devfreq: tegra: Reconfigure hardware on governor's restart
      PM / devfreq: tegra: Support Tegra30
      PM / devfreq: tegra: Enable COMPILE_TEST for the driver
      PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
      PM / devfreq: Introduce driver for NVIDIA Tegra20

Ezequiel Garcia (1):
      PM / devfreq: Fix kernel oops on governor module load

Ga=C3=ABl PORTAY (2):
      PM / devfreq: Fix spelling typo
      PM / devfreq: rk3399_dmc: Fix spelling typo

Kamil Konieczny (2):
      PM / devfreq: exynos-bus: Correct clock enable sequence
      PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()

Krzysztof Kozlowski (1):
      PM / devfreq: Correct devm_devfreq_remove_device() documentation

Leonard Crestez (1):
      PM / devfreq: passive: Use non-devm notifiers

Lukasz Luba (3):
      PM / devfreq: events: add Exynos PPMU new events
      PM / devfreq: exynos-events: change matching code during probe
      PM / devfreq: events: extend events by type of counted data

 drivers/devfreq/Kconfig                            |  19 +-
 drivers/devfreq/Makefile                           |   3 +-
 drivers/devfreq/devfreq.c                          |  12 +-
 drivers/devfreq/event/exynos-ppmu.c                | 104 ++++---
 drivers/devfreq/exynos-bus.c                       | 153 +++-------
 drivers/devfreq/governor_passive.c                 |   6 +-
 drivers/devfreq/rk3399_dmc.c                       |   2 +-
 drivers/devfreq/tegra20-devfreq.c                  | 212 ++++++++++++++
 .../devfreq/{tegra-devfreq.c =3D> tegra30-devfreq.c} | 315 ++++++++++-----=
------
 include/linux/devfreq-event.h                      |   6 +
 10 files changed, 500 insertions(+), 332 deletions(-)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c
 rename drivers/devfreq/{tegra-devfreq.c =3D> tegra30-devfreq.c} (80%)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJdYhJkAAoJEBOhurvWBoCK9p4QAKGSl6FzPvfkeXG6XbQFncsj
w86M36c8SeH1JgrcxfPkSpZSnsChg0WPD7aWgpwFcf6DmSa7BSBqPcz1kfzK+J8Z
69b1HPi/YNP3dV/zxe108oQj+XpI88pPxoShudP6tG9PQGTWAIhXWL1VonSaEtVw
gMvbWXGfTap8F+4XsJTF5+aapv0KHsJ97RduhwFxMiB4oFGuML7dn4+a5KIIl48i
oRi5V1icEowHnrOImsuqUpigcPcxylIPzk2QHCrg3IFV5sX0XrTlorNRt42Hj/gd
rU2HCyRUOIdJnAFMh6IyxON+OKfyg8eCUQFV6wyfjiZz6efhaEEUESJnt7VE4+hO
h95NIHtsMzeoQXBLAMb1gMORYsv+JAAvYLP4AnqAWYhwtrRcTL0FJZhPdyKRZd/s
rU+zLjkjxj5xDI8ToBhLBnv5jB83bqsMEhfzIdLuEIrAtT9ekxDVI08T3uHn7Le+
g+RyyKsIdQkNK8L8VT/+12A0rcUQqw4b7q125U3pM5G4Q325BuBFQTmkoo8zdCiz
Zbso2U2HOBAT3SC3I19UFcSpUnkno6IrBwFzt5Si8YbBvUGtD4xBXFa1KSCclKWp
8UpFivfj237sstPW073gazO+9bZqEG19Y1oI2paJCcwoNpnJdijSbELKmphg+Yf7
b0LFEk+sN8pFvF2zGC7A
=3DPUVK
-----END PGP SIGNATURE-----
