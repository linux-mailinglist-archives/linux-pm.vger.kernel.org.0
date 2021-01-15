Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5EF2F76FB
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 11:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbhAOKs5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 05:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbhAOKs4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Jan 2021 05:48:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4851D236FB;
        Fri, 15 Jan 2021 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610707696;
        bh=X8p8xCCagyumYGRgcrDd3MAdLNIHS0yUzVv/QmbHWZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTVF3Bh7Re8OetrwwAe6p6iljBxBvCrJPcj6TsC68JKjH+76EGm2t4TF+Ns9Nwz43
         943X3FMK9OQU3xbrEmjOBnh3e2+Ak9eYDY/93J2B5JtJeDoG7cB+uxlbTTxi4dGWLX
         bo+VPJ3rfRPvlBXoYWT5jlHcUrVxtm4vnmHf7GCtODhYMyT40xi2Y/l323d7ALa18M
         x+oDdfwF4gJE2swPVo2EN7UqVvMeE9kx3RdK5QpBQKZArD4YWye/hMOPyW/RFv2rBP
         E29d/yVRdmxvrLzY+PMllN1LvED5ZYk2r0Sly5GaDlKYX2nFF2zRHzm5fwfS48IQ2x
         ZigKVyIRR/sCA==
Date:   Fri, 15 Jan 2021 18:48:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] arm64: dts: imx8mq: Add interconnect provider
 property
Message-ID: <20210115104809.GP28365@dragon>
References: <20210111045103.GH28365@dragon>
 <20210111082144.24450-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111082144.24450-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 09:21:44AM +0100, Martin Kepplinger wrote:
> Add #interconnect-cells on main &noc so that it will probe the interconnect
> provider.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Applied, thanks.
