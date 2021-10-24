Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC54388F9
	for <lists+linux-pm@lfdr.de>; Sun, 24 Oct 2021 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJXNFW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Oct 2021 09:05:22 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:31958
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhJXNFV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Oct 2021 09:05:21 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdLI+OKPeR7FDE8BcTsqjsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TESdfU7SKelfqyV9sjztiWE6wr5OktApTnoAsDpfZq2z/BICOcqUYtKEDOHhE?=
 =?us-ascii?q?KYaLAn14fkzjH6cheSysdW385bHJRDNA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397206040"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 15:02:58 +0200
Date:   Sun, 24 Oct 2021 15:02:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
cc:     linux-kernel@vger.kernel.org
Subject: problem in changing from active to passive mode
Message-ID: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I have an Intel 6130 and an Intel 5218.  These machines have HWP.  They
are configured to boot with active mode and performance as the power
governor.  Since the following commit:

commit a365ab6b9dfbaf8fb4fb4cd5d8a4c55dc4fb8b1c (HEAD, refs/bisect/bad)
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Dec 14 21:09:26 2020 +0100

    cpufreq: intel_pstate: Implement the ->adjust_perf() callback

If I change te mode from active to passive, I have the impression that the
machine is no longer able to raise the core frequencies above the minimum.
Changing the mode back to active has no effect.  This persists if I reboot
to another kernel.

Here are some runs that illustrate the problem.  I have tested the
benchmark many times, and apart from this issue its performance is stable.

Intel 6130:

root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
===== DaCapo 9.12-MR1 avrora completed warmup 1 in 3420 msec =====
===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2536 msec =====
===== DaCapo 9.12-MR1 avrora starting =====
===== DaCapo 9.12-MR1 avrora PASSED in 2502 msec =====
root@yeti-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
passive
root@yeti-2:/tmp#
root@yeti-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/status
active
root@yeti-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
===== DaCapo 9.12-MR1 avrora completed warmup 1 in 7561 msec =====
===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
===== DaCapo 9.12-MR1 avrora completed warmup 2 in 6528 msec =====
===== DaCapo 9.12-MR1 avrora starting =====
===== DaCapo 9.12-MR1 avrora PASSED in 7796 msec =====

-------------------------------------------------------------------------

Intel 5218:

root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
===== DaCapo 9.12-MR1 avrora completed warmup 1 in 2265 msec =====
===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
===== DaCapo 9.12-MR1 avrora completed warmup 2 in 2033 msec =====
===== DaCapo 9.12-MR1 avrora starting =====
===== DaCapo 9.12-MR1 avrora PASSED in 2068 msec =====
root@troll-2:/tmp# echo passive | tee /sys/devices/system/cpu/intel_pstate/status
passive
root@troll-2:/tmp# echo active | tee /sys/devices/system/cpu/intel_pstate/statusactive
root@troll-2:/tmp# java -jar dacapo-9.12-MR1-bach.jar avrora -n 3
===== DaCapo 9.12-MR1 avrora starting warmup 1 =====
===== DaCapo 9.12-MR1 avrora completed warmup 1 in 4363 msec =====
===== DaCapo 9.12-MR1 avrora starting warmup 2 =====
===== DaCapo 9.12-MR1 avrora completed warmup 2 in 4486 msec =====
===== DaCapo 9.12-MR1 avrora starting =====
===== DaCapo 9.12-MR1 avrora PASSED in 3417 msec =====

-------------------------------------------------------------------------

thanks,
julia
