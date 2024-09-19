Return-Path: <linux-pm+bounces-14423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F365097C245
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 02:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FC21C20F3F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 00:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415E81E;
	Thu, 19 Sep 2024 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJvUEwJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D123A6
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726704577; cv=none; b=Mwxean4iqkOkdZ3gPX2saug1ivBd/15VGZrQZrI0Yo0ghHsGR3lgE0eM0vPQC6iLFMhoVejzG9kl+f/zMvhbqjf7P7sZVcoX1ax7b2IiEZF2mwV6NyUSmW5QIJlxhVs3wBN3t/Z9Sp7vNSDLhcheqNMidewJNW6Xz7xdeZfv9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726704577; c=relaxed/simple;
	bh=Huv0x6+QG2qOapzzUdKLlmio3uZBmfCnkYe9sj0+0Yg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e14ja0ppmy8nnqXnZgTGWzMhnmCxjVS1+SSXpcl4XX1NUb/hGoeqt6s8Bqk7H6H82U0qABQGH8pF/6n9OTcfjY7KZcTR16nt+zdeYVLl22xDSmAXEIf2yB1UCp+4EqmFRdPQK0x3f/8CPUvRNa7pnrq2k1YFRyfzzXBupsxnvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJvUEwJ2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbffbae597so6585047b3.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726704574; x=1727309374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+7PtONO3VwleHUu34WIbs8aPi11pqgDJAjNB4ofJaQ=;
        b=xJvUEwJ2+X1mM0ttCuoOHDWeFTho5rYaJwwc1ocp6X1cjrCZPZN0pekwwVi50OnwOx
         g/hecv3ETyzHwQ/i8STFovkoGCM806zFfNX/7AoPMxDgJFHuRuyKFciLEMVjh71L8I/T
         UN235b0j+b+5BhDTwB1OfdtAQg7Pppjgk5XvoXmC9O3aalm+bs9i2V6vAYercvjKV4B4
         WkXQBDR/cPxoSlPVBoSZPek1pC09G7zK20nw72Nkty8ubkvo2y91nrjJyBX6HCJlujED
         u46ocukpeJy5iBSFqS2NrEWCFJ4dJ8dnLIqH4V+zvsu43BlKGbv0BN4GlHfzlQKq5PCF
         xMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726704574; x=1727309374;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+7PtONO3VwleHUu34WIbs8aPi11pqgDJAjNB4ofJaQ=;
        b=ZoeIpc1xbwLjwnoPAZvLQ+yET2LSYExAC183zN/E5mnZw2NJikC5FkLU0XLQAFbFvD
         u2ruvuDUAhQdrJfN62h+rN3hJ61rJcwOt+UgW8CggqAAVgT9OrpHPTf1xXxdd9GH08b6
         LSGchNJjAI0RLxpiL83yv6vBxlxg5wws6cGODf9KjGvomc7cq1r7KBcUf5HhZRHEYowY
         avuq6baaW+PHCpBm4txPknWcy+zkIOym3HlrXTmZtRWC5HJgXt3PsVvFQYf0MmMR1KnF
         GTUXv6RjuIKFPtXaBgHAAVB7MHbHlh1o8gHmpdEWDk3myKt9EKGKijYwTTTc9vdk31AI
         3gkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgDZLbkpfCDCWKS9phIEbaLvYe2/NUYSsav3C0IUxXw7T7rp35zXbYav/SEHvnw66cFMEb/2iL/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh60OFjElvF8UbhG6wT/5MOSnMSZLvyVPTrb03FWXVl0m0yjiB
	sazPk9KSzeIR4R52Wyare5kQKWsVbBe092VM8JtRqtgCTX9fRUnmjieTjLYq2pnSJQpGQs8gD1F
	IaVLvtw==
X-Google-Smtp-Source: AGHT+IFJ3iIzuhiJ1YMdN17al8AnvhkF64stCXR6W18hgdxUqpEtE/A1379elmO+/RZzxrA27mVFgwTJFOrg
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:2985:f9c1:f5a3:ad7a])
 (user=davidai job=sendgmr) by 2002:a25:9bc5:0:b0:e20:205b:5372 with SMTP id
 3f1490d57ef6-e20205b550cmr5653276.11.1726704574085; Wed, 18 Sep 2024 17:09:34
 -0700 (PDT)
Date: Wed, 18 Sep 2024 17:08:31 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919000837.1004642-1-davidai@google.com>
Subject: [PATCH v7 0/2] Improve VM CPUfreq and task placement behavior
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

v6 -> v7:
-Updated .exit and .remove function type from int to void to match
 required types
-Added Reviewed-by tag from Rob on dt-bindings patch
-Dropped "depends on OF" as the driver doesn't depend on it

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
 drivers/cpufreq/virtual-cpufreq.c             | 333 ++++++++++++++++++
 include/linux/arch_topology.h                 |   1 +
 5 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-=
cpufreq.yaml
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

--=20
2.46.0.792.g87dc391469-goog


