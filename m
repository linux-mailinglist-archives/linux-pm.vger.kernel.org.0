Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07A865C5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHHPaB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 11:30:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40155 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfHHPaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 11:30:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id a186so6335735vsd.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ67960ROY2a/127HWY6jHmfLZvvKglq5u8NMNjYI1Y=;
        b=kmlK0/FKpYSrx2hur8a9t4OIdtqyOzr9THPxdPoXoVp2SotkfMdIG/oBPmgepUANo7
         5wxGRYKFtXcz35m5NYV6n1mpRxqm3J2IZBnVx0RHjV/f6d+9Nbyp1jlPAq46MLaojzYN
         zfi/wcFKJI3CHSAL+5RzV2adQgeYh7gk4sIk4EnOTPm8bYukyOnot1KAbcjyIKVBrUZh
         sFrr6Tarmycg6qQ2M7QAqs9AkYpRdwv6qGUtBpfOhgF6bEPeR4Re16KmoQwXCwdNsmcl
         zGYuMktiq2EFXkfZ9q8GKn/83u45cK2qTB/gs/sxKjc+SJZ8WXvAkQlU0hjn71hXwCB0
         Kvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ67960ROY2a/127HWY6jHmfLZvvKglq5u8NMNjYI1Y=;
        b=aVd91568sejPQg9p84ks3/OfK6sKGOjoK/fN46ECC3F3PRUxfP4f/hm7m54uDQPlRF
         918l/eppVIZyYQ5NitLtXI3RbC5Nhj1cXd3oLh43bgyt1xJXn0Lmqmrh8RwGDtFCNZU4
         9OEoe3FQTsnwUUjw61iOEz4wuEG2P5Xx7TIvUUA+1fa2dUIYC25hL4aMMBQf4EHnRGMA
         06f2yYEtnGLuJv+SmtV9tOnyEoOH4AV0jqnFTXZ+jqpbbuAhuxzhbRZqzaEfQqqBAwu+
         G5e2Z4w/hHDI3SPVbI8TXT0LTDRFhcenYvwP0qryZfZK5dizyIWGuiew46go1HHr933f
         wCdA==
X-Gm-Message-State: APjAAAWos8BExvJowxqP1CJS2UuXN/tUR7leLu3GLKakP2WdUDkhvQCS
        haenzo/Hnnd7rOqhJ8cro6Eawfa2SvoRBHpckPpDQQ==
X-Google-Smtp-Source: APXvYqxKi3cA9YcGMYMd//YpNRPqFA3cCz3N7LoXHqKDwPYBU0jxMSGjHUhjBPY7g60T9+jxuZelgTW7fSvznp0WgLQ=
X-Received: by 2002:a67:e454:: with SMTP id n20mr10625187vsm.34.1565278199947;
 Thu, 08 Aug 2019 08:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-7-lorenzo.pieralisi@arm.com> <20190808125516.GA2246@e107155-lin>
In-Reply-To: <20190808125516.GA2246@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Aug 2019 17:29:24 +0200
Message-ID: <CAPDyKFqHHwq=3XhSH_=uu5QoFkP3VYJ+2h7ENG5DNs-YzM6bNQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] PSCI: cpuidle: Refactor CPU suspend power_state
 parameter handling
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Aug 2019 at 14:55, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jul 22, 2019 at 04:37:45PM +0100, Lorenzo Pieralisi wrote:
> > Current PSCI code handles idle state entry through the
> > psci_cpu_suspend_enter() API, that takes an idle state index as a
> > parameter and convert the index into a previously initialized
> > power_state parameter before calling the PSCI.CPU_SUSPEND() with it.
> >
> > This is unwieldly, since it forces the PSCI firmware layer to keep track
> > of power_state parameter for every idle state so that the
> > index->power_state conversion can be made in the PSCI firmware layer
> > instead of the CPUidle driver implementations.
> >
> > Move the power_state handling out of drivers/firmware/psci
> > into the respective ACPI/DT PSCI CPUidle backends and convert
> > the psci_cpu_suspend_enter() API to get the power_state
> > parameter as input, which makes it closer to its firmware
> > interface PSCI.CPU_SUSPEND() API.
> >
> > A notable side effect is that the PSCI ACPI/DT CPUidle backends
> > now can directly handle (and if needed update) power_state
> > parameters before handing them over to the PSCI firmware
> > interface to trigger PSCI.CPU_SUSPEND() calls.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> > +static __init int psci_cpu_init_idle(unsigned int cpu)
> > +{
> > +     struct device_node *cpu_node;
> > +     int ret;
> > +
> > +     /*
> > +      * If the PSCI cpu_suspend function hook has not been initialized
> > +      * idle states must not be enabled, so bail out
> > +      */
> > +     if (!psci_ops.cpu_suspend)
> > +             return -EOPNOTSUPP;
> > +
> > +     cpu_node = of_get_cpu_node(cpu, NULL);
>
> [nit] You could use of_cpu_device_node_get in linux/of_device.h as
> it may avoid parsing if used later during the boot(i.e. after
> cpu->of_node is populated). I think there's another instance in
> psci_idle_init_cpu

Good idea!

However, as $subject patch more or less just moves code from the
current psci firmware directory into cpuidle, perhaps it's better to
defer improvements to be made on top?

Kind regards
Uffe
