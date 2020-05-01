Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA21C1B4F
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgEARKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 13:10:51 -0400
Received: from foss.arm.com ([217.140.110.172]:44246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgEARKu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 13:10:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E3C930E;
        Fri,  1 May 2020 10:10:50 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF703F305;
        Fri,  1 May 2020 10:10:46 -0700 (PDT)
Date:   Fri, 1 May 2020 18:10:43 +0100
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
Subject: Re: [PATCH v2 13/16] bus: vexpress-config: simplify config bus
 probing
Message-ID: <20200501171043.GK14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-14-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:22PM -0500, Rob Herring wrote:
> The vexpress-config initialization is dependent on the vexpress-syscfg
> driver probing. As vexpress-config was not a driver, deferred probe
> could not be used and instead initcall ordering was relied upon. This is
> fragile and doesn't work for modules.
> 
> Let's move the config bus init into the vexpress-syscfg probe. This
> eliminates the initcall ordering requirement and the need to create a
> struct device and the "vexpress-config" class.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks a lot for all these clean up. It was always confusing to remember
these ordering every time I looked at the code after few months are years,
but never bothered to cleanup as it was *working* 😁.

-- 
Regards,
Sudeep
