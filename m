Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0631582538
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiG0LOS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG0LOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 07:14:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E254481C2;
        Wed, 27 Jul 2022 04:14:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3394823A;
        Wed, 27 Jul 2022 04:14:17 -0700 (PDT)
Received: from bogus (unknown [10.57.11.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC0C3F70D;
        Wed, 27 Jul 2022 04:14:14 -0700 (PDT)
Date:   Wed, 27 Jul 2022 12:14:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: PSCI domains without OSI support
Message-ID: <20220727111410.bglx2u26456ray2u@bogus>
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> Hi,
> 
> Lately I have been working on improving the msm8996 platform support.
> Vendor kernel seems to support domain-like idle (see [1], [2]).
> However when I tried changing upstream msm8996.dtsi to use PSCI
> domains, I faced the firmware reporting NOT_SUPPORTED to an attempt to
> enable OSI (thus rendering PSCI domains useless, as they are now
> marked with ALWAYS_ON).
>

That's not good to hear 🙁.

> I noticed that vendor kernel makes a call to cpu_suspend() with
> power_state following the original format (described in PSCI spec
> 5.4.2.1). What would be the best way to support this?

And why is this not possible with the existing code ? Not sure if I
understood it right, I am assuming you are mentioning that it is not
possible.

> - Allow DTS forcing the PSCI power domains even if OSI enablement fails?

Meaning DTS flag for this ? If OSI enable fails, why would you want to
still proceed. It is non-compliant and must be fixed if the firmware
supports OSI and expects OSPM to use the same.

> - Add a separate cpuidle driver?

I would avoid that.

> - Just forget about it and use plain PSCI as we currently do?
>

Worst case yes. My main worry is how many of the old SDM SoC has such a
behaviour and how much they wary from each other. The OSI mode was pushed
after lengthy discussions to support all these platforms and now we have
platforms needing separate idle driver ?

> Additional topic: for one of idle states the vendor kernel uses a
> proprietary call into the hypervisor ([3]).

Again I would say it is not spec compliant.

> Up to now we have ignored this, as 8996 seems to be the only platform using
> it. I suppose that adding it to cpuidle-psci.c would be frowned upon.

Indeed.

> Is this assumption correct? Would it add another point for adding a separate
> cpuidle driver?
>

I am getting a sense that this would be cleaner approach but I would like
to understand how much of these non-compliance is carried to the other
relatively newer SoCs. I understand this is atleast 5-6+ years old. I don't
want this to set example to deviate from standard driver by adding new
drivers though they all are supposedly using PSCI(and are not fully compliant)

-- 
Regards,
Sudeep
