Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C863D1C1A8A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEAQ0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 12:26:51 -0400
Received: from foss.arm.com ([217.140.110.172]:43468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728947AbgEAQ0u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 12:26:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086DD30E;
        Fri,  1 May 2020 09:26:50 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02DB43F68F;
        Fri,  1 May 2020 09:26:45 -0700 (PDT)
Date:   Fri, 1 May 2020 17:26:30 +0100
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
Subject: Re: [PATCH v2 04/16] clk: versatile: Rework kconfig structure
Message-ID: <20200501162605.GA14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-5-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:13PM -0500, Rob Herring wrote:
> CONFIG_COMMON_CLK_VERSATILE doesn't really do anything other than hiding
> Arm Ltd reference platform clock drivers. It is both selected by the
> platforms that need it and has a 'depends on' for those platforms. Let's
> drop the selects and convert CONFIG_COMMON_CLK_VERSATILE into a
> menuconfig entry. With this make CONFIG_ICST visible.
> 
> Move the 'select REGMAP_MMIO' to the drivers that require it (SP810 did
> not).
> 
> This also has the side effect of enabling CONFIG_ICST for COMPILE_TEST
> as it was not visible before.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
