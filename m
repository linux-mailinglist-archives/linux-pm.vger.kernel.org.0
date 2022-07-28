Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B2583AFB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiG1JIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiG1JIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 05:08:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38096655A8;
        Thu, 28 Jul 2022 02:08:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96C20106F;
        Thu, 28 Jul 2022 02:08:10 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 038ED3F73B;
        Thu, 28 Jul 2022 02:08:08 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:08:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <20220728090806.nnighsbx2lcgugon@bogus>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:
> To ease debugging of PSCI supported features, add debugfs file called
> 'psci' describing PSCI and SMC CC versions

These 2 are for sure in the boot log. Having them is debugfs accessible
via file system add not much value as we would hit issues quite early in
the boot for most of the things related to PSCI.

> enabled features and options.
> 

We have psci_checker.c which does some minimal testing of PSCI. I prefer
to add things to that rather than a debugfs as it is run during boot. IMO
it is usual useful to debug things that cause boot issue most of the time.
I am not against this so I will leave it to the maintainers.

-- 
Regards,
Sudeep
