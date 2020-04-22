Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23C1B43DD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDVMDS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 08:03:18 -0400
Received: from foss.arm.com ([217.140.110.172]:48494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgDVMDS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 08:03:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8746931B;
        Wed, 22 Apr 2020 05:03:17 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685A03F6CF;
        Wed, 22 Apr 2020 05:03:17 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 22348682F37; Wed, 22 Apr 2020 13:03:16 +0100 (BST)
Date:   Wed, 22 Apr 2020 13:03:16 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/17] vexpress: Move site master init to vexpress-config
 bus
Message-ID: <20200422120316.GZ364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-16-robh@kernel.org>
 <158754906803.132238.5380277174069330915@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158754906803.132238.5380277174069330915@swboyd.mtv.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 02:51:08AM -0700, Stephen Boyd wrote:
> Is the subject supposed to say 'set master' vs. 'site master'?

Funnily enough, the VExpress has two "sites" (daughterboard sockets) and this was
used to set which one was the master. Didn't realised the subject mismatch until
you pointed out. :)

Acked-by: Liviu Dudau <liviu.dudau@arm.com>


> 
> Quoting Rob Herring (2020-04-19 10:08:08)
> > There's only a single caller of vexpress_config_set_master() from
> > vexpress-sysreg.c. Let's just make the registers needed available to
> > vexpress-config and move all the code there. The registers needed aren't
> > used anywhere else either. With this, we can get rid of the private API
> > between these 2 drivers.
> > 
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
