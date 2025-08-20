Return-Path: <linux-pm+bounces-32698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8BB2D756
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473381635BC
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450F2DAFB5;
	Wed, 20 Aug 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mT3uV26S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF502DA773
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680172; cv=none; b=R55Mrm4XayUAHP8n9wPcYcSnIBWdXEvnOK1r5faePCsZKfixBVxwN6G49AduQuHN/mj8LFKwhyj1GshY2WozEceIGF44LIA608J3nDZBaKPhq2tjCAX0+fh/XiDkm98XfXnkKRLv/aii9GjGLjpgGCTuDD+rMCK2zIkYXT19j8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680172; c=relaxed/simple;
	bh=C21N2rRskrVQBQ8aqWDXrR5bKn/h4+TANQ0c0Xbc7FM=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type:
	 References; b=ZipEnHOzkppQwSH/3xW8ibRiHVLF1uB8JAajHFrfb/sNhP+Ej9EoDo6qhT+ID7AwDuydh9TTxiXW/S5TQdc+2TlNZHYjF7RjonGCU3/QS5QZqQVcNtE/QgDlS5cDUHiju1yu2R9V5m7DQFzlfwJBQrzH1o2QzCzgvhro5U7Is+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mT3uV26S; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250820085608euoutp01271347fa48d6bccad6679dd905622ed3~dbc_hT7510776807768euoutp01n
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:56:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250820085608euoutp01271347fa48d6bccad6679dd905622ed3~dbc_hT7510776807768euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755680168;
	bh=FfzPfDmUXDz1HDgCxhByAeu7Sm7Cy6qgcRtHNXF5Jhg=;
	h=From:Subject:Date:To:Cc:References:From;
	b=mT3uV26SKEWvWF3dc/EOE2N0v4ZImuFTW6pOTV55sBVxwIgexdYtMLf7r8JC+fM2F
	 JcFgUdpkcfkrD8THmo4EZ1PB5N1Ak1fc05pF8cvVRf7Yv0IGIxlbjubDZwPnMoFOUT
	 vUYxqD7Cw8zy/BKtuB1pgA+UL2OwJ9j/89ghDHlA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250820085607eucas1p244c70a988cdc6b71c824f86f32f1be03~dbc99S0u61093210932eucas1p20;
	Wed, 20 Aug 2025 08:56:07 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250820085606eusmtip1d49f65157a37c2549887aa6513caf2e4~dbc86r6nk2656126561eusmtip1Q;
	Wed, 20 Aug 2025 08:56:06 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v12 0/4] Add TH1520 GPU support with power sequencing
Date: Wed, 20 Aug 2025 10:55:52 +0200
Message-Id: <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJiNpWgC/33Qz07DMAwG8FeZcqYodv5z4j0QmjLH2XpYOzVQg
	aa9O9kuLWrg6E/yz598FYWnnot42V3FxHNf+nGoA+DTTtApDkfu+lQDgRKN1KC7eJn2oPd5nPa
	Fh9QPx84cVADnwUUiURcvE+f+66G+vdf51JePcfp+HJnxnv7LzdjJzkkyMWPMwdJriefyORyfa
	TyLOzirBTFKNhFVEa+ScVqnEFwD0Qti/2ii7wiroA15CJS2iFkjvomYiqDjpBRHQzZvEbtCUDU
	RWxFrvCKW2RKaLeLWiG0i7oEE5RBZIrgt4hfEYfsnviLSgT5wrnVM2CJhhShoIqEihBoTQc4Ee
	ouAXBQv2wrUJh174yUGiREbXQDWjGkzUJmDYybOlBPJ38ztdvsBNdWjiSgDAAA=
X-Change-ID: 20250414-apr_14_for_sending-5b3917817acc
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250820085607eucas1p244c70a988cdc6b71c824f86f32f1be03
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820085607eucas1p244c70a988cdc6b71c824f86f32f1be03
X-EPHeader: CA
X-CMS-RootMailID: 20250820085607eucas1p244c70a988cdc6b71c824f86f32f1be03
References: <CGME20250820085607eucas1p244c70a988cdc6b71c824f86f32f1be03@eucas1p2.samsung.com>

This patch series introduces support for the Imagination IMG BXM-4-64
GPU found on the T-HEAD TH1520 SoC. A key aspect of this support is
managing the GPU's complex power-up and power-down sequence, which
involves multiple clocks and resets.

The TH1520 GPU requires a specific sequence to be followed for its
clocks and resets to ensure correct operation. Initial discussions and
an earlier version of this series explored managing this via the generic
power domain (genpd) framework. However, following further discussions
with kernel maintainers [1], the approach has been reworked to utilize
the dedicated power sequencing (pwrseq) framework.

This revised series now employs a new pwrseq provider driver
(pwrseq-thead-gpu.c) specifically for the TH1520 GPU. This driver
encapsulates the SoC specific power sequence details. The Imagination
GPU driver (pvr_device.c) is updated to act as a consumer of this power
sequencer, requesting the "gpu-power" target. The sequencer driver,
during its match phase with the GPU device, acquires the necessary clock
and reset handles from the GPU device node to perform the full sequence.

This approach aligns with the goal of abstracting SoC specific power
management details away from generic device drivers and leverages the
pwrseq framework as recommended.

The series is structured as follows:

Three patches below are NOT included in this revision, as they were
merged to maintainers trees:

Patch 1: Introduces the pwrseq-thead-gpu auxiliary driver to manage the
         GPU's power-on/off sequence. (already in maintainer tree)
Patch 2: Adds device tree bindings for the gpu-clkgen reset to the
         existing thead,th1520-aon binding. (already in maintainer tree)
Patch 3: Extends the pm-domains driver to detect the gpu-clkgen reset
         and spawn the pwrseq-thead-gpu auxiliary driver. (already in
         maintainer tree)
Patch 4: Adds the gpu-clkgen reset property to the aon node in the
         TH1520 device tree source.

Revised numbering for the rest of un-merged patches:

Patch 1: Updates the Imagination DRM driver to utilize the pwrseq
         framework for TH1520 GPU power management.
Patch 2: Adds the thead,th1520-gpu compatible string to the PowerVR GPU
         device tree bindings.
Patch 3: Adds the device tree node for the IMG BXM-4-64 GPU and its
         required fixed-clock.
Patch 4: Enables compilation of the Imagination PowerVR driver on the
         RISC-V architecture.

This patchset finishes the work started in bigger series [2] by adding
remaining GPU power sequencing piece. After this patchset the GPU probes
correctly.

This series supersedes the previous genpd based approach. Testing on
T-HEAD TH1520 SoC indicates the new pwrseq based solution works
correctly.

Link to v11 of this series - [3].

v12:
- Re-base on top of 6.17-rc1.

v11:
 - Add the clock constraints in the dt-binding.
 - Add Rev-by from Krzysztof.
 - Remove unnecessary header change in first commit.

v10:
 - Squashed the two dt-binding patches back into a single commit.
 - Simplified the B-series GPU rule by removing the not clause.
 - Reverted the removal of the items definition from the top-level
   power-domain-names property, per maintainer feedback.

v9:
 - Split the dt-bidning patch to two patches: one for refactoring the
   binding and one for adding TH1520 BXM-4-64 support
 - Reworked the device tree binding entirely to define power domain
   constraints on a per-variant basis, per maintainer feedback. This
   replaces the previous generic rules with explicit definitions for
   each GPU variant.
 - Removed Reviewed-by tags from Patch 1 and the dt-binding patches, as
   they have changed significantly since they were provided.

v8:
- Re-base on top of linux-next.
- Refactor the power management logic to use an ->init() callback on
  the pvr_power_sequence_ops struct. This eliminates platform-specific
  initialization code from pvr_device.c, decoupling the generic
  driver from the power sequencing implementation details.
- Improve dt-binding to forbid the power-domain-names for thead.

v7:
- Re-based on linux-next patch 1 from v6 made it there, while I believe
  the 2-3 will join shortly as well

- Implemented conditional devicetree binding constraints. The binding
  now enforces one power domain for the TH1520 SoC while requiring two
  for other BXM/BXS GPUs, using an `if/not` construct to create a
  specific exception for the TH1520

- Rework the Imagination DRM driver's power management. The
  platform-specific logic is now abstracted into a new
  `pvr_power_sequence_ops` struct. The `of_device_id` table uses pointers
  to constant instances of this struct, allowing for a cleaner, more
  robust check at probe time

- Add stubs for the pwrseq functions which return -ENOTSUPP and issue a
  warning if the driver is used on a pwrseq-based platform without
  CONFIG_POWER_SEQUENCING enabled

- Update Kconfig dependencies to restrict RISC-V support to 64-bit
  platforms and ensure correct alphabetical ordering of the
  dependencies

v6:
 - check return values from reset_control_assert() and propagate the
   first error, ensuring all teardown steps are still attempted
 - the driver now stores a reference to the consumer's device node to
   ensure it binds to a single, specific device
 - rename Kconfig option to POWER_SEQUENCING_TH1520_GPU
 - remove COMPILE_TEST

v5:

- reworked the pwrseq-thead-gpu driver, now using manual resource
  management in .match and a .remove callback
- refactored the drm/imagination driver to use function pointers for
  power management instead of a boolean flag
- switched the pmdomain driver to use the generic
  device_property_match_string() helper
- added MMU and COMPILE_TEST dependencies to Kconfig to fix RISC-V
  build warnings.

v4:

- the pwrseq driver is now an auxiliary driver with a robust match
  function based on the power-domains property, spawned from the AON
  node
- Imagination DRM driver now uses of_device_id match data to
  conditionally probe for the pwrseq, solving the cross platform
  probe deferral issue
- add Reviewed-by from Ulf for the entire series

v3:

- re-worked cover letter completely
- complete architectural rework from using extended genpd callbacks to a
  dedicated pwrseq provider driver
- introduced pwrseq-thead-gpu.c and associated DT bindings
   (thead,th1520-gpu-pwrseq)
- the Imagination driver now calls devm_pwrseq_get() and uses
  pwrseq_power_on() / pwrseq_power_off() for the TH1520 GPU
- removed the platform_resources_managed flag from dev_pm_info and
  associated logic
- the new pwrseq driver's match() function now acquires consumer-specific
  resources (GPU clocks, GPU core reset) directly from the consumer device

v2:

Extended the series by adding two new commits:
 - introduced a new platform_resources_managed flag in dev_pm_info along
   with helper functions, allowing drivers to detect when clocks and resets
   are managed by the platform
 - updated the DRM Imagination driver to skip claiming clocks when
   platform_resources_managed is set

Split the original bindings update:
 - the AON firmware bindings now only add the GPU clkgen reset (the GPU
   core reset remains handled by the GPU node)

Reworked the TH1520 PM domain driver to:
 - acquire GPU clocks and reset dynamically using attach_dev/detach_dev
   callbacks
 - handle clkgen reset internally, while GPU core reset is obtained from
   the consumer device node
 - added a check to enforce that only a single device can be attached to
   the GPU PM domain

[1] - https://lore.kernel.org/all/CAPDyKFpi6_CD++a9sbGBvJCuBSQS6YcpNttkRQhQMTWy1yyrRg@mail.gmail.com/
[2] - https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
[3] - https://lore.kernel.org/all/20250805-apr_14_for_sending-v11-0-b7eecefcfdc0@samsung.com/

---
Michal Wilczynski (4):
      drm/imagination: Use pwrseq for TH1520 GPU power management
      dt-bindings: gpu: img,powervr-rogue: Add TH1520 GPU support
      riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
      drm/imagination: Enable PowerVR driver for RISC-V

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml |  37 ++++-
 arch/riscv/boot/dts/thead/th1520.dtsi              |  21 +++
 drivers/gpu/drm/imagination/Kconfig                |   3 +-
 drivers/gpu/drm/imagination/pvr_device.c           |  22 +--
 drivers/gpu/drm/imagination/pvr_device.h           |  22 +++
 drivers/gpu/drm/imagination/pvr_drv.c              |  27 +++-
 drivers/gpu/drm/imagination/pvr_power.c            | 174 ++++++++++++++++-----
 drivers/gpu/drm/imagination/pvr_power.h            |  15 ++
 8 files changed, 253 insertions(+), 68 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250414-apr_14_for_sending-5b3917817acc

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


