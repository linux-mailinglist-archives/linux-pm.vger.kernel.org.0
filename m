Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893F1B4EA8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 22:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDVU4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 16:56:49 -0400
Received: from foss.arm.com ([217.140.110.172]:54834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDVU4s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 16:56:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370EB31B;
        Wed, 22 Apr 2020 13:56:48 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B093F68F;
        Wed, 22 Apr 2020 13:56:44 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:56:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/17] clk: vexpress-osc: Use the devres clock API
 variants
Message-ID: <20200422205641.GG25585@bogus>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419170810.5738-8-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:00PM -0500, Rob Herring wrote:
> In preparation to enable the vexpress-osc clock driver as a module,
> convert the driver to use the managed devres clock API variants. With
> this, a driver .remove() hook is not needed.
>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
