Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C62106B3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgGAItL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 04:49:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:16780 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgGAItL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 04:49:11 -0400
IronPort-SDR: 5/8DGeTxX0n+pq8POOxf4Z1/x4oPMHgjaSLJH447W9hDy52rgomEae4B2sQ3X0mtXnOi3GrTTL
 8P4P85qyyiPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="144678447"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="gz'50?scan'50,208,50";a="144678447"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 01:20:02 -0700
IronPort-SDR: ttSfq8b3PsLszDoyAdHY/UdI2VY81/GAgtjPAmmteKtz/jaGd3heQI+xDAuSPwBFbKJ3wsrJZ2
 RzkcaN84MoDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="gz'50?scan'50,208,50";a="266703947"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2020 01:19:59 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqXyI-0002nK-VM; Wed, 01 Jul 2020 08:19:58 +0000
Date:   Wed, 1 Jul 2020 16:19:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lina Iyer <ilina@codeaurora.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH] cpuidle: governor: export cpuidle_register_governor
Message-ID: <202007011604.gdY3YScQ%lkp@intel.com>
References: <20200630191308.23611-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20200630191308.23611-1-ilina@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lina,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on daniel.lezcano/clockevents/next v5.8-rc3 next-20200701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lina-Iyer/cpuidle-governor-export-cpuidle_register_governor/20200701-031538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-s002-20200630 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/fair.c:23:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/core.c:9:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:587:
   kernel/rcu/tasks.h:405:6: warning: no previous prototype for 'rcu_tasks_postscan' [-Wmissing-prototypes]
     405 | void rcu_tasks_postscan(struct list_head *hop)
         |      ^~~~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:757:6: warning: no previous prototype for 'rcu_read_unlock_trace_special' [-Wmissing-prototypes]
     757 | void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/rcu/tasks.h:1135:6: warning: no previous prototype for 'synchronize_rcu_tasks_trace' [-Wmissing-prototypes]
    1135 | void synchronize_rcu_tasks_trace(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:587:
   kernel/rcu/tasks.h:1148:6: warning: no previous prototype for 'rcu_barrier_tasks_trace' [-Wmissing-prototypes]
    1148 | void rcu_barrier_tasks_trace(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:305:5: warning: no previous prototype for '__register_ftrace_function' [-Wmissing-prototypes]
     305 | int __register_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:348:5: warning: no previous prototype for '__unregister_ftrace_function' [-Wmissing-prototypes]
     348 | int __unregister_ftrace_function(struct ftrace_ops *ops)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:1353:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1353 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/wait.c:7:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/core.c:21:
   kernel/bpf/core.c: In function '___bpf_prog_run':
   include/linux/filter.h:879:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
     879 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1521:13: note: in expansion of macro '__bpf_call_base_args'
    1521 |   BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
         |             ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c: In function 'bpf_patch_call_args':
   include/linux/filter.h:879:3: warning: cast between incompatible function types from 'u64 (*)(u64,  u64,  u64,  u64,  u64)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int)'} to 'u64 (*)(u64,  u64,  u64,  u64,  u64,  const struct bpf_insn *)' {aka 'long long unsigned int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  const struct bpf_insn *)'} [-Wcast-function-type]
     879 |  ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
         |   ^
   kernel/bpf/core.c:1712:3: note: in expansion of macro '__bpf_call_base_args'
    1712 |   __bpf_call_base_args;
         |   ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/loadavg.c:9:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3801:15: warning: no previous prototype for 'arch_ftrace_match_adjust' [-Wmissing-prototypes]
    3801 | char * __weak arch_ftrace_match_adjust(char *str, const char *search)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'process_mod_list':
   kernel/trace/ftrace.c:4112:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    4112 |  int ret;
         |      ^~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/clock.c:56:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'ftrace_regex_release':
   kernel/trace/ftrace.c:5517:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    5517 |  int ret;
         |      ^~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/rt.c:6:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/cputime.c:5:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/deadline.c:18:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   kernel/panic.c:85:13: warning: no previous prototype for 'panic_smp_self_stop' [-Wmissing-prototypes]
      85 | void __weak panic_smp_self_stop(void)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:95:13: warning: no previous prototype for 'nmi_panic_self_stop' [-Wmissing-prototypes]
      95 | void __weak nmi_panic_self_stop(struct pt_regs *regs)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c:106:13: warning: no previous prototype for 'crash_smp_send_stop' [-Wmissing-prototypes]
     106 | void __weak crash_smp_send_stop(void)
         |             ^~~~~~~~~~~~~~~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:590:3: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     590 |   vprintk(args->fmt, args->args);
         |   ^~~~~~~
   kernel/panic.c: At top level:
   kernel/panic.c:683:24: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
     683 | __visible noinstr void __stack_chk_fail(void)
         |                        ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5352:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5352 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/clock.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/wait.o] Error 1
   kernel/sched/fair.c:11078:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11078 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11080:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11080 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11085:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11085 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11087:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11087 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/cputime.o] Error 1
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/idle.c:9:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/fair.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/deadline.o] Error 1
   kernel/sched/core.c:2117:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    2117 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/loadavg.o] Error 1
   kernel/sched/rt.c:253:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     253 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:255:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     255 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:668:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     668 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/core.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/rt.o] Error 1
   kernel/trace/trace_seq.c:142: warning: Function parameter or member 'args' not described in 'trace_seq_vprintf'
   kernel/trace/trace_output.c: In function 'trace_output_raw':
   kernel/trace/trace_output.c:321:2: warning: function 'trace_output_raw' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     321 |  trace_seq_vprintf(s, fmt, ap);
         |  ^~~~~~~~~~~~~~~~~
   kernel/events/core.c:6490:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
    6490 | long perf_pmu_snapshot_aux(struct perf_buffer *rb,
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/wait_bit.c:5:
>> include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
>> include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/swait.c:5:
   include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/wait_bit.o] Error 1
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/idle.o] Error 1
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/completion.c:14:
   include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:5306: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5306: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5306: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5306: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5320: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5348: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5348: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5348: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5348: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5367: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5367: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5367: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5367: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5382: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5382: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5382: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5398: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5398: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5398: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:7374: warning: Function parameter or member 'ops' not described in 'register_ftrace_function'
   kernel/trace/ftrace.c:7396: warning: Function parameter or member 'ops' not described in 'unregister_ftrace_function'
   kernel/exit.c:1714:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1714 | __weak void abort(void)
         |             ^~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from arch/x86/include/asm/percpu.h:45,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/sched.h:12,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/cpupri.c:25:
   include/linux/cpuidle.h:267:19: error: 'cpuidle_governor' undeclared here (not in a function)
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:16: note: in definition of macro '___EXPORT_SYMBOL'
      98 |  extern typeof(sym) sym;       \
         |                ^~~
   include/linux/export.h:155:34: note: in expansion of macro '__EXPORT_SYMBOL'
     155 | #define _EXPORT_SYMBOL(sym, sec) __EXPORT_SYMBOL(sym, sec, "")
         |                                  ^~~~~~~~~~~~~~~
   include/linux/export.h:159:33: note: in expansion of macro '_EXPORT_SYMBOL'
     159 | #define EXPORT_SYMBOL_GPL(sym)  _EXPORT_SYMBOL(sym, "_gpl")
         |                                 ^~~~~~~~~~~~~~
   include/linux/cpuidle.h:267:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
     267 | EXPORT_SYMBOL_GPL(cpuidle_governor);
         | ^~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1141: warning: Function parameter or member 'cpu_buffer' not described in 'rb_check_list'
   kernel/trace/ring_buffer.c:1141: warning: Function parameter or member 'list' not described in 'rb_check_list'
   make[3]: *** [scripts/Makefile.build:281: kernel/sched/swait.o] Error 1
   kernel/rcu/tree.c:969: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'
   kernel/rcu/tree.c:3024: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
   In file included from include/linux/linkage.h:7,
..

vim +/cpuidle_governor +267 include/linux/cpuidle.h

   247	
   248	/******************************
   249	 * CPUIDLE GOVERNOR INTERFACE *
   250	 ******************************/
   251	
   252	struct cpuidle_governor {
   253		char			name[CPUIDLE_NAME_LEN];
   254		struct list_head 	governor_list;
   255		unsigned int		rating;
   256	
   257		int  (*enable)		(struct cpuidle_driver *drv,
   258						struct cpuidle_device *dev);
   259		void (*disable)		(struct cpuidle_driver *drv,
   260						struct cpuidle_device *dev);
   261	
   262		int  (*select)		(struct cpuidle_driver *drv,
   263						struct cpuidle_device *dev,
   264						bool *stop_tick);
   265		void (*reflect)		(struct cpuidle_device *dev, int index);
   266	};
 > 267	EXPORT_SYMBOL_GPL(cpuidle_governor);
   268	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
D34ZVEcA5286O12eF/FeTr2KFfkfuGrLL8ojAgA=

--RnlQjJ0d97Da+TV1--
