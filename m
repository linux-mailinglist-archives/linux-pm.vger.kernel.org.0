Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4950020AB56
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 06:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFZE0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 00:26:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42477 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgFZE0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 00:26:33 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7517CECFD;
        Fri, 26 Jun 2020 06:36:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Comment on unbalanced pm reference
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
Date:   Fri, 26 Jun 2020 06:26:30 +0200
Cc:     Oliver Neukum <oneukum@suse.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-pm@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D70FEC02-74EA-4082-B3F6-40B099EA645B@holtmann.org>
References: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> Add a comment clarifying that a PM reference in btusb_qca_cmd_timeout is
> not unbalanced because it results in a device reset.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

