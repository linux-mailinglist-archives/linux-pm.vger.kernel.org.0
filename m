Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177AE7A02C1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjINLfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjINLfA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54B7E1BE8
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694691255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyZTrDy0/hTH0K9EatTkNwN6H8aU89mHjN3C7EMRwqQ=;
        b=iQN9Fe6nfprTZ5syMdH/7BClWd+9TynWg8aPH+ty4DvwbfTuVa+/xVZBI708oS/S8/NrAa
        I4DcTFs72qNNZnKg1Z0hwPxnDRaqIP+jvOjRGSjnMvdY3gznFMv/d/OQB9B0WfITyB15Ek
        YKKr1vI2JTSpwfcQ690cMd4UGCzsdnM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199--qndlhkBP-eKhPyiSFza5A-1; Thu, 14 Sep 2023 07:34:14 -0400
X-MC-Unique: -qndlhkBP-eKhPyiSFza5A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26fb3f2edc9so714454a91.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691253; x=1695296053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyZTrDy0/hTH0K9EatTkNwN6H8aU89mHjN3C7EMRwqQ=;
        b=M8WsCNHiMTQnOUY9VZR8hCj4AFWmf0hzPNxqCawtgCwbuD5LsIM9ZIc7nM+/x6VPAZ
         KkR/uwJcvoiE59/eLpqF9q57AaHdgfeQA34Ru4njOhvZ/5JZbJoLX3yc1RibpIUnyWdD
         Od3Td82FCrtFzNLOOs3aMxFQUYTWo1rsrRB2s3AkVnAyB+O+/6HTXfftUu457x2nvhDJ
         BdJR71SiPcOaxWgu+2YBJ/QyJ0b3PoeW/JXds/KEO0f1XK0n2BANUtn2x1//BQfVUo6N
         PTO6n4ktNu/tMyVD26kvPOBwVvfSt7aLqpVU7uyYqz3XaCWf3AYwLU8A0Z8WlR6dIRqw
         6DBQ==
X-Gm-Message-State: AOJu0YxgpudopgdWaJxXiO9kwqyDS29FqZIRq8E1+SiXu6WT9AeohKh2
        SJpAP6yyC2q9nqei3VM0kw+8FJxW3yp/lUvjMy8NkwiEM94EZBCNbtepbmhGAGgr+fKYM3XeveQ
        qBx2eWPG+amXzFZjkZX2M1TWqOgvQGbFuDcs=
X-Received: by 2002:a17:90b:1953:b0:271:8195:8 with SMTP id nk19-20020a17090b195300b0027181950008mr4962722pjb.36.1694691253243;
        Thu, 14 Sep 2023 04:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+T3eZarPZ9nZ1kl+VZnwP2bzJmj2nhQcmZkbug8WrUbmTzW0SE3NyLmlL8SFSEAVUSs75vseHQzI79kWaPnA=
X-Received: by 2002:a17:90b:1953:b0:271:8195:8 with SMTP id
 nk19-20020a17090b195300b0027181950008mr4962702pjb.36.1694691252955; Thu, 14
 Sep 2023 04:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111712.586522-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111712.586522-1-ulf.hansson@linaro.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Thu, 14 Sep 2023 12:33:36 +0100
Message-ID: <CAOgh=FykP9LLpkg4WLhYaKYv8Myofu7KSYc2=_3ea=4paPfMCQ@mail.gmail.com>
Subject: Re: [PATCH 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Sept 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The Kconfig option belongs closer to the corresponding implementation,
> hence let's move it from the soc subsystem to the pmdomain subsystem.
>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: <asahi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Makes sense, since the C code and Makefile is there now.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/pmdomain/Kconfig       |  1 +
>  drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
>  drivers/soc/apple/Kconfig      | 13 -------------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pmdomain/apple/Kconfig
>
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
> index 07d2f8165abe..55a9ca191849 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -3,5 +3,6 @@ menu "Power Domains Support"
>
>  source "drivers/pmdomain/actions/Kconfig"
>  source "drivers/pmdomain/amlogic/Kconfig"
> +source "drivers/pmdomain/apple/Kconfig"
>
>  endmenu
> diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
> new file mode 100644
> index 000000000000..12237cbcfaa9
> --- /dev/null
> +++ b/drivers/pmdomain/apple/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +if ARCH_APPLE || COMPILE_TEST
> +
> +config APPLE_PMGR_PWRSTATE
> +       bool "Apple SoC PMGR power state control"
> +       depends on PM
> +       select REGMAP
> +       select MFD_SYSCON
> +       select PM_GENERIC_DOMAINS
> +       select RESET_CONTROLLER
> +       default ARCH_APPLE
> +       help
> +         The PMGR block in Apple SoCs provides high-level power state
> +         controls for SoC devices. This driver manages them through the
> +         generic power domain framework, and also provides reset support.
> +
> +endif
> diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
> index a1596fefacff..eff486a77337 100644
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
>
>  menu "Apple SoC drivers"
>
> -config APPLE_PMGR_PWRSTATE
> -       bool "Apple SoC PMGR power state control"
> -       depends on PM
> -       select REGMAP
> -       select MFD_SYSCON
> -       select PM_GENERIC_DOMAINS
> -       select RESET_CONTROLLER
> -       default ARCH_APPLE
> -       help
> -         The PMGR block in Apple SoCs provides high-level power state
> -         controls for SoC devices. This driver manages them through the
> -         generic power domain framework, and also provides reset support.
> -
>  config APPLE_RTKIT
>         tristate "Apple RTKit co-processor IPC protocol"
>         depends on MAILBOX
> --
> 2.34.1
>
>

