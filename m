Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1313D123
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAPAbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 19:31:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgAPAbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 19:31:06 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irt3S-0004QP-Qv; Thu, 16 Jan 2020 01:30:35 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B7BBB10121C; Thu, 16 Jan 2020 01:30:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
In-Reply-To: <20200115063410.131692-1-hsinyi@chromium.org>
References: <20200115063410.131692-1-hsinyi@chromium.org>
Date:   Thu, 16 Jan 2020 01:30:33 +0100
Message-ID: <8736cgxmxi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.

'some race condition and kernel warning' is pretty useless information.
Please describe exactly which kind of issues are caused by the current
mechanism. Especially the race conditions are the interesting part (the
warnings are just a consequence).

> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would
> offline cpus in

Please read Documentation/process/submitting-patches.rst and search for
'This patch'.

> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop.

This does not make any sense. The issues which you are trying to solve
are going to be still there when CONFIG_HOTPLUG_CPU is disabled.

> If architecture don't enable this config, or some cpus somehow fails
> to offline, it would fallback to ipi function.

This is really a half baken solution which keeps the various pointlessly
different pseudo reboot/kexec offlining implementations around. So with
this we have yet more code which only works depending on kernel
configuration and has the issue of potentially not being able to offline
a CPU. IOW this is going to fail completely in cases where a system is
in a state which prevents regular hotplug.

The existing pseudo-offline functions have timeouts and eventually a
fallback, e.g. the NMI fallback on x86. With this proposed regular
offline solution this will just get stuck w/o a chance to force
recovery.

While I like the idea and surely agree that the ideal solution is to
properly shutdown the CPUs on reboot, we need to take a step back and
look at the minimum requirements for a regular shutdown/reboot and at
the same time have a look at the requirements for emergency shutdown and
kexec/kcrash. Having proper information about the race conditions and
warnings you mentioned would be a good starting point.

> Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.

This is not opt-in. You force that on all architectures which support
CONFIG_HOTPLUG_CPU. The way we do this normally is to provide the
infrastructure first and then have separate patches (one per
architecture) enabling this, which allows the architecture maintainers
to decide individually.

Thanks,

        tglx
