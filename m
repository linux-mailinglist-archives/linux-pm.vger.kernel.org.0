Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA08C196954
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1Un6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 16:43:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36265 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgC1Un6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 16:43:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id i13so6456299pfe.3;
        Sat, 28 Mar 2020 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KFYTP+4isYO+Nu64ocnQ9VsaDC4G9NxfTqcPGikuJs=;
        b=Vql+JZGSmvAVWvNQMLCmmxOwBp8hkm1vmq2icYAMfmPekocTIe0TWnP0P1f66x72Rd
         WRzklPFEhlDRhG05xIl3WKb/Ee33fkmUm7TL8DVm/6FJBJGDGqjGUuKZarRyKHrjx7FG
         pv/qHWehTkswx9foPs0HByFifQef1fzxj708Tcktu74H664Dfsvk5+tjnq3EY2YNh5bm
         +j0FI/Jqk7SSzZxV+4XR4ikkTRFdhcy9la5VCfAesdIOS0EcywrjCk0xvUkuTe5aP3sV
         xuQGK8zyTub6rBEN2E6G+2+qhkiC7AH1sHF9iUEJ5SbFRLQFaR8hurdhVbApo/GlL1HY
         gRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KFYTP+4isYO+Nu64ocnQ9VsaDC4G9NxfTqcPGikuJs=;
        b=LqJ/RwGzYXyAVjfTT7GTjL4tGW8Gzn9zaI9mpijT9knmDA7128uK39uYEzYPZCOb/2
         0G1qcn1b5V7WpUid4huMh3SrRQJ8tp/HOLBAIp0lMvkNfFiS5keD/ACWAS95hITLsG/c
         FtuGpObzUeA3clM5WY/LtRFCZth4sP3hw+yrHJHOjJjWQGGRgHOoUeSx7+90a/zvbDSg
         7Q8FUtCRzO0SgSvQA02zjKjJoxEU0J9dHJmhP8u5qhLf8qGicwWnnmxmwh487fMQ5Qyx
         31ufDFBPQ0G8DU00JYv1Qy26iWmUjfkMNuP/gOZg0Zo/D3TSUfOSfMEeQ9zIqryAdo5l
         A+kg==
X-Gm-Message-State: ANhLgQ19Btc+QxSVy4QwOYL4diV2LxDbPhx7cn6e74/eHovsxPYaXG1V
        mav0fCAW6Ll8qJoDO2G8rWlgQi7i+tNrCDJcBHY=
X-Google-Smtp-Source: ADFU+vsKB4iGKQecF/EusqwlApCiHlWvxU386zM5SXxTzdTzlx3AyjA89liyhD5mK+CGJcFxZDYz9oJXwK1ffx2gimI=
X-Received: by 2002:a63:798a:: with SMTP id u132mr6025684pgc.203.1585428237055;
 Sat, 28 Mar 2020 13:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585343507.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1585343507.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 22:43:44 +0200
Message-ID: <CAHp75VcEO0udSzpWX14vaZcjLni2RA3NGXNqr50HMK=S7GWjxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes: update Tiger Lake ACPI device IDs
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Alex Hung <alex.hung@canonical.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 27, 2020 at 11:34 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Hi,
>
> The hardware IDs for devices supported by Tiger Lake for various drivers
> such as DPTF, fan, Intel thermal and intel-hid are added with missing 'C'
> which makes them invalid. Hence fix these IDs by updating.
>
> For instance, the updated ID now looks like
> INT1047 --> INTC1047
>
> Patch 1: Update Tiger Lake ACPI device IDs for DPTF and fan drivers
> Patch 2: Update Tiger Lake ACPI device ID for intel-hid driver
> Patch 3: Update Tiger Lake ACPI device IDs for thermal driver
>

Please, keep the IDs sorted (INTC should go after INT, etc).
Also I will need an Ack for patch 1 (at least).

> Changes since v1:
> 1) Added fixes tag to each patch
>
> Gayatri Kammela (3):
>   ACPI: fix: Update Tiger Lake ACPI device IDs
>   platform/x86: intel-hid: fix: Update Tiger Lake ACPI device ID
>   thermal: int340x_thermal: fix: Update Tiger Lake ACPI device IDs
>
>  drivers/acpi/device_pm.c                                | 2 +-
>  drivers/acpi/dptf/dptf_power.c                          | 2 +-
>  drivers/acpi/dptf/int340x_thermal.c                     | 8 ++++----
>  drivers/platform/x86/intel-hid.c                        | 2 +-
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
