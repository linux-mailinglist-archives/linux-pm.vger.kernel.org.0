Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220492FE01B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 04:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbhAUDl7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 20 Jan 2021 22:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbhAUA4y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 19:56:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F28A23884
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 00:55:46 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0AA5581649; Thu, 21 Jan 2021 00:55:46 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] New: schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Thu, 21 Jan 2021 00:55:45 +0000
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
Message-ID: <bug-211305-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=211305

            Bug ID: 211305
           Summary: schedutil selects low P-States on AMD EPYC with
                    frequency invariance
           Product: Power Management
           Version: 2.5
    Kernel Version: v5.11-rc1
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

Phoronix.com discovered a severe performance regression on AMD APYC
introduced on schedutil [see link 1] by the following commits from v5.11-rc1

    commit 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD
systems")
    commit 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for
frequency invariance on AMD EPYC")

The problem happens on CPU-bound workloads spanning a large number of cores.
In this case schedutil won't select the maximum P-State. Actually, it's
likely that it will select the minimum one.

[link 1]
https://www.phoronix.com/scan.php?page=article&item=linux511-amd-schedutil&num=1

TEST        : Intel Open Image Denoise, www.openimagedenoise.org
INVOCATION  : ./denoise -hdr memorial.pfm -out out.pfm -bench 200 -threads
$NTHREADS
CPU         : MODEL            : 2x AMD EPYC 7742
              FREQUENCY TABLE  : P2: 1.50 GHz
                                 P1: 2.00 GHz
                                 P0: 2.25 GHz
              MAX BOOST        :     3.40 GHz

Results: threads, msecs (ratio). Lower is better.

               v5.10          v5.11-rc4    v5.11-rc4-patch
    -------------------------------------------------------
      1   1069.85 (1.00)   1071.84 (1.00)   1070.42 (1.00)
      2    542.24 (1.00)    544.40 (1.00)    544.48 (1.00)
      4    278.00 (1.00)    278.44 (1.00)    277.72 (1.00)
      8    149.81 (1.00)    149.61 (1.00)    149.87 (1.00)
     16     79.01 (1.00)     79.31 (1.00)     78.94 (1.00)
     24     58.01 (1.00)     58.51 (1.01)     58.15 (1.00)
     32     46.58 (1.00)     48.30 (1.04)     46.66 (1.00)
     48     37.29 (1.00)     51.29 (1.38)     37.27 (1.00)
     64     34.01 (1.00)     49.59 (1.46)     33.71 (0.99)
     80     31.09 (1.00)     44.27 (1.42)     31.33 (1.01)
     96     28.56 (1.00)     40.82 (1.43)     28.47 (1.00)
    112     28.09 (1.00)     40.06 (1.43)     28.63 (1.02)
    120     28.73 (1.00)     39.78 (1.38)     28.14 (0.98)
    128     28.93 (1.00)     39.60 (1.37)     29.38 (1.02)

See how the 128 threads case is almost 40% worse than baseline in v5.11-rc4.
The column v5.11-rc4-patch corresponds to a patch I've just sent to LKML to
address this problem.

I'm opening this bugzilla entry to attach a few plots made during the study
of this problem, for lack of a better place to share them.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
