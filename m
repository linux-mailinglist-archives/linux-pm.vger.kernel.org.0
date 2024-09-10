Return-Path: <linux-pm+bounces-13923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E29729D2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 08:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA35B23AA0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18817B421;
	Tue, 10 Sep 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6/Ms1Tp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFB17A58F;
	Tue, 10 Sep 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951324; cv=none; b=AGQWlXeE7/Q3wRWoHv9LodQW3xX0bz57/rNM0lpjWfzC0bFcIq7eWc0V86LwAzbvpjx1EIsKiodELadrE5kjVMWjGmXgli/Lr9xmE62E7ly4BWqqfa5wPCZcs8/ieyNZwgCtsD9W50+gsCT8byC0n2rp6OlPHQqHPP73u3xNMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951324; c=relaxed/simple;
	bh=yMoAZbAtekW3uQ9aQZGT09zkLaEwXK04c3IWeA/hNho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVEcLFXbVqL9EHyzhnOk5qxGBVjqSc0nlcMyyo33Vr9zjIizdFMeHcSM+TSeXiuRHT3Pmrs9I6OpdFXcFaAvmckFc5DX1uB7liFTdRo91rQt+Wwg87q9KZ79qjf+YzSKLyJRlZeVS1u12WSl/ihrIJPb3fqvy/bDR7PzdkvESok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6/Ms1Tp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725951323; x=1757487323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yMoAZbAtekW3uQ9aQZGT09zkLaEwXK04c3IWeA/hNho=;
  b=M6/Ms1Tpeqiv6ZU/cC3MpqWlrXbEYMbH+wgdyKalOCN5IHQX9P/4sTTc
   +n2fhMFaT5zco+lC9GE35y0ACvemyC782vAcXzm1hctvXB/AZyxKQSAqA
   nEb76krBKFlAalkV8OdldJwr1dJJ/bDn+63cDGtoRjEZmELE6ftEVNKYf
   3RflvnjA9yDXPq30jTAfqh68y8nBN6JMHS5TcMIglkb4FQIZ5bYmqna3U
   ZEr8BSa8RZhjb7yHt0mcKwpPmv0EJ2a0P1FBwItNHGwK/M5u+nfa0zuDM
   QBJIkoCLA3t2r6ngqI4MdlzJVUDWnC+v5HsVOYzXbG28JojhcXThvF+Gm
   g==;
X-CSE-ConnectionGUID: 5zc80YFWRAa2h72nEKxSpw==
X-CSE-MsgGUID: Y1wK980dTIKJSxZ1Fca5hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="50092352"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="50092352"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:55:22 -0700
X-CSE-ConnectionGUID: keHH/kEsTPWZFOAttb32ug==
X-CSE-MsgGUID: zWJzHy0zQDCmy99u2UV6wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71535305"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.67.115]) ([10.125.67.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:55:22 -0700
Message-ID: <18df4d28-1288-4d57-b5ff-6e2f608eddbf@linux.intel.com>
Date: Mon, 9 Sep 2024 23:55:21 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] platform/x86:intel/pmc: Move PMC devid to core.h
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
 <20240828222932.1279508-4-xi.pardee@linux.intel.com>
 <e7f3cb98-977e-b4fa-4631-9043873d6806@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <e7f3cb98-977e-b4fa-4631-9043873d6806@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/29/2024 3:52 AM, Ilpo Järvinen wrote:
> On Wed, 28 Aug 2024, Xi Pardee wrote:
>
>> Move PMC devid definition for each PMC of Arrow Lake and Meteor
>> Lake platforms to core.h. This patch is a preparation step to
>> introduce a new SSRAM Telemetry driver which will be using the
>> PMC devid.
>>
>> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/arl.c  |  9 +++------
>>   drivers/platform/x86/intel/pmc/core.h | 10 ++++++++++
>>   drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
>>   3 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
>> index e10527c4e3e0..870da98ceb41 100644
>> --- a/drivers/platform/x86/intel/pmc/arl.c
>> +++ b/drivers/platform/x86/intel/pmc/arl.c
>> @@ -650,23 +650,20 @@ const struct pmc_reg_map arl_pchs_reg_map = {
>>   	.etr3_offset = ETR3_OFFSET,
>>   };
>>   
>> -#define PMC_DEVID_SOCS 0xae7f
>> -#define PMC_DEVID_IOEP 0x7ecf
>> -#define PMC_DEVID_PCHS 0x7f27
>>   static struct pmc_info arl_pmc_info_list[] = {
>>   	{
>>   		.guid	= IOEP_LPM_REQ_GUID,
>> -		.devid	= PMC_DEVID_IOEP,
>> +		.devid	= PMC_DEVID_MTL_IOEP,
>>   		.map	= &mtl_ioep_reg_map,
>>   	},
>>   	{
>>   		.guid	= SOCS_LPM_REQ_GUID,
>> -		.devid	= PMC_DEVID_SOCS,
>> +		.devid	= PMC_DEVID_ARL_SOCS,
>>   		.map	= &arl_socs_reg_map,
>>   	},
>>   	{
>>   		.guid	= PCHS_LPM_REQ_GUID,
>> -		.devid	= PMC_DEVID_PCHS,
>> +		.devid	= PMC_DEVID_ARL_PCHS,
>>   		.map	= &arl_pchs_reg_map,
>>   	},
>>   	{}
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index 9a1cc01f31d9..6763e59180a4 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -290,6 +290,16 @@ enum ppfear_regs {
>>   #define LNL_PPFEAR_NUM_ENTRIES			12
>>   #define LNL_S0IX_BLOCKER_OFFSET			0x2004
>>   
>> +/* SSRAM PMC Device ID*/
> Missing space.
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


Will add a space in next version.

Thanks!

Xi

>

