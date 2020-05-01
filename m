Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05901C1B03
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgEAQ7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 12:59:07 -0400
Received: from foss.arm.com ([217.140.110.172]:44082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgEAQ7G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 12:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3655C30E;
        Fri,  1 May 2020 09:59:06 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8605D3F305;
        Fri,  1 May 2020 09:59:02 -0700 (PDT)
Date:   Fri, 1 May 2020 17:58:59 +0100
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
Subject: Re: [PATCH v2 15/16] bus: vexpress-config: Support building as module
Message-ID: <20200501165859.GI14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-16-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429205825.10604-16-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:24PM -0500, Rob Herring wrote:
> Enable building vexpress-config driver as a module.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
