Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B4586C03
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiHANag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHANaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 09:30:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F41533CBE7;
        Mon,  1 Aug 2022 06:30:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24290ED1;
        Mon,  1 Aug 2022 06:30:35 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97CF73F73B;
        Mon,  1 Aug 2022 06:30:32 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:30:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <20220801133029.3gtjlvomwbydybwy@bogus>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
 <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
 <7d9607ed-f8eb-f3a2-22e4-4d2a240919c9@gmail.com>
 <20220801095910.ngexid57qgmvhes7@bogus>
 <YufDoc7VWG4e8r0o@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufDoc7VWG4e8r0o@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 01, 2022 at 01:14:25PM +0100, Mark Brown wrote:
> On Mon, Aug 01, 2022 at 10:59:10AM +0100, Sudeep Holla wrote:
> 
> > So if we need this beyond PSCI FID range, better you have it as generic
> > SMCCC debug FS. Thoughts ?
> 
> That thought did cross my mind when reviewing Dmitry's patch but given
> that as far as I'm aware SMCCC isn't particularly enumerable it seemed
> like it might be more of a small library of helpers than something you
> could write a general structure for.  I might be missing something
> though.

Agreed. I don't know how feasible in that yet, but would like to know
Florian's thoughts/requirements to give it a thought. I don't think you
are missing anything. One thing I thought is to add SMCCC version as well
if we are adding PSCI version as lots of new additions have happened
and it is good to have info IMO. SMCCC_ARCH_FEATURES query APIs might be
useful. This is just initial thoughts.

--
Regards,
Sudeep
