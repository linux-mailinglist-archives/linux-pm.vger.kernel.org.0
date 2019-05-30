Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB212FAD6
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE3LYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 07:24:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3LYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 07:24:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F33D6374;
        Thu, 30 May 2019 04:24:48 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7343E3F5AF;
        Thu, 30 May 2019 04:24:46 -0700 (PDT)
Date:   Thu, 30 May 2019 12:24:44 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] thermal: cpu_cooling: Make the power-related code
 depend on IPA
Message-ID: <20190530112442.kywpbophjkv2j2tq@queper01-lin>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-3-quentin.perret@arm.com>
 <20190530110356.vet2exwowdbm4umq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530110356.vet2exwowdbm4umq@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 30 May 2019 at 16:33:56 (+0530), Viresh Kumar wrote:
> On 30-05-19, 10:20, Quentin Perret wrote:
> > The core CPU cooling infrastructure has power-related functions
> > that have only one client: IPA. Since there can be no user of those
> > functions if IPA is not compiled in, make sure to guard them with
> > checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
> > unnecessarily.
> > 
> > Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
> >  1 file changed, 104 insertions(+), 110 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks !
Quentin
