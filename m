Return-Path: <linux-pm+bounces-37321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E967BC2E013
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 21:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DC51893213
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2329D27F;
	Mon,  3 Nov 2025 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj+7SW3P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA6238C1B;
	Mon,  3 Nov 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200639; cv=none; b=d5BqmQ2bPQ+6o2uvad+60z1V3yfVQhndkuxJxq8Sx2W4bnj42Ek04wG3h7h0WQNluTQsqfgQYUrvHMlc6Mjabh57Dxa1j4qZbeoQBAG2zeFshpWi69VX6fjMEJZV06DI+6R3BIPy/jRRHxc7GoWwj6asTQv5GHJsLI+DnhNtrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200639; c=relaxed/simple;
	bh=A5dQOFvhbgqWL3OuKBz+EdvXGKAJA3XEFjMsllbNXp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5Rxwv+BUVqO1UJTPAzeFF3vrUcxeCuQbGRfjYpjtKhd3q034lX3gRqU0wzLF5bPGR81WvkRxdkSZmsLk6/1vYW2N01Ezcs3OPp9lrB8OfQ+jka3V/XWPmR2kdV9zniMyppxeUv/y3brPdiqHX0NDNtmrW44V16LETcu5QOS4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj+7SW3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F03C4CEE7;
	Mon,  3 Nov 2025 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762200638;
	bh=A5dQOFvhbgqWL3OuKBz+EdvXGKAJA3XEFjMsllbNXp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gj+7SW3PAdFMQAJPwdv0kjmp8LGvjGEtcWdgkWXYl4x29xPhjXF2QDcreEJVRMOQg
	 nmChkdCh3LVX1UXOK/pDoR1P7j3a0duKwYATYK/SnBZOyG3iVl/7ICUlE/+vASbREd
	 RkyGs1/QKJpO/QLEDFNjC7KUzx7Xi8IXqpJruz5nyajvjeiTI87Y6L5Xnz6ERzd7zY
	 5vzpRGfQf47M+aJfML3UQciG2I6QM29sE40AyWUxkE9T9lTyOi2MLKiPJdxh68jfLV
	 FYNIHnWUGgiBkgkmDt+83jIDzIrBuFi5cQwcJoaGMrypHI57wU7v1lumdqS/EEX/+p
	 L9V//e54CtB7g==
Message-ID: <06cd1b43-e765-4597-9f61-5058c8a13425@kernel.org>
Date: Mon, 3 Nov 2025 14:10:34 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251026050905.764203-1-superm1@kernel.org>
 <20251026050905.764203-5-superm1@kernel.org>
 <CAJZ5v0hXR5wb5chsqT1Vu5i5ucneeGpbRDEU9TPVxZVCAfuiow@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0hXR5wb5chsqT1Vu5i5ucneeGpbRDEU9TPVxZVCAfuiow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/3/2025 2:09 PM, Rafael J. Wysocki wrote:
> On Sun, Oct 26, 2025 at 6:09 AM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> suspend_common() passes a PM message indicating what type of event
>> is occurring.  PMSG_POWEROFF is intended to be used when hibernate
>> callbacks were utilized for turning off the system.
>>
>> Add a new callback hcd_pci_poweroff() which will
>> determine if target state is power off and pass PMSG_POWEROFF as the
>> message.
>>
>> suspend_common() doesn't do any special handling with this case at
>> the moment, so there are no functional changes in this patch.
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v9:
>>   * Reword commit message (Bjorn)
>> v8:
>>   * Drop SYSTEM_HALT case
>> v7:
>>   * Reword commit mesasge
>> v6:
>>   * Fix LKP robot issue without CONFIG_PM_SLEEP
>> v5:
>>   * New patch
>> v4:
>>   * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
>> ---
>>   drivers/usb/core/hcd-pci.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>> index cd223475917ef..959baccfb07d1 100644
>> --- a/drivers/usb/core/hcd-pci.c
>> +++ b/drivers/usb/core/hcd-pci.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/pm.h>
>>   #include <linux/usb.h>
>>   #include <linux/usb/hcd.h>
>>
>> @@ -531,6 +532,13 @@ static int hcd_pci_freeze(struct device *dev)
>>          return suspend_common(dev, PMSG_FREEZE);
>>   }
>>
>> +static int hcd_pci_poweroff(struct device *dev)
>> +{
>> +       if (system_state == SYSTEM_POWER_OFF)
>> +               return suspend_common(dev, PMSG_POWEROFF);
>> +       return suspend_common(dev, PMSG_SUSPEND);
>> +}
>> +
>>   static int hcd_pci_suspend_noirq(struct device *dev)
>>   {
>>          struct pci_dev          *pci_dev = to_pci_dev(dev);
>> @@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
>>   #define hcd_pci_suspend                NULL
>>   #define hcd_pci_freeze                 NULL
>>   #define hcd_pci_suspend_noirq  NULL
>> +#define hcd_pci_poweroff       NULL
>>   #define hcd_pci_poweroff_late  NULL
>>   #define hcd_pci_resume_noirq   NULL
>>   #define hcd_pci_resume         NULL
>> @@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>>          .freeze_noirq   = check_root_hub_suspended,
>>          .thaw_noirq     = NULL,
>>          .thaw           = hcd_pci_resume,
>> -       .poweroff       = hcd_pci_suspend,
>> +       .poweroff       = hcd_pci_poweroff,
>>          .poweroff_late  = hcd_pci_poweroff_late,
>>          .poweroff_noirq = hcd_pci_suspend_noirq,
>>          .restore_noirq  = hcd_pci_resume_noirq,
>> --
> 
> I would defer this patch until you know what exactly suspend_common()
> will do for PMSG_POWEROFF because it may just be simpler to check
> system_state == SYSTEM_POWER_OFF in it internally.

OK - in that case would you just take the first 3 for 6.19?

