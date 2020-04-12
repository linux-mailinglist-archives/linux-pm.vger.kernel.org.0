Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2A1A5CE6
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 07:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLFZ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 01:25:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:64803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgDLFZ3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Apr 2020 01:25:29 -0400
IronPort-SDR: Ef+KG6mtU/Hw/ZB8KETrCOcwhOWHVy2PdMgNszAoPRace3EXYbSZ5UydAwJUnNYwOIknpMCtWO
 +nuBvVHF6MSg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 22:25:28 -0700
IronPort-SDR: D5XvxkF9FiX/OW+aTXZvJa8N1LhjFl0sz/fm9VHSH8HcAhUm6V3mFzylHGt+dnv9UArAOFQgOs
 sVOcddZFHG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,373,1580803200"; 
   d="gz'50?scan'50,208,50";a="399306066"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2020 22:25:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNV7O-0003ym-B0; Sun, 12 Apr 2020 13:25:18 +0800
Date:   Sun, 12 Apr 2020 13:24:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild-all@lists.01.org, linux-mips@vger.kernel.org,
        "dietmar.eggemann@arm.com, Jiaxun Yang" <jiaxun.yang@flygoat.com>,
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
        =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
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
Message-ID: <202004121349.xFzTOGS4%lkp@intel.com>
References: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiaxun,

I love your patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on pm/linux-next linus/master next-20200411]
[cannot apply to tip/perf/core tip/irq/core v5.6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git a10c9c710f9ecea87b9f4bbb837467893b4bef01
config: mips-allnoconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

Note: the linux-review/Jiaxun-Yang/MIPS-Topology-DeviceTree-CPU-rework-v2/20200412-113308 HEAD 8e8e9d4f7aa74359f2199773786ffe2fbb7877d0 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/mips/include/asm/mips-cm.h:398:31: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
     398 |  unsigned int core = cpu_core(&cpu_data[cpu]);
         |                               ^~~~~~~~~~~~~~
         |                               |
         |                               struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/mips-cpc.c:13:
   arch/mips/include/asm/mips-cm.h:399:31: error: passing argument 1 of 'cpu_vpe_id' makes integer from pointer without a cast [-Werror=int-conversion]
     399 |  unsigned int vp = cpu_vpe_id(&cpu_data[cpu]);
         |                               ^~~~~~~~~~~~~~
         |                               |
         |                               struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:73:43: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      73 | static inline unsigned int cpu_vpe_id(int cpu)
         |                                       ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/mips-cpc.c:13:
   arch/mips/include/asm/mips-cm.h: In function 'mips_cm_lock_other_cpu':
   arch/mips/include/asm/mips-cm.h:456:33: error: passing argument 1 of 'cpu_cluster' makes integer from pointer without a cast [-Werror=int-conversion]
     456 |  mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
         |                                 ^
         |                                 |
         |                                 struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:63:44: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      63 | static inline unsigned int cpu_cluster(int cpu)
         |                                        ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/mips-cpc.c:13:
   arch/mips/include/asm/mips-cm.h:456:46: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
     456 |  mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
         |                                              ^
         |                                              |
         |                                              struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/mips-cpc.c:13:
   arch/mips/include/asm/mips-cm.h:456:61: error: passing argument 1 of 'cpu_vpe_id' makes integer from pointer without a cast [-Werror=int-conversion]
     456 |  mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
         |                                                             ^
         |                                                             |
         |                                                             struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:73:43: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      73 | static inline unsigned int cpu_vpe_id(int cpu)
         |                                       ~~~~^~~
   arch/mips/kernel/mips-cpc.c: In function 'mips_cpc_lock_other':
>> arch/mips/kernel/mips-cpc.c:97:23: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
      97 |  curr_core = cpu_core(&current_cpu_data);
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   arch/mips/kernel/mips-cpc.c: In function 'mips_cpc_unlock_other':
   arch/mips/kernel/mips-cpc.c:117:23: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
     117 |  curr_core = cpu_core(&current_cpu_data);
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from arch/mips/kernel/mips-cpc.c:9:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   cc1: all warnings being treated as errors

vim +/cpu_core +97 arch/mips/kernel/mips-cpc.c

76ae658465c231 Paul Burton   2014-02-14   87  
76ae658465c231 Paul Burton   2014-02-14   88  void mips_cpc_lock_other(unsigned int core)
76ae658465c231 Paul Burton   2014-02-14   89  {
6b89d22e742aa3 Matt Redfearn 2016-09-07   90  	unsigned int curr_core;
d6219420480b75 Matt Redfearn 2016-09-07   91  
d6219420480b75 Matt Redfearn 2016-09-07   92  	if (mips_cm_revision() >= CM_REV_CM3)
d6219420480b75 Matt Redfearn 2016-09-07   93  		/* Systems with CM >= 3 lock the CPC via mips_cm_lock_other */
d6219420480b75 Matt Redfearn 2016-09-07   94  		return;
d6219420480b75 Matt Redfearn 2016-09-07   95  
76ae658465c231 Paul Burton   2014-02-14   96  	preempt_disable();
f875a832d20285 Paul Burton   2017-08-12  @97  	curr_core = cpu_core(&current_cpu_data);
76ae658465c231 Paul Burton   2014-02-14   98  	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
76ae658465c231 Paul Burton   2014-02-14   99  			  per_cpu(cpc_core_lock_flags, curr_core));
829ca2be9c55c7 Paul Burton   2017-08-12  100  	write_cpc_cl_other(core << __ffs(CPC_Cx_OTHER_CORENUM));
78a54c4d8e5a79 Paul Burton   2015-09-22  101  
78a54c4d8e5a79 Paul Burton   2015-09-22  102  	/*
78a54c4d8e5a79 Paul Burton   2015-09-22  103  	 * Ensure the core-other region reflects the appropriate core &
78a54c4d8e5a79 Paul Burton   2015-09-22  104  	 * VP before any accesses to it occur.
78a54c4d8e5a79 Paul Burton   2015-09-22  105  	 */
78a54c4d8e5a79 Paul Burton   2015-09-22  106  	mb();
76ae658465c231 Paul Burton   2014-02-14  107  }
76ae658465c231 Paul Burton   2014-02-14  108  

:::::: The code at line 97 was first introduced by commit
:::::: f875a832d2028523f9b53c261b67e05a359bab8b MIPS: Abstract CPU core & VP(E) ID access through accessor functions

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+HP7ph2BbKc20aGI--
