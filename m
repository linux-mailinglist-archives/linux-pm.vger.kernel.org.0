Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1945BAB3
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGALa3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:30:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36871 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfGALa3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:30:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so22972646eds.4
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FZVerzE1oFDIf/AEgJefyhsJDoB9qh6VUR1z8DL6tw=;
        b=p42CVzXPfxj/s1SxtG9nZja+jYG09yxNNZcSdwCzSUzMNtiYWAaXCPSfRWU5A3OMZS
         w1aBoxVeE6MdNQxm8oY9EdZI/mBGLGkhLu9Cgs0HMSP0OjF6g9qqr5pJ5Fr7P/i4THz9
         NVztkALDPziapn+GM2YgFWL0zVx4YMyJ2GqSwCGjeIIa5W6TYr8gXiY/n6sLOh5sR8zF
         HSm2i+eq45uXV7xDQ87sMsYg6tr2/pO/HzJAREvcc0d3snb8eWahjKAurkbIA9dlXnPd
         ivBBUKYXrwr9DFTNL8G3BAFyVYnjmEDD1E2kWkrccAxU5ow/BZ7e/m7g1gKmf5REOxrB
         f3GA==
X-Gm-Message-State: APjAAAVzfg7/CsyyE5DNbl36LpA0MPZqdaSv/eGQ+wmNk+3/ZNr+6e4u
        a6aUGJu5Xd7sLvS9GH4w3WXa/A==
X-Google-Smtp-Source: APXvYqz/0QfqYPFurt8vHq2JQ9efiubTG15CmggEQS1oSAuTuLo82LfJbwtMPGobRwI6nNQaLSJ6rw==
X-Received: by 2002:a50:e718:: with SMTP id a24mr28061508edn.91.1561980627445;
        Mon, 01 Jul 2019 04:30:27 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v32sm3589172edm.92.2019.07.01.04.30.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:30:26 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] PM: PCI/ACPI: Hibernation handling fixes
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
References: <4976412.ihyb9sT5jY@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc53d965-c5b6-45b9-8e0d-1de2fbed09a8@redhat.com>
Date:   Mon, 1 Jul 2019 13:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 01-07-19 12:42, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series of patches addresses a few issues related to the handling of
> hibernation in the PCI bus type and the ACPI PM domain and ACPI LPSS driver.
> 
> The v2 addresses Hans' concerns regarding the LPSS changes.
> 
> First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
> PM domains will be resumed during hibernation (first patch).  This appears to be the
> only way to avoid weird corner cases and the benefit from avoiding to resume those
> devices during hibernation is questionable.
> 
> That change allows the the hibernation callbacks in all of the involved subsystems to be
> simplified (patches 2 and 3).
> 
> Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
> hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 4
> fixes that.
> 
> Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 5).

Thank you for the new version, the entire series looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

p.s.

FWIW I agree that the calling of the suspend_late method of the i2c-designware driver
at suspend_noirq time is ugly, thank you for adding the comment documenting this.
