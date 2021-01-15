Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D342F76FA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 11:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbhAOKsh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 05:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbhAOKsg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 05:48:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF2E23603;
        Fri, 15 Jan 2021 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610707676;
        bh=tFBgYn1Bx+JIP2C7Y8L+v0cC5c9Ov0DJ9qeI2R+vYEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcjRNayZtyzwfIaKLlgxgex+OG4S8PSD8ARbHGcjJeh1bDrQWPClQFF7ajj4N5P6E
         np45TAxk6ikM/clmGzUgjZxUIJY0QFyXSJPTzZpg76gN3cB03sNoYrqx0IuEfyUoPQ
         hsLSiEQ/AmnO1LitcPGgQIYHYStwJeXbcNVI5iB25Jmcv8F1gSrJa1jW2xBbUu3TDb
         +A1DPdKcOQa9m92dFtr3sh0t+e2ktJZ/Xk6bficbv+tNGYA3g89yp9deRm6fZcrJ0q
         4RasL65g2W/CCspZCupDA8LvR1nGqzfRC6ec7mgEk7TxazPPFUpWJGSxl52YHeTEkJ
         nEkVAycNz/G2w==
Date:   Fri, 15 Jan 2021 18:47:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: imx8mq: Add NOC node
Message-ID: <20210115104748.GO28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107121754.3295-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:17:50PM +0100, Martin Kepplinger wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add initial support for dynamic frequency scaling of the main NOC
> on imx8mq.
> 
> Make DDRC the parent of the NOC (using passive governor) so that the
> main NOC is automatically scaled together with DDRC by default.
> 
> Support for proactive scaling via interconnect will come on top.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Applied, thanks.
