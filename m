Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72518CD33
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTLrC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 07:47:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43641 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCTLrC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 07:47:02 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jFG74-0001oA-3u; Fri, 20 Mar 2020 12:46:54 +0100
Message-ID: <94a8cdf893e95a6d6f374eac7ce01f767cefefa8.camel@pengutronix.de>
Subject: Re: [BUG] __set_opp_voltage: failed to set voltage: timeout
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Fri, 20 Mar 2020 12:46:52 +0100
In-Reply-To: <a705cdf2-72d3-8122-e066-4e727ec038eb@puri.sm>
References: <a705cdf2-72d3-8122-e066-4e727ec038eb@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

Am Freitag, den 20.03.2020, 12:37 +0100 schrieb Martin Kepplinger:
> Hi,
> 
> I'm running Linus latest tree on imx8mq with no patches related to opp
> (or cpufreq) on the librem5 (devkit):
> https://source.puri.sm/Librem5/linux-next/tree/imx8-next-librem5
> 
> I've seen the system hang a few times with the following:
> 
> [   38.326712] cpu cpu0: _set_opp_voltage: failed to set voltage (900000
> 900000 900000 mV): -110
> [   38.335464] cpufreq: __target_index: Failed to change cpu frequency: -110
> 
> Also seen with 1000000 mV. The devicetree doesn't set anything unusual
> either:
> https://source.puri.sm/Librem5/linux-next/blob/imx8-next-librem5/arch/arm64/boot/dts/freescale/imx8mq-librem5.dts
> 
> Given I can *not* easily reproduce this, how would I be able to further
> debug this? For any thoughts about the reason for this, I'd be thankful,

The -110 is -ETIMEDOUT, with the most probably chain of events being:
_set_opp_voltage -> regulator_set_voltage -> regmap_write ->
i2c_transfer

My first suspicion would be the i2c bus connecting your PMIC being
locked up for some reason. Reasons for that can be devices on the bus
not being able to operate at the bus frequency, or electrical issues
like ringing due to too high drive strengths. Your pinctrl setting for
the PMIC i2c bus look like the defaults from the NXP pinconf tool,
which are way too high for most designs.

Regards,
Lucas

