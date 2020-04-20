Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7441B07F1
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 13:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgDTLpn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 07:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgDTLpn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 07:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6AC20724;
        Mon, 20 Apr 2020 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383142;
        bh=wABszUiKC+9GnVORubiyNHHzTm5AHEnPJbHOJRIArfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpJwyvDoKUdVT1tPO452DOepBmSKEejmCLkw8mVa7E4VJfypEoE7zbNXHPoQmS4WF
         ca3oDam9DlUg9s2vGjn42nLXFUgfcOBNrMtiOnfiExMHO7hBG2r9BgUIVmILNnNFTr
         NYdrK0C2xy19+52e+9nr7euh8N0iSmGtn6hpdX0o=
Date:   Mon, 20 Apr 2020 13:45:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/17] bus: vexpress-config: Merge vexpress-syscfg into
 vexpress-config
Message-ID: <20200420114540.GA3908919@kroah.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419170810.5738-14-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:06PM -0500, Rob Herring wrote:
> The only thing that vexpress-syscfg does is provide a regmap to
> vexpress-config bus child devices. There's little reason to have 2
> components for this. The current structure with initcall ordering
> requirements makes turning these components into modules more difficult.
> 
> So let's start to simplify things and merge vexpress-syscfg into
> vexpress-config. There's no functional change in this commit and it's
> still separate components until subsequent commits.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-vexpress/Kconfig |   1 -
>  drivers/bus/vexpress-config.c  | 283 +++++++++++++++++++++++++++++++--
>  drivers/misc/Kconfig           |   9 --
>  drivers/misc/Makefile          |   1 -
>  drivers/misc/vexpress-syscfg.c | 280 --------------------------------
>  include/linux/vexpress.h       |  17 --
>  6 files changed, 274 insertions(+), 317 deletions(-)
>  delete mode 100644 drivers/misc/vexpress-syscfg.c


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
