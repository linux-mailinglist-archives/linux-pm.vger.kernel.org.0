Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7044596
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392720AbfFMQpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 12:45:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39089 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfFMGNf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 02:13:35 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hbIzN-0005Za-0K
        for linux-pm@vger.kernel.org; Thu, 13 Jun 2019 06:13:33 +0000
Received: by mail-pl1-f197.google.com with SMTP id q2so11286053plr.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2019 23:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xZMnfNxiIJQHgk6DTR2b96lSjKM+Cv557iMAiHl0otE=;
        b=RumxGnO7aptO1ak3YNXi4NUHD/uoAxKxRKZq6eDFPTg/2H0JbeRJMTk9gr5N/MvVVS
         NWDMDQ0eNxtFJ0sYD5kosTzhrwPdbbK4VSWvtT6XGnI5pOWOGdTl4EZpror8t+8d/8cq
         fkaeW/PqXLpzj0DqPXIjT9K0qCE+mJljhnL+pIVfLSTJPt2uP3c/f7uejgGRgqVN/eg6
         sdTpu3RELTGsVn6iLo/TavrxH69kWmWjjdCw9BOFp2X2/CIKVQNFsY2N1hf53WA2PuKP
         YViYEZ6lRo6nI1BJINbNNjCPNTBK6kOdf/blEqbxTymEvXzfLR0FKMlbWOeuYVJlOHpF
         xOOQ==
X-Gm-Message-State: APjAAAVCtxe3K2dFJRH8+e90Ry1c3LWqWzfXm4saJ6Y6zkQE8ALI97S/
        iRCZZm+qF1anLz/g7+UUtQZUPSQ7qIlwyGlGUtGt1HJwB3FykhW7c+qK0ghh87LTW5xeRaFzhkG
        yD13NpbJYxFpzCBMo7T6U6PZej4/CEoHh9pOp
X-Received: by 2002:aa7:9407:: with SMTP id x7mr48714682pfo.163.1560406411622;
        Wed, 12 Jun 2019 23:13:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/M4KOk8anUvleYe4Z0kHfP1YyeHtJEQFqJQMyjw20cPWdlOiaKzI0TiyHxZ0ofVL/cTvhMw==
X-Received: by 2002:aa7:9407:: with SMTP id x7mr48714652pfo.163.1560406411293;
        Wed, 12 Jun 2019 23:13:31 -0700 (PDT)
Received: from [172.20.10.4] (223-136-183-91.emome-ip.hinet.net. [223.136.183.91])
        by smtp.gmail.com with ESMTPSA id u123sm1554074pfu.67.2019.06.12.23.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 23:13:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] PCI: PM: Skip devices in D0 for suspend-to-idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2513600.jR9RdVMSR0@kreacher>
Date:   Thu, 13 Jun 2019 14:13:26 +0800
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A0D09537-12D3-4466-945A-7D7F889A5472@canonical.com>
References: <2513600.jR9RdVMSR0@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 06:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> attempted to avoid a problem with devices whose drivers want them to
> stay in D0 over suspend-to-idle and resume, but it did not go as far
> as it should with that.
>
> Namely, first of all, it is questionable to change the power state
> of a PCI bridge with a device in D0 under it, but that is not
> actively prevented from happening during system-wide PM transitions,
> so use the skip_bus_pm flag introduced by commit d491f2b75237 for
> that.
>
> Second, the configuration of devices left in D0 (whatever the reason)
> during suspend-to-idle need not be changed and attempting to put them
> into D0 again by force may confuse some firmware, so explicitly avoid
> doing that.
>
> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks! This patch solves the issue I reported earlier.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>
> Tested on Dell XPS13 9360 with no issues.
>
> ---
>  drivers/pci/pci-driver.c |   47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -524,7 +524,6 @@ static void pci_pm_default_resume_early(
>  	pci_power_up(pci_dev);
>  	pci_restore_state(pci_dev);
>  	pci_pme_restore(pci_dev);
> -	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>
>  /*
> @@ -842,18 +841,16 @@ static int pci_pm_suspend_noirq(struct d
>
>  	if (pci_dev->skip_bus_pm) {
>  		/*
> -		 * The function is running for the second time in a row without
> +		 * Either the device is a bridge with a child in D0 below it, or
> +		 * the function is running for the second time in a row without
>  		 * going through full resume, which is possible only during
> -		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
> -		 * device was originally left in D0, so its power state should
> -		 * not be changed here and the device register values saved
> -		 * originally should be restored on resume again.
> +		 * suspend-to-idle in a spurious wakeup case.  The device should
> +		 * be in D0 at this point, but if it is a bridge, it may be
> +		 * necessary to save its state.
>  		 */
> -		pci_dev->state_saved = true;
> -	} else if (pci_dev->state_saved) {
> -		if (pci_dev->current_state == PCI_D0)
> -			pci_dev->skip_bus_pm = true;
> -	} else {
> +		if (!pci_dev->state_saved)
> +			pci_save_state(pci_dev);
> +	} else if (!pci_dev->state_saved) {
>  		pci_save_state(pci_dev);
>  		if (pci_power_manageable(pci_dev))
>  			pci_prepare_to_sleep(pci_dev);
> @@ -862,6 +859,22 @@ static int pci_pm_suspend_noirq(struct d
>  	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
>  		pci_power_name(pci_dev->current_state));
>
> +	if (pci_dev->current_state == PCI_D0) {
> +		pci_dev->skip_bus_pm = true;
> +		/*
> +		 * Changing the power state of a PCI bridge with a device in D0
> +		 * below it is questionable, so avoid doing that by setting the
> +		 * skip_bus_pm flag for the parent bridge.
> +		 */
> +		if (pci_dev->bus->self)
> +			pci_dev->bus->self->skip_bus_pm = true;
> +	}
> +
> +	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
> +		dev_dbg(dev, "PCI PM: Skipped\n");
> +		goto Fixup;
> +	}
> +
>  	pci_pm_set_unknown_state(pci_dev);
>
>  	/*
> @@ -909,7 +922,16 @@ static int pci_pm_resume_noirq(struct de
>  	if (dev_pm_smart_suspend_and_suspended(dev))
>  		pm_runtime_set_active(dev);
>
> -	pci_pm_default_resume_early(pci_dev);
> +	/*
> +	 * In the suspend-to-idle case, devices left in D0 during suspend will
> +	 * stay in D0, so it is not necessary to restore or update their
> +	 * configuration here and attempting to put them into D0 again may
> +	 * confuse some firmware, so avoid doing that.
> +	 */
> +	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
> +		pci_pm_default_resume_early(pci_dev);
> +
> +	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);
> @@ -1200,6 +1222,7 @@ static int pci_pm_restore_noirq(struct d
>  	}
>
>  	pci_pm_default_resume_early(pci_dev);
> +	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_resume_early(dev);


