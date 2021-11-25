Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9B45DB6D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 14:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbhKYNqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 08:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350014AbhKYNoz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Nov 2021 08:44:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E746761074
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847703;
        bh=BVKrXOIrvOMwIlas2Oen+hGRNFKFHyWaT8qi+Otep4E=;
        h=From:To:Subject:Date:From;
        b=X6Sz1dUwIOzm92BODbc3DmYDbpJ2LvicP2rqqzqU/R8wcD24sNp2MOKTGW33OxwLw
         A5M4G1QdcpnAKC8zl1wDj5w+DSeA4X1Dc9HMizT4K8KBF20QElKblYCVXZ+75LclZ9
         ghBifDq7LXH2uR0BBMjmurSEqOCYinvRnbouKz7hdbPvJp+raioQ5kEw4JlxCGWUSj
         hf+Wkr5FfqH/3pMsCdO9WkArIB+4+t5/acZyfGS+pAeDtHpVrlt6VasTGg7RgcJ79b
         kovit7ZVj8ecOlbhSyS6JjlJcs5rQWe9rWzQ97OW50zKSacGqfvkp70KgieOccsIwI
         fLjgrrNW57Ufg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id DBB8D61001; Thu, 25 Nov 2021 13:41:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215135] New: proposed cpufreq driver amd-pstate regresses wrt
 acpi-cpufreq on some AMD EPYC Zen3
Date:   Thu, 25 Nov 2021 13:41:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ggherdovich@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215135-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215135

            Bug ID: 215135
           Summary: proposed cpufreq driver amd-pstate regresses wrt
                    acpi-cpufreq on some AMD EPYC Zen3
           Product: Power Management
           Version: 2.5
    Kernel Version: not merged
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: ggherdovich@suse.cz
        Regression: No

Reference:=20
https://lore.kernel.org/lkml/20211029130241.1984459-2-ray.huang@amd.com/
[PATCH v3 00/21] cpufreq: introduce a new AMD CPU frequency control mechani=
sm

Note: this is not-yet-merged code. This bugzilla entry is to track progress=
 in
the performance optimization of the "amd-pstate" cpufreq driver, proposed in
the patchset linked above. The bug should be assigned to the patch author,
Huang Rui <ray.huang@amd.com>.

I've tested this driver and it seems the results are a little underwhelming.
The test machine is a two sockets server with two AMD EPYC 7713,
family:model:stepping 25:1:1, 128 cores/256 threads, 256G of memory and SSD
storage. On this system, the amd-pstate driver works only in "shared memory
support", not in "full MSR support", meaning that frequency switches are
triggered from a workqueue instead of scheduler context (!fast_switch).

Dbench sees some ludicrous improvements in both performance and performance
per watt; likewise netperf sees some modest improvements, but that's about
the only good news. Schedutil/ondemand on tbench and hackbench do worse
with amd-pstate than acpi-cpufreq. I don't have data for
ondemand/amd-pstate on kernbench and gitsource, but schedutil regresses on
both.

Here the tables, then some questions & discussion points.

Tilde (~) means the result is the same as baseline (which is, the ratio is
close to 1).
"Sugov" means "schedutil governor", "perfgov" means "performance governor".

             :        acpi-cpufreq          :        amd-pstate          :
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =
- -
- - - -
             :  ondemand  sugov  perfgov    :  ondemand  sugov  perfgov  :=
=20
better if
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =
- -
- - - -
                                       PERFORMANCE RATIOS
dbench       :  1.00      ~      0.33       :  0.37      0.35   0.36     :=
=20
lower
netperf      :  1.00      0.97   ~          :  1.03      1.04   ~        :=
=20
higher
tbench       :  1.00      1.04   1.06       :  0.83      0.40   1.05     :=
=20
higher
hackbench    :  1.00      ~      1.03       :  1.09      1.42   1.03     :=
=20
lower
kernbench    :  1.00      0.96   0.97       :  N/A       1.08   ~        :=
=20
lower
gitsource    :  1.00      0.67   0.69       :  N/A       0.79   0.67     :=
=20
lower
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =
- -
- - - -
                                  PERFORMANCE-PER-WATT RATIOS
dbench4      :  1.00      ~      3.37       :  2.68      3.12   3.03     :=
=20
higher
netperf      :  1.00      0.96   ~          :  1.09      1.06   ~        :=
=20
higher
tbench4      :  1.00      1.03   1.06       :  0.76      0.34   1.04     :=
=20
higher
hackbench    :  1.00      ~      0.95       :  0.88      0.65   0.96     :=
=20
higher
kernbench    :  1.00      1.06   1.05       :  N/A       0.93   1.05     :=
=20
higher
gitsource    :  1.00      1.53   1.50       :  N/A       1.33   1.55     :=
=20
higher


How to read the table: all numbers are ratios of the results of some
governor/driver combination and ondemand/acpi-cpufreq, which is the
baseline (first column). When the "better if" column says "higher", a ratio
larger than 1 indicates an improvement; otherwise it's a regression.
Example: hackbench with sugov/amd-pstate is 42% slower than with
ondemand/acpi-cpufreq (top table). At the same time, it's also 35% less
efficient (bottom table).

CPU information of this dual-socket server:

    CPU(s):                          256
    On-line CPU(s) list:             0-255
    Thread(s) per core:              2
    Core(s) per socket:              64
    Socket(s):                       2
    NUMA node(s):                    2
    Vendor ID:                       AuthenticAMD
    CPU family:                      25
    Model:                           1
    Model name:                      AMD EPYC 7713 64-Core Processor
    Stepping:                        1

The results posted above are, with the exception of gitsource, the average
over several value of a scaling parameter, which generally is the number of
threads or processes used. The tests are performed at low load (eg: a single
thread) all the way up to some multiple of the number of hardware threads. =
For
example, for tbench we varied the number of clients:

  low load -> 1 2 4 8 16 32 64 128 256 512 1024 <- 4x the number of cpus.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
