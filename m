Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3737D54A
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 08:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfHAGLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 02:11:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfHAGLI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 02:11:08 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ht4Is-0002HZ-CG
        for linux-pm@vger.kernel.org; Thu, 01 Aug 2019 06:11:06 +0000
Received: by mail-pg1-f198.google.com with SMTP id m19so29996145pgv.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 23:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QZGV7+BXR1toRoMcvP04+kAINcsNNoog0nbXTRBRUkI=;
        b=raZlTe9h/uUcLxYVTI7msU6a9jj2j3sO/5WGCWVTYTlOkQr80mdJ9Coe2lt4Le9iOq
         HBxvkoGqZyRPEcX+wYKMO9V+jKtO49mMP/Gb8hTLmHMu1c/Eak2tGojXyJg2H64wYTkF
         hycJXY4K0cKjcxWH1EY5i9K6TpC+Hy2VwQ57gVoeDdH0iDL4wFvLbdF7QD7xBZmQw9fd
         XnelWJORYCIn1cRM0QdDVWjdN/Cbh9k9XAxaMnPK8AQaoJVCqjNmIPfN6gqjg50Mmtzj
         sxKP+0cI0+o6UpdL7vMfCP3Fu7yQ8GiIGjj8zffYCDJxFORYWbSuh0huRTRVZzds3vOZ
         OMUA==
X-Gm-Message-State: APjAAAWNskNGxQd74X5v/U3ge682uWZHPv3sZR95XBNpHb9OK4M+jgVc
        Mi5Wlf9INgqERE/KkLO2lkmTenGmmN2NfTRlFTkwEV1NbVtB7OVl4SjuC82EN+5wyTk1vwbFJEn
        oV6GEVEnErtST+/D6J4IsLaG124YaM/9htRZb
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr10486362plr.185.1564639865078;
        Wed, 31 Jul 2019 23:11:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzXh5jh0NLL++hnpmUdxpOQK3aTn8RT4M9XQoFlEZWbL6U+5kk0SoJW9sp8o1OsqZo1L05qA==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr10486342plr.185.1564639864814;
        Wed, 31 Jul 2019 23:11:04 -0700 (PDT)
Received: from 2001-b011-380f-37d3-f52e-c69b-5d89-c245.dynamic-ip6.hinet.net (2001-b011-380f-37d3-f52e-c69b-5d89-c245.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:f52e:c69b:5d89:c245])
        by smtp.gmail.com with ESMTPSA id 97sm4210103pjz.12.2019.07.31.23.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 23:11:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] ACPI: PM: Fix regression in acpi_device_set_power()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <4199592.UtrPOv3ZmA@kreacher>
Date:   Thu, 1 Aug 2019 14:11:00 +0800
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Transfer-Encoding: 7bit
Message-Id: <27715F95-E729-4EF5-B2BA-03BA3C87AE29@canonical.com>
References: <4199592.UtrPOv3ZmA@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 07:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> special cases") overlooked the fact that acpi_power_transition() may
> change the power.state value for the target device and if that
> happens, it may confuse acpi_device_set_power() and cause it to
> omit the _PS0 evaluation which on some systems is necessary to
> change power states of devices from low-power to D0.
>
> Fix that by saving the current value of power.state for the
> target device before passing it to acpi_power_transition() and
> using the saved value in a subsequent check.
>
> Fixes: f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in  
> special cases")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/acpi/device_pm.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -236,13 +236,15 @@ int acpi_device_set_power(struct acpi_de
>  		if (device->power.flags.power_resources)
>  			result = acpi_power_transition(device, target_state);
>  	} else {
> +		int cur_state = device->power.state;
> +
>  		if (device->power.flags.power_resources) {
>  			result = acpi_power_transition(device, ACPI_STATE_D0);
>  			if (result)
>  				goto end;
>  		}
>
> -		if (device->power.state == ACPI_STATE_D0) {
> +		if (cur_state == ACPI_STATE_D0) {
>  			int psc;
>
>  			/* Nothing to do here if _PSC is not present. */


