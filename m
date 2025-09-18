Return-Path: <linux-pm+bounces-35001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17152B86FDA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208E3621E79
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7315226173;
	Thu, 18 Sep 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3yzNnN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F413B2A4;
	Thu, 18 Sep 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229285; cv=none; b=l2cAHRMu9dFnSS6NGEqcii3hj0WOya0Y9aJtHZ1ROMgWvN+tKNqf8dYWSZi+3NsHtjB6md/0zlE6Mv+LBitXC4lL6TNJ8iFujMaX1Tr4O+rXNRd0tShNPwEYuGPtN6cyKM2efWXzByCx4+BGk3WwULMqoYYQO4oFJCah8oFPryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229285; c=relaxed/simple;
	bh=3Fr5cTyASEnRYfVPbwcbcj3QYtupddmi9rlAva9j1/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJLZ6DmacQ0pL1bjL0FnQi9SEFH9pDuWtw/HlOdTuupAQlyidSWXPQFqsCrkfFkoG8v1Pfqc+W83tZ8Z6Tx+5ElwX0TEDJlRvRpvtbIkkNPAzwv5Z8tZxRuXobeg1u2NkBCB6RhrCHdB1LWCNRo0wkm9/h6JHA0u11klDzQqi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3yzNnN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F198C4CEE7;
	Thu, 18 Sep 2025 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229285;
	bh=3Fr5cTyASEnRYfVPbwcbcj3QYtupddmi9rlAva9j1/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g3yzNnN5lyv+G8ndwvOiP7abAJ2qbeVjngy19oeVEbaS1EPhdFX1+J8oc3SAL5KEm
	 q/yc5zbrKD9ptopC5+nO2Ia3+pfOGv0JOnUwItX6FtYre0jYsAouU94zQhs1JXFKWR
	 JHwnxpi16LkED3mC2xtbnibzEh5GOtYrph+SZEDR7E4lM5akqPD+v3Zr9uPz3YN2ih
	 cOGydhOJCK7dvPeYWo2ZFrEY4lt5M10851MtxzDowX2mtlKB0VTzqHeBAU5+Szo+xY
	 ke6VvHvyYFTVPuoPQ1Gt4IeQdtu/fR3MoKf06RPou2vO+A0+6siaNBrrOmW4Dmgmic
	 9MCQWBmA2WHUw==
Message-ID: <e36f6832-16e3-4aac-a1b9-02b51ab11e2a@kernel.org>
Date: Thu, 18 Sep 2025 16:01:21 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20250918195509.GA1918371@bhelgaas>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250918195509.GA1918371@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/2025 2:55 PM, Bjorn Helgaas wrote:
> On Wed, Sep 17, 2025 at 10:44:27PM -0500, Mario Limonciello (AMD) wrote:
>> suspend_common() passes the a PM message indicating what type of event
>> is occurring.  Add a new callback hcd_pci_poweroff() which will
>> determine if target state is power off and pass PMSG_POWEROFF as the
>> message.
> 
> Something is missing in "passes the a".

A wild 'a' appeared.
> 
>> There are no functional changes in this patch.
> 
> Maybe so, but the .poweroff() path previously called
> "suspend_common(dev, PMSG_SUSPEND)" and now may call
> "suspend_common(dev, PMSG_POWEROFF)", so it's not completely obvious
> that this is a functional no-op.
> 
> It seems sort of weird that apparently we can call .poweroff() for
> either a "suspend" or a "power-off" event.
> 

It's actually either a hibernate or a power off event.  The nomenclature 
can be a bit confusing.

I'll add a comment to the top of the function to explain it.

> Maybe it would be helpful to explain how we get to .poweroff() when
> system_state is something other than SYSTEM_POWER_OFF, and what that
> means?

Well right now it's not a possible path, but per Rafael's guidance of 
splitting the series into 3 parts across 3 cycles the path that leads 
here won't exist for a while.  It was just plumbing.

I'll adjust the commit message to allude to the future.

> 
>> +static int hcd_pci_poweroff(struct device *dev)
>> +{
>> +	if (system_state == SYSTEM_POWER_OFF)
>> +		return suspend_common(dev, PMSG_POWEROFF);
>> +	return suspend_common(dev, PMSG_SUSPEND);
>> +}
>> +
>>   static int hcd_pci_suspend_noirq(struct device *dev)
>>   {
>>   	struct pci_dev		*pci_dev = to_pci_dev(dev);
>> @@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
>>   #define hcd_pci_suspend		NULL
>>   #define hcd_pci_freeze			NULL
>>   #define hcd_pci_suspend_noirq	NULL
>> +#define hcd_pci_poweroff	NULL
>>   #define hcd_pci_poweroff_late	NULL
>>   #define hcd_pci_resume_noirq	NULL
>>   #define hcd_pci_resume		NULL
>> @@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>>   	.freeze_noirq	= check_root_hub_suspended,
>>   	.thaw_noirq	= NULL,
>>   	.thaw		= hcd_pci_resume,
>> -	.poweroff	= hcd_pci_suspend,
>> +	.poweroff	= hcd_pci_poweroff,
>>   	.poweroff_late	= hcd_pci_poweroff_late,
>>   	.poweroff_noirq	= hcd_pci_suspend_noirq,
>>   	.restore_noirq	= hcd_pci_resume_noirq,
>> -- 
>> 2.51.0
>>


