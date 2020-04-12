Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2936E1A5CE9
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 07:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLFZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 01:25:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:61340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgDLFZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Apr 2020 01:25:32 -0400
IronPort-SDR: bITmxDyLsT4j3/1tnpHf1EL2+ybQjec+nofsojSAnwFrFvBPlDrlywl2np8mb7OCg3tY4f2XZV
 6zBPOaQI3YiQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 22:25:31 -0700
IronPort-SDR: ru53ppzpKxgTXt6cYxFm4H81GKTmbH9TAHHyNCRs20azl+BzxNWa3+bjc23UZ8Wd/V0Uo7fR2a
 b7HXTZbcxgxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,373,1580803200"; 
   d="gz'50?scan'50,208,50";a="331544195"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2020 22:25:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNV7Q-0004AR-Ca; Sun, 12 Apr 2020 13:25:20 +0800
Date:   Sun, 12 Apr 2020 13:24:19 +0800
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
Message-ID: <202004121355.oP26ZAtx%lkp@intel.com>
References: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20200412032123.3896114-6-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ReaqsoxgOBHFXBhH
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
config: mips-fuloong2e_defconfig (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
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

   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/process.c:43:
   arch/mips/include/asm/mips-cm.h: In function 'mips_cm_vp_id':
>> arch/mips/include/asm/mips-cm.h:398:31: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
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
                    from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/mips/kernel/process.c:17:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/process.c:43:
>> arch/mips/include/asm/mips-cm.h:399:31: error: passing argument 1 of 'cpu_vpe_id' makes integer from pointer without a cast [-Werror=int-conversion]
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
                    from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/mips/kernel/process.c:17:
   arch/mips/include/asm/topology.h:73:43: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      73 | static inline unsigned int cpu_vpe_id(int cpu)
         |                                       ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/process.c:43:
   arch/mips/include/asm/mips-cm.h: In function 'mips_cm_lock_other_cpu':
>> arch/mips/include/asm/mips-cm.h:456:33: error: passing argument 1 of 'cpu_cluster' makes integer from pointer without a cast [-Werror=int-conversion]
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
                    from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/mips/kernel/process.c:17:
   arch/mips/include/asm/topology.h:63:44: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      63 | static inline unsigned int cpu_cluster(int cpu)
         |                                        ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/process.c:43:
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
                    from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/mips/kernel/process.c:17:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   In file included from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/kernel/process.c:43:
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
                    from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/mips/kernel/process.c:17:
   arch/mips/include/asm/topology.h:73:43: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      73 | static inline unsigned int cpu_vpe_id(int cpu)
         |                                       ~~~~^~~
   cc1: all warnings being treated as errors
--
   arch/mips/kernel/cacheinfo.c: In function 'fill_cpumask_siblings':
   arch/mips/kernel/cacheinfo.c:58:7: error: implicit declaration of function 'cpus_are_siblings' [-Werror=implicit-function-declaration]
      58 |   if (cpus_are_siblings(cpu, cpu1))
         |       ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/cacheinfo.c: In function 'fill_cpumask_cluster':
>> arch/mips/kernel/cacheinfo.c:65:16: error: implicit declaration of function 'cpu_cluster' [-Werror=implicit-function-declaration]
      65 |  int cluster = cpu_cluster(&cpu_data[cpu]);
         |                ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   arch/mips/kernel/proc.c: In function 'show_cpuinfo':
>> arch/mips/kernel/proc.c:141:50: error: 'struct cpuinfo_mips' has no member named 'package'
     141 |  seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
         |                                                  ^
>> arch/mips/kernel/proc.c:142:45: error: passing argument 1 of 'cpu_core' makes integer from pointer without a cast [-Werror=int-conversion]
     142 |  seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
         |                                             ^~~~~~~~~~~~
         |                                             |
         |                                             struct cpuinfo_mips *
   In file included from include/linux/topology.h:36,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/fs.h:15,
                    from include/linux/seq_file.h:11,
                    from arch/mips/kernel/proc.c:10:
   arch/mips/include/asm/topology.h:68:41: note: expected 'int' but argument is of type 'struct cpuinfo_mips *'
      68 | static inline unsigned int cpu_core(int cpu)
         |                                     ~~~~^~~
   cc1: all warnings being treated as errors

vim +/cpu_core +398 arch/mips/include/asm/mips-cm.h

7573b94e08aeb5 Paul Burton 2015-09-22  385  
7573b94e08aeb5 Paul Burton 2015-09-22  386  /**
7573b94e08aeb5 Paul Burton 2015-09-22  387   * mips_cm_vp_id() - calculate the hardware VP ID for a CPU
7573b94e08aeb5 Paul Burton 2015-09-22  388   * @cpu: the CPU whose VP ID to calculate
7573b94e08aeb5 Paul Burton 2015-09-22  389   *
7573b94e08aeb5 Paul Burton 2015-09-22  390   * Hardware such as the GIC uses identifiers for VPs which may not match the
7573b94e08aeb5 Paul Burton 2015-09-22  391   * CPU numbers used by Linux. This function calculates the hardware VP
7573b94e08aeb5 Paul Burton 2015-09-22  392   * identifier corresponding to a given CPU.
7573b94e08aeb5 Paul Burton 2015-09-22  393   *
7573b94e08aeb5 Paul Burton 2015-09-22  394   * Return: the VP ID for the CPU.
7573b94e08aeb5 Paul Burton 2015-09-22  395   */
7573b94e08aeb5 Paul Burton 2015-09-22  396  static inline unsigned int mips_cm_vp_id(unsigned int cpu)
7573b94e08aeb5 Paul Burton 2015-09-22  397  {
f875a832d20285 Paul Burton 2017-08-12 @398  	unsigned int core = cpu_core(&cpu_data[cpu]);
7573b94e08aeb5 Paul Burton 2015-09-22 @399  	unsigned int vp = cpu_vpe_id(&cpu_data[cpu]);
7573b94e08aeb5 Paul Burton 2015-09-22  400  
7573b94e08aeb5 Paul Burton 2015-09-22  401  	return (core * mips_cm_max_vp_width()) + vp;
7573b94e08aeb5 Paul Burton 2015-09-22  402  }
7573b94e08aeb5 Paul Burton 2015-09-22  403  
23d5de8efb9aed Paul Burton 2015-09-22  404  #ifdef CONFIG_MIPS_CM
23d5de8efb9aed Paul Burton 2015-09-22  405  
23d5de8efb9aed Paul Burton 2015-09-22  406  /**
68923cdc2eb341 Paul Burton 2017-08-12  407   * mips_cm_lock_other - lock access to redirect/other region
68923cdc2eb341 Paul Burton 2017-08-12  408   * @cluster: the other cluster to be accessed
23d5de8efb9aed Paul Burton 2015-09-22  409   * @core: the other core to be accessed
23d5de8efb9aed Paul Burton 2015-09-22  410   * @vp: the VP within the other core to be accessed
68923cdc2eb341 Paul Burton 2017-08-12  411   * @block: the register block to be accessed
23d5de8efb9aed Paul Burton 2015-09-22  412   *
68923cdc2eb341 Paul Burton 2017-08-12  413   * Configure the redirect/other region for the local core/VP (depending upon
68923cdc2eb341 Paul Burton 2017-08-12  414   * the CM revision) to target the specified @cluster, @core, @vp & register
68923cdc2eb341 Paul Burton 2017-08-12  415   * @block. Must be called before using the redirect/other region, and followed
68923cdc2eb341 Paul Burton 2017-08-12  416   * by a call to mips_cm_unlock_other() when access to the redirect/other region
68923cdc2eb341 Paul Burton 2017-08-12  417   * is complete.
68923cdc2eb341 Paul Burton 2017-08-12  418   *
68923cdc2eb341 Paul Burton 2017-08-12  419   * This function acquires a spinlock such that code between it &
68923cdc2eb341 Paul Burton 2017-08-12  420   * mips_cm_unlock_other() calls cannot be pre-empted by anything which may
68923cdc2eb341 Paul Burton 2017-08-12  421   * reconfigure the redirect/other region, and cannot be interfered with by
68923cdc2eb341 Paul Burton 2017-08-12  422   * another VP in the core. As such calls to this function should not be nested.
23d5de8efb9aed Paul Burton 2015-09-22  423   */
68923cdc2eb341 Paul Burton 2017-08-12  424  extern void mips_cm_lock_other(unsigned int cluster, unsigned int core,
68923cdc2eb341 Paul Burton 2017-08-12  425  			       unsigned int vp, unsigned int block);
23d5de8efb9aed Paul Burton 2015-09-22  426  
23d5de8efb9aed Paul Burton 2015-09-22  427  /**
68923cdc2eb341 Paul Burton 2017-08-12  428   * mips_cm_unlock_other - unlock access to redirect/other region
23d5de8efb9aed Paul Burton 2015-09-22  429   *
68923cdc2eb341 Paul Burton 2017-08-12  430   * Must be called after mips_cm_lock_other() once all required access to the
68923cdc2eb341 Paul Burton 2017-08-12  431   * redirect/other region has been completed.
23d5de8efb9aed Paul Burton 2015-09-22  432   */
23d5de8efb9aed Paul Burton 2015-09-22  433  extern void mips_cm_unlock_other(void);
23d5de8efb9aed Paul Burton 2015-09-22  434  
23d5de8efb9aed Paul Burton 2015-09-22  435  #else /* !CONFIG_MIPS_CM */
23d5de8efb9aed Paul Burton 2015-09-22  436  
68923cdc2eb341 Paul Burton 2017-08-12  437  static inline void mips_cm_lock_other(unsigned int cluster, unsigned int core,
68923cdc2eb341 Paul Burton 2017-08-12  438  				      unsigned int vp, unsigned int block) { }
23d5de8efb9aed Paul Burton 2015-09-22  439  static inline void mips_cm_unlock_other(void) { }
23d5de8efb9aed Paul Burton 2015-09-22  440  
23d5de8efb9aed Paul Burton 2015-09-22  441  #endif /* !CONFIG_MIPS_CM */
23d5de8efb9aed Paul Burton 2015-09-22  442  
68923cdc2eb341 Paul Burton 2017-08-12  443  /**
68923cdc2eb341 Paul Burton 2017-08-12  444   * mips_cm_lock_other_cpu - lock access to redirect/other region
68923cdc2eb341 Paul Burton 2017-08-12  445   * @cpu: the other CPU whose register we want to access
68923cdc2eb341 Paul Burton 2017-08-12  446   *
68923cdc2eb341 Paul Burton 2017-08-12  447   * Configure the redirect/other region for the local core/VP (depending upon
68923cdc2eb341 Paul Burton 2017-08-12  448   * the CM revision) to target the specified @cpu & register @block. This is
68923cdc2eb341 Paul Burton 2017-08-12  449   * equivalent to calling mips_cm_lock_other() but accepts a Linux CPU number
68923cdc2eb341 Paul Burton 2017-08-12  450   * for convenience.
68923cdc2eb341 Paul Burton 2017-08-12  451   */
68923cdc2eb341 Paul Burton 2017-08-12  452  static inline void mips_cm_lock_other_cpu(unsigned int cpu, unsigned int block)
68923cdc2eb341 Paul Burton 2017-08-12  453  {
68923cdc2eb341 Paul Burton 2017-08-12  454  	struct cpuinfo_mips *d = &cpu_data[cpu];
68923cdc2eb341 Paul Burton 2017-08-12  455  
68923cdc2eb341 Paul Burton 2017-08-12 @456  	mips_cm_lock_other(cpu_cluster(d), cpu_core(d), cpu_vpe_id(d), block);
68923cdc2eb341 Paul Burton 2017-08-12  457  }
68923cdc2eb341 Paul Burton 2017-08-12  458  

:::::: The code at line 398 was first introduced by commit
:::::: f875a832d2028523f9b53c261b67e05a359bab8b MIPS: Abstract CPU core & VP(E) ID access through accessor functions

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ReaqsoxgOBHFXBhH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ReaqsoxgOBHFXBhH--
