Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B501A14ED61
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 14:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgAaNbk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 08:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgAaNbk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 08:31:40 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4106320CC7;
        Fri, 31 Jan 2020 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580477499;
        bh=rGI+UF/ICJd+DA8hslNtVh1f+xovDraNDpFwivdJgEQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lNh1WjFIpIEW9gXqIRSmZJAOjv3O4mh6mGQrDhX5I681cYGAB8HU+xBjBD2rJ1C9Q
         TJXUu70xcUSirXIZgn61heC1YOyaIndk86NtztEiWfuW+VPE4WHR42hV+ivyvdWash
         4JYm9F+/bLF3lWQwcU2T8HrzxncujDFoDpSqLTdg=
Received: by mail-lf1-f41.google.com with SMTP id v201so4846532lfa.11;
        Fri, 31 Jan 2020 05:31:39 -0800 (PST)
X-Gm-Message-State: APjAAAUfOqiAnmYfk/Ca11X4t/qjG+9TuFvOGw62bnkuc8ANS+PDekVW
        8KYpEZlp/CjWuHiHM5SE3J8Z8Z7xMR3a/4EKmoY=
X-Google-Smtp-Source: APXvYqwSbqju6JUksaPdkz/97mfFYOYXw/rc+uN4pEE26ZZoKFaM+ty1mhlgkTYOmglIESjcDg0P8El//QIqqmY+O8o=
X-Received: by 2002:ac2:4472:: with SMTP id y18mr5340968lfl.39.1580477497394;
 Fri, 31 Jan 2020 05:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20200127215453.15144-1-lukasz.luba@arm.com> <CGME20200127215538eucas1p2b8d4886de6f59f6a62257d3d66307c73@eucas1p2.samsung.com>
 <20200127215453.15144-4-lukasz.luba@arm.com> <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
In-Reply-To: <d14546d5-0cd8-c441-c2be-cdeefc8ebb8d@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 14:31:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcZCks1SxwBP-vhpsYzpsrV9MQo91QNU2obgAppxfTiyQ@mail.gmail.com>
Message-ID: <CAJKOXPcZCks1SxwBP-vhpsYzpsrV9MQo91QNU2obgAppxfTiyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     lukasz.luba@arm.com, kgene@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 Jan 2020 at 14:30, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
>
> Hi,
>
> On 1/27/20 10:54 PM, lukasz.luba@arm.com wrote:
> > From: Lukasz Luba <lukasz.luba@arm.com>
> >
> > Enable the Energy Model (EM) brings possibility to use Energy Aware
> > Scheduler (EAS). This compiles the EM but does not enable to run EAS in
> > default. The EAS only works with SchedUtil - a CPUFreq governor which
> > handles direct requests from the scheduler for the frequency change. Thus,
> > to make EAS working in default, the SchedUtil governor should be
> > configured as default CPUFreq governor. Although, the EAS might be enabled
> > in runtime, when the EM is present for CPUs, the SchedUtil is compiled and
> > then set as CPUFreq governor, i.e.:
> >
> > echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> > echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
> >
> > To check if EAS is ready to work, the read output from the command below
> > should show '1':
> > cat /proc/sys/kernel/sched_energy_aware
> >
> > To disable EAS in runtime simply 'echo 0' to the file above.
> >
> > Some test results, which stress the scheduler on Odroid-XU3:
> > hackbench -l 500 -s 4096
> > With mainline code and with this patch set.
> >
> > The tests have been made with and without CONFIG_PROVE_LOCKING (PL)
> > (which is set to =y in default exynos_defconfig)
> >
> >               |               this patch set                  | mainline
> >               |-----------------------------------------------|---------------
> >               | performance   | SchedUtil     | SchedUtil     | performance
> >               | governor      | governor      | governor      | governor
> >               |               | w/o EAS       | w/ EAS        |
> > ----------------|---------------|---------------|---------------|---------------
> > hackbench w/ PL | 12.7s               | 11.7s         | 12.0s         | 13.0s - 12.2s
> > hackbench w/o PL| 9.2s                | 8.1s          | 8.2s          | 9.2s - 8.4s
>
> Would you happen to have measurements of how much power is
> saved by running hackbench using "SchedUtil governor w/ EAS"
> instead of "SchedUtil governor w/o EAS"?

That's a good point and quite important reason behind enabling (or not) EAS...

Best regards,
Krzysztof
