Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB96515AC07
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBLPg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 10:36:27 -0500
Received: from foss.arm.com ([217.140.110.172]:34174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgBLPg1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 10:36:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B54328;
        Wed, 12 Feb 2020 07:36:26 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909A13F68F;
        Wed, 12 Feb 2020 07:36:24 -0800 (PST)
Subject: Re: [PATCH v3 3/7] arm64/kvm: disable access to AMU registers from
 kvm guests
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-4-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a4d66284-a0fc-4bbb-3a98-ea4093bcf389@arm.com>
Date:   Wed, 12 Feb 2020 15:36:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211184542.29585-4-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/02/2020 18:45, Ionela Voinescu wrote:
> Access to the AMU counters should be disabled by default in kvm guests,
> as information from the counters might reveal activity in other guests
> or activity on the host.
> 
> Therefore, disable access to AMU registers from EL0 and EL1 in kvm
> guests by:
>  - Hiding the presence of the extension in the feature register
>    (SYS_ID_AA64PFR0_EL1) on the VCPU.
>  - Disabling access to the AMU registers before switching to the guest.
>  - Trapping accesses and injecting an undefined instruction into the
>    guest.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com> 
