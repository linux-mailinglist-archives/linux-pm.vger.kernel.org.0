Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AE186134
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 02:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgCPBNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 21:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgCPBNG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 21:13:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA84B20674;
        Mon, 16 Mar 2020 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584321185;
        bh=ILnGuopfrhCWnkKrqnyInl7MvbflrVYGdJUJ9X9o7J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bl8nACmy85FPAzdl2QuPd305imWBxyeo5FBiR8LYXOqQj8S5slX/47kvyaF3x5XFu
         hPor8oR0wjKb7Vkzpsd+o3Mpu7FMl32oQyMKkKFlMyOIVNFGJj+k7TbPCtIZvXU6KI
         0lKVPSE8X99h/ee+sSyTkwyOZdn0zrUPkeFbVqc8=
Date:   Mon, 16 Mar 2020 09:12:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, daniel.baluta@nxp.com,
        linux@rempel-privat.de, gregkh@linuxfoundation.org,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de, robh@kernel.org,
        yuehaibing@huawei.com, ronald@innovation.ch, krzk@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Message-ID: <20200316011255.GL17221@dragon>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
 <20200316002803.GL29269@dragon>
 <6bc06056-b614-fbbf-037c-4a98bafa591c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc06056-b614-fbbf-037c-4a98bafa591c@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 15, 2020 at 05:54:52PM -0700, Guenter Roeck wrote:
> On 3/15/20 5:28 PM, Shawn Guo wrote:
> > On Sat, Mar 07, 2020 at 09:25:53AM +0800, Anson Huang wrote:
> >> Add stubs for those i.MX SCU APIs to make those modules depending
> >> on IMX_SCU can pass build when COMPILE_TEST is enabled.
> >>
> >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > Already had such a patch from Peng Fan.
> > 
> 
> Did you follow the discussion and the conclusion that the only patch
> really needed is patch 2/7 ?

Thanks for the reminding.  Just did.

Shawn
