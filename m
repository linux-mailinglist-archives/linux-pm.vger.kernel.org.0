Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4025EA9D8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Sep 2022 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiIZPMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiIZPMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 11:12:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6F5FF69
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 06:50:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so10357120wrb.4
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=51L11/Eb0FzfzPONeQTaL/VY2y3dvAoHKauy/xTHuE4=;
        b=X3SwnMtC+ZcczcNmCkVzFFRP5wKAClQbc6zKdrN4XjyOC1ievUb9e5H2FblwKKo7/N
         E0qYejC6HSnwtJsUwmPBUMlR/Bu0xkapidnanYtkaH0VApVmDdFJjhgIS9oT1rQTL8Ru
         DhaIRBLfT12GYjE+0EHKh5aY6bI3ANszQXkDKq6pk8qUymNFzZRa+3AXvmG484OP1M+4
         bzG4vlObkndYekbqsG/d9lS6T01Iv/No8h1Das7F/EpBIEanqmDBduQ6yDs7fExRjzkG
         d4MgjoJm7l6IEyPR0eEKhh9rZyFLGcfc8BTOEafioufzgslCXO72RTg7G82AwnE1CStM
         f/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=51L11/Eb0FzfzPONeQTaL/VY2y3dvAoHKauy/xTHuE4=;
        b=mTDvIYXrXqDZBjQU4yteaG/qDcQ0bJNRFJHdV7S7uekznLlxnI4YwmdIIduh7v80Nt
         PsVS56/cl0RBMIEKX5ZYu3WJzG0Id2vOX607IEm3RCYb+6G4QX7PREUsoH8T275JUlF9
         ADPQM6CVWK6kE5KJS/4sfQWPL0K06w/709rKX1RG/uEWtuCtZcCw1zYPHaJaKNqxFgJA
         avGTcl580+NGYlttieTnYhNU6CNYKlbUBtv49UMOg8UIjZQhLWFdXzsnvUGYrAgusHBM
         DWRRIQPm8pCtjObyBkfFOHsfpHi9Tp4OA3HHp27b7JImVnWzaqsj2jeFXQNyq5OarQDh
         yBZA==
X-Gm-Message-State: ACrzQf1pIxUbqdgV88JXhrohA/1fYRkJXQwNBjbxv2bJp5oz3aGFd86x
        zpeIy1bxddhOfBNTAWT2cBcbU/IAIJWzbj/8d5g7wTzlAGM=
X-Google-Smtp-Source: AMsMyM4DSZsg80UMW9gmncp54qOAxC+heRjWLPvbzKg9P5pBwAwJV+IvQGRKEYPqITaFdrW7X8ObfY9fn+pTk7Kq14A=
X-Received: by 2002:a05:6000:81e:b0:228:a17f:92f0 with SMTP id
 bt30-20020a056000081e00b00228a17f92f0mr13959102wrb.31.1664200249678; Mon, 26
 Sep 2022 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220926110758.666922-1-dmitry.baryshkov@linaro.org>
 <CAPDyKFqAgukYVPvkrE=mzM88e+PfFnecwPLxdRogjnwHgLq=Jw@mail.gmail.com> <CAA8EJpqq-DKL-8z15C33KmQNs4CYcWUi6zaCN856OyE2VoJwzg@mail.gmail.com>
In-Reply-To: <CAA8EJpqq-DKL-8z15C33KmQNs4CYcWUi6zaCN856OyE2VoJwzg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 26 Sep 2022 15:50:13 +0200
Message-ID: <CAPDyKFpJGdX39ZKqwZZhsFns4aKq++3se_EPcAGzUjOy_dj3mg@mail.gmail.com>
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

On Mon, 26 Sept 2022 at 14:04, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 26 Sept 2022 at 14:39, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 26 Sept 2022 at 13:08, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > To ease debugging of PSCI supported features, add debugfs file called
> > > 'psci' describing PSCI and SMC CC versions, enabled features and
> > > options.
> > >
> > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > > I sketched this while trying to narrow down the particular issue on
> > > the Qualcomm platform (which started as an attempt to implement PSCI
> > > domains, but then led to understanding that while the platform claims
> > > supports OSI, it doesn't support SET_SUSPEND). We were going to use
> > > this to help to narrow down issues with the PSCI support on other
> > > platforms as well.
> > >
> > > Changes since v1:
> > > - Extended the table to include MEM_PROTECT functions (noted by Mark
> > >   Brown)
> > > - Switched to seq_puts where possible
> > > - Changed S_IRUGO to 0444
> > >
> > > The patch is resent to include soc@kernel.org
> > > ---
> > >  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
> > >  include/uapi/linux/psci.h    |  14 +++++
> > >  2 files changed, 129 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index cfb448eabdaa..9fdcb6bff403 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/acpi.h>
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/cpuidle.h>
> > > +#include <linux/debugfs.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/linkage.h>
> > >  #include <linux/of.h>
> > > @@ -324,12 +325,125 @@ static void psci_sys_poweroff(void)
> > >         invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> > >  }
> > >
> > > -static int __init psci_features(u32 psci_func_id)
> > > +static int psci_features(u32 psci_func_id)
> > >  {
> > >         return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
> > >                               psci_func_id, 0, 0);
> > >  }
> > >
> > > +#ifdef CONFIG_DEBUG_FS
> > > +
> > > +#define PSCI_ID(ver, _name) \
> > > +       { .fn = PSCI_##ver##_FN_##_name, .name = #_name, }
> > > +#define PSCI_ID_NATIVE(ver, _name) \
> > > +       { .fn = PSCI_FN_NATIVE(ver, _name), .name = #_name, }
> > > +
> > > +/* A table of all optional functions */
> > > +static const struct {
> > > +       u32 fn;
> > > +       const char *name;
> > > +} psci_fn_ids[] = {
> > > +       PSCI_ID_NATIVE(0_2, MIGRATE),
> > > +       PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> > > +       PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> > > +       PSCI_ID(1_0, CPU_FREEZE),
> > > +       PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> > > +       PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> > > +       PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> > > +       PSCI_ID(1_0, SET_SUSPEND_MODE),
> > > +       PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> > > +       PSCI_ID_NATIVE(1_0, STAT_COUNT),
> > > +       PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> > > +       PSCI_ID(1_1, MEM_PROTECT),
> > > +       PSCI_ID_NATIVE(1_1, MEM_PROTECT_CHECK_RANGE),
> > > +};
> > > +
> > > +static int psci_debugfs_read(struct seq_file *s, void *data)
> > > +{
> > > +       int feature, type, i;
> > > +       u32 ver;
> > > +
> > > +       ver = psci_ops.get_version();
> >
> > This call and some other calls below, triggers calls into the PSCI FW
> > (via smc calls). Rather than having to do that, each time user space
> > wants to read the debugfs data, we could cache/store that data during
> > the "probe" sequence of the psci fw driver. In this way, we don't need
> > to run the smc calls each time, but just once when probing.
> >
> > Did you consider that option? Or perhaps there are other problems of doing that?
>
> Basically I did not want to complicate this. While caching firmware
> information sounds appealing, it would complicate adding support for
> the additional debugging features, like checking sleep state stats.
>
> So, I'd say, it's not worth doing that.

Alright, no strong opinion from my side. Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
