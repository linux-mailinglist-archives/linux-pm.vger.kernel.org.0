Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209F584FC2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jul 2022 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiG2Ltw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jul 2022 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiG2Ltv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2022 07:49:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A16474787;
        Fri, 29 Jul 2022 04:49:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05ED71063;
        Fri, 29 Jul 2022 04:49:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4995D3F73D;
        Fri, 29 Jul 2022 04:49:49 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:49:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <20220729114946.jhjjmkw36vjdsyj3@bogus>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
 <YuKJtKHzoR4DUsOr@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuKJtKHzoR4DUsOr@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 28, 2022 at 02:05:56PM +0100, Mark Brown wrote:
> On Thu, Jul 28, 2022 at 10:08:06AM +0100, Sudeep Holla wrote:
> > On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:
> 
> > > To ease debugging of PSCI supported features, add debugfs file called
> > > 'psci' describing PSCI and SMC CC versions
> 
> > These 2 are for sure in the boot log. Having them is debugfs accessible
> > via file system add not much value as we would hit issues quite early in
> > the boot for most of the things related to PSCI.
> 
> It can be useful to have something that can be queried at any point when
> collecting diagnostics, even if there's been a lot of logging or log
> rotation since boot.  It makes it easier to give people instructions or
> a tool which will reliably collect useful information when filing a bug
> report.

Fair enough. I agree this is will be useful to debug/analyse non boot
issues.

--
Regards,
Sudeep
