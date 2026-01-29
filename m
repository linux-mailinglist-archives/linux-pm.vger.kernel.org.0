Return-Path: <linux-pm+bounces-41715-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LhvGPCoe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41715-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28AB39F4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3969E30300E0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E02FF66B;
	Thu, 29 Jan 2026 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGfpP5aE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC052FD69B;
	Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711830; cv=none; b=gyAKLAlwdMPlcDcy02hhQps5L+Gpvzu/29oqucFfg+JSVS3t60u41zfjrUx9Y2U4DCWbCHGEl7txqhwf9RtD8uKYpaWv5r6QnOxB55UTaxBRzCkIIPhPR0FwdYOAZSx50g+PMHH58qTEiDnC/WbW2Eshw1I6rbs4KwcDRVDucGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711830; c=relaxed/simple;
	bh=RVFZpXwE4vtzMd4GfMWmFSn4TMciv5u0tMiSsfa7AkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYVCPHwp5X4Rvh5tduqcrPFUtrqEmJYjvOklLVXj/2jYypszSfEFpjeNsSvX5CMQKbPd/Cw7ea41AaPTdWNS93iWxNiHgKnGy/1FeMCa00RVuPdmP3Lmyqx41doFcfcWxRTfGZTrh1ZAWo/z+ryAa+t8Zm61eOSftKaycGWF+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGfpP5aE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711829; x=1801247829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVFZpXwE4vtzMd4GfMWmFSn4TMciv5u0tMiSsfa7AkU=;
  b=GGfpP5aEQYYIfA1zS6Zca9Q2VG/aZrgMBziQCaXTrWv7GYtdA3maVTQ4
   /GLX0gQz4m7/ucI9il+lkpt5lYL+Fg/+0IaNdsLJp7oLrQ4kLDmeSP15U
   +1f6Yv5ZDFa2/pcUBOKcMOIdfbp/BkWQS6qJNDlrSqrqeucoBjTZXif+E
   8xXnTH06UxOIzA90ns3gm03S4EubYmRo/sV4/IJ7FqEW+19tAP9nc2vjv
   5COcl2yEqK4YJWxz90oK/08YQD8rnY0sRMKJcuSG9D/r3TgRaQ2t3eDLE
   sgxc+SIHesQ9zvdB2i9QCsRti99Kob6H38YbSmECHti9mP57M43Exhqlz
   g==;
X-CSE-ConnectionGUID: wujjtVuLQY+mcT5JT/SCjg==
X-CSE-MsgGUID: WZAUnwdmS96jCZlX+hMt8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388377"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388377"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:08 -0800
X-CSE-ConnectionGUID: UdOX2cy+TnqpgCjnlT6HsQ==
X-CSE-MsgGUID: 0YDo8c4MTEi1D0VkkaDwpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070977"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:07 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
Date: Thu, 29 Jan 2026 10:36:44 -0800
Message-ID: <20260129183646.558866-8-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41715-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: DC28AB39F4
X-Rspamd-Action: no action

Previously, the MMIO and MSR RAPL interfaces shared the same set of
RAPL defaults provided by common code. However, unlike the MSR
interface, the MMIO RAPL interface does not require CPU-specific
variations in its default handling. Keeping the RAPL defaults in
the RAPL common driver therefore provides no additional benefit.

Move the MMIO defaults into the MMIO interface driver. This change
includes the following updates:

  * Introduce a MMIO-local rapl_defaults instance with the appropriate
    default callbacks.
  * Assign the MMIO-specific rapl_defaults to priv->defaults during
    MMIO driver initialization.

No functional changes are expected.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_rapl.c        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e56b18aeda71..5dbeb0a43c8c 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -19,6 +19,13 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
+static const struct rapl_defaults rapl_defaults_mmio = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+};
+
 static int rapl_mmio_read_raw(int cpu, struct reg_action *ra, bool atomic)
 {
 	if (!ra->reg.mmio)
@@ -67,6 +74,7 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 
 	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
 	rapl_mmio_priv.write_raw = rapl_mmio_write_raw;
+	rapl_mmio_priv.defaults = &rapl_defaults_mmio;
 
 	rapl_mmio_priv.control_type = powercap_register_control_type(NULL, "intel-rapl-mmio", NULL);
 	if (IS_ERR(rapl_mmio_priv.control_type)) {
-- 
2.43.0


