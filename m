Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8BE2172F3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgGGPtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 11:49:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59486C08C5DC
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 08:49:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so16904718plr.8
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5vsrk7vEHY5/cQx0UlucywmyaBj8fW6BqF1VBBdS+A=;
        b=Pv2fPxp7OIeEF3uKCol9thsCERjYulCcAkB8AUk4Gwl1bXaMqg3qeUpmuYbfoG9h9f
         R5P3I1Ko6Ww0MIpmSFkLAAtMlFxfdZNVyLLOkErJST905aoYkJitnFGHHJ6iFlOuBYlK
         CgPKunazaYPhxRQlwQCb+IDxN7kMA+6YmsRDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5vsrk7vEHY5/cQx0UlucywmyaBj8fW6BqF1VBBdS+A=;
        b=kyPwywj5LSy/a7pI5303dcoKYDO0BHD3XcbOpwMY5J5ZZiEdu1cfCnAhy6KjwMz4Ld
         KzKkMjbiHfn99PMwUibkIXrZq+M0xRvDmg2a45uNL/jtD3P14tfczVMBtQh+5UFDTJ3E
         eNGzSfyzbxzSg3CseZQciMoKsOyHED4l1XpLfJckJhrT1RrPZdR2s4UcenT35SAKDzFB
         qLN4oPIdBQb7yHC2LNPv2dyHRJRzJIZhHhHFJJUSzQsNXIjlhhCdUijXEgElViOQZToK
         lI62llAsQe9r+jbS0oUq4wZJwNklSO/qmLe7CFS8L2CqLEaniyT9OmS7qTAq/jAJ8O5p
         9wqg==
X-Gm-Message-State: AOAM531d82GlM7jJCZWmA2Ec+9JpK24f4QpU3ynTCLsnUBbdsRjqKzDD
        COJ4JdJ8jcYn6jM3y6wQKYVJ0P1/5MM=
X-Google-Smtp-Source: ABdhPJzLS/0a5ZIkTRnBJsarvJBHCyL5ykuVlth8AWwaID0VPkNo2x7wmAhQzmyPS9TNjQsw6QlLFA==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr5071431pju.212.1594136953766;
        Tue, 07 Jul 2020 08:49:13 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id t5sm1360194pgl.38.2020.07.07.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:49:13 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v3 0/1] power: Emit change uevent when updating sysfs
Date:   Tue,  7 Jul 2020 08:49:04 -0700
Message-Id: <20200707154905.2763616-1-abhishekpandit@chromium.org>
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

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

