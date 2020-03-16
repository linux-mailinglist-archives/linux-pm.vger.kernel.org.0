Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8462C1860F8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 01:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgCPAxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 20:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgCPAxa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 20:53:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDB9205C9;
        Mon, 16 Mar 2020 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584320010;
        bh=v8Qu/XknM0RD2gDDO51zIHVXWGIRSk9coPKyrYVgcjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujLJm6xe//rcf+hUNGkyO0h0a7Lx8tTwdm8N9OktM6r1qUflvMp+xloOLnsxQOza/
         c5uAU61POySUJ2yy3PVfwOwUMuuQ4zY1uu2PsrmELF3D+3VA6P8/dkaynaQ+OkVW+8
         1QCQf0f4g8pwuwmRjEtpt1u+f6hID0vRaDjp1li0=
Date:   Mon, 16 Mar 2020 08:53:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        dmitry.torokhov@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        gregkh@linuxfoundation.org, linux@rempel-privat.de,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        ronald@innovation.ch, krzk@kernel.org, robh@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 2/7] firmware: imx: add COMPILE_TEST support
Message-ID: <20200316005320.GE17221@dragon>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <1583714300-19085-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583714300-19085-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 08:38:15AM +0800, Anson Huang wrote:
> Add COMPILE_TEST support to i.MX SCU drivers for better compile
> testing coverage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied this one, thanks.
