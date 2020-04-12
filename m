Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765971A5D58
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgDLHt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 03:49:59 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:55326 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLHt7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2020 03:49:59 -0400
Received: from flygoat-x1e (unknown [IPv6:240e:390:499:a20::d68])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 92F8320CE8;
        Sun, 12 Apr 2020 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586677799; bh=k5hxOeHZh9IXjDoSK3WNcs/9hTqV8S41aIzhUrny+3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Izfs6T4sNhGSQrbDpc1FuzRkrZlA/Osk5StRIEV1TJ4Fe72X2TGwBh4OAZyI2RU9H
         4juvb/wwxEJZ3JXCHjgwRcIBnQdtXetGmwTCkFlGS41zJErwM87iU1Gv/z4e1vGywy
         SQZpAlaAbQD7K3v8RQncp4B/+s1NnynFKs6WpUgcybeYZfvPqtjHEnga7cEYuIoNrw
         oJn5cQ/8B8Kmbd7o/+D+RhAHqnzIwpzM1ZNvugs1JD/QH49S5fuB2bcbOOL09BID/u
         A0pRRIrRmZxwAYv+sKsaqDlJoZebMupTbfAJ5m47TwhhVmG7SP3TMwB7hiS2sMxPSE
         IlIU52Wnfg4OQ==
Date:   Sun, 12 Apr 2020 15:49:27 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-mips@vger.kernel.org,
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
        Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20200412154927.7ac453d5@flygoat-x1e>
In-Reply-To: <202004121349.xFzTOGS4%lkp@intel.com>
References: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
        <202004121349.xFzTOGS4%lkp@intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 12 Apr 2020 13:24:21 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Jiaxun,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on driver-core/driver-core-testing]
> [also build test ERROR on pm/linux-next linus/master next-20200411]
> [cannot apply to tip/perf/core tip/irq/core v5.6]
> [if your patch is applied to the wrong git tree, please drop us a
> note to help improve the system. BTW, we also suggest to use '--base'
> option to specify the base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]
> 
> url:
> https://github.com/0day-ci/linux/commits/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> a10c9c710f9ecea87b9f4bbb837467893b4bef01 config: mips-allnoconfig
> (attached as .config) compiler: mips-linux-gcc (GCC) 9.3.0 reproduce:
> wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross chmod +x ~/bin/make.cross # save the attached
> .config to linux build tree GCC_VERSION=9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: the
> linux-review/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
> HEAD 8e8e9d4f7aa74359f2199773786ffe2fbb7877d0 builds fine. It only
> hurts bisectibility.
> 
Hi all,

In this case I think it should be fine to break bisect, otherwise #05
will combine too many modifications in different subsystems.


Thanks.
--
Jiaxun Yang
