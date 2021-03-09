Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7F3327C4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhCINxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhCINxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 08:53:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFBBC061761
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 05:53:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d15so15739592wrv.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kFVtOx569baGOAKGpAbqzwWllCmChqhXIo2liOk0ceI=;
        b=G6P5oKXBWUjO7SOwyrRLmk9g0kBGCxUzokJg4b7vohGZV+YlSnhkQbeMIpHgtcB4bs
         gt5qZi4lM1jBSAohAJRM8Rf3puZ71S5wgRil37/dDYAZwvoQ1pBBvGI3Y/oikDi8DB4g
         MQ2NZEjWUOE1rI26ODBcoORm5Grh9CTP1nTgHi2LKLXPzMH7v+RADnvAl03UyrNuIRqC
         RS78nMRedLbGO5IxeYJSH6KL+3u+G0YnZYYH6tdvwr8mIb4kGDP7Frh367mvqu8Vn4tQ
         Mao8BRCyYbxFD75sdpF3UdrtVzDR8im0v53+c/VaEU/TAPn9TLWPA3TNqzSAbCiuZbnG
         FlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kFVtOx569baGOAKGpAbqzwWllCmChqhXIo2liOk0ceI=;
        b=bnKwUwK8ftba6vWF2emBAbgU4vyTXXaVGRh0Gkhp6vhb3krfYegq2ST8eS0YD/0Rwa
         c7A5Ftj+fsLcSNfbd5zP3nR4xlpf3h+4aAr7fWn51aYmPkVMNXTASWKu34PX8+v2PDau
         7bnWQhFKna1tMpxd8yr5rGRevf48fjh0tl79mkeUyZRNPdOW3EuTxCQe53/N/7L1Rj6D
         A/O7DfeKINRyXFEK2mkDgNLOxM9ZqnwLTUXFxQzSV/KCE++5R/KYFmqgDM03A6ydJ3/U
         7NQ7uFOyOilWwUxUX69irNEPiwi3ClWzxLFupo9nQuObSpGUoNdaHgD+rb3sVZm74BXN
         UOfQ==
X-Gm-Message-State: AOAM530D1AIhPSOsYnWwb2f+sruzJal7w0eavOvACisgyMKuEj1l/Y9d
        HJY4g2OmwrH5jZSIiC4pmOvKHA==
X-Google-Smtp-Source: ABdhPJxlEhK/3aki8s15KlPFLQnMxSYce7/Y/v5LhUFdToUd79EWJAHE/k3UJcHVmhEMClZES2mwqQ==
X-Received: by 2002:adf:d217:: with SMTP id j23mr29049339wrh.113.1615297984786;
        Tue, 09 Mar 2021 05:53:04 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id u15sm3756679wmq.4.2021.03.09.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:53:04 -0800 (PST)
Date:   Tue, 9 Mar 2021 13:53:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Input due for the v5.13
 merge window
Message-ID: <20210309135302.GP4931@dell>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v5.13

for you to fetch changes up to b58c808ca46c163c1924ec5d3285e67e9217ec74:

  MAINTAINERS: Add entry for ATC260x PMIC (2021-03-09 13:50:39 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Input due for the v5.13 merge window

----------------------------------------------------------------
Cristian Ciocaltea (4):
      dt-bindings: input: Add reset-time-sec common property
      dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
      mfd: Add MFD driver for ATC260x PMICs
      input: atc260x: Add onkey driver for ATC260x PMICs

Manivannan Sadhasivam (1):
      MAINTAINERS: Add entry for ATC260x PMIC

 Documentation/devicetree/bindings/input/input.yaml |   7 +
 .../devicetree/bindings/mfd/actions,atc260x.yaml   | 183 ++++++++++++
 MAINTAINERS                                        |  12 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +-
 drivers/input/misc/atc260x-onkey.c                 | 305 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |  18 ++
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/atc260x-core.c                         | 310 +++++++++++++++++++++
 drivers/mfd/atc260x-i2c.c                          |  64 +++++
 include/linux/mfd/atc260x/atc2603c.h               | 281 +++++++++++++++++++
 include/linux/mfd/atc260x/atc2609a.h               | 308 ++++++++++++++++++++
 include/linux/mfd/atc260x/core.h                   |  58 ++++
 13 files changed, 1561 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
 create mode 100644 drivers/input/misc/atc260x-onkey.c
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 include/linux/mfd/atc260x/atc2603c.h
 create mode 100644 include/linux/mfd/atc260x/atc2609a.h
 create mode 100644 include/linux/mfd/atc260x/core.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
