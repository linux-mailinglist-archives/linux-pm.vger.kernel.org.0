Return-Path: <linux-pm+bounces-19077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6399EDC34
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 00:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E9281133
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A191F0E26;
	Wed, 11 Dec 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="iKBFnBb1"
X-Original-To: linux-pm@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BE1F2390
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960785; cv=none; b=gVinLXrucYvTQ0jfb8bk7c7Hk1XM416vmNg1w07ZDmVAeMTpTSqVtby/L7eT04m7VDXIOEfSLLFM2OhKWIzl6cMHLyhuyUfnSBpy1gNFHQjxZuiYz2gRdEduvZP5WxucIAtb+HJIPaPsMk0MBRPuhN5kmsR9dumrdhJAhXdiSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960785; c=relaxed/simple;
	bh=R6T9g6xgRMwD3NlYfsEIjh4P4185UdWYvSJUjznb9pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmypSdrTWU25dRdz1CWLtUXvFPiClCA3zJR/b3hGd6aalz7rNs3A7BifM3Ca/p855z55O4XbfPCN7Vphtempf5yH88mKnrIcGHpCU2Pn0rtUhwVqZ//+fQFrWyMyBZ+tNiX7ct4OdjvMgzgNl4ra0Ba6ouz/Iss80oJLUUuQMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=iKBFnBb1; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4Y7sF05RQDzDSF
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 18:26:44 -0500 (EST)
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y7sDt1JVHz4PPT;
	Wed, 11 Dec 2024 18:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1733959598; bh=R6T9g6xgRMwD3NlYfsEIjh4P4185UdWYvSJUjznb9pU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iKBFnBb1fRJTcVU4l7yow6/7HP2+0EtOSj0D95CnS5eUpECxKSoxjIpB3fxe+cOAC
	 fj1v8btAgW5AQ7mGI1l6id/NeI/kfz3vvbiC1LDMHfBYyeMXy23PmgWDiM2PjnX1df
	 fTPK9KAomU2OF7iWAxFe/xJQdX6slYtviNTnTNHU=
Message-ID: <b720f20b-ff2f-4646-b263-8597fb3b342f@panix.com>
Date: Wed, 11 Dec 2024 15:26:37 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com,
 vicamo.yang@canonical.com, linux-pm@vger.kernel.org
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
 <1c6a9a8c-a6f-c884-7d58-5c713b1d77d7@panix.com>
 <CAAd53p70Hkv6vaim0HOncSQGBPO83f4QOGLE869T+4WKWdLjBw@mail.gmail.com>
 <0481ec61-3a57-4b4b-a0d8-b8b523af3f17@panix.com>
 <CAAd53p7NpwK11AyMtAOiFxAEJ8Ho=V=93gwje_2j=h3a=L5G9Q@mail.gmail.com>
 <bff3e11e-7b60-4e23-933a-3e84fd82aabc@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <bff3e11e-7b60-4e23-933a-3e84fd82aabc@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


So we're on 6.13-rc2 and the patches are getting closer and closer, but 
they still need to be manually added.

The good news is now only (variants of) "PCI/ASPM: Enable LTR for 
endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links under VMD 
domain" are needed.

Any new news on getting those upstreamed?

But I was curious as why I wasn't seeing the "enable LTR for nvme behind 
vmd" message on bootup, and looking at it further it looks like my BIOS 
already sets the "PCI_LTR_MAX_SNOOP_LAT" and "PCI_LTR_MAX_NOSNOOP_LAT" 
values to the ones the patch does, so I'm submitting a modified patch 
that lets you know if it's already been set (via BIOS or elsewhere).

It's not a "real" patch format (I'm running it but haven't committed it 
yet) but I think you should get the gist of what it's doing:

----
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c5145e74df73..cdb9f34eb67d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6336,11 +6336,13 @@ static void pci_fixup_enable_aspm(struct pci_dev 
*pdev)
  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  			       PCI_CLASS_BRIDGE_PCI, 8, pci_fixup_enable_aspm);

+#define LTR_LATENCY_300US	(0x1003) /* 3145728ns, i.e. 0x300000ns */
+
  static void pci_fixup_enable_vmd_nvme_ltr(struct pci_dev *pdev)
  {
  	struct pci_dev *parent;
-	int pos;
-	u16 val;
+	int pos, ret;
+	u16 val_sn, val_ns;

  	parent = pci_upstream_bridge(pdev);
  	if (!parent)
@@ -6353,18 +6355,21 @@ static void pci_fixup_enable_vmd_nvme_ltr(struct 
pci_dev *pdev)
  	if (!pos)
  		return;

-	pci_read_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &val);
-	if (val)
+	ret = pci_read_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &val_sn);
+	if (ret || (val_sn && (val_sn != LTR_LATENCY_300US)))
  		return;

-	pci_read_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, &val);
-	if (val)
+	ret = pci_read_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, &val_ns);
+	if (ret || (val_ns && (val_ns != LTR_LATENCY_300US)))
  		return;

-	/* 3145728ns, i.e. 0x300000ns */
-	pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
-	pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
-	pci_info(pdev, "enable LTR for nvme behind vmd");
+	if (!val_sn && !val_ns) {
+		ret = pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 
LTR_LATENCY_300US);
+		ret = pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 
LTR_LATENCY_300US);
+		pci_info(pdev, "enable LTR for nvme behind vmd");
+	} else {
+		pci_info(pdev, "LTR for nvme behind vmd enabled via BIOS");
+	}
  }
  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
  			      PCI_CLASS_STORAGE_EXPRESS, 0, pci_fixup_enable_vmd_nvme_ltr);
----

On 7/17/24 16:46, Kenneth Crudup wrote:
> 
> Seems to be working OK, I do think running power states seem to be 
> spending more time in pc10/cpuLPI/SysLPI, but that's just seat-of-the- 
> pants though.
> 
> While-suspended battery drain seems about the same, however:
> 
> ----
> [E130] 518 /home/kenny> cat /tmp/battery-levels
> suspend-in:  Wed, 17 Jul 2024 09:33:33 -0700
> /sys/power/wakeup_count:46
> /sys/power/suspend_stats/success:0
> /sys/class/power_supply/BAT0/charge_full:3882000
> /sys/class/power_supply/BAT0/capacity:100
> /sys/class/power_supply/BAT0/voltage_now:12856000
> /sys/class/power_supply/BAT0/status:Full
> /sys/class/power_supply/BAT0/capacity_level:Full
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:0
> /sys/kernel/debug/pmc_core/slp_s0_residency_usec:0
> ----------
> suspend-out: Wed, 17 Jul 2024 16:38:37 -0700
> /sys/kernel/debug/pmc_core/slp_s0_residency_usec:0
> /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us:0
> /sys/class/power_supply/BAT0/charge_full:3882000
> /sys/class/power_supply/BAT0/capacity:89
> /sys/class/power_supply/BAT0/voltage_now:12206000
> /sys/class/power_supply/BAT0/status:Discharging
> /sys/class/power_supply/BAT0/capacity_level:Normal
> /sys/power/suspend_stats/success:1
> /sys/power/wakeup_count:52
> ==================================================
> 
> [17/16:44:11 kenny@xps-9320]
> ----
> 
> On 7/16/24 18:59, Kai-Heng Feng wrote:
>> Hi Kenneth,
>>
>> On Tue, Jul 16, 2024 at 2:27 AM Kenneth Crudup <kenny@panix.com> wrote:
>>>
>>>
>>> No joy yet for 6.10, so here's my patches, maybe it'll save someone some
>>> time (they're pretty much the same as 6.9) .
>>>
>>> Fingers crossed for 6.11!
>>
>> I forgot to Cc you when I sent the patch [0].
>>
>> It will be great if you can test it out.
>>
>> [0] https://lore.kernel.org/linux-pci/20240530085227.91168-1- 
>> kai.heng.feng@canonical.com/
>>
>> Kai-Heng
>>
>>>
>>> -Kenny
>>>
>>> On 3/21/24 03:12, Kai-Heng Feng wrote:
>>>> Hi Kenneth,
>>>>
>>>> On Tue, Mar 12, 2024 at 10:37 AM Kenneth R. Crudup <kenny@panix.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>> On Sat, 4 Nov 2023, Kenneth R. Crudup wrote:
>>>>>
>>>>>> The only release kernel that was able to get this laptop to fully 
>>>>>> get into
>>>>>> low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... 
>>>>>> series from Ubuntu
>>>>>
>>>>>> I'd bisected it to the following commits:
>>>>>> 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for 
>>>>>> suspend/resume
>>>>>> 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register 
>>>>>> programming
>>>>>> 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under 
>>>>>> VMD domain
>>>>>> 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints 
>>>>>> behind VMD
>>>>>> 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name 
>>>>>> instead
>>>>>
>>>>> Since (for what I'm sure is a good reason ... I hope :) ) this has 
>>>>> yet to make
>>>>> it into mainline, here's the set of commits refactored for v6.8; 
>>>>> maybe someone
>>>>> scanning the archives for a solution to their Dell draining too 
>>>>> much power can
>>>>> use them.
>>>>>
>>>>> But is there anything I can do to help these go in? I saw that 
>>>>> "Refactor L1
>>>>> PM Substates Control Register programming" is still reverted, is 
>>>>> that still
>>>>> an issue on the machine it affected?
>>>>
>>>> Let me work on this.
>>>>
>>>> I think both VMD and Thunderbolt devices need ASPM enabled by default
>>>> regardless of BIOS setting, but I am not sure if PCI folks will like
>>>> the idea.
>>>>
>>>> Kai-Heng
>>>>
>>>>>
>>>>>           -Kenny
>>>>>
>>>>> -- 
>>>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, 
>>>>> Orange County CA
>>>>
>>>
>>> -- 
>>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
>>> County CA
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


