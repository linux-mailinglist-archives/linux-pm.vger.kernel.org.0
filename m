Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4CC1D0AB3
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgEMIUT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 04:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMIUS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 04:20:18 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D86205C9;
        Wed, 13 May 2020 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589358018;
        bh=emeq7Bm92V31yWuvxP5ydSOqrwXbpkdJSdTQeptas74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwJ0rauTL/sQKAj4as1KlCFju4oGiD025lSgoQ5hojWoxIovSjVfQRlN5stFSKP/m
         jt68zokZJ7oVDIjOLwIDlgR4UHJKdnachvTl3jpzDj3cWX99EldhfYav/Z7oivgWAl
         wWOUtYjJ8GSAe5Y+48fj3MhMUBfOS7qzsPc/wFSw=
Date:   Wed, 13 May 2020 16:20:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        leonard.crestez@nxp.com, linux@rempel-privat.de, peng.fan@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: imx: Move system control
 into dt-binding headfile
Message-ID: <20200513082003.GD26997@dragon>
References: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587888704-7158-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 04:11:43PM +0800, Anson Huang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> i.MX8 SoCs DTS file needs system control macro definitions, so move them
> into dt-binding headfile, then include/linux/firmware/imx/types.h can be
> removed and those drivers using it should be changed accordingly.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
