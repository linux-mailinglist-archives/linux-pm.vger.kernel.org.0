Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298EF21F694
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGNP6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Jul 2020 11:58:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36593 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNP6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 11:58:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id h17so14328489oie.3;
        Tue, 14 Jul 2020 08:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qvEysgJYfCAug8jVBcrbyiiBEEw40SucgK7wjiV/k08=;
        b=Z0Rtv5btpLrfFcNqmpAVRXlrC828HElFNUiJpt70GgQhhG2Ncpt7yWAH6/0vHNvm2j
         I3G6nuOAs2lbXNVtQtsmt4p2gpPgu7pTCAbQuL9SzlXlfLs2Uf272T6oRcX9FeXYctPF
         /lSvPXMy2cruNlVi/B1yCt4v6dToYOdmv0g6IPcVQkSIXE8AqrPk0IlQftWCj8Ro29Gk
         YDwnWQgAz6MxUncyR6sSrGQN4cHv/fTBeL3clEo7ky33pVGRXiL5Mrm8J7RQRy2xSrwC
         bKkW1i4FbffOmp4jJ6+nGN6NlreRp9d71L/Si0j4oPlmBfJgVkDY/x1XKRFZ11TlrpGd
         b6UA==
X-Gm-Message-State: AOAM530EFUlfdAjzLpYhmBvoJAM1M/Os9PRfcLGWzpUlb6miDla4qtty
        TeFfWCcBd0mjfKiJP1quwEans4L9wJeXFME6g2E=
X-Google-Smtp-Source: ABdhPJx3F5Gi+qjW3wd97TexweWn1i7SVIu1JsmkDLtvkyWQmXrxdacZYE66yGenmJOtuuP/TNv58mMUgzRQ1viiQ4w=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr4403423oia.103.1594742292442;
 Tue, 14 Jul 2020 08:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-10-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-10-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 17:58:01 +0200
Message-ID: <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Can't see them being used anywhere and the compiler doesn't complain
> that they're missing, so ...

Aren't they needed for automatic module loading in certain configurations?

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/cpufreq/acpi-cpufreq.c:1004:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
>  997 | static const struct x86_cpu_id acpi_cpufreq_ids[] = {
>  | ^~~~~~~~~~~~~~~~
>  drivers/cpufreq/acpi-cpufreq.c:997:32: warning: ‘acpi_cpufreq_ids’ defined but not used [-Wunused-const-variable=]
>  619 | static const struct acpi_device_id processor_device_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~
>
> Cc: Andy Grover <andrew.grover@intel.com>
> Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> Cc: Dominik Brodowski <linux@brodo.de>
> Cc: Denis Sadykov <denis.m.sadykov@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index d38a693b48e03..fc68f13352695 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -995,18 +995,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
>
> -static const struct x86_cpu_id acpi_cpufreq_ids[] = {
> -       X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
> -       X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
> -       {}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
> -
> -static const struct acpi_device_id processor_device_ids[] = {
> -       {ACPI_PROCESSOR_OBJECT_HID, },
> -       {ACPI_PROCESSOR_DEVICE_HID, },
> -       {},
> -};
> -MODULE_DEVICE_TABLE(acpi, processor_device_ids);
> -
>  MODULE_ALIAS("acpi");
> --
> 2.25.1
>
