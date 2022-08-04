Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A106589E9F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiHDP0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiHDP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 11:26:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B921245
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 08:26:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v1so3512544qkg.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LMfqn114ViYGfJ/tgikcxyhcWrzGqivQiC5keCabEz0=;
        b=NdISfji8XhyKB67q8QMZWCelg46f9R9V0JGmqypRy3D6k1qqNIN6Sovmly7Bnr84rq
         MHRGWHEEQ+hXW8xtWqr0KYOLAgHoBy6LUDDUMml74pINAL65QSJ30l0lqBlDa//fDb51
         xgnsdB6tJdXii/dGEWlcZwctkJ3RiVaxhFfnbcRaWkYTNwQwmGvAGLDIRnActlYb8PHj
         K2ap2nDftpuCBE3fzQiQh1a9cPR1cxVc/rqH2OOeQ1EquQ4vYBOQ9zVJOrLPbKItb3sy
         ro4ILxlDHTlzEoS8OFyod83xSuvewpineH9jr5VR4oCnLc/ac1+zqM8k2LUet/KfNXwn
         kIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LMfqn114ViYGfJ/tgikcxyhcWrzGqivQiC5keCabEz0=;
        b=xiwrToRlYYBB1hgFdenln0MBp2XH1pAmwVYHLxL7rnrspOuSdQQpt33oR27bgHh89L
         u0i6ss2a+nInkdXYOSopr23rgOiX6As8ifWDFOY6IR6Q1/jTAeQzswIpKNk5v1zg7h7t
         8zJSAvxFoGS6L9LonNlFvorMXE6w2krsNnIIemDrkjCjFE4Qk/6T+aAMRF5oVAZP+d0s
         WYrMKRObCRsFaKsHAnyeobFRdSX4x8KTh08IcdXDlQH6PIVVd44/0cZakvHtTtZrf3j9
         UlWpmuafkaL26QbRUCd0Em6L7ZM/Ov2j/bRvD/5kyOzWf1txw30ixMQUONMN/qHlj6Ph
         M27w==
X-Gm-Message-State: ACgBeo3siSOTIQygXuOIvHT0e2bsTG/vr1uIkXdvs89WnMdK0yUGitYT
        cJQAxzokhejxPwbeM7YUuWKfRh+8VO3haHX+dsK29CNXOoY=
X-Google-Smtp-Source: AA6agR6pLYm7L2r+swF/+kYACjodN0qQ+kyeHS2Ytmy1otBvKR+Gq8iznmfKqi5Fon7Wzc1DI5ynizxAMMmF4P9uQ1c=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr1682838qko.363.1659626801024; Thu, 04
 Aug 2022 08:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org> <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 4 Aug 2022 18:26:29 +0300
Message-ID: <CAA8EJppqWTwXxKX3pxTc=P5kGWMuibKA54UNhq1Yoca+RHvm2w@mail.gmail.com>
Subject: Re: [PATCH v2] firmware/psci: Add debugfs support to ease debugging
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 4 Aug 2022 at 17:49, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Aug 04, 2022 at 04:15:07PM +0300, Dmitry Baryshkov wrote:
> > To ease debugging of PSCI supported features, add debugfs file called
> > 'psci' describing PSCI and SMC CC versions, enabled features and
> > options.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes since v1:
> > - Extended the table to include MEM_PROTECT functions (noted by Mark
> >   Brown)
> > - Switched to seq_puts where possible
> > - Changed S_IRUGO to 0444
> > ---
> >  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/psci.h    |  14 +++++
> >  2 files changed, 129 insertions(+), 1 deletion(-)
>
> TBH I am really not keen on exposing this to userspace. AFAICT this is his is
> incredibly niche, and is going to be very painful to maintain.
>
> Without a strong rationale, I do not thing we should do this.
>
> Who is going to use this, and when?

I sketched this while trying to narrow down the particular issue on
the Qualcomm platform (which started as an attempt to implement PSCI
domains, but then led to understanding that while the platform claims
supports OSI, it doesn't support SET_SUSPEND). We were going to use
this to help to narrow down issues with the PSCI support on other
platforms as well.
Moreover during v1 review I saw at least a subtle request to include
other information as well (e.g. the output from STAT_*),

>
> I'd be much happier logging stuff as it's probed into dmesg; I'm happy to add
> more information there (and/or a command line parameter to be more verbose).

Collecting logs is a nice thing, but asking the user to send the
debugfs file is much easier compared to rebooting the kernel with
different cmdline args (which in the Qualcomm case involves rebuilding
the boot image).

>
> Thanks,
> Mark.
>
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 1628f1edef4a..42cae0ba10e2 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> >  #include <linux/cpuidle.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/errno.h>
> >  #include <linux/linkage.h>
> >  #include <linux/of.h>
> > @@ -326,12 +327,125 @@ static void psci_sys_poweroff(void)
> >       invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> >  }
> >
> > -static int __init psci_features(u32 psci_func_id)
> > +static int psci_features(u32 psci_func_id)
> >  {
> >       return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
> >                             psci_func_id, 0, 0);
> >  }
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define PSCI_ID(ver, _name) \
> > +     { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
> > +#define PSCI_ID_NATIVE(ver, _name) \
> > +     { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
> > +
> > +/* A table of all optional functions */
> > +static const struct {
> > +     u32 fn;
> > +     const char *name;
> > +} psci_fn_ids[] = {
> > +     PSCI_ID_NATIVE(0_2, MIGRATE),
> > +     PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> > +     PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> > +     PSCI_ID(1_0, CPU_FREEZE),
> > +     PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> > +     PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> > +     PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> > +     PSCI_ID(1_0, SET_SUSPEND_MODE),
> > +     PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> > +     PSCI_ID_NATIVE(1_0, STAT_COUNT),
> > +     PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> > +     PSCI_ID(1_1, MEM_PROTECT),
> > +     PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> > +};
> > +
> > +static int psci_debugfs_read(struct seq_file *s, void *data)
> > +{
> > +     int feature, type, i;
> > +     u32 ver;
> > +
> > +     ver = psci_ops.get_version();
> > +     seq_printf(s, "PSCIv%d.%d\n",
> > +                PSCI_VERSION_MAJOR(ver),
> > +                PSCI_VERSION_MINOR(ver));
> > +
> > +     /* PSCI_FEATURES is available only starting from 1.0 */
> > +     if (PSCI_VERSION_MAJOR(ver) < 1)
> > +             return 0;
> > +
> > +     feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> > +     if (feature != PSCI_RET_NOT_SUPPORTED) {
> > +             ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> > +             seq_printf(s, "SMC Calling Convention v%d.%d\n",
> > +                        PSCI_VERSION_MAJOR(ver),
> > +                        PSCI_VERSION_MINOR(ver));
> > +     } else {
> > +             seq_puts(s, "SMC Calling Convention v1.0 is assumed\n");
> > +     }
> > +
> > +     feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
> > +     if (feature < 0) {
> > +             seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
> > +     } else {
> > +             seq_printf(s, "OSI is %ssupported\n",
> > +                        (feature & BIT(0)) ? "" : "not ");
> > +             seq_printf(s, "%s StateID format is used\n",
> > +                        (feature & BIT(1)) ? "Extended" : "Original");
> > +     }
> > +
> > +     type = psci_ops.migrate_info_type();
> > +     if (type == PSCI_0_2_TOS_UP_MIGRATE ||
> > +         type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
> > +             unsigned long cpuid;
> > +
> > +             seq_printf(s, "Trusted OS %smigrate capable\n",
> > +                        type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
> > +             cpuid = psci_migrate_info_up_cpu();
> > +             seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n",
> > +                        cpuid, resident_cpu);
> > +     } else if (type == PSCI_0_2_TOS_MP) {
> > +             seq_puts(s, "Trusted OS migration not required\n");
> > +     } else {
> > +             if (type != PSCI_RET_NOT_SUPPORTED)
> > +                     seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
> > +     }
> > +
> > +     for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
> > +             feature = psci_features(psci_fn_ids[i].fn);
> > +             if (feature == PSCI_RET_NOT_SUPPORTED)
> > +                     continue;
> > +             if (feature < 0)
> > +                     seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n",
> > +                                psci_fn_ids[i].name, feature);
> > +             else
> > +                     seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_debugfs_open(struct inode *inode, struct file *f)
> > +{
> > +     return single_open(f, psci_debugfs_read, NULL);
> > +}
> > +
> > +static const struct file_operations psci_debugfs_ops = {
> > +     .owner = THIS_MODULE,
> > +     .open = psci_debugfs_open,
> > +     .release = single_release,
> > +     .read = seq_read,
> > +     .llseek = seq_lseek
> > +};
> > +
> > +static int __init psci_debugfs_init(void)
> > +{
> > +     return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
> > +                                                &psci_debugfs_ops));
> > +}
> > +late_initcall(psci_debugfs_init)
> > +#endif
> > +
> >  #ifdef CONFIG_CPU_IDLE
> >  static int psci_suspend_finisher(unsigned long state)
> >  {
> > diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> > index 2bf93c0d6354..3511095c2702 100644
> > --- a/include/uapi/linux/psci.h
> > +++ b/include/uapi/linux/psci.h
> > @@ -48,12 +48,26 @@
> >  #define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU    PSCI_0_2_FN64(7)
> >
> >  #define PSCI_1_0_FN_PSCI_FEATURES            PSCI_0_2_FN(10)
> > +#define PSCI_1_0_FN_CPU_FREEZE                       PSCI_0_2_FN(11)
> > +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND              PSCI_0_2_FN(12)
> > +#define PSCI_1_0_FN_NODE_HW_STATE            PSCI_0_2_FN(13)
> >  #define PSCI_1_0_FN_SYSTEM_SUSPEND           PSCI_0_2_FN(14)
> >  #define PSCI_1_0_FN_SET_SUSPEND_MODE         PSCI_0_2_FN(15)
> > +#define PSCI_1_0_FN_STAT_RESIDENCY           PSCI_0_2_FN(16)
> > +#define PSCI_1_0_FN_STAT_COUNT                       PSCI_0_2_FN(17)
> > +
> >  #define PSCI_1_1_FN_SYSTEM_RESET2            PSCI_0_2_FN(18)
> > +#define PSCI_1_1_FN_MEM_PROTECT                      PSCI_0_2_FN(19)
> > +#define PSCI_1_1_FN_MEM_PROTECT_CHECK_RANGE  PSCI_0_2_FN(19)
> >
> > +#define PSCI_1_0_FN64_CPU_DEFAULT_SUSPEND    PSCI_0_2_FN64(12)
> > +#define PSCI_1_0_FN64_NODE_HW_STATE          PSCI_0_2_FN64(13)
> >  #define PSCI_1_0_FN64_SYSTEM_SUSPEND         PSCI_0_2_FN64(14)
> > +#define PSCI_1_0_FN64_STAT_RESIDENCY         PSCI_0_2_FN64(16)
> > +#define PSCI_1_0_FN64_STAT_COUNT             PSCI_0_2_FN64(17)
> > +
> >  #define PSCI_1_1_FN64_SYSTEM_RESET2          PSCI_0_2_FN64(18)
> > +#define PSCI_1_1_FN64_MEM_PROTECT_CHECK_RANGE        PSCI_0_2_FN64(19)
> >
> >  /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
> >  #define PSCI_0_2_POWER_STATE_ID_MASK         0xffff
> > --
> > 2.35.1
> >



-- 
With best wishes
Dmitry
