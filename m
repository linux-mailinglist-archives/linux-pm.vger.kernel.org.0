Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB117F0D1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJHBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 03:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJHBr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 03:01:47 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1A12467C;
        Tue, 10 Mar 2020 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583823706;
        bh=uXhlkK6m4rFYqC7rfUPeSbG0I1pRrOsi/+xRnMgu3Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uV3Ts6vkE5Fp768fM6DJjeKqN3gx2pe3fboRGD2UPeS0RWNuXx/iedtBQPvOqo8MA
         t4V9s014B537zzvQIxhpJtf4B74ttqKqfJvYG2+xqJYcOU6dspuHFCjy1UOR8dmw1H
         /DJB1Xvj60Z8y1d8tiKBFT26V1Gw8cYIXoStU21c=
Date:   Tue, 10 Mar 2020 15:01:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V16 4/5] defconfig: arm64: add i.MX system controller
 thermal support
Message-ID: <20200310070134.GB17772@dragon>
References: <1582330132-13461-1-git-send-email-Anson.Huang@nxp.com>
 <1582330132-13461-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582330132-13461-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 22, 2020 at 08:08:51AM +0800, Anson Huang wrote:
> This patch enables CONFIG_IMX_SC_THERMAL as module.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Prefix should be 'arm64: defconfig: ...'

Fixed it up and applied patch.

Shawn

> ---
> No change.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1c74437..1ff479c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -453,6 +453,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
>  CONFIG_CPU_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
>  CONFIG_QORIQ_THERMAL=m
> +CONFIG_IMX_SC_THERMAL=m
>  CONFIG_ROCKCHIP_THERMAL=m
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_RCAR_GEN3_THERMAL=y
> -- 
> 2.7.4
> 
