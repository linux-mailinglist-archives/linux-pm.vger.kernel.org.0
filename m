Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C6232FED
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgG3Jzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 05:55:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35882 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgG3Jzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 05:55:54 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6647FCECF2;
        Thu, 30 Jul 2020 12:05:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Disable runtime suspend on
 Realtek devices"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
Date:   Thu, 30 Jul 2020 11:55:51 +0200
Cc:     chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C006448A-9FE3-4F83-AB67-68973709C0C2@holtmann.org>
References: <20200729161740.1.Ib03d0827c8e48fc3df887fec698f79fa335c9274@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> This reverts commit 7ecacafc240638148567742cca41aa7144b4fe1e.
> 
> Testing this change on a board with RTL8822CE, I found that enabling
> autosuspend has no effect on the stability of the system. The board
> continued working after autosuspend, suspend and reboot.
> 
> The original commit makes it impossible to enable autosuspend on working
> systems so it should be reverted. Disabling autosuspend should be done
> via module param or udev in userspace instead.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> We have a few Chromebooks using the RTL 8822CE part over USB and they
> are running without problems with autosuspend enabled. While bringing up
> a new board, I found some power regressions that I was able to narrow
> down to this change so I'm requesting a revert.
> 
> I tested this on Hp Chromebook 14a (running 4.14 kernel and 5.4 kernel)
> with this revert:
> * Enabled autosuspend, used it normally with a HID device
> * Suspended the Chromebook and verified it worked normally on resume
> * Rebooted the Chromebook and verified Bluetooth was working on next
>  boot
> 
> I didn't see the issue that was originally reported with this fix. For
> the original reporter, if you're still seeing this issue, there are
> other ways to disable autosuspend for your device:
> * set module param: enable_autosuspend=0
> * change your kconfig so BT_HCIBTUSB_AUTOSUSPEND=n
> * use a udev rule to disable autosuspend for specific vid:pid
> 
> Keeping this change in the kernel makes it impossible to enable
> autosuspend so it should be reverted.
> 
> drivers/bluetooth/btusb.c | 4 ----
> 1 file changed, 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

