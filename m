Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC57A1B3A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjIOJwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIOJwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 05:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08563EB
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694771280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1VBwuYXQUntYei3UdowzwFY82byxmtnNnjvSqOT3Vs=;
        b=RrmkNemnL4NO5N3rM9rNVGeW+G2qzamh8a14VMImAQTozWeM1QBFo9m/qEwJGBCQKBkYZk
        mNEkpXkfv0yjhxCrTyj5u4Gu+LhI6bgBi0aDvIiHXYyld2pNHjKksM42dI3fdvfxpHMgPL
        WTfHIWmWqlnPutpXkwQyY9R/J5tM/zE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-hyHTQhrRPpuTrbHcGMBQdQ-1; Fri, 15 Sep 2023 05:45:47 -0400
X-MC-Unique: hyHTQhrRPpuTrbHcGMBQdQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-274800b0216so1177552a91.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771146; x=1695375946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1VBwuYXQUntYei3UdowzwFY82byxmtnNnjvSqOT3Vs=;
        b=EIM/oFOhSoeHt5y9sSYQhidzBRZfrQMBIoGMkbGRiUxr8iwKV/nMqbVGrubc/75ZHA
         W99XfeXsI+H7dn9G6zjFTrST0ZYTdNFl/ZmPCMM+O0OrtadGomyiSCMFWPRrceXCGuLo
         mZqKi5OQzgc7SZfvD+wHvlmZK4ALtxKocnY0amqMPGMMniQEoRIELzSkk88ljYuP+bG2
         85/9E2IkRMYFqaSpiiP5LY39FsJsu3CVnWaGJAsJwDGacWLejxiS8Dzir+rQwpBI3Eow
         SEF9eCsGm6TRpPbmhy0cXJEZyFhSJy/w2sqflaEUUwuzyOw5eVJNts4fyV9BHQHSCs7v
         2GQg==
X-Gm-Message-State: AOJu0YxFM6GA+y5z1mnN0S0eZVmJR3/yoLipFiVpHF4HYTl+o3+JhXGr
        f8inFIt3YKnUmCRHM7uIjkdysCYigroXYaQzytSEYf3WqddU5AevzEXaZV7CFRyUNvI5WFHbiDL
        7dbzHwhNSN2wKlsF5/QlKtQili7vMFHyMNAzyV2Msu9yEcQ==
X-Received: by 2002:a17:90a:488e:b0:25c:8b5e:814 with SMTP id b14-20020a17090a488e00b0025c8b5e0814mr905166pjh.44.1694771146514;
        Fri, 15 Sep 2023 02:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+w0KCMY2aOS5+Qti0qYHaaiMfOlm1MoZJGYHxoE7tu1gXi7tNdwS+brqiPhBxoPCU8oo/3Z3q4o6FnaJnUN8=
X-Received: by 2002:a17:90a:488e:b0:25c:8b5e:814 with SMTP id
 b14-20020a17090a488e00b0025c8b5e0814mr905153pjh.44.1694771146206; Fri, 15 Sep
 2023 02:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org> <20230915092003.658361-5-ulf.hansson@linaro.org>
In-Reply-To: <20230915092003.658361-5-ulf.hansson@linaro.org>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Fri, 15 Sep 2023 10:45:10 +0100
Message-ID: <CAOgh=FzNordx=_YMiQs2Uj6JQ7Ctqqi=XZbbRAY9cS-F8v68RA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] pmdomain: apple: Move Kconfig option to the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Sept 2023 at 10:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The Kconfig option belongs closer to the corresponding implementation,
> hence let's move it from the soc subsystem to the pmdomain subsystem.
>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: <asahi@lists.linux.dev>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This patch in the patchset looks the same as yesterday, so...

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
> index 03c8991ad0fd..482d9e970e14 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -3,5 +3,6 @@ menu "PM Domains"
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

