Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A084613D8C1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 12:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPLLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 06:11:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAPLLY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 06:11:24 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is33A-00050C-K7; Thu, 16 Jan 2020 12:10:56 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3D46D101B66; Thu, 16 Jan 2020 12:10:56 +0100 (CET)
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
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
In-Reply-To: <CAJMQK-jDi+AACE1Cv_hKSMq8VhGTBeh+kyHO2U4sx9w=9bO2mA@mail.gmail.com>
References: <20200115063410.131692-1-hsinyi@chromium.org> <8736cgxmxi.fsf@nanos.tec.linutronix.de> <CAJMQK-jDi+AACE1Cv_hKSMq8VhGTBeh+kyHO2U4sx9w=9bO2mA@mail.gmail.com>
Date:   Thu, 16 Jan 2020 12:10:56 +0100
Message-ID: <87h80vwta7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:
> On Thu, Jan 16, 2020 at 8:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> We saw this issue on regular reboot (not panic) on arm64: If tick
> broadcast and smp_send_stop() happen together and the first broadcast
> arrives to some idled CPU that hasn't already executed reboot ipi to
> run in spinloop, it would try to broadcast to another CPU, but that
> target CPU is already marked as offline by set_cpu_online() in reboot
> ipi, and a warning comes out since tick_handle_oneshot_broadcast()
> would check if it tries to broadcast to offline cpus. Most of the time
> the CPU getting the broadcast interrupt is already in the spinloop and
> thus isn't going to receive interrupts from the broadcast timer.

The timer broadcasting is obviously broken by the existing reboot unplug
mechanism as the outgoing CPU should remove itself from the broadcast.

Just addressing the broadcast issue is not sufficient as there are tons
of other places which rely on consistency of the various cpu masks.

> If system supports hotplug, _cpu_down() would properly handle tasks
> termination such as remove CPU from timer broadcasting by
> tick_offline_cpu()...etc, as well as some interrupt handling.

Well, emphasis on 'if system supports hotplug'. If not, then you are
back to square one. On ARM64 hotplug is selectable by a config option.

So either we mandate HOTPLUG_CPU for SMP and get rid of all the
ifdeffery or we need to have a mechanism which works on !HOTPLUG_CPU as
well.

That whole reboot/shutdown stuff is an unpenetrable mess of notifiers
and architecture hackery, so something generic and understandable is
really required.

Thanks,

        tglx
