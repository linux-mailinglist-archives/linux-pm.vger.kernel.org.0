Return-Path: <linux-pm+bounces-19158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D09EFFCF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846CD168310
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382821B07AE;
	Thu, 12 Dec 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="UHgjM1jz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDC1E493
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044700; cv=none; b=rVhHqWc+I47PVqmQota3usvpSbYaPPnzQLA4i/NigEv+hZcMoD1niB6TmYiSEmF7Wdhufi+9nxg0bsDZZlIkXB3hQX7ThgqZGj+jlpTcit1t9bJb6ORvyv2qtGYmug0Vies9q0bSVyhGtxylORAmVu15IW1hIry4O3BH3DbOV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044700; c=relaxed/simple;
	bh=EcTQEaTJ/hj/TMjEm6C8LdIB5E3HARudR2bWrVD9oIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrkFSvDXbxQkoeTHoA7kJ1k8X62LuAV7ctSA+AexoMWCvf/LN1YnPlVPn862cMmvKOscnZIPpbxgutBCCBIGAeA6Zy6cmODSlq4ecKj2M6fPR19aAd7f2T0e/NG8rRqVRnPZj0mklfDzDFUHHabwBnk8zua5NscX2qbYCsc7NUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=UHgjM1jz; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y8SjL6gSJz4kF1;
	Thu, 12 Dec 2024 18:04:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734044695; bh=EcTQEaTJ/hj/TMjEm6C8LdIB5E3HARudR2bWrVD9oIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UHgjM1jzl7dUV7fGLWQLt6284xmG09zG/S91nPxtQXkuMRmrhokcalLxOzieJRODM
	 JawP8sDWugp6y0bUpm864Nh5hSGGodXqBBgNtm2rVA2ki5UtpiXLgJlSWJsMnGhGKn
	 +V23jkCLkko6UuS50pjeutAXa0b0Vxgy+mqb9gJ8=
Message-ID: <402b2e32-3b54-4e80-92fd-9237549ffa14@panix.com>
Date: Thu, 12 Dec 2024 15:04:53 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, vidyas@nvidia.com,
 bhelgaas@google.com, andrea.righi@canonical.com, vicamo.yang@canonical.com,
 linux-pm@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
References: <20241212205612.GA3368300@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20241212205612.GA3368300@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/24 12:56, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>
>> So we're on 6.13-rc2 and the patches are getting closer and closer, but they
>> still need to be manually added.
>>
>> The good news is now only (variants of) "PCI/ASPM: Enable LTR for endpoints
>> behind VMD" and "PCI/ASPM: Enable ASPM for links under VMD domain" are
>> needed.
> 
> Do you have lore links for these handy?  I'm not sure exactly what to
> look at.
> 
> https://lore.kernel.org/linux-pci/?q=s%3A%22Enable+LTR+for+endpoints+behind+VMD%22
> didn't find anything.
> 
> https://lore.kernel.org/linux-pci/?q=s%3A%22Enable+ASPM+for+links+under+VMD+domain%22
> found
> https://lore.kernel.org/linux-pci/20200821123222.32093-1-kai.heng.feng@canonical.com/t/#u,
> but it's four years old.
> 

----
On Mon, 6 Nov 2023, Bjorn Helgaas wrote:

 > > I'd bisected it to the following commits (in this order):
 > > 4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for 
suspend/resume
 > > 5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register 
programming
 > > 1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under 
VMD domain
 > > 47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints 
behind VMD
 > > 154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name 
instead

 > Thanks for these.  You don't happen to have URLs for those Ubuntu
 > commits, do you?

https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c
878b5526
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297a
ebbb8679
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4e
db550981
----

-Kenny


-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


