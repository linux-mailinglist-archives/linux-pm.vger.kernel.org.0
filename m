Return-Path: <linux-pm+bounces-27820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E898AC842C
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 00:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD791BC3D32
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866621E08B;
	Thu, 29 May 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DjoeaMRN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289021C16A
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557454; cv=none; b=JD/k/irZvMXB1o/KFx4jiDqH/jKXbLOQXVn4lXr80UOAHkj9OcIJP8HM6ttuCY6ikDAe8mlIap0fLKdzE0jiVsChOY0rFbqXkl3xgEhe4grGXH75hM7AKntPiALDvwqjItK86pb+NvSAG9p9wMaNaf+7GXHVsfTtfUqKQaj6LJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557454; c=relaxed/simple;
	bh=Gr0NgPqNi0lP5QyMNmiOSsSTjiU0uQl3DenFDvmJ+Eg=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type:
	 References; b=Ih4MJ0hM6deK/ZRlMVPpfZ9+T2geJ6w49m6UIIW+WzZgyZ5PHsd0Puxy71KNCbX7aC5mXvuN6Z4M4hQnOaNs3Djotqq7bWEC9rmZc8RT5mxfx95XGKmUNoaaKafrHi/Ou9KuiVp2jBor+oRPoSltozwSRhSa4y6rwTFDAEJlGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DjoeaMRN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250529222404euoutp019b43820060d0c8eaf8b36f9d57044c17~EH7szsJFN0344303443euoutp01B
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 22:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250529222404euoutp019b43820060d0c8eaf8b36f9d57044c17~EH7szsJFN0344303443euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748557444;
	bh=Vr23UlpBgLnrYfzNBGLb2Ydx/f2xbaLUmJeQ4lO+18g=;
	h=From:Subject:Date:To:Cc:References:From;
	b=DjoeaMRNO77hcLqcgjpbsfJ+/EWurFq9LX0IZv69bz/VgnGAIZqJw1Lk/fc+g8Po4
	 s3Xq37gtjoiKtmiUBi2owUTi0mZgVWOKJmmyTgrjcWlnaHwVJwi278aWlWNMcd1F44
	 1/CQjQ0DpW0PHNqW94dMwbaVZiqZMbnYWS7FO/Tg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58~EH7raVWlc2958729587eucas1p1i;
	Thu, 29 May 2025 22:24:02 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529222401eusmtip212d38f75d4ad984b84715139e66bb596~EH7qgNOc32867928679eusmtip2S;
	Thu, 29 May 2025 22:24:01 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v3 0/8] Add TH1520 GPU support with power sequencing
Date: Fri, 30 May 2025 00:23:47 +0200
Message-Id: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHTeOGgC/32NQQ6DIBBFr2JmXRpALdVV79EYQxFwFoJhWtPGc
	PdSD9Dle8l/fweyCS1BX+2Q7IaEMRSoTxWYWQdvGU6FQXLZ8kY0TK9pFM3oYhrJhgmDZ+2j7oS
	6CqWNgTJck3X4PqL3ofCM9Izpc3xs8mf/5jbJOFPctNpJ7bqLuZFe6BX82cQFhpzzF7RfXNO2A
	AAA
X-Change-ID: 20250414-apr_14_for_sending-5b3917817acc
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>,  Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Frank Binns
	<frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,  Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
X-EPHeader: CA
X-CMS-RootMailID: 20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58
References: <CGME20250529222402eucas1p1c9e0ddd3efd62e078e5de2cf71655f58@eucas1p1.samsung.com>

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

Patch 1: Adds device tree bindings for the new T-HEAD TH1520 GPU
         power sequencer provider.
Patch 2: Introduces the pwrseq-thead-gpu driver to manage the GPU's
         power-on/off sequence.
Patch 3: Updates the Imagination DRM driver to utilize the pwrseq
         framework for TH1520 GPU power management.
Patch 4: Adds the TH1520 GPU compatible string to the Imagination
         GPU DT bindings.
Patch 5: Adds the missing reset controller header include in the
         TH1520 DTS include file.
Patch 6: Adds the device tree node for the GPU power sequencer to
         the TH1520 DTS include file.
Patch 7: Adds the GPU device tree node for the IMG BXM-4-64 GPU to
         the TH1520 DTS include file.
Patch 8: Enables compilation of the drm/imagination on the RISC-V
         architecture

This patchset finishes the work started in bigger series [2] by adding
all the remaining GPU power sequencing piece. After this patchset the GPU
probes correctly.

This series supersedes the previous genpd based approach. Testing on
T-HEAD TH1520 SoC indicates the new pwrseq based solution works
correctly.

This time it's based on linux-next, as there are dependent patches not
yet merged, but present in linux-next like clock and reset patches.

An open point in Patch 7/8 concerns the GPU memory clock (gpu_mem_clk),
defined as a fixed-clock. The specific hardware frequency for this clock
on the TH1520 could not be determined from available public
documentation. Consequently, clock-frequency = <0>; has been used as a
placeholder to enable driver functionality.

Link to v2 of this series - [3].

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
[3] - https://lore.kernel.org/all/20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com/

---
Michal Wilczynski (8):
      dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
      power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver
      drm/imagination: Use pwrseq for TH1520 GPU power management
      dt-bindings: gpu: Add TH1520 GPU compatible to Imagination bindings
      riscv: dts: thead: th1520: Add missing reset controller header include
      riscv: dts: thead: Add GPU power sequencer node
      riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
      drm/imagination: Enable PowerVR driver for RISC-V

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml |   9 +-
 .../bindings/power/thead,th1520-pwrseq.yaml        |  42 +++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi              |  29 ++++
 drivers/gpu/drm/imagination/Kconfig                |   3 +-
 drivers/gpu/drm/imagination/pvr_device.c           |  33 +++-
 drivers/gpu/drm/imagination/pvr_device.h           |   6 +
 drivers/gpu/drm/imagination/pvr_power.c            |  82 +++++----
 drivers/power/sequencing/Kconfig                   |   8 +
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-thead-gpu.c        | 183 +++++++++++++++++++++
 11 files changed, 363 insertions(+), 35 deletions(-)
---
base-commit: 49473fe7fdb5fbbe5bbfa51083792c17df63d317
change-id: 20250414-apr_14_for_sending-5b3917817acc

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


