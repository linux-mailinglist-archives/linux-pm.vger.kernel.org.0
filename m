Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD3586731
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiHAJ7R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiHAJ7Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 05:59:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98AF12ED73;
        Mon,  1 Aug 2022 02:59:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5111515;
        Mon,  1 Aug 2022 02:59:15 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4353F67D;
        Mon,  1 Aug 2022 02:59:13 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:59:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <20220801095910.ngexid57qgmvhes7@bogus>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
 <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
 <7d9607ed-f8eb-f3a2-22e4-4d2a240919c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9607ed-f8eb-f3a2-22e4-4d2a240919c9@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 29, 2022 at 11:45:10AM -0700, Florian Fainelli wrote:
>
> Yes I would agree with both of those points, in fact, I would go one step
> further and add the ability to probe an arbitrary PSCI function ID, since
> deployed firmware typically go beyond the standard PSCI scope and implement
> a variety of custom extensions (at least we do).
>

Technically they must not be PSCI right ? Also I hope they are not using
Arm Architecture/CPU service range of FID and they use SiP/OEM service
range. From what I understand, you need a generic debug FS for all
SMCCC instead of just PSCI in your case. The latter must cover PSCI as
well while the reverse must not happen.

So if we need this beyond PSCI FID range, better you have it as generic
SMCCC debug FS. Thoughts ?

-- 
Regards,
Sudeep
