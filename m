Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673B9B664E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfIROle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 10:41:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730029AbfIROle (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 10:41:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98543B76A;
        Wed, 18 Sep 2019 14:41:30 +0000 (UTC)
Message-ID: <1568817684.23075.10.camel@suse.com>
Subject: Re: [PATCH 0/2] Reset realtek bluetooth devices during user suspend
From:   Oliver Neukum <oneukum@suse.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     dianders@chromium.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hui Peng <benquike@gmail.com>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Date:   Wed, 18 Sep 2019 16:41:24 +0200
In-Reply-To: <20190917212702.35747-1-abhishekpandit@chromium.org>
References: <20190917212702.35747-1-abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, den 17.09.2019, 14:27 -0700 schrieb Abhishek Pandit-
Subedi:
> On a Realtek USB bluetooth device, I wanted a simple and consistent way
> to put the device in reset during suspend (2 reasons: to save power and

The device really uses less power if you reset it before suspendening
it?

> disable BT as a wakeup source). Resetting it in the suspend callback

Then do not enable it. Something is strange.

> causes a detach and the resume callback is not called. Hence the changes
> in this series to do the reset in suspend_noirq.
> 
> I looked into using PERSIST and reset on resume but those seem mainly
> for misbehaving devices that reset themselves.

No, not really. It is also for device that need to be reset if you use
the RESET_RESUME quirk. But that is on resume().
You could introduce a new flag. But the _noirq method is kind of
a hack, as USB really cannot operate without interrupts.

	Regards
		Oliver

