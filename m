Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D976E664F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjDRNsu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 18 Apr 2023 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjDRNss (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 09:48:48 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9542D1387B;
        Tue, 18 Apr 2023 06:48:18 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso39025166b.1;
        Tue, 18 Apr 2023 06:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825675; x=1684417675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uozf3W91u85ycR8eSvHXlO7LPB6dzE935AuEqaKzec=;
        b=PvC06eTMtd+qlA84QurcYHy8XYPG+BDwQSmZCqkdEFPmM4mzWJRl5IHK2LmA+EOkWr
         7hQ+L8vyG7qypUs7hGeNSPGKjEzHQnBXBj4506KwxVIRvYhUQtlNRECwLtZ7q2ecS3tp
         YF11PtsWawcZTwetkCEsFWrHczyPwBGXZ82kNd9oGI53kl9wT3AP6zHXnJ4KYTereQsy
         kc9B/Yj5HVb1jakvKQzy8E7SKBqhs/nl5JaQz5wgnZ27ZXmAwrQhXFbgi1IA3nsdGRbA
         kFL3gW5GSpkC3PD1cJUE019Ite9b13E6k1WbEhUPuAOAq2fiK520q+k9WM/wfySQzDz0
         BhTA==
X-Gm-Message-State: AAQBX9cdtQTKgxoooq3DFfIPO4Rc8ptaqS0sGKE26+O1Rh2Dt1+mgkcm
        Kg02g9fZdIC/pxN6hx81hkYwJYUryPCU4HfBql4=
X-Google-Smtp-Source: AKy350ZtbzWtgHQ4XNaLLsN4MTaFSWJ9riU5l62WBvTtPTO6gk+oybu7omrK5r2ggg/9RcTGgaWMJ1TI0p+2ICubIK0=
X-Received: by 2002:a17:906:3f49:b0:94e:63ae:5b9b with SMTP id
 f9-20020a1709063f4900b0094e63ae5b9bmr12182147ejj.7.1681825675404; Tue, 18 Apr
 2023 06:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
 <20230413114647.3878792-6-daniel.lezcano@linaro.org> <CAJZ5v0jqB18c1u-eqcEiXW+fOH=nX=Uu3xi5sp2F9udsFUrYew@mail.gmail.com>
 <7fd7df2d-f473-c0fd-5c3c-40d0fb697db7@linaro.org>
In-Reply-To: <7fd7df2d-f473-c0fd-5c3c-40d0fb697db7@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:47:44 +0200
Message-ID: <CAJZ5v0hkF37RL4fxqE7+iUw7gEtb+KMyDKBpjdO=DE72OSHFtg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] thermal/drivers/acpi: Make cross dev link optional
 by configuration
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 18, 2023 at 3:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 18/04/2023 15:38, Rafael J. Wysocki wrote:
> > On Thu, Apr 13, 2023 at 1:47 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The ACPI thermal driver creates a link in the thermal zone device
> >> sysfs directory pointing to the device sysfs directory. At the same
> >> time, it creates a back pointer link from the device to the thermal
> >> zone device sysfs directory.
> >>
> >>  From a generic perspective, having a device pointer in the sysfs
> >> thermal zone directory may make sense. But the opposite is not true as
> >> the same driver can be related to multiple thermal zones.
> >>
> >> The usage of these information is very specific to ACPI and it is
> >> questionable if they are really needed.
> >>
> >> Let's make the code optional and disable it by default. If it hurts,
> >> we will revert this change.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/acpi/Kconfig   | 13 +++++++++
> >>   drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
> >>   2 files changed, 55 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> >> index ccbeab9500ec..7df4e18f06ef 100644
> >> --- a/drivers/acpi/Kconfig
> >> +++ b/drivers/acpi/Kconfig
> >> @@ -336,6 +336,19 @@ config ACPI_THERMAL
> >>            To compile this driver as a module, choose M here:
> >>            the module will be called thermal.
> >>
> >> +config ACPI_THERMAL_SYSFS_ADDON
> >> +       bool "Enable thermal sysfs addon"
> >> +       depends on ACPI_THERMAL
> >> +       def_bool n
> >> +       help
> >> +        Enable sysfs extra information added in the thermal zone and
> >> +        the driver specific sysfs directories. That could be a link
> >> +        to the associated thermal zone as well as a link pointing to
> >> +        the device from the thermal zone. By default those are
> >> +        disabled and are candidate for removal, if you need these
> >> +        information anyway, enable the option or upgrade the
> >> +        userspace program using them.
> >> +
> >
> > I don't think that the Kconfig option is appropriate and the help text
> > above isn't really helpful.
>
> I'm sorry, I'm missing something. Don't we want to make these sysfs
> extra information optional and disable them by default ?

No, I mean no Kconfig option at all for this one at least for now.
