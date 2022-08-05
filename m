Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6158ADAD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiHEPxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiHEPva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 11:51:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6EB9767D;
        Fri,  5 Aug 2022 08:50:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ADA7106F;
        Fri,  5 Aug 2022 08:50:20 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373063F73B;
        Fri,  5 Aug 2022 08:50:18 -0700 (PDT)
Date:   Fri, 5 Aug 2022 16:50:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept
 PC mode
Message-ID: <20220805155015.vea3eorojeghmg3l@bogus>
References: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 04, 2022 at 04:07:50PM +0300, Dmitry Baryshkov wrote:
> The function psci_pd_try_set_osi_mode() will print an error if enabling
> OSI mode fails. To ease debugging PSCI issues print corresponding
> message if switching to PC mode fails too.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
