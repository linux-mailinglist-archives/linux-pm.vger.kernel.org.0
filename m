Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341182B66C2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKQNG5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 08:06:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33621 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgKQNG5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 08:06:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id i18so19317500ots.0;
        Tue, 17 Nov 2020 05:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vx363AuLp2YHu/Au97d1IEai6/qQ+kpifGY4zjpjUps=;
        b=Iho2Mcf3NPvNVzHtlGCViYeEEiC1ISjT0y3CH5tIMx7Xb8ixyl5lLADtWauz1qwUwG
         xzKrV1LApirBMNO7uMOsaoTivUPuNXIgoLJVs8KJwsGVKYAJld5tgk9e6QXCV/ig8BdA
         hBjETxJ0MF/cwJskp8WdMS/V23iSdOqmId4DaZdzq4j8WfZCJ8Loj44uU1vnPd5GkuN5
         ajrBwBCQ82JOqnNE8PLJ+EbPEMVzS3TuQE8xNMoSkqGIQUILXX6/3Jj3HumjvIZy7hP3
         KhCCCgDNRCrT7Pv67jF8Eyup3CrqNqv5XjhRnQL4tTpjqQnMWIBfbWwBl3GQCC1WY+Xz
         93Kw==
X-Gm-Message-State: AOAM532PvxJy0NyRcB+6w/4Jb2d5p82akPzmJ6iplvDgXjR2MYOe2fuV
        igY+jQO6BsJ5H0A9XoFIpjN/ENmHC0k3l3xa/KE=
X-Google-Smtp-Source: ABdhPJw0kEA0CejHn7npo46g6UwVxuglhYgclZCRsoNtl0/5eOKVMO5VMz+mMyVWkd+NbGTUPCj4Yk31y8xMeSfb3DA=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr3073375ota.260.1605618416372;
 Tue, 17 Nov 2020 05:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com> <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com> <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com> <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com> <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
 <0858962e-3a30-d177-594b-bb8e3149dd8d@arm.com> <20201117105337.vjwtig3qxpc6owmw@vireshk-i7>
In-Reply-To: <20201117105337.vjwtig3qxpc6owmw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 14:06:44 +0100
Message-ID: <CAJZ5v0iRs-uxzdV4vikN1VOwGuoorkRt2uqFSvbN2kySG-6duA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 11:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-11-20, 10:47, Nicola Mazzucato wrote:
> > Freq-invariance has been mentioned. I suppose the fix will depend on which
> > strategy we prefer to solve this.
>
> I am not sure how FIE will use this information, as I thought the
> problem is about knowing the current frequency on a CPU instead of
> which CPUs are related. Anyway, EM is good enough to get this stuff
> going.
>
> > As a reminder, two solutions:
> > 1) dependent_cpus cpumask in cpufreq and involved entities pick this info
>
> Yeah, this one. And it will be called freqdomain_cpus. Add support for
> freqdomain_cpus in core, update acpi-cpufreq to reuse it instead of
> adding its own and you can have it in other drivers then.

Is this really a cpufreq thing, though, or is it arch stuff?  I think
the latter, because it is not necessary for anything in cpufreq.

Yes, acpi-cpufreq happens to know this information, because it uses
processor_perflib, but the latter may as well be used by the arch
enumeration of CPUs and the freqdomain_cpus mask may be populated from
there.

As far as cpufreq is concerned, if the interface to the hardware is
per-CPU, there is one CPU per policy and cpufreq has no business
knowing anything about the underlying hardware coordination.
