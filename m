Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D72160D5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGFVHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGFVHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 17:07:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1CC061794
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 14:07:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so18932001pge.12
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ltxd3dYIIoYCEWLVWkAFd+Lvzl8zZTtrqnBoRTLOPrw=;
        b=h2cbsGNvG0tAe/ImaTVsxGwkE46Q+vlxD3xFsSo9MKqc4fVdwDwBfTqyph9hswjzur
         CYqkBZet0gWna39RzAOQhznMY3bFxO6++cwd1MVuakUPA9PHjxpwnjzfSkwh/f1/OrM7
         aSBK9wYYoe8Umfp4asSMM2vMDK98EqA4ftz7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ltxd3dYIIoYCEWLVWkAFd+Lvzl8zZTtrqnBoRTLOPrw=;
        b=SJP12uQJesRFQuER3v3IM2A8+L5NUCWmY4EoquHm28pgXaWn1p3iLCOF6nz/5oRuyg
         Uk8m//nlRJ2OqChBdwmOg3J2wkt0kBbtcRCTMCbjj1GeK29Jv8r8raXz8gs3+YAAgQCd
         yAfsZBLmXX22eINhli9W+EPYs6n2Z5Y4nZvG5MoXv4emg8iieHHWFW8sLfZqsQ9OZHIc
         7JfoOzvmPhrPz/GaMTSN3EyTXXvy0zhw4ZLOnyxCLG1FDOjyc1f8UqMgxsGEdv+f17rT
         6gfY3a3NSBKprC1Z+0mt4lnPtRMytIFxa11q8yz6G+CS0wgvnei6arDRsP1tBtTce5Jd
         myFw==
X-Gm-Message-State: AOAM532SJFT7aYYjdU1NaRYJhO4x6SgimYAJZOWnkIUwANsAP3GQQys+
        4IpXkIOqrLbcq7k1+12IhFcEif8W5Ns=
X-Google-Smtp-Source: ABdhPJy7PL/hlbFhwfnzuhW1Tr79eUWHhfP6EcBz2eu08ukka/c7cEFGGfAvpTJxtAZYYZAIv4kw1Q==
X-Received: by 2002:a63:338c:: with SMTP id z134mr27954169pgz.245.1594069649524;
        Mon, 06 Jul 2020 14:07:29 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id j8sm21088609pfd.145.2020.07.06.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:07:28 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2 0/1] power: Emit change uevent when updating sysfs
Date:   Mon,  6 Jul 2020 14:07:16 -0700
Message-Id: <20200706210717.1210639-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi linux-pm,

ChromeOS has a udev rule to chown the `power/wakeup` attribute so that
the power manager can modify it during runtime.

(https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/platform2/power_manager/udev/99-powerd-permissions.rules)

In our automated tests, we found that the `power/wakeup` attributes
weren't being chown-ed for some boards. On investigating, I found that
when the drivers probe and call device_set_wakeup_capable, no uevent was
being emitted for the newly added power/wakeup attribute. This was
manifesting at boot on some boards (Marvell SDIO bluetooth and Broadcom
Serial bluetooth drivers) or during usb disconnects during resume
(Realtek btusb driver with reset resume quirk).

It seems reasonable to me that changes to the attributes of a device
should cause a changed uevent so I have added that here.

Here's an example of the kernel events after toggling the authorized
bit of /sys/bus/usb/devices/1-3/

$ echo 0 > /sys/bus/usb/devices/1-3/authorized
KERNEL[27.357994] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill1 (rfkill)
KERNEL[27.358049] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[27.358458] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[27.358486] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)
KERNEL[27.358529] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)

$ echo 1 > /sys/bus/usb/devices/1-3/authorized
KERNEL[36.415749] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)
KERNEL[36.415798] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[36.417414] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[36.417447] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[36.417481] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)

Thanks
Abhishek

Changes in v2:
- Add newline at end of bt_dev_err

Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

