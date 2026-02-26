Return-Path: <linux-pm+bounces-43257-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICtzFMdWoGn4iQQAu9opvQ
	(envelope-from <linux-pm+bounces-43257-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:20:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E628E1A7670
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FE5F3072FEE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B93ACF07;
	Thu, 26 Feb 2026 14:18:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3EE3624A1;
	Thu, 26 Feb 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115525; cv=none; b=HoQo5e6njUsGGTghvmEut6hVNTu5zpde+v+RX1NDU7nG4qCvVIls791ZN0RvmVkjcvp0C1vDTtA4PlkSKBPAR8XsYBNCU+tNdnshrM9+Yegt+WtJ4Lxx3HQGbGD7z6SJjhZiNGJ7Nb4pp6Qs8x64Biq1BVSDO9dg1LpG1hLXT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115525; c=relaxed/simple;
	bh=6kGz6xviglIyw05t9b17V0sNmTLRK51y6oxe1JYLewg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inITBOxe2Lya0Wg4l7rpsOPmj96jJ8Jc+NVS5Qlw0SqZy4bue/I7A+SrrwYTPBK+uxtZ9yI6edBVy3WxprsA44URm2PMqtF2pm7Y2lT+HBgY4oa56HcJnvmTYqCXDeKidhhguhmq5GQg932whLJJGozyU56uzZMr29G7KCCLxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 197CE497;
	Thu, 26 Feb 2026 06:18:37 -0800 (PST)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9AB3F73B;
	Thu, 26 Feb 2026 06:18:40 -0800 (PST)
From: Philip Radford <philip.radford@arm.com>
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
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v3 0/9] Add support for SCMIv4.0 Powercap Extensions
Date: Thu, 26 Feb 2026 14:18:21 +0000
Message-ID: <20260226141830.3400924-1-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43257-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[arm.com,broadcom.com,gmail.com,linaro.org,st.com,oss.nxp.com,amd.com,quicinc.com,ti.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.881];
	FROM_NEQ_ENVFROM(0.00)[philip.radford@arm.com,linux-pm@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: E628E1A7670
X-Rspamd-Action: no action

Hi all,

I will be taking over this series from Cristian and in doing so I have
addressed a couple of issues raised by the first version and added two
additional patches since Cristian's original series:

[6/9] exposes the measurement averaging interval (MAI) value when the
agent has registered to receive power measurement change notifications
for the power capping domain.

[9/9] adds MAI get and set support for the powercap protocol.

The original series was based on v6.17-rc1 whereas this version has been
based on v7.0-rc1.

The rest of Cristian's series is explained below;

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

Note that the public SCMIv4.0 spec at [1] is currently still BETA0, so
this series could anyway need some minor rework along the way and
definitely will need to wait for a final public release before being
possibly merged.

Tested in a mocked setup implementing the new protocol extensions.
Based on v7.0-rc1.

Thanks,
Phil
---
V2->V3
- Added powercap MAI get/set support
V1->V2
- Rebased on sudeep/for-next/scmi/updates
- Amended Copyright to include 2026
- Added patch to extend powercap report to include MAI
- Removed creation of pi powercap_info struct due to legacy code change
- Amended references to pi->version and similar, which were based on
  legacy code
- Wrapped two variables in le32_to_cpu() to appease Sparse warnings
- Amended comparing operator value in response to feedback

Cristian Marussi (7):
  firmware: arm_scmi: Add an optional custom parameter to fastchannel
    helpers
  firmware: arm_scmi: Refactor powercap domain layout
  firmware: arm_scmi: Add SCMIv4.0 Powercap basic support
  firmware: arm_scmi: Add SCMIv4.0 Powercap FCs support
  firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
  include: trace: Add new parameter to trace_scmi_fc_call
  powercap: arm_scmi: Enable multiple constraints support

Philip Radford (2):
  firmware: arm_scmi: Extend powercap report to include MAI
  firmware: arm_scmi: add Powercap MAI get/set support

 drivers/firmware/arm_scmi/driver.c    |  12 +-
 drivers/firmware/arm_scmi/perf.c      |  16 +-
 drivers/firmware/arm_scmi/powercap.c  | 976 ++++++++++++++++++++------
 drivers/firmware/arm_scmi/protocols.h |   2 +-
 drivers/powercap/arm_scmi_powercap.c  |  54 +-
 include/linux/scmi_protocol.h         |  87 ++-
 include/trace/events/scmi.h           |  12 +-
 7 files changed, 889 insertions(+), 270 deletions(-)

--
2.47.3


