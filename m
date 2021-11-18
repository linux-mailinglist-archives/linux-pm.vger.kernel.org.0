Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16B44563F3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhKRUTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 15:19:03 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33513 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhKRUTC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 15:19:02 -0500
Received: by mail-oo1-f42.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so2889918ooe.0;
        Thu, 18 Nov 2021 12:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=53yrJNZgjzuWxLyaLPZg6b6NVr4RokSKSIIQ0xm+ifM=;
        b=yA7sVA2vd+7nxo4UJkoUJ8ahwuA1O/M9Eff2l554Gcwows6AxE+9geS4PYrGhlN3lz
         umA5Byyw98k4IuDMifRbOv71JmNhPxVg+wI9j5iRnrKZmNHYGwJil1BDyHd3irF1hm/L
         0UYeXll+E2KX451ElA18Cg01QFLIw6loHICN9HpfPUg3/oBPFKjnSVeqlM4RgNh3vpEe
         /l7qEz3zfg0Ixs/m2joHFeNG9fw+2IE2LruduEEwZX5uo44ynQ4wvk5q31kwVIPOGfeu
         0f6qF2O/Ujw/68rmYhf74GFrSKisWHQr7MtP45X6J6eXO8OOu8hw2qGDi1QQ2ykjJVia
         Yu6A==
X-Gm-Message-State: AOAM531FFmy1dK1PHDEdpJPiW5/eoqBG7yJEweo8/vriqh859nwpX5Os
        aXlhN251IS5MEG092Q76DT80sLkxTwVrf+V43m6JT/DZPlc=
X-Google-Smtp-Source: ABdhPJz0bhP3Ht5zuDByTN/o3mXx/jVlly3HB5cocMV98hCL/Dj2JYQjuyMJHVUp2R9dI+bY3qfHaVogOo8rCiHS62w=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr7998550ooj.0.1637266561897;
 Thu, 18 Nov 2021 12:16:01 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 21:15:51 +0100
Message-ID: <CAJZ5v0j98u1yWQuOxds6Vz_BiuE=QAqaZ=rUrK7_a33ftCpTMw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v5.16-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.16-rc2

with top-most commit b49e0015c1bd8ab6c228981ca2eb4ad217ed8223

 Merge branch 'thermal-int340x'

on top of commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf

 Linux 5.16-rc1

to receive thermal control fixes for 5.16-rc2.

These fix the handling of thermal zones during system resume and
disable building of the int340x thermal driver on 32-bit.

Specifics:

 - Prevent the previous high and low thermal zone trip values from
   being retained over a system suspend-resume cycle (Manaf
   Meethalavalappu Pallikunhi).

 - Prevent the int340x thermal driver from being built in 32-bit
   kernel configurations, because running it on 32-bit is
   questionable (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      thermal: int340x: Limit Kconfig to 64-bit

Manaf Meethalavalappu Pallikunhi (1):
      thermal: core: Reset previous low and high trip during thermal zone init

---------------

 drivers/thermal/intel/int340x_thermal/Kconfig | 4 ++--
 drivers/thermal/thermal_core.c                | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)
