Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA89D207B7E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 20:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405554AbgFXS1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 14:27:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40802 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404995AbgFXS1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 14:27:39 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id A3F1FCECDB;
        Wed, 24 Jun 2020 20:37:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Reset port on cmd timeout
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
Date:   Wed, 24 Jun 2020 20:27:37 +0200
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FB7B7C39-4F0F-440C-8C95-7C8E63E17C05@holtmann.org>
References: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> QCA_ROME sometimes gets into a state where it is unresponsive to
> commands. Since it doesn't have support for a reset gpio, reset the usb
> port when this occurs instead.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> On Chromebooks with this chipset, we encountered cmd_timeout after
> running suspend stress test for hundreds of iterations. Without
> a recovery mechanism, continued cmd_timeout failures eventually caused
> the suspend stress test to fail.
> 
> This change will just reset the port that the Bluetooth chip is on when
> cmd_timeout is encountered. At the very least, the driver will unload
> and stop affecting suspend. It doesn't seem to restore the BT controller
> to a good state however (this still requires a power cycle).
> 
> Changes in v2:
> - Renamed btusb_generic_usb_cmd_timeout to btusb_qca_cmd_timeout
> - Updated commit note
> 
> drivers/bluetooth/btusb.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

