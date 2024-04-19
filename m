Return-Path: <linux-pm+bounces-6716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E98AAE7A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 14:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3591C216CF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA31E867;
	Fri, 19 Apr 2024 12:31:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212B20300
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529875; cv=none; b=BDk0O5XF8irBXwT0wIu8Qe/yi1n91k2Q6p7USfAlSyOm2pODmPfAU1MzlRxK45CuElsT3T5L2d+nK8ADhrkEOCcObxiYbhg71PLSIqv2Vyc1L4RomBXxCEtWAFsbC61inzgtqFNRL8oLz1QyuEywaJqP+3lEb3OUyTDeDAlrb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529875; c=relaxed/simple;
	bh=O/SrvwnPSNSDMP5T2MMmgW12mV+NccNc4AqI53/GDfE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fUdJt5pUdRlamaPiHC797GRkB30NNPx5EdPUHJeT4jjtDvs9JecFLkWW0ACda2ZU/FBbrDyw1TE4lKXQBwYyrUre+lEe6AEQlvNM7t4Ue+Nu2nKtaXd4lEy1JxhjZhYjCCOuwLXFfCc8SQ3IOCUQ/20/9ELaqebE8dNzwLA3KR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D5B3961E5FE05;
	Fri, 19 Apr 2024 14:30:56 +0200 (CEST)
Message-ID: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
Date: Fri, 19 Apr 2024 14:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: linux-pm@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Warning `amd_pstate: the _CPC object is not present in SBIOS or ACPI
 disabled`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


On a Dell OptiPlex 5055 with AMD Ryzen 5 PRO 1500 Quad-Core Processor

     $ dmesg | grep -e "DMI:" -e "Linux version" -e microcode
     [    0.000000] Linux version 6.9.0-rc4.mx64.461-00045-g6c95a9f46024 
(x@holidayincambodia.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU 
Binutils) 2.41) #17 SMP PREEMPT_DYNAMIC Thu Apr 18 12:10:17 CEST 2024
     [    0.000000] DMI: Dell Inc. OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 
1.12.0 03/03/2024
     [    3.562349] microcode: Current revision: 0x08001137

even with the latest system firmware 1.12.0 [1], Linux warns:

     $ dmesg --level alert,crit,err,warn
     [    3.506197] amd_pstate: the _CPC object is not present in SBIOS 
or ACPI disabled
     [    5.152840] xfs filesystem being remounted at / supports 
timestamps until 2038-01-19 (0x7fffffff)
     [    5.340653] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC 
data block query control method not found
     [    7.891459] kfd kfd: amdgpu: VERDE  not supported in kfd
     [   12.032894] xfs filesystem being mounted at /amd/hypnotoad/0 
supports timestamps until 2038-01-19 (0x7fffffff)
     [   13.283545] NFSD: Unable to initialize client recovery tracking! 
(-110)

What can I do about the warning?


Kind regards,

Paul


[1]: 
https://dl.dell.com/FOLDER11328712M/1/OptiPlex_5055_Ryzen_CPU_1.12.0.exe

download with

     wget --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:52.0) 
Gecko/20100101 Firefox/52.0" 
https://dl.dell.com/FOLDER11328712M/1/OptiPlex_5055_Ryzen_CPU_1.12.0.exe

