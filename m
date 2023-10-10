Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910EF7BF913
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjJJKzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJJKzI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 06:55:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE519F
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 03:55:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50FD21FB;
        Tue, 10 Oct 2023 03:55:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2A33F7A6;
        Tue, 10 Oct 2023 03:55:05 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:55:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <20231010105503.jwrmjahuvcjgwtk5@bogus>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> Hi Ulf,
> 
> I just see you wrote scmi_perf_domain.c, just wonder this driver is only
> for devices, not support arm cores, right?
> 
> For ARM cores, we still need scmi_cpufreq.c for performance settings,
> right?

Sorry if I wasn't clear. The reason I mentioned it in private is that
we now support the power domain bindings in the scmi-cpufreq.c as you
were little bit nervous to use the clock bindings(though they work just
fine, I understand the possible confusion with the clock protocol).

There is also separate SCMI performance genpd driver that works for
non-CPU devices. As Ulf mentioned, scmi-cpufreq is not dependent on
those genpd performance driver ATM and we still need to check if it
has to be yet. Hope that clarifies.

-- 
Regards,
Sudeep
