Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70121F73F4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFLGjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 02:39:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48755 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLGjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 02:39:40 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 89E8FCECFF;
        Fri, 12 Jun 2020 08:49:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 0/3] Bluetooth: btmrvl_sdio: Refactor remote wakeup
 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200611015355.186666-1-abhishekpandit@chromium.org>
Date:   Fri, 12 Jun 2020 08:39:37 +0200
Cc:     marcel@holtman.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, dianders@chromium.org,
        linux-pm@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <09CDDC6F-EC61-45F2-ADA6-210F0599F52F@holtmann.org>
References: <20200611015355.186666-1-abhishekpandit@chromium.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> This patch series is refactoring the btmrvl driver to add better support
> for controlling remote wakeup during suspend. Previously, the hci device
> was getting created as /sys/devices/virtual/bluetooth/hci0 and there
> wasn't a way to control wakeup for the device from userspace. This
> series of changes adds the proper parent for the hci device, allows irq
> configuration via power/wakeup and properly disables scanning during
> suspend if wakeup isn't enabled.
> 
> This was tested on a Veyron Mighty Chromebook running the 4.19 kernel
> with these patches. It passes both automated and manual suspend+resume
> tests that make sure wakeup is working properly.
> 
> Thanks
> Abhishek
> 
> 
> 
> Abhishek Pandit-Subedi (3):
>  Bluetooth: btmrvl_sdio: Set parent dev to hdev
>  Bluetooth: btmrvl_sdio: Implement prevent_wake
>  Bluetooth: btmrvl_sdio: Refactor irq wakeup
> 
> drivers/bluetooth/btmrvl_main.c | 11 +++++++++++
> drivers/bluetooth/btmrvl_sdio.c | 13 ++++++++++---
> 2 files changed, 21 insertions(+), 3 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

