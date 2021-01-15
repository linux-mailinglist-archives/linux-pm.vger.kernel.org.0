Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52972F76FE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 11:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAOKtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 05:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAOKtk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 05:49:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CCFC23603;
        Fri, 15 Jan 2021 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610707740;
        bh=+0kSrKy+iMtt20xNFvJ+mWWPF79MAZITyTm7iLfIe1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zghde2ilZQUZLTZqW+jAeOmW9ZSsqwCmYQcONBvT50SEtpAEPDaPNdgR1tvmFr7c7
         DMBvOx4iWYqDiMeTK1xaHrdUABPmQ/7fn+e+29rafejcI5dYLlmZl+KvuYqT7hFxaP
         0DrO3xOEVYtljlWxFirC9nqZs+gllYFKtUB7heRKZlt9HPM975m37McTdWU0PqcSjM
         +hZp0fPcXvTVnqoV5Ywo81NzqbJFvOVlH4PIqgOTAU/EpYx2moiznOcB3W2b7kp0E5
         9Q7PEHq+UkbdCFefpK8RoqE8oPjgsoTcBHLqvdsrnTVAZql9IK0eWRQsTgKGq0arOe
         lVtRTQe3G6vwQ==
Date:   Fri, 15 Jan 2021 18:48:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] arm64: dts: imx8mq: Add interconnect for lcdif
Message-ID: <20210115104853.GQ28365@dragon>
References: <20210107121754.3295-1-martin.kepplinger@puri.sm>
 <20210107121754.3295-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107121754.3295-5-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:17:53PM +0100, Martin Kepplinger wrote:
> Add interconnect ports for lcdif to set bus capabilities.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied, thanks.
