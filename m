Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B61C1AD5
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgEAQuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 12:50:19 -0400
Received: from foss.arm.com ([217.140.110.172]:43880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgEAQuS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 12:50:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6C9230E;
        Fri,  1 May 2020 09:50:17 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E9C3F305;
        Fri,  1 May 2020 09:50:14 -0700 (PDT)
Date:   Fri, 1 May 2020 17:50:11 +0100
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
Subject: Re: [PATCH v2 09/16] mfd: vexpress-sysreg: Drop unused syscon child
 devices
Message-ID: <20200501165011.GE14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-10-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:18PM -0500, Rob Herring wrote:
> The "sys_id", "sys_misc" and "sys_procid" devices don't have a user
> anywhere in the tree and do nothing more than create a syscon regmap for
> a single register or 2. That's an overkill for creating child devices.
> Let's just remove them.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> ---
> Note that the other GPIO child devices could probably be removed and
> added to the bgpio driver. Unfortunately, the model dts files were
> never updated 6 years ago. Not sure if the models really need LEDs...
>

I don't understand the reference to models here. Any particular dts you
are referring ? Also may be led/flash gpios can do but we may need
mmci ones.

--
Regards,
Sudeep
