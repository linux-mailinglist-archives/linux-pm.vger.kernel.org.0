Return-Path: <linux-pm+bounces-43967-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFdBH2sNr2mfNAIAu9opvQ
	(envelope-from <linux-pm+bounces-43967-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 19:11:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B223E5A1
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 19:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B7FD3046136
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46077333426;
	Mon,  9 Mar 2026 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7JBjHhH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F660330301;
	Mon,  9 Mar 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079452; cv=none; b=hf6Vihyx3rOVmYVcfeTgvFuHFjCJ09r9aEpq+ZwydXDjZANlsgTRiocc8er5lCOw9AtdEHufHdXffXu1/ooUfOQwQHJYO1mpqB3zs5OPfxo2kMOuG/HPbhmcwplXE5Jv8q2yvzoFai9C+sIaiFHUjzasa7avgIxzFkyGXPgNd1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079452; c=relaxed/simple;
	bh=5RQR0tB8TaCktoIyLXNMgaAgv+1TxrjShEKgDbTNFY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A4L2RUjLxlcr9x77aPFye0lRIDfz2rNOnZxjC6NVMotuqIlcPI7q+e/y+mD39AW7wWmBas8IOKiALeFWOMlKRjezNTVOmFdlYwx8FtLCN7E84hsjZm65lNep0Z2ndFUs1lXcvKPtQ1n8oJW9WOM/OphcsXf99hdhM2ef1cm04zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7JBjHhH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773079451; x=1804615451;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=5RQR0tB8TaCktoIyLXNMgaAgv+1TxrjShEKgDbTNFY4=;
  b=e7JBjHhHZJ22FnwYqj+bGXE5LDlB2htjZpaPug38Rm7OfUtsNFsWVh1a
   ritgxnGpCETyiYFRHrW0rM9DLUsdd+cHtqw4SrEuC6IcT2yi1GtQHoRqn
   DDmmTpME+T67uiXLtBu5JZ4SCXiid6Pj86fqEiIFpkf4iUqxQ/pqizcOB
   VjwqyH+oybRQgzWKrKLUvogjR7gPSUWeAqqZI+67yW8rtHaJEPPyQaXf5
   LbSrHv0d6a4563htu0eBligQGMeygrtrZRh39sSY0LtzFAKD8DIBw6Yrz
   jnZv76xQ2v5+1AemYN4l4uLhpsxjZJ7V0OGRyBsTpYD4sl2WTWSgDqzXv
   g==;
X-CSE-ConnectionGUID: /ryRZr3LR06al7rWjCDPWA==
X-CSE-MsgGUID: cmaT6xI/R3OCDpZNL2hrug==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74225017"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74225017"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:04:10 -0700
X-CSE-ConnectionGUID: TqnZ+j21QRuCikbnEdvpPw==
X-CSE-MsgGUID: 0y3/eJb8S3qtzTEtnCfe8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218975703"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:04:09 -0700
Message-ID: <19dc5e60-2740-458f-9e0a-90d3982316f4@linux.intel.com>
Date: Mon, 9 Mar 2026 11:04:09 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
 <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
 <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
 <aZbEDldZxV1KG_5B@wunner.de>
 <CAJZ5v0gF244JC5C9pLqmzxUuQkxMOXXBf92ckTKfeo9n8wgb1w@mail.gmail.com>
 <09db5a83-980c-432e-adbc-2582680c8cf9@linux.intel.com>
Content-Language: en-US
In-Reply-To: <09db5a83-980c-432e-adbc-2582680c8cf9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 212B223E5A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-43967-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,linux.intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Action: no action

Hi Lukas/Rafael,

On 2/19/2026 1:54 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 2/19/2026 3:09 AM, Rafael J. Wysocki wrote:
>> On Thu, Feb 19, 2026 at 9:04 AM Lukas Wunner <lukas@wunner.de> wrote:
>>>
>>> On Wed, Feb 18, 2026 at 06:33:15PM +0100, Rafael J. Wysocki wrote:
>>>> First, keeping the ports in D0 may gate runtime PC10.  Does it not?
>>>
>>> The Root Port in question is on the PCH.  I'm not sure, does keeping a
>>> PCH Root Port in D0 also prevent PC10 entry or is that only the case
>>> for Root Ports on the CPU die/tile?
>>
>> If it is located in the PCH, it should not gate PC10 if in D0 at least
>> in theory, but it would be good to verify that.
>>
>> Of course, it will still gate S0ix entry through runtime idle, but
>> that's a bit moot if the platform is unable to enter S0ix through
>> runtime idle anyway for other reasons (which is quite likely), or if
>> the power difference between S0ix and PC10 is small.
> 
> I will gather current PC10 and S0ix numbers. If there is a significant
> difference between the two power savings, I will implement the
> pme_is_broken() approach.

I have gathered the test results. S0ix is not a POR for this platform, so
I was unable to collect those numbers. The deepest package  C-state supported
is PC6.

With pm_runtime_disable() keeping the port in D0, I observe approximately 
10% reduction in PC6 residency. Given this power impact, I will proceed with 
the pme_is_broken() approach suggested by Lukas, which allows the port to 
enter D3hot while keeping hotplug interrupts enabled.

I will submit v3 with this implementation. Change log looks like below:


diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 1e9158d7bac7..f854ef9551c3 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -260,13 +260,20 @@ static bool pme_is_native(struct pcie_device *dev)
        return pcie_ports_native || host->native_pme;
 }

+static bool pme_is_broken(struct pcie_device *pcie)
+{
+       struct pci_dev *pdev = pcie->port;
+
+       return !!(pdev->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE);
+}
+
 static void pciehp_disable_interrupt(struct pcie_device *dev)
 {
        /*
         * Disable hotplug interrupt so that it does not trigger
         * immediately when the downstream link goes down.
         */
-       if (pme_is_native(dev))
+       if (pme_is_native(dev) && !pme_is_broken(dev))
                pcie_disable_interrupt(get_service_data(dev));
 }

@@ -318,7 +325,7 @@ static int pciehp_resume(struct pcie_device *dev)
 {
        struct controller *ctrl = get_service_data(dev);

-       if (pme_is_native(dev))
+       if (pme_is_native(dev) && !pme_is_broken(dev))
                pcie_enable_interrupt(ctrl);

        pciehp_check_presence(ctrl);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..acaa328dff51 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,3 +6380,51 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * When a PCIe port is in D3hot, the hotplug driver depends on PME
+ * to wake the port back to D0 and then process any hotplug-related
+ * state changes. On Intel Catlow Lake platforms, PCH PCIe root ports
+ * do not reliably update PME state during D3hot to D0 transitions.
+ *
+ * Mark affected ports with PCI_DEV_FLAGS_PME_UNRELIABLE to keep
+ * hotplug interrupts (HPIE) enabled during D3hot instead of relying on
+ * PME-based wakeup. This allows hotplug events to be delivered via
+ * direct interrupts while still permitting the port to enter D3hot for
@@ -6380,3 +6380,51 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * When a PCIe port is in D3hot, the hotplug driver depends on PME
+ * to wake the port back to D0 and then process any hotplug-related
+ * state changes. On Intel Catlow Lake platforms, PCH PCIe root ports
+ * do not reliably update PME state during D3hot to D0 transitions.
+ *
+ * Mark affected ports with PCI_DEV_FLAGS_PME_UNRELIABLE to keep
+ * hotplug interrupts (HPIE) enabled during D3hot instead of relying on
+ * PME-based wakeup. This allows hotplug events to be delivered via
+ * direct interrupts while still permitting the port to enter D3hot for
+ * power savings.
+ *
+ */
+static void quirk_intel_catlow_pcie_pme_unreliable(struct pci_dev *dev)
+{
+       dev->dev_flags |= PCI_DEV_FLAGS_PME_UNRELIABLE;
+       pci_info(dev, "Catlow PCH port: PME unreliable\n");
+}
+/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_catlow_pcie_pme_unreliable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_catlow_pcie_pme_unreliable);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..9761351c5d70 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -253,6 +253,8 @@ enum pci_dev_flags {
         * integrated with the downstream devices and doesn't use real PCI.
         */
        PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
+       /* Device PME is broken or unreliable */
+       PCI_DEV_FLAGS_PME_UNRELIABLE = (__force pci_dev_flags_t) (1 << 15),
 };





> 
> 
>>
>>> If this does cause a power regression, the pme_is_broken() approach
>>> suggested upthread might be a viable alternative.  It'll allow the
>>> Root Port to go to D3hot but will keep interrupts enabled in the
>>> Slot Control register.
>>
>> Sounds reasonable to me.
> 
> Sounds good. 
> 
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


