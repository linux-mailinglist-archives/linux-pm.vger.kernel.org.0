Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A512F0BFB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 05:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAKEvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 23:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbhAKEvw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 23:51:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80110224D2;
        Mon, 11 Jan 2021 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610340671;
        bh=cExgHqE0WYAUy4mnP4ABwqH1JofZJfZZeZzaAbA8cCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klTAcy+2ts8/X0gGLmIHsLzqjAEEqtt8DtFjGgNmeUXA9UmhpdJDsDpPFLiPq4HwS
         XbI/OiwkJfmo1O5DZI6JhhYr01aCokXOcZYQdjuXwPQ5kSuRauk7wVuyLC2ZlMQAzU
         SZlSW1kph92ZAEYIXGgBzgMyxOYH7wZIKkemGWStJPiBJ9Ti5siFCe1DK1pW9Lmepl
         /SvY5YTqdYD0FotyhGVZnFiqOJvqEDLYxKGECotyT4RfFP7Sasvwcov6MtTtH4VG+Y
         TRWyGaIte2L9vi5vrPrBuIcCvXGADH4MUrlmOQHzXf5xmwV1ZgTe565/JDRZREi32f
         g9x5xOTgbFlvw==
Date:   Mon, 11 Jan 2021 12:51:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] imx8mq: updates for the interconnect fabric
Message-ID: <20210111045103.GH28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107121754.3295-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:17:49PM +0100, Martin Kepplinger wrote:
> revision history:
> v4: (thanks Shawn, Georgi and Greg)
>  * reorder to have dt-bindings doc before code addition
>  * add newline between dt nodes
>  * removed "interconnect: imx8mq: Use icc_sync_state" from the patchset
>    since it's part of gregkh/char-misc.git
>  * Add acks
> 
> v3: (thanks Krysztof and Georgi)
>  * drop the defconfig cycling patch and fix the interconnect enable config
>  * add the noc node to imx8mq only
>  * add missing signed-off-by
>  * https://lore.kernel.org/linux-arm-kernel/20201210100906.18205-1-martin.kepplinger@puri.sm/T/#t
> 
> v2: (thanks Lucas)
>  * reorder and clean up defconfig changes
>  * use "dram" for the interconnect path name and document it
>  * https://lore.kernel.org/linux-arm-kernel/20201201123932.12312-1-martin.kepplinger@puri.sm/T/#t
> 
> v1:
>  * https://lore.kernel.org/linux-arm-kernel/20201201100124.4676-1-martin.kepplinger@puri.sm/T/#t
> 
> thanks,
>                         martin
> 
> 
> Leonard Crestez (1):
>   arm64: dts: imx8mq: Add NOC node
> 
> Martin Kepplinger (4):
>   arm64: dts: imx8mq: Add interconnect provider property
>   dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
>   arm64: dts: imx8mq: Add interconnect for lcdif
>   arm64: defconfig: Enable interconnect for imx8mq

I only received 3 patches, 1/5, 4/5 and 5/5.

Shawn
