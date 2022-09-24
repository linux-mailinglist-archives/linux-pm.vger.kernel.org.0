Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB925E8EE6
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIXRXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIXRXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 13:23:52 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21C3E755
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:23:50 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id g23so1874386qtu.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yqicIqWDpeeInCnso5PD6oJsWT84ABOKo3l/Ic9+2uE=;
        b=HIwiWeInfTQArc2hY/CsNQLtM2VTTmqRq3jiRE6qGjB4PVEcHXpIBiv4/1eDGAE83r
         nvtFsJsmeoYef6df+Pwdz7dgeULDWI2Sc9J5j15p2OUtFGwt59nsNUEyu437MXb175S6
         5aQS1+NMLPxMqKEF1sI3I0FRF3EWLN2Zo8lp2PcRljbYeF/RyrpKkIMyiQuZxM6Fq5LM
         9ClbQ/y2C1jpDC6F1sg6E4itYteZU66g3Sy+EA23LzgbJZJXgq2p6tag6bcfJOW0vK+w
         dL45ZjTU/zX3UomHjVv4YL5wuSHRnpu47P8HprMwg/t/vGlAYDZ8Vk6T4ogxL+fX39rv
         08vQ==
X-Gm-Message-State: ACrzQf0yhTTb3H+FA0ABV/r1F6oIz4izLXKXeeVu8XElGLSIp96u+wbt
        uu/ijDDZrfgvJs3h1mHloypwdZrCyMD6NcqLoK6cplYT
X-Google-Smtp-Source: AMsMyM4zwPMuHP0vvZPqzHq9MdaBuYijE6ShNmJzj+kR//KehjFlhDgkSth9RgMapl7/XrBoZu2A2SPH7lQfKvrMGDU=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr11937657qtk.17.1664040230065; Sat, 24
 Sep 2022 10:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220922123141.24042-1-shangxiaojing@huawei.com>
In-Reply-To: <20220922123141.24042-1-shangxiaojing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:23:38 +0200
Message-ID: <CAJZ5v0ha0LbxsnBcDcpLZSGDVokBBSLqsPQewMTu4BiLBYR0Dg@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/int340x/processor_thermal: Switch
 to use module_pci_driver() macro
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Antoine Tenart <atenart@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 22, 2022 at 1:57 PM Shang XiaoJing <shangxiaojing@huawei.com> wrote:
>
> Since pci provides the helper macro module_pci_driver(), we may replace
> the module_init/exit with it.
>
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  .../int340x_thermal/processor_thermal_device_pci.c  | 13 +------------
>  .../processor_thermal_device_pci_legacy.c           | 13 +------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index c2dc4c158b9d..bf1b1cdfade4 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -373,18 +373,7 @@ static struct pci_driver proc_thermal_pci_driver = {
>         .driver.pm      = &proc_thermal_pci_pm,
>  };
>
> -static int __init proc_thermal_init(void)
> -{
> -       return pci_register_driver(&proc_thermal_pci_driver);
> -}
> -
> -static void __exit proc_thermal_exit(void)
> -{
> -       pci_unregister_driver(&proc_thermal_pci_driver);
> -}
> -
> -module_init(proc_thermal_init);
> -module_exit(proc_thermal_exit);
> +module_pci_driver(proc_thermal_pci_driver);
>
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
> index 4571a1a53b84..09e032f822f3 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
> @@ -151,18 +151,7 @@ static struct pci_driver proc_thermal_pci_driver = {
>         .driver.pm      = &proc_thermal_pci_pm,
>  };
>
> -static int __init proc_thermal_init(void)
> -{
> -       return pci_register_driver(&proc_thermal_pci_driver);
> -}
> -
> -static void __exit proc_thermal_exit(void)
> -{
> -       pci_unregister_driver(&proc_thermal_pci_driver);
> -}
> -
> -module_init(proc_thermal_init);
> -module_exit(proc_thermal_exit);
> +module_pci_driver(proc_thermal_pci_driver);
>
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
>  MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
> --

Applied as 6.1 material with some edits in the subject and changelog.

Thanks!
