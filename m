Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989E915AFB9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBLS1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 13:27:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLS1K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 13:27:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276DF30E;
        Wed, 12 Feb 2020 10:27:10 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8D93F68E;
        Wed, 12 Feb 2020 10:27:09 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:27:08 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        mark.rutland@arm.com, maz@kernel.org, linux-doc@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com,
        lukasz.luba@arm.com
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
Message-ID: <20200212182708.GA25105@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-2-ionela.voinescu@arm.com>
 <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
 <20200212161045.GA7475@arm.com>
 <ade32e03-b56b-7c5d-628d-124e52279d34@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade32e03-b56b-7c5d-628d-124e52279d34@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 12 Feb 2020 at 16:24:42 (+0000), Vladimir Murzin wrote:
> Hi,
> 
> On 2/12/20 4:10 PM, Ionela Voinescu wrote:
> > Hi Suzuki,
> > 
> > On Wednesday 12 Feb 2020 at 11:30:44 (+0000), Suzuki Kuruppassery Poulose wrote:
> >>> +static int __init set_disable_amu(char *str)
> >>> +{
> >>> +	int value = 0;
> >>> +
> >>> +	disable_amu = get_option(&str, &value) ? !!value : true;
> >> minor nit: You could simply use strtobool(str) here, which accepts:
> >>
> >> disable_amu= [0/1/on/off/y/n]
> >>
> > Yes, this was intentional as I wanted "disable_amu" to be a valid option
> > as well, not only "disable_amu=<option>".
> > 
> > If you don't mind I'd like to keep it like this. Currently the use of
> > AMU is enabled by default, and the most common kernel parameter to
> > disable it would be "disable_amu". Allowing "disable_amu=0" is just in
> > case we change the default in the kernel to not support AMU and we'd
> > like platforms to be able to enable it. 
> > 
> 
> Sorry for jumping into thread, but can we avoid negatives into naming which
> accept values? If is always tricky to get expected effect when both are combined.
> 
> If value doesn't really mater than can it be just "noamu"?
> 
> If value does matter can it be (per Suzuki) amu=[0/1/on/off/y/n]?
> 
> Or can you postpone introduction of "just in case" option till that case happens?
>

No worries, thank you very much for the input. I'll change it to
amu=[0/1/on/off/y/n] for clarity.

Thank you,
Ionela.

> Cheers
> Vladimir
