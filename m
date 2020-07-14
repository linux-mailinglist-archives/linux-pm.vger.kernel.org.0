Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D4220012
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGNVeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgGNVeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:34:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D65C061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:34:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so1010833wmf.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UtdKaUC50+DBu44j3zskZy46PDkWi7WEkFGNTwqCIoY=;
        b=ZdxXWZM/b8EqxIpABEM6pucd3tsDPMAQfWU1nIe16VgCJokdapVLUjRlV5UPCmXIy8
         g/cPrQ8DefYSLzelcVRd7gziOGDddN35aIqanSzhKRDTeYvP8zwPVdUBeSLv83jn8cLE
         CKlYIgFapNDT1Mujzuc1pYuICnf0PL9xwfIliuIxuZ9JpSzNBYWRBzqCkT/if1n7M9oY
         rR4t+NCLHGYA5fzbPQ1SUTM47Lvtj1nJvxceDGuv9luNbkkjGxydDcdvq6vyAOoWPIGt
         PKTwOkzm84pBrYLhfjP+ctuefK8I0nGvM2a2rfC3GAMvunHwuhO6DxKas83H/jumrufW
         /x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UtdKaUC50+DBu44j3zskZy46PDkWi7WEkFGNTwqCIoY=;
        b=d9Wl2fgnKk9iRJ0LQ5EM2OsqKIwbBV2U1rSYHJvsIpWud5DDCGMemkGG2wsZP8NWTY
         mOq33QYctq+KVltua8kybev3xvsheTIOF4bCFJoGHSPLRHhKJi0egVwCBVFunozDezDS
         3rjhUXXp0gWBMc3906IAQfVvEbgkyWasq2HXZOftbT61ajjTGauoYYShN8HiblgOu7fG
         ntKHvqpxiUbZaTdFHndro1QdiKtndCuBkUqNiq3CqIL2QQqDB27k6RmI2iFAm7rVDrjJ
         Ch83xc0jcUyYyNHlQ35r/H8qa/HTXHwF2FDPRwNyKukvealBV1t6V+lQsRVZiEfFjUBr
         iH5Q==
X-Gm-Message-State: AOAM531YNQpIQBPhG3IeAi9r5P0qICnAKVGcNVteuPAEezr6tfWENhIL
        m/8iahBT80J381NVU3tESKYv5YK62v6aRg==
X-Google-Smtp-Source: ABdhPJwN+wbuGDAsIxRpEcUZpQpduMqrY8XULh5RX+WB9UypF8LaMOjLVXqMgqHTPSLtn1qEMODkZw==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr5303227wmi.99.1594760623207;
        Tue, 14 Jul 2020 14:03:43 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w14sm30807910wrt.55.2020.07.14.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:03:42 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:03:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200714210340.GJ1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:

> On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Can't see them being used anywhere and the compiler doesn't complain
> > that they're missing, so ...
> 
> Aren't they needed for automatic module loading in certain configurations?

Any idea how that works, or where the code is for that?

> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/cpufreq/acpi-cpufreq.c:1004:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
> >  997 | static const struct x86_cpu_id acpi_cpufreq_ids[] = {
> >  | ^~~~~~~~~~~~~~~~
> >  drivers/cpufreq/acpi-cpufreq.c:997:32: warning: ‘acpi_cpufreq_ids’ defined but not used [-Wunused-const-variable=]
> >  619 | static const struct acpi_device_id processor_device_ids[] = {
> >  | ^~~~~~~~~~~~~~~~~~~~
> >
> > Cc: Andy Grover <andrew.grover@intel.com>
> > Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> > Cc: Dominik Brodowski <linux@brodo.de>
> > Cc: Denis Sadykov <denis.m.sadykov@intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 14 --------------
> >  1 file changed, 14 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index d38a693b48e03..fc68f13352695 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -995,18 +995,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
> >  late_initcall(acpi_cpufreq_init);
> >  module_exit(acpi_cpufreq_exit);
> >
> > -static const struct x86_cpu_id acpi_cpufreq_ids[] = {
> > -       X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
> > -       X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
> > -       {}
> > -};
> > -MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
> > -
> > -static const struct acpi_device_id processor_device_ids[] = {
> > -       {ACPI_PROCESSOR_OBJECT_HID, },
> > -       {ACPI_PROCESSOR_DEVICE_HID, },
> > -       {},
> > -};
> > -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> > -
> >  MODULE_ALIAS("acpi");
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
