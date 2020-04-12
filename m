Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE0B1A5DD8
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDLJjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 05:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgDLJjP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Apr 2020 05:39:15 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9A620709;
        Sun, 12 Apr 2020 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586684354;
        bh=wbyOBODIndCEMu0D2z+phq+6eSufCY9PcFL95wATkQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCvFXU6ZZAkPrqhY+3mO0dLN947kPjR0dnkmJSLpM8pYApfGKpeH/f2n2ddJe6pre
         YIswjxP8gVprMtr/9TTFdGG9nzgWZGJs7MNrbIE4WGoIiShAV7Zft3ggd5BxeCt+YC
         o23fwDeeTcJzz/NMWB712zrQ5FcEDe+ApYn4lckc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jNZ55-002cys-Sy; Sun, 12 Apr 2020 10:39:12 +0100
Date:   Sun, 12 Apr 2020 10:39:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        " =?UTF-8?Q?=E5=91=A8=E7=90=B0=E6=9D=B0?= (Zhou Yanjie) " 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 05/11] MIPS: Switch to arch_topology
Message-ID: <20200412103908.2594483d@why>
In-Reply-To: <20200412154927.7ac453d5@flygoat-x1e>
References: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
        <202004121349.xFzTOGS4%lkp@intel.com>
        <20200412154927.7ac453d5@flygoat-x1e>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jiaxun.yang@flygoat.com, lkp@intel.com, kbuild-all@lists.01.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de, chenhc@lemote.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, f.fainelli@gmail.com, rric@kernel.org, sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, paulburton@kernel.org, allison@lohutok.net, info@metux.net, kstewart@linuxfoundation.org, vladimir.kondratiev@intel.com, paul@crapouillou.net, zhouyanjie@zoho.com, zhouyanjie@wanyeetech.com, syq@debian.org, arnd@arndb.de, fancer.lancer@gmail.com, matt.redfearn@mips.com, swinslow@gmail.com, alexios.zavras@intel.com, rfontana@redhat.com, peterx@redhat.com, afzal.mohd.ma@gmail.com, kdasu.kdev@gmail.com, linux@rempel-privat.de, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, oprofile-lis
 t@lists.sf.net, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 12 Apr 2020 15:49:27 +0800
Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> On Sun, 12 Apr 2020 13:24:21 +0800
> kbuild test robot <lkp@intel.com> wrote:
> 
> > Hi Jiaxun,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on driver-core/driver-core-testing]
> > [also build test ERROR on pm/linux-next linus/master next-20200411]
> > [cannot apply to tip/perf/core tip/irq/core v5.6]
> > [if your patch is applied to the wrong git tree, please drop us a
> > note to help improve the system. BTW, we also suggest to use '--base'
> > option to specify the base tree in git format-patch, please see
> > https://stackoverflow.com/a/37406982]
> > 
> > url:
> > https://github.com/0day-ci/linux/commits/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> > base:
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> > a10c9c710f9ecea87b9f4bbb837467893b4bef01 config: mips-allnoconfig
> > (attached as .config) compiler: mips-linux-gcc (GCC) 9.3.0 reproduce:
> > wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross chmod +x ~/bin/make.cross # save the attached
> > .config to linux build tree GCC_VERSION=9.3.0 make.cross ARCH=mips 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > Note: the
> > linux-review/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> > HEAD 8e8e9d4f7aa74359f2199773786ffe2fbb7877d0 builds fine. It only
> > hurts bisectibility.
> >   
> Hi all,
> 
> In this case I think it should be fine to break bisect, otherwise #05
> will combine too many modifications in different subsystems.

No. It is never OK to break bisection, specially when it affects a
whole architecture.

We introduce gradual changes over multiple subsystems all the time by
using configuration symbols, no matter the number of patches. Yes, it is
sometimes hard. But breaking the kernel and forcing everyone else to
just deal with it is not acceptable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
