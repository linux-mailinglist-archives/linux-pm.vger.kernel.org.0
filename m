Return-Path: <linux-pm+bounces-43065-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKYHNuOknGkYJwQAu9opvQ
	(envelope-from <linux-pm+bounces-43065-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:05:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5717BFB5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6C530528AB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F236A015;
	Mon, 23 Feb 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT59pT+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FD36A002;
	Mon, 23 Feb 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873499; cv=none; b=LsYcVjeISie3h16ITnjUZFT+QTErhwgS9UmNWPNolJrl6qIzdXguz3sQRlkJncG5tQeDKlrq3bklhFq+E5BZ+m9Ctsb1SuC9lyyF4su2uVKWSi6O3jVHmj1sJa7xDcl9Vpdr6uL3VF/4e18Qi3zvSzFDC/a68HKCq/IJ61lAw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873499; c=relaxed/simple;
	bh=36qoH7d2ZZRevErqizID1nHKti5Zrtn/oKG6FMsDyFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRbj2U5GiOiNICVfX1l62NmenMI779hUmfe8vOTskzfvK1LoXCYZA8HnmDDelX2ZnYnJLXWP/Jz1ThQ5fcqTc/IMk06fyYaqS8BjZXcRiPfakKEelqNhCJGWUPG203xYo/AKN1ZcZDpM8sbuSkkaDb+zv5Umj6vW0p96IkgLrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT59pT+N; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771873479; x=1803409479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=36qoH7d2ZZRevErqizID1nHKti5Zrtn/oKG6FMsDyFU=;
  b=PT59pT+NkDqGFKCXTwHTbFx1Xd3J0g0s1iO8XVbjoVzZQ1gd5QYZbQ9L
   ZhxJNO3o5GsUEAnd6n/ihn2AOXqVM8tUrYCM7arToHSi8CJT+dNSlrQhB
   EcMceeqvDAaW7MwhvXfawwN3/L2XLKNkbslQomzWTeJj/Mvvk0q17nC9z
   NeelpFZP++gyVab5d5f9EJgTrhSpobJjQWXNt7W0KNINrYIqca7GLKuLa
   lp+UsTVJE26C4W/GukbhOSh9BaP0zadCBE2eFygTKV0YS1vMdMigwS9vt
   RXAojLFcxBtBVyhVGApJFtQiK6YPmuAD21wUECDGD0iCo6+hcmUnK2JHO
   A==;
X-CSE-ConnectionGUID: ro2yP6YrRsWmKo19V7e7ew==
X-CSE-MsgGUID: 4Rdvi22VRkaCnX/1MdVs5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="98341601"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="98341601"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:04:36 -0800
X-CSE-ConnectionGUID: /qIchopFRZCmhuD5ocb0Zw==
X-CSE-MsgGUID: VuZkBKCwSU6eIRBSFKe03A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="243747934"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa001.fm.intel.com with ESMTP; 23 Feb 2026 11:04:36 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: intel: int340x: Read DDR data rate for Nova Lake
Date: Mon, 23 Feb 2026 11:04:20 -0800
Message-ID: <20260223190420.874853-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43065-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 85C5717BFB5
X-Rspamd-Action: no action

Add support for reading DDR data rate from PCI config offset.
The register details are:
CFG Offset : 0xE0
Bits	   : 11:2

DDR Data rate is in 33.33 MTPS units.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rfim.c     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 314fbc1f490f..2e834a175471 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -402,6 +402,11 @@ static ssize_t rfi_restriction_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", resp);
 }
 
+ /* ddr_data_rate */
+static const struct mmio_reg nvl_ddr_data_rate_reg = { 1, 0xE0, 10, 0x3FF, 2};
+
+static const struct mmio_reg *ddr_data_rate_reg;
+
 static ssize_t ddr_data_rate_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -410,10 +415,20 @@ static ssize_t ddr_data_rate_show(struct device *dev,
 	u64 resp;
 	int ret;
 
+	if (ddr_data_rate_reg) {
+		u16 reg_val;
+
+		pci_read_config_word(to_pci_dev(dev), ddr_data_rate_reg->offset, &reg_val);
+		resp = (reg_val >> ddr_data_rate_reg->shift) & ddr_data_rate_reg->mask;
+		resp = (resp * 3333) / 100;
+		goto ret_resp;
+	}
+
 	ret = processor_thermal_send_mbox_read_cmd(to_pci_dev(dev), id, &resp);
 	if (ret)
 		return ret;
 
+ret_resp:
 	return sysfs_emit(buf, "%llu\n", resp);
 }
 
@@ -461,6 +476,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 		case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
 		case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
 			dlvr_mmio_regs_table = nvl_dlvr_mmio_regs;
+			ddr_data_rate_reg = &nvl_ddr_data_rate_reg;
 			break;
 		default:
 			dlvr_mmio_regs_table = dlvr_mmio_regs;
-- 
2.52.0


