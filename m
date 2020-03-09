Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F317E2EB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 15:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCIO5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 10:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgCIO5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 10:57:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1F421655;
        Mon,  9 Mar 2020 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583765844;
        bh=lKI8Yb8uZ3tBIe9X4wlAKYTXm/yXMD/FBLCurx3Ybds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JhpMNSKzrpZSjcFxvL6Ii+nhacGswhk8gehCkK+Eu0AsQMpo2Bf4KZRdeAeibLrmQ
         ZdB2DECIG4CtwARIQU1ytrj8fN+cvZyyaVFv7Ld7bc3gbmHuRdtqgIF6y5bY05dnbq
         ztSx+ssyOK9hjHm0wZi1g0s/VeSN+lZ/Nuqla/dI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBJqM-00BJCg-Ig; Mon, 09 Mar 2020 14:57:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 14:57:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v5 3/7] arm64/kvm: disable access to AMU registers from
 kvm guests
In-Reply-To: <20200309142529.GB13343@arm.com>
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-4-ionela.voinescu@arm.com>
 <46b89d0c9704e0a0fb7a4ac2a1fb5b7a@kernel.org>
 <20200309142529.GB13343@arm.com>
Message-ID: <e3c164afe9fdefe2a01ddbdf34e437a2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ionela.voinescu@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com, rjw@rjwysocki.net, pkondeti@codeaurora.org, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-09 14:25, Ionela Voinescu wrote:

Hi Ionela,

[now with everyone on cc...]

>> This will definitely conflict with some of the ongoing rework I 
>> have[1].
>> I'm happy to provide this as a stable branch for you to rebase on top,
>> or use an arm64 provided branch to rebase my stoff on top.
>> 
>> Just let me know how you want to proceed.
>> 
> 
> Catalin added the AMU patches on top of 5.6-rc3 at [1].
> Is this okay as a base branch for your patches?

Sure, no problem. I still need to respin those...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
