Return-Path: <linux-pm+bounces-8008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFF8CA758
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238B12822DA
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C42BAE9;
	Tue, 21 May 2024 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vq3GIjl5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2463C8
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265916; cv=none; b=CbUVjzWa87R4hSD5AEx78YD2IgDY7dWE730TLbi2HzGz8v+CGtgDZhtmOjZ6fuhtXsE2rl47zITbpaCi4/oToPbOTSxvmeVGs/W6g+5Xd86pu2HtNpDf36bY0upKpog45eXp4Kf00D6T68eWj0MEqPCmJJzxaTnUVLjVNaAXEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265916; c=relaxed/simple;
	bh=ezvtyT4Tl4T28YPtbIZCUqfxaj+bRfYwvTHAOiVONMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YjAGMNjWarPFWZWMQkBr0XhDhNw5RuF1BOKXSdlXi0T5dzClEJepxb/glZmu5J8R14nZCN3BDDK3IzBDBntr/7hpx/+1oWIMPHO/9G529Ypj9c0uif/MpguXKSqvwFfpPbVA9ZJtznI/2uLJJMcnddFDHTnV6VkixvnzQRfGh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vq3GIjl5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so21650176276.2
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 21:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716265912; x=1716870712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q49GdX54+ZdShNnHokNwxcsWhuKobLIATjRPy5SWnw8=;
        b=vq3GIjl54dqWhW3/lpq+OMBEgNq6VixhQ8dnfZM/0DqroDfr/0rQS3JVoS2KnzNNAQ
         B/OvENHdyJkUZmegvMsxLpFZQirB6wO+ScxZoqrB/FP1e4syZ/obp+c54nMBNOO/mes+
         4HlymOObM3MCSNIwO3SnCuQAEUmYJFvRq0HnzaavF3xzySrRD4ONWLPiJOIfdANB7Z8t
         y9C3vOBWsm8Uz1nyrLpE0qAhxEkARbwwP8TInl/vXNiG/y8emp4BGxIWEuW2EARJw3E+
         Q1dNONKEHmd2X6vrE6yENjyqYM9oTU4x9nfhuNW1rPpAPhdO8Y4kr1xnnPLJHfENWQnY
         5Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716265912; x=1716870712;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q49GdX54+ZdShNnHokNwxcsWhuKobLIATjRPy5SWnw8=;
        b=KGazZuEZFlEfNHMIWJ3kpHDqBMfTYtHxOtVNZsGj10dIl1aLcaQDdNBhQAmKBvnz6I
         yewdEff8/fNcegVZcEFj0swn2QggK7EoQbSDHSYq+xbFw+TrAhCSSCRFnzPX+4fOn4Ji
         tQF/t7qrx93XhXUQTpdvlrZNTt2sFShRuEDOSO4qX3Olhi1HyIt5A0flvGQY1aLylC+m
         FZb0RjYNT3SnO8thxdQvowjysoRynkPjNom03QwS2IY19AtUbe0hRdYDb2wpogWXKfZN
         DhTWgqUYKXNmFd0tyWS6uJr+H5bprKQf7an5hXScxa1YhIUx03zkYrxeEQ4HWJEWQ2FG
         iUYw==
X-Forwarded-Encrypted: i=1; AJvYcCWc05ijnd+EFzpmGRBREpR476nif8T4tFrcaq/+ASjvGs3s0+gEKZjyxUm276k7Sr8mONI+bZzp5B15s789LNP4fiLwhQh/v40=
X-Gm-Message-State: AOJu0Yw6JAQ3/z+ngKZAF3tOBLcya2LsW4G5xbijNbBXDiKZgo4prvjH
	wu+voLtKup11hqUlFVBREiygx07WvuaTjlCUWmLowTVZKv8kT/nKaAxnisLu3C897K0eAYjnUE9
	/d9KG+Q==
X-Google-Smtp-Source: AGHT+IGhzjRuyVLwcypJtFSGaMVn4BPGwS/GmcRbJeOvDJ0Je3tCQrEP4f3aqjqZ7WdvpP1oSXiWOi0nKCpG
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:ffe6:3bcf:e120:a07a])
 (user=davidai job=sendgmr) by 2002:a05:6902:1026:b0:dee:6147:7e26 with SMTP
 id 3f1490d57ef6-dee6bf164abmr2697564276.11.1716265912319; Mon, 20 May 2024
 21:31:52 -0700 (PDT)
Date: Mon, 20 May 2024 21:30:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240521043102.2786284-1-davidai@google.com>
Subject: [PATCH v6 0/2] Improve VM CPUfreq and task placement behavior
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch series is a continuation of the talk Saravana gave at LPC 2022
titled "CPUfreq/sched and VM guest workload problems" [1][2][3]. The gist
of the talk is that workloads running in a guest VM get terrible task
placement and CPUfreq behavior when compared to running the same workload
in the host. Effectively, no EAS(Energy Aware Scheduling) for threads
inside VMs. This would make power and performance terrible just by running
the workload in a VM even if we assume there is zero virtualization
overhead.

With this series, a workload running in a VM gets the same task placement
and CPUfreq behavior as it would when running in the host.

The idea is to improve VM CPUfreq/sched behavior by:
- Having guest kernel do accurate load tracking by taking host CPU
  arch/type and frequency into account.
- Sharing vCPU frequency requirements with the host so that the
  host can do proper frequency scaling and task placement on the host side.

Based on feedback from RFC v1 proposal[4], we've revised our
implementation to using MMIO reads and writes to pass information
from/to host instead of using hypercalls. In our example, the
VMM(Virtual Machine Manager) translates the frequency requests into
Uclamp_min and applies it to the vCPU thread as a hint to the host
kernel.

To achieve the results below, configure the host to:
- Affine vCPUs to specific clusters.
- Set vCPU capacity to match the host CPU they are running on.

To make it easy for folks to try this out with CrosVM, we have put up
userspace patches[5][6]. With those patches, you can configure CrosVM
correctly by adding the options "--host-cpu-topology" and "--virt-cpufreq".

Results:
=3D=3D=3D=3D=3D=3D=3D=3D

Here are some side-by-side comparisons of RFC v1 proposal vs the current
patch series and are labelled as follows.

- (RFC v1) UtilHyp =3D hypercall + util_guest
- (current) UClampMMIO =3D MMIO + UClamp_min

Use cases running a minimal system inside a VM on a Pixel 6:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FIO
Higher is better
+-------------------+----------+---------+--------+------------+--------+
| Usecase(avg MB/s) | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Seq Write         |     13.3 |    16.4 |   +23% |       13.6 |    +2% |
+-------------------+----------+---------+--------+------------+--------+
| Rand Write        |     11.2 |    12.9 |   +15% |       11.8 |    +8% |
+-------------------+----------+---------+--------+------------+--------+
| Seq Read          |      100 |     168 |   +68% |        138 |   +38% |
+-------------------+----------+---------+--------+------------+--------+
| Rand Read         |     20.5 |    35.6 |   +74% |       31.0 |   +51% |
+-------------------+----------+---------+--------+------------+--------+

CPU-based ML Inference Benchmark
Lower is better
+----------------+----------+------------+--------+------------+--------+
| Test Case (ms) | Baseline | UtilHyp    | %delta | UClampMMIO | %delta |
+----------------+----------+------------+--------+------------+--------+
| Cached Sample  |          |            |        |            |        |
| Inference      |     3.40 |       2.37 |   -30% |       2.99 |   -12% |
+----------------+----------+------------+--------+------------+--------+
| Small Sample   |          |            |        |            |        |
| Inference      |     9.87 |       6.78 |   -31% |       7.65 |   -22% |
+----------------+----------+------------+--------+------------+--------+
| Large Sample   |          |            |        |            |        |
| Inference      |    33.35 |      26.74 |   -20% |      31.05 |    -7% |
+----------------+----------+------------+--------+------------+--------+

Use cases running Android inside a VM on a Chromebook:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

PCMark (Emulates real world usecases)
Higher is better
+-------------------+----------+---------+--------+------------+--------+
| Test Case (score) | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Weighted Total    |     6190 |    7442 |   +20% |       7171 |   +16% |
+-------------------+----------+---------+--------+------------+--------+
| Web Browsing      |     5461 |    6620 |   +21% |       6284 |   +15% |
+-------------------+----------+---------+--------+------------+--------+
| Video Editing     |     4891 |    5376 |   +10% |       5344 |    +9% |
+-------------------+----------+---------+--------+------------+--------+
| Writing           |     6929 |    8791 |   +27% |       8457 |   +22% |
+-------------------+----------+---------+--------+------------+--------+
| Photo Editing     |     7966 |   12057 |   +51% |      11881 |   +49% |
+-------------------+----------+---------+--------+------------+--------+
| Data Manipulation |     5596 |    6057 |    +8% |       5694 |    +2% |
+-------------------+----------+---------+--------+------------+--------+

PCMark Performance/mAh
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Score/mAh         |       87 |     100 |   +15% |         92 |    +5% |
+-------------------+----------+---------+--------+------------+--------+

Roblox
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| FPS               |    17.92 |   21.82 |   +22% |      20.02 |   +12% |
+-------------------+----------+---------+--------+------------+--------+

Roblox Frames/mAh
Higher is better
+-------------------+----------+---------+--------+------------+--------+
|                   | Baseline | UtilHyp | %delta | UClampMMIO | %delta |
+-------------------+----------+---------+--------+------------+--------+
| Frames/mAh        |    77.91 |   84.46 |    +8% |     81.71  |     5% |
+-------------------+----------+---------+--------+------------+--------+

We've simplified our implementation based on community feedback to make
it less intrusive and to use a more generic MMIO interface for
communication with the host. The results show that the current design
still has tangible improvements over baseline. We'll continue looking
into ways to reduce the overhead of the MMIO read/writes and submit
separate and generic patches for that if we find any good optimizations.

Thanks,
David & Saravana

Cc: Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Masami Hiramatsu <mhiramat@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Gupta Pankaj <pankaj.gupta@amd.com>
Cc: Mel Gorman <mgorman@suse.de>

v5 -> v6:
-Renamed dt-binding documentation file to match compatible string
-Removed opp bindings from dt-binding examples
-Added register interface description as a comment in driver
-Performance info now initialized from the device via MMIO instead
 of opp bindings
-Updated driver to use perf tables or max perf depending on VMM
-Added initialization for sharing perf domain
-Updated driver to use .target instead of .target_index
-Updated .verify to handle both perf tables and max perf case
-Updated Kconfig dependencies

v4 -> v5:
-Added dt-binding description to allow for normalized frequencies
-Updated dt-binding examples with normalized frequency values
-Updated cpufreq exit to use dev_pm_opp_free_cpufreq_table to free tables
-Updated fast_switch and target_index to use entries from cpufreq tables
-Refreshed benchmark numbers using indexed frequencies
-Added missing header that was indirectly being used

v3 -> v4:
-Fixed dt-binding formatting issues
-Added additional dt-binding descriptions for =E2=80=9CHW interfaces=E2=80=
=9D
-Changed dt-binding to =E2=80=9Cqemu,virtual-cpufreq=E2=80=9D
-Fixed Kconfig formatting issues
-Removed frequency downscaling when requesting frequency updates
-Removed ops and cpufreq driver data
-Added check to limit freq_scale to 1024
-Added KHZ in the register offset naming
-Added comments to explain FIE and not allowing dvfs_possible_from_any_cpu

v2 -> v3:
- Dropped patches adding new hypercalls
- Dropped patch adding util_guest in sched/fair
- Cpufreq driver now populates frequency using opp bindings
- Removed transition_delay_us=3D1 cpufreq setting as it was configured too
  agressively and resulted in poor I/O performance
- Modified guest cpufreq driver to read/write MMIO regions instead of
  using hypercalls to communicate with the host
- Modified guest cpufreq driver to pass frequency info instead of
  utilization of the current vCPU's runqueue which now takes
  iowait_boost into account from the schedutil governor
- Updated DT bindings for a virtual CPU frequency device
Userspace changes:
- Updated CrosVM patches to emulate a virtual cpufreq device
- Updated to newer userspace binaries when collecting more recent
  benchmark data

v1 -> v2:
- No functional changes.
- Added description for EAS and removed DVFS in coverletter.
- Added a v2 tag to the subject.
- Fixed up the inconsistent "units" between tables.
- Made sure everyone is To/Cc-ed for all the patches in the series.

[1] - https://lpc.events/event/16/contributions/1195/
[2] - https://lpc.events/event/16/contributions/1195/attachments/970/1893/L=
PC%202022%20-%20VM%20DVFS.pdf
[3] - https://www.youtube.com/watch?v=3DhIg_5bg6opU
[4] - https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.c=
om/
[5] - https://chromium-review.googlesource.com/c/crosvm/crosvm/+/4208668
[6] - https://chromium-review.googlesource.com/q/topic:%22virtcpufreq-v6%22

David Dai (2):
  dt-bindings: cpufreq: add virtual cpufreq device
  cpufreq: add virtual-cpufreq driver

 .../cpufreq/qemu,virtual-cpufreq.yaml         |  48 +++
 drivers/cpufreq/Kconfig                       |  14 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/virtual-cpufreq.c             | 335 ++++++++++++++++++
 include/linux/arch_topology.h                 |   1 +
 5 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-=
cpufreq.yaml
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

--=20
2.45.0.215.g3402c0e53f-goog


