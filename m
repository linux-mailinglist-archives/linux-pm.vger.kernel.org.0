Return-Path: <linux-pm+bounces-18843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2913B9E9CB1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189D4165FC5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033CA14A60F;
	Mon,  9 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKNHG60J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA213AA2F;
	Mon,  9 Dec 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764311; cv=none; b=okcIeRyWIvJ1sig6eHiyRUDULCrvAN+5MU2OeoQuKeGqNAcbW/ExnqDz6Lf53eIcTI+4KsHk8M0Hxarkv7aqaifgnAVZFKBOkovx+cug5QIHMkeYi6TvReQUOncDIWTPxvubbk5gtyo7j6n5K+uEUXK3HeLVvw2nj+KEBihMMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764311; c=relaxed/simple;
	bh=V1IRcBKz+2MDX3a2wbdxLqvqdh2IYyh5G7XBYuuSfLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/AMynYQq5qYC5qFSLrFaytAbILkKU4pvf31iVqMgWowiQuA9rHqrdljPjCljgOSyL4LHaywIbZB7bEZOiDN6l13Yvvx/BmSpDu1PPRDKOHWVimyDY7srj5vh3qdl28P3+/mUzDNc9OUOse7EP2+B+vb4/C+3vOHWyKSaOls3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKNHG60J; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733764310; x=1765300310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1IRcBKz+2MDX3a2wbdxLqvqdh2IYyh5G7XBYuuSfLY=;
  b=SKNHG60J4qkKbhDrQNhOzVz27eAYpF/rTuh9QG27phsgSWwOw3IGiAUj
   wACnwlV8uhplpfP0Xff54KL/S8kO+8cj/xLri7IJTgEvCTikRbP6o/en1
   QnXLxCZcsYLstTSZWAG0PkGdHD09u5qhFue+kujPXrmCd3w02fqgiFMs6
   eSgb2lBPpVAItJDQ6xVzgIYfUL4l9VpYeHr02QtO2vPJkiHrGhNhPzT7x
   hK1s7d24S/KWHL4f9uDGP+7CZghe/hmJ4nLjr33Q5mxnxGBY7mTLAGTfK
   j0dIRZxh/VnQifIiH36D+qF3TcuEaF0qOT/NsbdFQXRpLfag+qAGj+UGx
   A==;
X-CSE-ConnectionGUID: y94XWhsVS4G6EH9zuZIKPA==
X-CSE-MsgGUID: pfRTDk/PQHe8uFhdbXKwKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44753537"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44753537"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 09:11:49 -0800
X-CSE-ConnectionGUID: TajxL1saTNujHZuZO6NrXA==
X-CSE-MsgGUID: FonTT+X8STypXpMdREj3wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="99607066"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 09:11:47 -0800
Message-ID: <4ee01e24-176e-46ac-9ecd-a0976490cbdc@intel.com>
Date: Mon, 9 Dec 2024 19:11:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for
 exporting PM functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
 <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
 <Z1ccjxyxO0NMNbkm@smile.fi.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Z1ccjxyxO0NMNbkm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 18:36, Andy Shevchenko wrote:
> On Mon, Dec 09, 2024 at 12:38:59PM +0200, Adrian Hunter wrote:
>> On 1/11/24 12:11, Andy Shevchenko wrote:
>>> Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
>>> for exporting PM functions. This helps cleaning up the other
>>> SDHCI drivers in the future.
>>
>> It seems sdhci is the first code in the kernel to use
>> EXPORT_PM_FN_NS_GPL() but it was not asked for ;-)
>>
>> As such, can you fill in a little background.  I am not
>> sure what it achieves.  Why have CONFIG_PM if not to
>> #ifdef dependent code behind it?
> 
> It makes sure that the code elimination happens at compile time and

Does it eliminate the code?  Maybe I am missing something,
but it looks like it is still there:

$ grep CONFIG_PM .config
# CONFIG_PM is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_PMBUS is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PM_DEVFREQ=y
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_PM_OPP=y
$ objdump -d drivers/mmc/host/sdhci.ko | grep sdhci_suspend_host
00000000000089f0 <__pfx_sdhci_suspend_host>:
0000000000008a00 <sdhci_suspend_host>:
    8a16:       e8 00 00 00 00          call   8a1b <sdhci_suspend_host+0x1b>
    8a29:       74 0c                   je     8a37 <sdhci_suspend_host+0x37>
    8a35:       75 54                   jne    8a8b <sdhci_suspend_host+0x8b>
    8a4c:       0f 85 06 01 00 00       jne    8b58 <sdhci_suspend_host+0x158>
    8a66:       0f 85 00 01 00 00       jne    8b6c <sdhci_suspend_host+0x16c>
    8a7b:       e8 00 00 00 00          call   8a80 <sdhci_suspend_host+0x80>
    8a86:       e9 00 00 00 00          jmp    8a8b <sdhci_suspend_host+0x8b>
    8a92:       75 0a                   jne    8a9e <sdhci_suspend_host+0x9e>
    8a98:       0f 84 87 00 00 00       je     8b25 <sdhci_suspend_host+0x125>
    8aa5:       74 90                   je     8a37 <sdhci_suspend_host+0x37>
    8ab8:       0f 85 f5 00 00 00       jne    8bb3 <sdhci_suspend_host+0x1b3>
    8ad8:       0f 85 c0 00 00 00       jne    8b9e <sdhci_suspend_host+0x19e>
    8af0:       0f 85 93 00 00 00       jne    8b89 <sdhci_suspend_host+0x189>
    8b06:       e8 00 00 00 00          call   8b0b <sdhci_suspend_host+0x10b>
    8b14:       0f 85 1d ff ff ff       jne    8a37 <sdhci_suspend_host+0x37>
    8b20:       e9 00 00 00 00          jmp    8b25 <sdhci_suspend_host+0x125>
    8b25:       e8 00 00 00 00          call   8b2a <sdhci_suspend_host+0x12a>
    8b2c:       75 52                   jne    8b80 <sdhci_suspend_host+0x180>
    8b53:       e9 55 ff ff ff          jmp    8aad <sdhci_suspend_host+0xad>
    8b62:       e8 00 00 00 00          call   8b67 <sdhci_suspend_host+0x167>
    8b67:       e9 ef fe ff ff          jmp    8a5b <sdhci_suspend_host+0x5b>
    8b76:       e8 00 00 00 00          call   8b7b <sdhci_suspend_host+0x17b>
    8b7b:       e9 f5 fe ff ff          jmp    8a75 <sdhci_suspend_host+0x75>
    8b84:       e9 15 ff ff ff          jmp    8a9e <sdhci_suspend_host+0x9e>
    8b94:       e8 00 00 00 00          call   8b99 <sdhci_suspend_host+0x199>
    8b99:       e9 60 ff ff ff          jmp    8afe <sdhci_suspend_host+0xfe>
    8ba9:       e8 00 00 00 00          call   8bae <sdhci_suspend_host+0x1ae>
    8bae:       e9 32 ff ff ff          jmp    8ae5 <sdhci_suspend_host+0xe5>
    8bbb:       e8 00 00 00 00          call   8bc0 <sdhci_suspend_host+0x1c0>
    8bc0:       e9 03 ff ff ff          jmp    8ac8 <sdhci_suspend_host+0xc8>
$ 

> at the same time gives developer less uglified (by ifdeffery) code.
> It means there is less risk to miss anything of that which make become
> a compile-time warning of unused function, or even issues during linking
> with modules, etc.
> 
> Should I update a commit message with that?


