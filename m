Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9581A5E4B
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLLdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 07:33:22 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55386 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLLdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2020 07:33:21 -0400
Received: from flygoat-x1e (unknown [IPv6:240e:390:499:a20::d68])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 6461320D00;
        Sun, 12 Apr 2020 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586691201; bh=sL4MzaGwxvIRSq9CUuhbsYMx0T4QWjj2y1rYAqSVLws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HKcd+fItvP6Hapt81u6McR/G/BybTwn3ZURsy4BZib/1PjBh2tKi6u+OJFUSc2qpd
         fsFLojsxIqB04tj7sKG2ACe7sVOS5TtTM/g9Y9vqolFWHquMOONkXrKcWwO2Mrc+0V
         7dBHRoP1XMZyUPWQmmcKdZ27U141H3GZ+tTI0GvNDhwrnFRfFeUmXnQZy9GRNhBCjG
         GH0JbQt+iaqvwDZ0SrrZqpkporGlnb7+XS+iybCr3/L2fL06Jh1eFSb9/feiAqBhcr
         ktE1Sc8dO7p2vQMtI9YgJyFEvvyhzJ9RBLYnO1MquOdrUGdi23XekKr9N/u03ny4ZI
         XEO1Do3o7sh+w==
Date:   Sun, 12 Apr 2020 19:32:25 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Marc Zyngier <maz@kernel.org>
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
        " =?UTF-8?B?5ZGo55Cw5p2w?= (Zhou Yanjie) " 
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
Message-ID: <20200412193225.47fa4680@flygoat-x1e>
In-Reply-To: <20200412103908.2594483d@why>
References: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
        <202004121349.xFzTOGS4%lkp@intel.com>
        <20200412154927.7ac453d5@flygoat-x1e>
        <20200412103908.2594483d@why>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 12 Apr 2020 10:39:08 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Sun, 12 Apr 2020 15:49:27 +0800
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 
> > On Sun, 12 Apr 2020 13:24:21 +0800
> > kbuild test robot <lkp@intel.com> wrote:
> >   
> > > Hi Jiaxun,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on driver-core/driver-core-testing]
> > > [also build test ERROR on pm/linux-next linus/master
> > > next-20200411] [cannot apply to tip/perf/core tip/irq/core v5.6]
> > > [if your patch is applied to the wrong git tree, please drop us a
> > > note to help improve the system. BTW, we also suggest to use
> > > '--base' option to specify the base tree in git format-patch,
> > > please see https://stackoverflow.com/a/37406982]
> > > 
> > > url:
> > > https://github.com/0day-ci/linux/commits/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> > > base:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> > > a10c9c710f9ecea87b9f4bbb837467893b4bef01 config: mips-allnoconfig
> > > (attached as .config) compiler: mips-linux-gcc (GCC) 9.3.0
> > > reproduce: wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross chmod +x ~/bin/make.cross # save the attached
> > > .config to linux build tree GCC_VERSION=9.3.0 make.cross
> > > ARCH=mips 
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > Note: the
> > > linux-review/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> > > HEAD 8e8e9d4f7aa74359f2199773786ffe2fbb7877d0 builds fine. It only
> > > hurts bisectibility.
> > >     
> > Hi all,
> > 
> > In this case I think it should be fine to break bisect, otherwise
> > #05 will combine too many modifications in different subsystems.  
> 
> No. It is never OK to break bisection, specially when it affects a
> whole architecture.

I'm going to squash all these into patch #5.
It's really hard to do it gradually.

Thanks.

> 
> We introduce gradual changes over multiple subsystems all the time by
> using configuration symbols, no matter the number of patches. Yes, it
> is sometimes hard. But breaking the kernel and forcing everyone else
> to just deal with it is not acceptable.
> 
> Thanks,
> 
> 	M.
--
Jiaxun Yang

