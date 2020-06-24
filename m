Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C240E207B28
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbgFXSCF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jun 2020 14:02:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35670 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405538AbgFXSCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 14:02:04 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id B4340CECDA;
        Wed, 24 Jun 2020 20:11:55 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Reset port on cmd timeout
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200624105737.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
Date:   Wed, 24 Jun 2020 20:02:02 +0200
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <825D1018-9453-4D7F-8978-0E54784CF3D2@holtmann.org>
References: <20200624105737.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> QCA_ROME doesn't have support for the reset gpio but sometimes gets into
> a state where it is unresponsive to commands. When this happens, reset
> the port to attempt to revive the chip.
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
> drivers/bluetooth/btusb.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e42fdd625eb023..b806a88702328b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -573,6 +573,22 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
> 	gpiod_set_value_cansleep(reset_gpio, 0);
> }
> 
> +static void btusb_generic_usb_cmd_timeout(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	int err;
> +
> +	if (++data->cmd_timeout_cnt < 5)
> +		return;
> +
> +	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
> +	err = usb_autopm_get_interface(data->intf);
> +	if (!err)
> +		usb_queue_reset_device(data->intf);
> +	else
> +		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
> +}
> +
> static inline void btusb_free_frags(struct btusb_data *data)
> {
> 	unsigned long flags;
> @@ -3964,6 +3980,7 @@ static int btusb_probe(struct usb_interface *intf,
> 	if (id->driver_info & BTUSB_QCA_ROME) {
> 		data->setup_on_usb = btusb_setup_qca;
> 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> +		hdev->cmd_timeout = btusb_generic_usb_cmd_timeout;

lets give this a btusb_qca_cmd_timeout name. If it ever gets generic, we can rename it, but right now it is specific to QCA.

Regards

Marcel

