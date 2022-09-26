Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505DC5EA7CF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiIZOAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIZN7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 09:59:44 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994BB85F92
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 05:13:46 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3454b0b1b6dso66422577b3.4
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JXQJXsGI89BdCSLfZat6mqt1uav/fNaAZbjr/4gf+nY=;
        b=Not6ByvvqSIZQZHWVAoraSBErTyfNCZuQSIsTP+CvEuMvX3ZkKWYVvXCGe9AxSdFo0
         JAHu9LPuzFdg5FzLsjNs6LuQDIz+9+InCcPb6zNLim4sko7brzZlZ1Kk4BaslnHHQZpg
         UIb3DPD+qDElW0JEOomkrX7IPwbgXVo8u7zESg1fB78A1Eqn9LYElbsktdSu4c+HXCxb
         u/T7pDhKeDvZNqN33veQ910oYVeBojxWdns+B9KQOK8HmAjIabdYSxlxZ//xoPVH9ATl
         axnSCwRXnbqnWV8W1xL+65kCeo4fZhf/o8WnGcxsX4875LPPAUUpzagm4dbfF3y9YwgQ
         u/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JXQJXsGI89BdCSLfZat6mqt1uav/fNaAZbjr/4gf+nY=;
        b=vTqVMWlmY63HKQLLTPtLtPD02EjDiXKAnRPhU3pqfk2nrf6ZwCf53mMBD/EbmEKbtK
         vDZ1a5FQyA8IgdT6r0r8ZYTH8D6o6Bdl33Ar04Yg3oPun20KFNJsTUDwMMtGZk3wbwkf
         6UJF/rdjLze1xPxzFGLxMVtyL4VCa4p0H7Uj0ouFKokWEZmIwkY/prIDTEPxF5jT9y8b
         zfSoMy5WsxljsddSqmAEblak7oct0ISBYFY9wwNWs+KN5twervje+/3eLmnLiujXDDLV
         JU7h5SKleJhet1Tl9VTaBpqVsYUfBrPnQukYs5zcVC/H7N5qzY5t6l/UxIYudF11S+s2
         KZPA==
X-Gm-Message-State: ACrzQf0ieR17Bd8r/z9WDCZQtk4i8h8AAn+iLOb7fYejxZfNABUFdwM/
        N1Tw8rSukiGXYFKhfGJ1kwmDNh1Frl8wT8BSd0SEthFfrWk=
X-Google-Smtp-Source: AMsMyM4cNRRF1ligGecX4Z88psxs6jU2e2tZuXyzXnEvHF+OxhZDXd+5vRzIuCnI3wf+uU2N7khkngp7Huh+qm7tt4o=
X-Received: by 2002:a81:8502:0:b0:340:a7fc:ddb2 with SMTP id
 v2-20020a818502000000b00340a7fcddb2mr21484301ywf.378.1664193851645; Mon, 26
 Sep 2022 05:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220926110758.666922-1-dmitry.baryshkov@linaro.org> <CAPDyKFqAgukYVPvkrE=mzM88e+PfFnecwPLxdRogjnwHgLq=Jw@mail.gmail.com>
In-Reply-To: <CAPDyKFqAgukYVPvkrE=mzM88e+PfFnecwPLxdRogjnwHgLq=Jw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 26 Sep 2022 15:04:00 +0300
Message-ID: <CAA8EJpqq-DKL-8z15C33KmQNs4CYcWUi6zaCN856OyE2VoJwzg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] firmware/psci: Add debugfs support to ease debugging
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Mon, 26 Sept 2022 at 14:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 26 Sept 2022 at 13:08, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > To ease debugging of PSCI supported features, add debugfs file called
> > 'psci' describing PSCI and SMC CC versions, enabled features and
> > options.
> >
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > I sketched this while trying to narrow down the particular issue on
> > the Qualcomm platform (which started as an attempt to implement PSCI
> > domains, but then led to understanding that while the platform claims
> > supports OSI, it doesn't support SET_SUSPEND). We were going to use
> > this to help to narrow down issues with the PSCI support on other
> > platforms as well.
> >
> > Changes since v1:
> > - Extended the table to include MEM_PROTECT functions (noted by Mark
> >   Brown)
> > - Switched to seq_puts where possible
> > - Changed S_IRUGO to 0444
> >
> > The patch is resent to include soc@kernel.org
> > ---
> >  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/psci.h    |  14 +++++
> >  2 files changed, 129 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index cfb448eabdaa..9fdcb6bff403 100644
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
> > @@ -324,12 +325,125 @@ static void psci_sys_poweroff(void)
> >         invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> >  }
> >
> > -static int __init psci_features(u32 psci_func_id)
> > +static int psci_features(u32 psci_func_id)
> >  {
> >         return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
> >                               psci_func_id, 0, 0);
> >  }
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +#define PSCI_ID(ver, _name) \
> > +       { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
> > +#define PSCI_ID_NATIVE(ver, _name) \
> > +       { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
> > +
> > +/* A table of all optional functions */
> > +static const struct {
> > +       u32 fn;
> > +       const char *name;
> > +} psci_fn_ids[] = {
> > +       PSCI_ID_NATIVE(0_2, MIGRATE),
> > +       PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> > +       PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> > +       PSCI_ID(1_0, CPU_FREEZE),
> > +       PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> > +       PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> > +       PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> > +       PSCI_ID(1_0, SET_SUSPEND_MODE),
> > +       PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> > +       PSCI_ID_NATIVE(1_0, STAT_COUNT),
> > +       PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> > +       PSCI_ID(1_1, MEM_PROTECT),
> > +       PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> > +};
> > +
> > +static int psci_debugfs_read(struct seq_file *s, void *data)
> > +{
> > +       int feature, type, i;
> > +       u32 ver;
> > +
> > +       ver = psci_ops.get_version();
>
> This call and some other calls below, triggers calls into the PSCI FW
> (via smc calls). Rather than having to do that, each time user space
> wants to read the debugfs data, we could cache/store that data during
> the "probe" sequence of the psci fw driver. In this way, we don't need
> to run the smc calls each time, but just once when probing.
>
> Did you consider that option? Or perhaps there are other problems of doing that?

Basically I did not want to complicate this. While caching firmware
information sounds appealing, it would complicate adding support for
the additional debugging features, like checking sleep state stats.

So, I'd say, it's not worth doing that.

>
> > +       seq_printf(s, "PSCIv%d.%d\n",
> > +                  PSCI_VERSION_MAJOR(ver),
> > +                  PSCI_VERSION_MINOR(ver));
> > +
> > +       /* PSCI_FEATURES is available only starting from 1.0 */
> > +       if (PSCI_VERSION_MAJOR(ver) < 1)
> > +               return 0;
> > +
> > +       feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
> > +       if (feature != PSCI_RET_NOT_SUPPORTED) {
> > +               ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> > +               seq_printf(s, "SMC Calling Convention v%d.%d\n",
> > +                          PSCI_VERSION_MAJOR(ver),
> > +                          PSCI_VERSION_MINOR(ver));
> > +       } else {
> > +               seq_puts(s, "SMC Calling Convention v1.0 is assumed\n");
> > +       }
> > +
> > +       feature = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
> > +       if (feature < 0) {
> > +               seq_printf(s, "PSCI_FEATURES(CPU_SUSPEND) error (%d)\n", feature);
> > +       } else {
> > +               seq_printf(s, "OSI is %ssupported\n",
> > +                          (feature & BIT(0)) ? "" : "not ");
> > +               seq_printf(s, "%s StateID format is used\n",
> > +                          (feature & BIT(1)) ? "Extended" : "Original");
> > +       }
> > +
> > +       type = psci_ops.migrate_info_type();
> > +       if (type == PSCI_0_2_TOS_UP_MIGRATE ||
> > +           type == PSCI_0_2_TOS_UP_NO_MIGRATE) {
> > +               unsigned long cpuid;
> > +
> > +               seq_printf(s, "Trusted OS %smigrate capable\n",
> > +                          type == PSCI_0_2_TOS_UP_NO_MIGRATE ? "not " : "");
> > +               cpuid = psci_migrate_info_up_cpu();
> > +               seq_printf(s, "Trusted OS resident on physical CPU 0x%lx (#%d)\n",
> > +                          cpuid, resident_cpu);
> > +       } else if (type == PSCI_0_2_TOS_MP) {
> > +               seq_puts(s, "Trusted OS migration not required\n");
> > +       } else {
> > +               if (type != PSCI_RET_NOT_SUPPORTED)
> > +                       seq_printf(s, "MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
> > +       }
> > +
> > +       for (i = 0; i < ARRAY_SIZE(psci_fn_ids); i++) {
> > +               feature = psci_features(psci_fn_ids[i].fn);
> > +               if (feature == PSCI_RET_NOT_SUPPORTED)
> > +                       continue;
> > +               if (feature < 0)
> > +                       seq_printf(s, "PSCI_FEATURES(%s) error (%d)\n",
> > +                                  psci_fn_ids[i].name, feature);
> > +               else
> > +                       seq_printf(s, "%s is supported\n", psci_fn_ids[i].name);
> > +       }
> > +
> > +       return 0;
> > +}
>
> [...]
>
> Kind regards
> Uffe



-- 
With best wishes
Dmitry
