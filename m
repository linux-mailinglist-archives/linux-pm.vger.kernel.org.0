Return-Path: <linux-pm+bounces-32264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EAB248BB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F93A653C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E22F069C;
	Wed, 13 Aug 2025 11:46:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3E1D7E4A;
	Wed, 13 Aug 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085610; cv=none; b=eQtsO3OW0UjGcgtW78gZIYo8VlnbTWyw90/iIozqB8HitqrNk14UmeU4ByjEbG6frs2Q96BPfyNdjhpWPand3qT1f/m3P9cKpfSqbMAtgjYXvewGNRrUeYAVJb7bKT2cOpYddO5DQiKGuu1+KoytPPR67uU4uwqAb/XuQW3rUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085610; c=relaxed/simple;
	bh=1TfAQGQCYHuxmDCqG0Le334KtJ2qftVKyGbJM5ISVeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zo6EUQ2LwRKh2PI4CxypzlspGjeceTL0Vtjc14WQ488QsfJQsSAJtPYGX11/jrkmHjsSzVyEIwFuxIVgxxfK4OVzCXa84DfsBKSaJAnsll7kXrDK7uwzwGDZZILZ7T3kJyu76vFCeKRXoimPEe6XakJIEwPO5ZIWBSUQ656rfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D66B12FC;
	Wed, 13 Aug 2025 04:46:40 -0700 (PDT)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939873F738;
	Wed, 13 Aug 2025 04:46:45 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/8] Add support for SCMIv4.0 Powercap Extensions
Date: Wed, 13 Aug 2025 12:46:01 +0100
Message-ID: <20250813114609.1305571-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

SCMIv4.0 [1] introduces some new features and commands into the Powercap
protocol. In a nutshell, such protocol changes add support for:

 - setting multiple powercap limit/interval constraints for each SCMI
   powercap domain which supports multiple Concurrent Power Limit
 - enabling more Powercap commands to use Fastchannels mechanism
 - adding multiple constraints support to the existing notifications

After a bit of needed updates in the SCMI core this series adds:

- support for the idea of optional multiple Concurrent Power Limit (CPLs)
- support for the new FCs
- support for extended notifications
- enable usage of such multiple constraint in the ARM SCMI Powercap driver

Note that the public SCMIv4.0 spec at [1] is currently still ALPHA0, so
this series could anyway need some minor rework along the way and
definitely will need to wait for a final public release before being
possibly merged.

Tested in a mocked setup implementing the new protocol extensions.
Based on v6.17-rc1.

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/den0056/f/?lang=en


Cristian Marussi (8):
  firmware: arm_scmi: Add an optional custom parameter to fastchannel
    helpers
  firmware: arm_scmi: Add bound iterators support
  firmware: arm_scmi: Refactor powercap domain layout
  firmware: arm_scmi: Add SCMIv4.0 Powercap basic support
  firmware: arm_scmi: Add SCMIv4.0 Powercap FCs support
  firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
  include: trace: Add new parameter to trace_scmi_fc_call
  powercap: arm_scmi: Enable multiple constraints support

 drivers/firmware/arm_scmi/driver.c    |  33 +-
 drivers/firmware/arm_scmi/perf.c      |  16 +-
 drivers/firmware/arm_scmi/powercap.c  | 843 ++++++++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |   8 +-
 drivers/powercap/arm_scmi_powercap.c  |  54 +-
 include/linux/scmi_protocol.h         |  78 ++-
 include/trace/events/scmi.h           |  10 +-
 7 files changed, 777 insertions(+), 265 deletions(-)

-- 
2.47.0


