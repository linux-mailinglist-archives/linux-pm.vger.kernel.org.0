Return-Path: <linux-pm+bounces-19217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8489F175C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 21:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1453D188C1CD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93E190696;
	Fri, 13 Dec 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="LRXiavRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46C18DF73;
	Fri, 13 Dec 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121636; cv=none; b=kjEp5qRcBh6QpPQDA9cL/A2BoOk5JN3e1UysUm/2+vbL8B3RoinEqZ8w6m9qzldZTD3g7baplnfVxFmGts6Au7XywJP2HbcViBSZnIE36Oj9mJ/xh3AKcn5IUg+7ZgTckPRoqKMba1yMnAtr8nrJodgdW+ej3tE4+PnIEvevyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121636; c=relaxed/simple;
	bh=FUaxiN2VCvv5ojjeS/+HFQazvavG2bTZGgDE8w6IKXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIYgHZ0a54d1ObSzAWrWjumZxaWZGiYg+kPg6WnBRo8MjaiiF8KvCtjtNfFalEIIndCmpqOPdJbUjIlxpc6uVwe1qZaJ/DiezwxRGuOvjp8SZC3M2/Z8n0+BRG2bpVVA0LfvTZbMrtSkqnKRPmrFmdvlv3EsS5S+GqEkUjM7NfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=LRXiavRf; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y918v1rj3z4fKx;
	Fri, 13 Dec 2024 15:27:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734121632; bh=FUaxiN2VCvv5ojjeS/+HFQazvavG2bTZGgDE8w6IKXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LRXiavRfFf223WKGEzD4ghja02upugNwvsTb4l1mSJz25fiMXnuOA3UuVmfG68aS3
	 JyFq+k1fzcLf9PojjtcK3IKSNGctnjgDOl1XklP1VwMw2uZNy7tjn7g2HORrmRaxtH
	 XSDTodQAAkufC+77k+kvAj1YuoC0VapIQNLNcZZw=
Message-ID: <ff7abb52-fb53-40ce-bef5-50540d6b9512@panix.com>
Date: Fri, 13 Dec 2024 12:27:10 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>, Me <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>
References: <20241213164335.GA3381091@bhelgaas>
 <66843f3e-e8f9-40e6-8f7e-a332ff386fe7@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <66843f3e-e8f9-40e6-8f7e-a332ff386fe7@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Turns out that my current VMD is already listed as "VMD_FEATS_CLIENT" 
after all:

----
         {PCI_VDEVICE(INTEL, 0x467f),
                 .driver_data = VMD_FEATS_CLIENT,},
----
0000:00:0e.0 0104: 8086:467f
         Subsystem: 1028:0af3
         Flags: bus master, fast devsel, latency 0, IOMMU group 9
         Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
         Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
         Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
         Capabilities: [80] MSI-X: Enable+ Count=19 Masked-
         Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 00
         Capabilities: [e0] Power Management version 3
         Kernel driver in use: vmd
----

I'm going to compare the commits you'd pointed out in master to what the 
working (Ubuntu) patches do and figure out where the disconnect is.

-K

On 12/13/24 11:48, Kenneth Crudup wrote:
> 
> I was really hopeful this would have handled it, but no joy.
> 
> I also tried dropping "PCI/ASPM: Enable LTR for endpoints behind VMD" 
> and "PCI/ASPM: Enable ASPM for links under VMD domain" each separately 
> on top of the below quirk patch to no avail.
> 
> The only thing that works is the aggregate patch I've added.
> 
>  > However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>  > VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>  > so I'd be surprised if VMD worked for those devices unless BIOS set
>  > up the VMD itself.
> 
> Yeah, my BIOS does- not sure if you'd missed it, but I'd rewritten 
> "Enable LTR for endpoints behind VMD" to print if the BIOS already does 
> that for you, and sent the patch here (since I wasn't seeing the message 
> printed when the fixup was being done and wanted to know why).
> 
> I'd REALLY like to get this into mainline, so if there's anything I can 
> do to help, LMK.
> 
> Thanks,
> -Kenny
> 
> 
> On 12/13/24 08:43, Bjorn Helgaas wrote:
>> [+cc David, Nirmal, linux-pci]
>>
>> On Thu, Dec 12, 2024 at 03:04:53PM -0800, Kenneth Crudup wrote:
>>> On 12/12/24 12:56, Bjorn Helgaas wrote:
>>>> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>>>> So we're on 6.13-rc2 and the patches are getting closer and
>>>>> closer, but they still need to be manually added.
>>>>>
>>>>> The good news is now only (variants of) "PCI/ASPM: Enable LTR
>>>>> for endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links
>>>>> under VMD domain" are needed.
>>> ...
>>
>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>> lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679
>>
>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind
>> VMD", which writes PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT
>> for PCI_CLASS_STORAGE_EXPRESS devices directly below VMDs with Device
>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>
>> This looks equivalent in spirit to upstream
>> https://git.kernel.org/linus/f492edb40b54 ("PCI: vmd: Add quirk to
>> configure PCIe ASPM and LTR"), which writes PCI_LTR_MAX_SNOOP_LAT and
>> PCI_LTR_MAX_NOSNOOP_LAT for any kind of device below VMDs tagged with
>> VMD_FEATS_CLIENT, which includes 0x467f, 0x4c3d, 0x7d0b, 0x9a0b,
>> 0xa77f, 0xad0b, 0xb06f, 0xb60b.
>>
>> However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>> VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>> so I'd be surprised if VMD worked for those devices unless BIOS set
>> up the VMD itself.
>>
>> Maybe David or Nirmal can comment on this?
>>
>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>> lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
>>
>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
>> domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
>> IDs 0x9a09 and 0xa0b0.
>>
>> This looks like it should also be handled by upstream f492edb40b54
>> ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
>> "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
>>
>> But again, the Device IDs mentioned in the Ubuntu commit are NOT
>> included in the upstream VMD_FEATS_CLIENT list.
>>
>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>> lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981
>>
>> This is "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
>> instead", which applies the quirk that writes PCI_LTR_MAX_SNOOP_LAT
>> and PCI_LTR_MAX_NOSNOOP_LAT for PCI_CLASS_STORAGE_EXPRESS devices
>> below any VMD claimed by the "vmd" driver, not just VMDs with Device
>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>
>> I think the only thing that's missing is that the upstream vmd_ids[]
>> needs to be updated with some new VMD Device IDs that are tagged with
>> VMD_FEATS_CLIENT.
>>
>> I don't know what the vmd_ids[] strategy is, but Kenneth, you might
>> try an upstream patch like the one below.  If that resolves the
>> standby/low-power issues, maybe David or Nirmal can figure out the
>> "right" way to do this.
>>
>> Bjorn
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 9d9596947350..4de7ff3bbf23 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -1109,6 +1109,12 @@ static const struct pci_device_id vmd_ids[] = {
>>                   .driver_data = VMD_FEATS_CLIENT,},
>>       {PCI_VDEVICE(INTEL, 0xb06f),
>>                   .driver_data = VMD_FEATS_CLIENT,},
>> +    {PCI_VDEVICE(INTEL, 0x9a09),
>> +                .driver_data = VMD_FEATS_CLIENT,},
>> +    {PCI_VDEVICE(INTEL, 0xa0b0),
>> +                .driver_data = VMD_FEATS_CLIENT,},
>> +    {PCI_VDEVICE(INTEL, 0xa0bc),
>> +                .driver_data = VMD_FEATS_CLIENT,},
>>       {0,}
>>   };
>>   MODULE_DEVICE_TABLE(pci, vmd_ids);
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


