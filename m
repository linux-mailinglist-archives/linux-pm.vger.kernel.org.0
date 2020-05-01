Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40EC1C1B88
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgEARUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 13:20:37 -0400
Received: from foss.arm.com ([217.140.110.172]:44416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgEARUg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 13:20:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B2D930E;
        Fri,  1 May 2020 10:20:36 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764B23F305;
        Fri,  1 May 2020 10:20:32 -0700 (PDT)
Date:   Fri, 1 May 2020 18:20:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/17] Modularizing Versatile Express
Message-ID: <20200501172029.GM14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:09PM -0500, Rob Herring wrote:
> This series enables building various Versatile Express platform drivers
> as modules. The primary target is the Fast Model FVP which is supported
> in Android. As Android is moving towards their GKI, or generic kernel,
> the hardware support has to be in modules. Currently ARCH_VEXPRESS
> enables several built-in only drivers. Some of these are needed, but
> some are only needed for older 32-bit VExpress platforms and can just
> be disabled. For FVP, the pl111 display driver is needed. The pl111
> driver depends on vexpress-osc clocks which had a dependency chain of
> vexpress-config --> vexpress-syscfg --> vexpress-sysreg. These
> components relied on fixed initcall ordering and didn't support deferred
> probe which would have complicated making them modules. All these levels
> of abstraction are needlessly complicated, so this series simplifies
> things a bit by merging the vexpress-config and vexpress-syscfg
> functionality.
>
> There's a couple of other pieces to this which I've sent out separately
> as they don't have dependencies with this series. The cross subsystem
> dependencies in this series are mainly the ordering of enabling drivers
> as modules.
>
> A complete git branch is here[1]. Tested on Fast Model FVP Rev C.

I am assuming you will send pull request to ARM SoC guys directly. Let
me know what's the plan if that's not the case.

--
Regards,
Sudeep
