Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB62B6822
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgKQO7g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 09:59:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45561 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgKQO7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 09:59:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id k3so19621859otp.12;
        Tue, 17 Nov 2020 06:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBAt+SOaJCyDloFwjlRJ/ezQ7X0Co5bocslvDWABnKo=;
        b=b38Hd9RXoZlJrwyEifprcBNhnyPD0ueBCSmtNTHtrpIYUf0GBU2Cf0ZwzqmpOgTucs
         f0Z9KhPUUbaIM7soZImVeHXejbYz7Rhg/sd2tQQ6KHUz5ufTKYJaoXOURzmWuZgy1j72
         d3mf4ypWG+W4hHgH1C+hmrVolKyC7DtPW1e1sME2lxmbsMUkwKkI/zhLBxZqKIkcBU8k
         r5qMocerDpmdVsd52IIgwFEodbJ4VKskJ/OwZNFFqfHYBNOpxN2WOj2ji5HgiQaLZzkg
         PEq87NzINjiBssNSlyiRc6DoMjK4SzvovKQztTSgrs8gliebwRMVb0bEeJ9LfSuoGtEb
         XDAQ==
X-Gm-Message-State: AOAM533gA9UzEjU3st3zHnTSf7cESpoufnPzHmWSTDCEXXInu7VflEkW
        SxeoX51tBP+zrJVx4qGCUIQ7l70qhDhwz7u2k5Q=
X-Google-Smtp-Source: ABdhPJx/vcIT9i+JK3UjFgMS/W4kUHQudvPXg2GomkpBC9XwnCKOGTckmJw4Uop1jB6m9rP6eHUSAYKAbjESxGwpBsA=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr3450409ota.260.1605625174900;
 Tue, 17 Nov 2020 06:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 15:59:24 +0100
Message-ID: <CAJZ5v0hucue4fwGgHF5-jXRn8kSt3hORyQ7Q4-azmZ8UBijUkw@mail.gmail.com>
Subject: Re: [PATCH 0/8] cppc_cpufreq: fix, clarify and improve support
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 5, 2020 at 1:56 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> I found myself staring a bit too much at this driver in the past weeks
> and that's likely the cause for me coming up with this series of 8
> patches that cleans up, clarifies and reworks parts of it, as follows:
>
>  - patches 1-3/8: trivial clean-up and renaming with the purpose to
>                   improve readability
>  - patch 4/8: replace previous per-cpu data structures with lists of
>               domains and CPUs to get more efficient storage for driver
>               data and fix previous issues in case of CPU hotplugging,
>               as discussed at [1].
>  - patches 5-6/8: a few fixes and clarifications: mostly making sure
>                   the behavior described in the comments and debug
>                   messages matches the code and there is clear
>                   indication of what is supported and how.
>  - patch 7/8: use the existing freqdomains_cpus attribute to inform
>               the user on frequency domains.
>  - patch 8/8: acpi: replace ALL coordination with NONE coordination
>                     when errors are find parsing the _PSD domains
>               (as described in the comments in the code).
>
> Hopefully you'll find this useful for ease of maintenance and ease of
> future development of the driver.
>
> This functionality was tested on a Juno platform with modified _PSD
> tables to test the functionality for all currently supported
> coordination types: ANY, HW, NONE.
>
> The current code is based on v5.10-rc2.
>
> Thanks,
> Ionela.
>
> [1] https://lore.kernel.org/linux-pm/20200922162540.GB796@arm.com/
>
> Ionela Voinescu (8):
>   cppc_cpufreq: fix misspelling, code style and readability issues
>   cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
>   cppc_cpufreq: simplify use of performance capabilities
>   cppc_cpufreq: replace per-cpu structures with lists
>   cppc_cpufreq: use policy->cpu as driver of frequency setting
>   cppc_cpufreq: clarify support for coordination types
>   cppc_cpufreq: expose information on frequency domains
>   acpi: fix NONE coordination for domain mapping failure
>
>  .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
>  drivers/acpi/cppc_acpi.c                      | 126 +++---
>  drivers/acpi/processor_perflib.c              |   2 +-
>  drivers/cpufreq/cppc_cpufreq.c                | 358 +++++++++++-------
>  include/acpi/cppc_acpi.h                      |  14 +-
>  5 files changed, 277 insertions(+), 226 deletions(-)
>
> --

All patches applied as 5.11 material (with a minor subject edit in the
last patch), thanks!

In the future, though, please CC all/any ACPI-related changes to the
linux-acpi mailing list.
