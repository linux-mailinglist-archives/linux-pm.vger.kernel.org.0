Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E40207E14
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgFXVGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbgFXVGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 17:06:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A6CC061795
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 14:06:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so1787364pfp.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MJjDisSYsFLi9xjpuxw/vmSuouvLE6xSiePJnwRksg=;
        b=nGg2gjeBPhPwU7thZ1v6JzWty3y8rRAI/iIlXN0JlQmZd1dX6Taavm70RQncr/FVmX
         IlFoXu2K3JqzWg6Ejw0e4HbVfWsQpgjWv1qYxIw5YiQraZTpAQ58NssIb/+GUnyUzA8L
         5Q/WN5nncXm7ARdnvhcEtDn54pJv/0PFKq+IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MJjDisSYsFLi9xjpuxw/vmSuouvLE6xSiePJnwRksg=;
        b=dSoqk3MXXJsRKl62pRJiD3Mgs73bCGcIwylqqAMYLeEl8hWpzxZXXJ6A9hu9PEDZOb
         jC8VhvFhEB+op6oL0JFFYBuJtj+cNxK9Vdf+xAcy7dZyA6CMwMD/pKppxMdhJEw2ZjjV
         54FYM4leicQ8gXoVOAp49XUOejUy13+no62DaF+q5Qb6bzfxz9vPesrt70g23tUNC/NE
         JzCgSWgYE2/q6tKKMGA5meamulkfiMN9q1SjlxmL2bmEA9LG7itqYAFJ+6fz4BxV4SUE
         APOlKJr0A7zMo/acE8Ql8t9CM/K9CTGOZqqjD5unyZRutIzoP0qsGfyR05Ct2jZPCvC0
         SfWQ==
X-Gm-Message-State: AOAM530TNufGRQ0PGgxlpe0gX4Xu+6L9iulc7bov9SYyoWhjZxMBpJei
        qXqXoHl89lMimAFkGVS/3Jnq+rSZr2E=
X-Google-Smtp-Source: ABdhPJwnLertNgi8e0ErMQYUFVupWeSlyxCkLSLR+LP5JzpyPFSxudWYnPgOS2GT8jLpWRLkG7r9/g==
X-Received: by 2002:a62:4d46:: with SMTP id a67mr14170483pfb.290.1593032783177;
        Wed, 24 Jun 2020 14:06:23 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y9sm442927pfn.84.2020.06.24.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 14:06:22 -0700 (PDT)
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
Subject: [PATCH 0/1] power: Emit change uevent when updating sysfs
Date:   Wed, 24 Jun 2020 14:06:15 -0700
Message-Id: <20200624210616.28477-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
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


Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.27.0.111.gc72c7da667-goog

