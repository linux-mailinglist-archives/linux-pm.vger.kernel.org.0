Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87022332F88
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCIUEx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 15:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhCIUEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 15:04:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A0BC06175F
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 12:04:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e23so3488754wmh.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 12:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=th+pFGsKV4oACuzSEJwxa21qiSSHxcmfhJ8lnbdpJ3I=;
        b=IkTZLESOhO3dhEUmEIFDXKWmjDhnOH/2/TsnOofR60AvPlmL995rGCwM18ScprpzuN
         qKTBL0S5ILbpPgiJbbv8PFswofpDQDdBxW2zy711I3vgqJGADOZKzIwNPYnH1vGQnw7P
         sGQDPwbJFBcJKbNN6jgmMBZIKTCsX3g8mVbfhii6obFESct2hXyjigZa1bVkLpdDJM9j
         WmirkBTXoqYMdyYFITgFuuV6x+Gn6gP7sLkShYIjMWK+ESdjIL96Elq1txzvx/ijJ8Wq
         dPUGEQGg+GMVUsQ3BRoHjHRLXJ1XFLql1kib4mT2G7Sc7rAssM6G3M6bhH1RLTWTIgkh
         kbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=th+pFGsKV4oACuzSEJwxa21qiSSHxcmfhJ8lnbdpJ3I=;
        b=OCb9HM8r284bXzq6Ula6x6Aoum710LLKtUv8R2qz/5wwk25k2g/ECTPuU9HligZjBN
         pkXWW0Z7A0LCHx6sU3tzFg5BHawy7Cnucn/8VMRVnWNfqxNcIaZmC13a3YKyTRWjOiOJ
         KE1wrErIXbPdtGh77TJZSXieF+6XGmbN/Equbc+G5hcPMRjZYZBpYkjcia85p6kqcIQ1
         apcUa0KPln3Dr4ExfyM1FFnXKk4zlA3XiVFMlYMPeV+oYCAkGcvkCd5JDTRLH4ucC2Qv
         wZ+LjZL8AtbRo1wZL3e6mTgNBGMy35mtZntgW/PQe1fin5ClUrSRD/1eddaM49gmhQCx
         hMAA==
X-Gm-Message-State: AOAM531EG36AXKcwzb7VcquSK/Mgu80ZsW76zSZPhJEJKgBEOoilO8yp
        4dArvTCbpLTQY4eLcJfPHgsnBQ==
X-Google-Smtp-Source: ABdhPJzsA/giZodWpMf/MSCDx29xhRcNuXOsnjxVJqqjtET7bDyrxhp5eAHRqgpo3e5982jWMYZGAA==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr5900872wmo.155.1615320259949;
        Tue, 09 Mar 2021 12:04:19 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id h22sm6008483wmb.36.2021.03.09.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:04:19 -0800 (PST)
Date:   Tue, 9 Mar 2021 20:04:17 +0000
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
Subject: Re: [GIT PULL] Immutable branch between MFD and Input due for the
 v5.13 merge window
Message-ID: <20210309200417.GZ4931@dell>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210309135302.GP4931@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309135302.GP4931@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 09 Mar 2021, Lee Jones wrote:

> Enjoy!
> 
> The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> 
>   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v5.13
> 
> for you to fetch changes up to b58c808ca46c163c1924ec5d3285e67e9217ec74:
> 
>   MAINTAINERS: Add entry for ATC260x PMIC (2021-03-09 13:50:39 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and Input due for the v5.13 merge window
> 
> ----------------------------------------------------------------
> Cristian Ciocaltea (4):
>       dt-bindings: input: Add reset-time-sec common property
>       dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
>       mfd: Add MFD driver for ATC260x PMICs
>       input: atc260x: Add onkey driver for ATC260x PMICs
> 
> Manivannan Sadhasivam (1):
>       MAINTAINERS: Add entry for ATC260x PMIC
> 
>  Documentation/devicetree/bindings/input/input.yaml |   7 +
>  .../devicetree/bindings/mfd/actions,atc260x.yaml   | 183 ++++++++++++
>  MAINTAINERS                                        |  12 +
>  drivers/input/misc/Kconfig                         |  11 +
>  drivers/input/misc/Makefile                        |   2 +-
>  drivers/input/misc/atc260x-onkey.c                 | 305 ++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  18 ++
>  drivers/mfd/Makefile                               |   3 +
>  drivers/mfd/atc260x-core.c                         | 310 +++++++++++++++++++++
>  drivers/mfd/atc260x-i2c.c                          |  64 +++++
>  include/linux/mfd/atc260x/atc2603c.h               | 281 +++++++++++++++++++
>  include/linux/mfd/atc260x/atc2609a.h               | 308 ++++++++++++++++++++
>  include/linux/mfd/atc260x/core.h                   |  58 ++++
>  13 files changed, 1561 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
>  create mode 100644 drivers/input/misc/atc260x-onkey.c
>  create mode 100644 drivers/mfd/atc260x-core.c
>  create mode 100644 drivers/mfd/atc260x-i2c.c
>  create mode 100644 include/linux/mfd/atc260x/atc2603c.h
>  create mode 100644 include/linux/mfd/atc260x/atc2609a.h
>  create mode 100644 include/linux/mfd/atc260x/core.h

FYI, if anyone has pulled this, they should probably rebase it onto
v5.12-rc2 and delete the v5.12-rc1 tag from their tree:

 https://lwn.net/Articles/848431/
  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
