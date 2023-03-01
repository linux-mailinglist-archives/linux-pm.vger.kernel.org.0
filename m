Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6056A7372
	for <lists+linux-pm@lfdr.de>; Wed,  1 Mar 2023 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCASaf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Mar 2023 13:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCASaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2023 13:30:35 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB032503;
        Wed,  1 Mar 2023 10:30:34 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id eg37so57515118edb.12;
        Wed, 01 Mar 2023 10:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtYgXoCwtUuhPXmHs5pHvu8QCWRq+j3buBks+eQBQac=;
        b=ftp7Jq5Q54F4SAmVLxDi6UbI8b92eEVqwDwsmt/ytlSLX6KJLN9W82VpBnUVVl8awh
         lOg5B+D2DECmphh7Q2Kfg7wJukiIRBrwZZVNh6rEjQZ1UNzw/fja8MaCkmHbyxot9hUi
         +2PIruKedT6E1uoklo0+Orj3/sY8H5Py695ItqzaQbtEwB+5oke8vUZd0LvD32m16Y/a
         RGViYxk+nGkcUMLj/xmqnXwe6G7sE+UJkqtoF0DqIlOkTl8hbtITM7sP97KCy8KDg52D
         TXGfChmDRP+Ma6PTpCJx1uuFZbpVMMTr71f4y3jvMjw6wqpjvHXGx98yWAllIbcC5PYH
         hY4Q==
X-Gm-Message-State: AO0yUKU/fq32/tC0FsZRKk75nzxhhfGbWvxsdbtMgVNxxjgAPoZraaRk
        FbaVusPd7P6nL9e7TlTPslrbhsP1TJE0nM/3+4M=
X-Google-Smtp-Source: AK7set+EyCePVrgZG0Rf4nKfGO8kKAJEBVSZkOMRs2FEBANMdM5uILSfp92588QSCdddTe/6Cs/I80dA3gHasUDqfKE=
X-Received: by 2002:a17:906:2358:b0:877:747d:1108 with SMTP id
 m24-20020a170906235800b00877747d1108mr3522847eja.5.1677695432557; Wed, 01 Mar
 2023 10:30:32 -0800 (PST)
MIME-Version: 1.0
References: <Y/yAusqpje3MqS1N@kili>
In-Reply-To: <Y/yAusqpje3MqS1N@kili>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Mar 2023 19:30:21 +0100
Message-ID: <CAJZ5v0gt1NiW76jsz_FU8c4CfNBv0ojN-Aq7Ds0WxDqO2-SVsg@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: quark_dts: fix error pointer dereference
To:     Dan Carpenter <error27@gmail.com>
Cc:     Boon Leong <boon.leong.ong@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 27, 2023 at 11:06 AM Dan Carpenter <error27@gmail.com> wrote:
>
> If alloc_soc_dts() fails, then we can just return.  Trying to free
> "soc_dts" will lead to an Oops.
>
> Fixes: 8c1876939663 ("thermal: intel Quark SoC X1000 DTS thermal driver")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/thermal/intel/intel_quark_dts_thermal.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
> index 97b843fa7568..ffdc95047838 100644
> --- a/drivers/thermal/intel/intel_quark_dts_thermal.c
> +++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
> @@ -400,22 +400,14 @@ MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);
>
>  static int __init intel_quark_thermal_init(void)
>  {
> -       int err = 0;
> -
>         if (!x86_match_cpu(qrk_thermal_ids) || !iosf_mbi_available())
>                 return -ENODEV;
>
>         soc_dts = alloc_soc_dts();
> -       if (IS_ERR(soc_dts)) {
> -               err = PTR_ERR(soc_dts);
> -               goto err_free;
> -       }
> +       if (IS_ERR(soc_dts))
> +               return PTR_ERR(soc_dts);
>
>         return 0;
> -
> -err_free:
> -       free_soc_dts(soc_dts);
> -       return err;
>  }
>
>  static void __exit intel_quark_thermal_exit(void)
> --

Applied as 6.3-rc material, thanks!
