Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EEE3C615
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391399AbfFKIjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 04:39:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41530 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfFKIjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 04:39:51 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hacJp-0004W7-10
        for linux-pm@vger.kernel.org; Tue, 11 Jun 2019 08:39:49 +0000
Received: by mail-pl1-f199.google.com with SMTP id 91so7360598pla.7
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 01:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rVsUekWgO9PjOQAYkWEsmmAT3npgK55j5LYcU+/1NsI=;
        b=ge7QcQCpAtyToTfWjfKuTUKatlyIcVnCTANnQvJCMKPAtqyYnJ/ANjwFnRaOknKeKT
         0t+M0TGiZpAlypWbJzrs8Mq1F5tnhKRwVAi2jaxAf7ER2S0pjFkVigpffj9l5y1i6XsQ
         uUdQyzWeDlGlaBlubX+NflZKQv0MjH7aPtxIQoMZffjMGSPW6POFXM1K465Wqeq3VGqM
         yGzBDewLcZUjrpved98MySdDwf2IeLFp0+lv1VjKpTf70Nz/QGD1RmJaGQ8/CJSgJkBk
         mk4/bhik8NJk/s+B071MxKAEVJkE7LxZn/YO36g7/bM9yJ1X0d4AlPYYv5r/txDF2MBq
         vqig==
X-Gm-Message-State: APjAAAXs4QMHV7a5O+eBy3zpv+yTsCspStm29cHUcQoYF/EfZqEuCJ1N
        4mEQkxTNXmVzTkjGxBp+/mENa4wqNcYQ1BKqFVUwPix4hl97HAdbyVXjniOgWpCpNyiW5eLlVL9
        fRbeJeoMisR0lHuY904YI+rYZeGUcc3Ghe3rI
X-Received: by 2002:a65:4209:: with SMTP id c9mr19842585pgq.111.1560242387639;
        Tue, 11 Jun 2019 01:39:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzuYF3piJnyOda/rKez83uueSPcHG0dOaccY61HirK/Mbwuke30Y6uhXpd7ba0xGBMR7UtJkw==
X-Received: by 2002:a65:4209:: with SMTP id c9mr19842567pgq.111.1560242387238;
        Tue, 11 Jun 2019 01:39:47 -0700 (PDT)
Received: from 2001-b011-380f-115a-95b8-0536-80ef-496a.dynamic-ip6.hinet.net (2001-b011-380f-115a-95b8-0536-80ef-496a.dynamic-ip6.hinet.net. [2001:b011:380f:115a:95b8:536:80ef:496a])
        by smtp.gmail.com with ESMTPSA id b7sm12905627pgq.71.2019.06.11.01.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:39:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <10983642.dUqMSvAAlD@kreacher>
Date:   Tue, 11 Jun 2019 16:39:44 +0800
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <527F9B70-68AC-4CD4-A3C2-576EA09187DD@canonical.com>
References: <2315917.ZGeXE6pBFC@kreacher> <10983642.dUqMSvAAlD@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

at 19:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Friday, May 17, 2019 11:08:50 AM CEST Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> If a PCI driver leaves the device handled by it in D0 and calls
>> pci_save_state() on the device in its ->suspend() or ->suspend_late()
>> callback, it can expect the device to stay in D0 over the whole
>> s2idle cycle.  However, that may not be the case if there is a
>> spurious wakeup while the system is suspended, because in that case
>> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
>> which calls pci_restore_state(), via pci_pm_default_resume_early(),
>> so state_saved is cleared and the second iteration of
>> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
>> may change the power state of the device.
>>
>> To avoid that, add a new internal flag, skip_bus_pm, that will be set
>> by pci_pm_suspend_noirq() when it runs for the first time during the
>> given system suspend-resume cycle if the state of the device has
>> been saved already and the device is still in D0.  Setting that flag
>> will cause the next iterations of pci_pm_suspend_noirq() to set
>> state_saved for pci_pm_resume_noirq(), so that it always restores the
>> device state from the originally saved data, and avoid calling
>> pci_prepare_to_sleep() for the device.
>>
>> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from  
>> suspend-to-idle")
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I just found out this patch has a chance to freeze or reboot the system  
during suspend cycles.
What information do you need to debug?

Kai-Heng

>> ---
>>  drivers/pci/pci-driver.c |   17 ++++++++++++++++-
>>  include/linux/pci.h      |    1 +
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/pci/pci-driver.c
>> ===================================================================
>> --- linux-pm.orig/drivers/pci/pci-driver.c
>> +++ linux-pm/drivers/pci/pci-driver.c
>> @@ -734,6 +734,8 @@ static int pci_pm_suspend(struct device
>>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>
>> +	pci_dev->skip_bus_pm = false;
>> +
>>  	if (pci_has_legacy_pm_support(pci_dev))
>>  		return pci_legacy_suspend(dev, PMSG_SUSPEND);
>>
>> @@ -827,7 +829,20 @@ static int pci_pm_suspend_noirq(struct d
>>  		}
>>  	}
>>
>> -	if (!pci_dev->state_saved) {
>> +	if (pci_dev->skip_bus_pm) {
>> +		/*
>> +		 * The function is running for the second time in a row without
>> +		 * going through full resume, which is possible only during
>> +		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
>> +		 * device was originally left in D0, so its power state should
>> +		 * not be changed here and the device register values saved
>> +		 * originally should be restored on resume again.
>> +		 */
>> +		pci_dev->state_saved = true;
>> +	} else if (pci_dev->state_saved) {
>> +		if (pci_dev->current_state == PCI_D0)
>> +			pci_dev->skip_bus_pm = true;
>> +	} else {
>>  		pci_save_state(pci_dev);
>>  		if (pci_power_manageable(pci_dev))
>>  			pci_prepare_to_sleep(pci_dev);
>> Index: linux-pm/include/linux/pci.h
>> ===================================================================
>> --- linux-pm.orig/include/linux/pci.h
>> +++ linux-pm/include/linux/pci.h
>> @@ -344,6 +344,7 @@ struct pci_dev {
>>  						   D3cold, not set for devices
>>  						   powered on/off by the
>>  						   corresponding bridge */
>> +	unsigned int	skip_bus_pm:1;	/* Internal: Skip bus-level PM */
>>  	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
>>  	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
>>  						      controlled exclusively by
>
> Bjorn, I've assumed no concerns or objections from you regarding this one  
> and
> queued it up.
>
> If that assumption is incorrect, please let me know.


