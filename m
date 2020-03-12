Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF31832DF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCLOZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 10:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOZ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 10:25:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3148320650;
        Thu, 12 Mar 2020 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584023125;
        bh=IJZgWyzQXOaK+PHYHTp3+TM2BySWKiwXl8P6u6C0DTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kz3ZHSch0M2pneIcsz38LoTBcir99AOr/mi2y0EjQfznsWLEIjFIMcP8jnrDBD+3b
         5oBM+G7S7+HRr+APwIIOYZkeYd3dqDVVbPUNXoitJ8uZfOv4yKGd/T2u0YTciVdWSF
         vMDNSVWvAjpuVCxI7eOyqmXolp5B61QgkS+BXytM=
Date:   Thu, 12 Mar 2020 22:25:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        peng.fan@nxp.com, aford173@gmail.com, ping.bai@nxp.com,
        jun.li@nxp.com, shengjiu.wang@nxp.com, bjorn.andersson@linaro.org,
        olof@lixom.net, vkoul@kernel.org, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 RESEND 3/4] arm64: defconfig: Enable
 CONFIG_IMX8MM_THERMAL as module
Message-ID: <20200312142513.GB1249@dragon>
References: <1582947862-11073-1-git-send-email-Anson.Huang@nxp.com>
 <1582947862-11073-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582947862-11073-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 29, 2020 at 11:44:21AM +0800, Anson Huang wrote:
> Enable CONFIG_IMX8MM_THERMAL as module to support i.MX8MM
> thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
