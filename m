Return-Path: <linux-pm+bounces-42817-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH6IO4HolWlWWQIAu9opvQ
	(envelope-from <linux-pm+bounces-42817-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:27:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037A157BAF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F26B3002F43
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34B340A7D;
	Wed, 18 Feb 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Be+TGLhr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABD301460;
	Wed, 18 Feb 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432056; cv=none; b=D/Hwkn6mI65LF0fCdw8bQ7MB8HmOg+ZvjDnaxHJZ//vzuZ7sDVRX0vZ6gC2Kp0e4fFnJ/aKlVHVKhZKGD9n5bAVSJKpL2agqp8TyRugpZGspD/h/0GeJjiRoZFu9DbTlMttyvrC6ZF9SrgJ/UBrE0NvfN+WNPSCO2jQXxk7UgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432056; c=relaxed/simple;
	bh=/iSVujH+BgQbdiqANA/IPDHm2T2rE2DWj42mhBMSkoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvlWbPdlzCLh0YQYIEwlTvEH6dtdFEbiRMftK1jWJztxg0XlNqzEj1KBA8Qa3TBkhDI7Erl/O8gGwdq7ZqxFoIAcCnBINCJjrFFllxI2LuQpbA/vAmXfe6nnX5QrvMILOqkZ0xsRiEDJfC9aRmcNiBYM6Z9FlvgTujiaUsb5DNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Be+TGLhr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771432055; x=1802968055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/iSVujH+BgQbdiqANA/IPDHm2T2rE2DWj42mhBMSkoY=;
  b=Be+TGLhrSClgNVdS263B44XDpbjbBYJ8A6TKfweNPNVOaKYgfeUt+ZoH
   3o/Pe5+w3WwTZ6CFe4U5qFPtt2Xb0d18590HswnQMQGMnW35LZ1vGjfws
   6sdDLYdOVyWDj9OVxMVmuFoNkabvo+2yTbGeEDKDG1bjGOUp+qhxE3MFG
   4T3iiKS0HGE8vzPjVHnKf8qJmbYKyr9c3q6EtJMp9cUIn1uAqALM1IVkn
   7JiiWtaJbzg+syBnf3hmICJPnN4mTYS4fVvfD2TD/UKTCLfjLPWHh7rhx
   bbh//AdVMWMX65vuG7K3EUcYjcvZ9J5cz4lwb1/xFUlLi+9L1toLAc7+t
   Q==;
X-CSE-ConnectionGUID: amDq/WoDRYyEmNzZ+ZhlmA==
X-CSE-MsgGUID: I2tPgxAISom0jSNsXLkAFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="90095119"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="90095119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:27:34 -0800
X-CSE-ConnectionGUID: AIhdKESDShazAcjEIvfzNg==
X-CSE-MsgGUID: jqTJfDlzQumnRTd3YVfgLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213478670"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:27:35 -0800
Message-ID: <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
Date: Wed, 18 Feb 2026 08:27:34 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
 <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42817-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 0037A157BAF
X-Rspamd-Action: no action



On 2/17/2026 10:08 AM, Rafael J. Wysocki wrote:
> On Tue, Feb 17, 2026 at 5:54 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> Hi Rafael,
>>
>> On 2/13/2026 3:14 PM, Kuppuswamy Sathyanarayanan wrote:
>>> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
>>> update PME status registers (PME Status and PME Requester_ID in the
>>> Root Status register) during D3hot to D0 transitions, even though PME
>>> interrupts are delivered correctly.
>>>
>>> This issue manifests during PCIe hotplug operations as follows:
>>>
>>> 1. After a hot-remove event, the PCIe port transitions to D3hot and
>>>    the hotplug interrupt enable (HPIE) flag is disabled as the port
>>>    enters low power state.
>>>
>>> 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
>>>    fires as expected to wake the port.
>>>
>>> 3. However, the PME interrupt handler finds the PME_Status and
>>>    PME_Requester_ID registers unpopulated, preventing identification
>>>    of which device triggered the PME. The handler returns IRQ_NONE,
>>>    leaving the port in D3hot.
> 
> I think that you mean the
> 
> if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME))
> 
> check in pcie_pme_irq().  Or do you mean something else?

Yes, I was referring to the above check.

> 
> An alternative workaround might be to add a (new) "always poll PME"
> flag for the port in question that will cause it to go to pci_pme_list
> in pci_pme_active() every time wakeup is enabled (essentially, an
> override for pme_poll clearing).

I will check whether this approach works. I want to make sure the poll
logic eventually triggers the hotplug handler to detect slot state
changes.

But if you think there is no power-related issue with keeping these ports
in D0, then we can adopt the pm_runtime_disable() approach. I think this
approach looks clean and simple.

What's your preference?

> 
>>> 4. Because the port remains in D3hot with HPIE disabled, the hotplug
>>>    driver ignores the hot-add event, resulting in the newly inserted
>>>    device not being recognized.
>>>
>>> The PME interrupt delivery mechanism itself works correctly;
>>> interrupts arrive reliably. The problem is purely the missing status
>>> register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
>>> reads confirms that these registers remain empty when the PME
>>> interrupt fires. Neither BIOS nor kernel code is clearing these
>>> registers.
>>>
>>> This issue is present in all steppings of Catlow Lake PCH and affects
>>> customers in production deployments. A public hardware errata document
>>> is not yet available.
>>>
>>> Work around this issue by disabling runtime PM for affected ports,
>>> keeping them in D0 during runtime operation. This ensures hotplug
>>> events are handled via direct interrupts rather than relying on
>>> unreliable PME-based wakeup.
>>>
>>> During system suspend/resume, PCIe ports are resumed unconditionally
>>> when coming out of system sleep due to DPM_FLAG_SMART_SUSPEND set by
>>> pcie_portdrv_probe(), and pciehp re-enables interrupts and checks slot
>>> occupation status during resume.
>>>
>>> The quirk is applied only to Catlow PCH PCIe root ports (device IDs
>>> 0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
>>> they are not hotplug-capable.
>>>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>
>> Could you please review this patch and let us know if calling
>> pm_runtime_disable() from a PCI quirk is acceptable?
>>
>> The quirk keeps specific Catlow Lake PCH PCIe root ports in D0 to
>> work around a hardware bug where PME status registers are not reliably
>> updated during D3hot to D0 transitions, causing hotplug events to be
>> missed.
>>
>> System suspend/resume is unaffected as DPM_FLAG_SMART_SUSPEND ensures
>> ports are resumed unconditionally and pciehp checks slot occupation
>> on resume.
>>
>>
>>>
>>> Changes since v1:
>>>  * Removed hack in hotplug driver and disabled runtime PM on affected ports.
>>>  * Fixed the commit log and comments accordingly.
>>>
>>>  drivers/pci/quirks.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 280cd50d693b..779cd65b1a8a 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -6340,3 +6340,52 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>>>  #endif
>>> +
>>> +/*
>>> + * Intel Catlow Lake PCH PCIe root ports have a hardware issue where
>>> + * PME status registers (PME Status and PME Requester_ID in Root Status)
>>> + * are not reliably updated during D3hot to D0 transitions, even though
>>> + * PME interrupts are delivered correctly.
>>> + *
>>> + * When a hotplug event occurs while the port is in D3hot, the PME
>>> + * interrupt fires but the status registers remain empty. This prevents
>>> + * the PME handler from identifying the event source, leaving the port
>>> + * in D3hot and causing the hotplug driver to miss the event.
>>> + *
>>> + * Disable runtime PM to keep these ports in D0, ensuring hotplug events
>>> + * are handled via direct interrupts.
>>> + */
>>> +static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *dev)
>>> +{
>>> +     pm_runtime_disable(&dev->dev);
> 
> Personally, I would use pm_runtime_get_sync() here instead which would
> really mean "never suspend".
> 
>>> +     pci_info(dev, "Catlow PCH port: PME status unreliable, disabling runtime PM\n");
>>> +}
>>> +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_catlow_pcie_no_pme_wakeup);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_catlow_pcie_no_pme_wakeup);
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


