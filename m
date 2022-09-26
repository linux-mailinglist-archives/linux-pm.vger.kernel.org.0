Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7295EA6E0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIZNMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 09:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiIZNMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 09:12:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755C4D813
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 04:41:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cc5so9770783wrb.6
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tjKiqRgz8VEI15B46hBjxpLvpFG83gUPUxMgFtmmjB4=;
        b=Dk2DNfUDw+ZTPLwCyln7y/Z7pMpe02NyZlNVjla49FvZdIwaPN4P+30Wl1ceX6t+Uu
         XmS0r9FQe3st73zMrAuE8SgZaeQiDEhMM+eETJ/dfyubDRx6JNEs8Sj1hJBhtYL/yaNy
         XTo6FrEmhc6jIMOUVZ/S9d6g7WaILEFEv7f0XCkUFLmVfodv65j9kolsOENkWYdeAyko
         ERinCAL+hUr32y8rjdQyfsHzwqVSKHYTD7cm0IackZ+ByRUuW8fjTGaLmrz73yEj8U2C
         MH/sWoOqfaYxxfcRA9Y2VEWf7R7roS0n/AyqDV0vbpn+JctCyhgTG3ts/fmgYyiBCpa4
         XY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tjKiqRgz8VEI15B46hBjxpLvpFG83gUPUxMgFtmmjB4=;
        b=Ux6CHyqOT6sZVuJexE8F8/vaQR/Sa4q7XocuE5CFAYEEOJxZ8jJoh6go4wABTg9bsA
         WZb8VS3F0k5EIs+9w1qRasxsXI138Ff1eN9ehttKp9slFJhHhTDvwVR9M8p4bjLTZe/a
         Fj9Ikk0WFKlZQx3ZvIwSllTMnJs2TyttssCS/Csa71FdZxLELkcugJeVb+udE4aVJo4/
         aUfXfHaBjFoviqLDqXp2pExYspMCa+hjT9c/KdlmHEKhP9FGUh8bsoR6GSg1ZiA/JXUO
         eMAITXFzQ7JAKIPUBJTMeJHVenDF1VWYam/ubo3SrbMkLLxPHCnRoJPNrve3MUNnH3vp
         2xwA==
X-Gm-Message-State: ACrzQf39q8gncwiZAGgmHpuDrkKQJVsMqnlJGMJoAy40a/uiGkK17ZDN
        sDnnULnlNyHL515GPSmyVHkNlH3vjFGXcRwd8TSieg==
X-Google-Smtp-Source: AMsMyM5f77zjkWOcvINnHQEFY9f++ahy1UUywaRNF/amEkgQ+NNKPqgMl0w2GQgQkFa2RLo0RJuzwf4QcCm2qBUBTMY=
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id
 n15-20020a5d588f000000b0022b05cce1d3mr12451537wrf.142.1664192367193; Mon, 26
 Sep 2022 04:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220926110758.666922-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220926110758.666922-1-dmitry.baryshkov@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Sep 2022 13:38:50 +0200
Message-ID: <CAPDyKFqAgukYVPvkrE=mzM88e+PfFnecwPLxdRogjnwHgLq=Jw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] firmware/psci: Add debugfs support to ease debugging
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Sept 2022 at 13:08, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> To ease debugging of PSCI supported features, add debugfs file called
> 'psci' describing PSCI and SMC CC versions, enabled features and
> options.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> I sketched this while trying to narrow down the particular issue on
> the Qualcomm platform (which started as an attempt to implement PSCI
> domains, but then led to understanding that while the platform claims
> supports OSI, it doesn't support SET_SUSPEND). We were going to use
> this to help to narrow down issues with the PSCI support on other
> platforms as well.
>
> Changes since v1:
> - Extended the table to include MEM_PROTECT functions (noted by Mark
>   Brown)
> - Switched to seq_puts where possible
> - Changed S_IRUGO to 0444
>
> The patch is resent to include soc@kernel.org
> ---
>  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/psci.h    |  14 +++++
>  2 files changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cfb448eabdaa..9fdcb6bff403 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -9,6 +9,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/cpuidle.h>
> +#include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
>  #include <linux/of.h>
> @@ -324,12 +325,125 @@ static void psci_sys_poweroff(void)
>         invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
>  }
>
> -static int __init psci_features(u32 psci_func_id)
> +static int psci_features(u32 psci_func_id)
>  {
>         return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
>                               psci_func_id, 0, 0);
>  }
>
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define PSCI_ID(ver, _name) \
> +       { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
> +#define PSCI_ID_NATIVE(ver, _name) \
> +       { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
> +
> +/* A table of all optional functions */
> +static const struct {
> +       u32 fn;
> +       const char *name;
> +} psci_fn_ids[] = {
> +       PSCI_ID_NATIVE(0_2, MIGRATE),
> +       PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> +       PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> +       PSCI_ID(1_0, CPU_FREEZE),
> +       PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> +       PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> +       PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> +       PSCI_ID(1_0, SET_SUSPEND_MODE),
> +       PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> +       PSCI_ID_NATIVE(1_0, STAT_COUNT),
> +       PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> +       PSCI_ID(1_1, MEM_PROTECT),
> +       PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> +};
> +
> +static int psci_debugfs_read(struct seq_file *s, void *data)
> +{
> +       int feature, type, i;
> +       u32 ver;
> +
> +       ver = psci_ops.get_version();

This call and some other calls below, triggers calls into the PSCI FW
(via smc calls). Rather than having to do that, each time user space
wants to read the debugfs data, we could cache/store that data during
the "probe" sequence of the psci fw driver. In this way, we don't need
to run the smc calls each time, but just once when probing.

Did you consider that option? Or perhaps there are other problems of doing that?

> +       seq_printf(s, "PSCIv%d.%d\n",
> +                  PSCI_VERSION_MAJOR(ver),
> +                  PSCI_VERSION_MINOR(ver));
> +
> +       /* PSCI_FEATURES is available only starting from 1.0 */
> +       if (PSCI_VERSION_MAJOR(ver) < 1)
> +               return 0;
> +
> +       feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> +       if (feature != PSCI_RET_NOT_SUPPORTED) {
> +               ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> +               seq_printf(s, "SMC Calling Convention v%d.%d\n",
> +                          PSCI_VERSION_MAJOR(ver),
> +                          PSCI_VERSION_MINOR(ver));
> +       } else {
> +               seq_puts(s, "SMC Calling Convention v1.0 is assumed\n");
> +       }
> +
> +       feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
> +       if (feature < 0) {
> +               seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
> +       } else {
> +               seq_printf(s, "OSI is %ssupported\n",
> +                          (feature & BIT(0)) ? "" : "not ");
> +               seq_printf(s, "%s StateID format is used\n",
> +                          (feature & BIT(1)) ? "Extended" : "Original");
> +       }
> +
> +       type = psci_ops.migrate_info_type();
> +       if (type == PSCI_0_2_TOS_UP_MIGRATE ||
> +           type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
> +               unsigned long cpuid;
> +
> +               seq_printf(s, "Trusted OS %smigrate capable\n",
> +                          type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
> +               cpuid = psci_migrate_info_up_cpu();
> +               seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n",
> +                          cpuid, resident_cpu);
> +       } else if (type == PSCI_0_2_TOS_MP) {
> +               seq_puts(s, "Trusted OS migration not required\n");
> +       } else {
> +               if (type != PSCI_RET_NOT_SUPPORTED)
> +                       seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
> +               feature = psci_features(psci_fn_ids[i].fn);
> +               if (feature == PSCI_RET_NOT_SUPPORTED)
> +                       continue;
> +               if (feature < 0)
> +                       seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n",
> +                                  psci_fn_ids[i].name, feature);
> +               else
> +                       seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
> +       }
> +
> +       return 0;
> +}

[...]

Kind regards
Uffe
