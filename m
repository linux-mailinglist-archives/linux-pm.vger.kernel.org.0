Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2C347470
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhCXJVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 05:21:38 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44916 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCXJVG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 05:21:06 -0400
Received: by mail-lj1-f173.google.com with SMTP id u9so1629363ljd.11;
        Wed, 24 Mar 2021 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KwtrWhf8f4Zw1shSmmFlqEB5Jch6Dst+BR5dO8pa4gc=;
        b=o06AOP+sF7hA+9GiDBPnEPr6LooDSs6qjUBQh23+eBNXc0izFGn/fJUpwRi4zD4YgV
         3WxXXoiM3e+L+U0leNr8rk7VWhrGKZAtuWfnN2jJhG6bF+blpS8hNXk0qz3fVma4E/bD
         LaO59/HBLJejO3tANYLNhFKHDvQTYDyu2maNSGN3unJ2IEtTcIlRcs4XDo5CsOQfAMIl
         0erbCaP+Q5RoJtgLpQZU+eLvlP15GWELlrrLWydHRPLFHBH0rcvGbIcJpv9+SyK9eafF
         ZEBpd1SrszlLSuc6Mn3KHVLXxVfnZHLCxsvyojFSTsseosgf8cpNi/jBj6wO4fblHbcs
         UefA==
X-Gm-Message-State: AOAM5324JXVBGowQ/eCMxd35UFY7/Y14p/H4MtN9p10PjGTbiXZ2CYku
        zehw2xLu8ZmWunvdkDbS2Y0=
X-Google-Smtp-Source: ABdhPJxBkJvsvaGLG1uu/fgPF7N8/AvsHPfrH5IyWgXBN8+m4524ZIK961psKUHL3rPQGrGXA8bsMQ==
X-Received: by 2002:a2e:98d2:: with SMTP id s18mr1454207ljj.412.1616577664762;
        Wed, 24 Mar 2021 02:21:04 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id q26sm246954ljg.90.2021.03.24.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:21:04 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:20:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/2] Fixes to device-managed work-queue series
Message-ID: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series "Add managed version of delayed work init" was applied to
driver-core by Greg. Few issues were reported afterwards.

Chen-Yu Tsai reported problem in axp20x_usb_power power-supply driver.
Work-queue initialization and request IRQ ordering was wrong and
work-queue was initialized twice. This was originated by my incorrect
rebase where I missed a fixup done between my patch revisions.

Additional print was reuqested on work-queue initialization error path
at extcon-gpio.c by Chanwoo Choi.

This series fixes both of these issues.

Series is done based on driver-core-next.

---

Matti Vaittinen (2):
  extcon: extcon-gpio: Log error if work-queue init fails
  power: supply: axp20x_usb_power: fix work-queue init

 drivers/extcon/extcon-gpio.c            |  4 +++-
 drivers/power/supply/axp20x_usb_power.c | 10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)


base-commit: a7d30f3f41cf40aad1c4557fa180fe320d5b7c74
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
