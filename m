Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD2172911
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgB0T6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 14:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbgB0T6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 14:58:36 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA48924699;
        Thu, 27 Feb 2020 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582833514;
        bh=x3vROII1fesL5Z7wihX+F7A34FxrSIHnIzf7GM+zPQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aiIz6iBHZl7rsJ4UGi3Jb2Bj0iBPC75Qn40xSaLvnPfRdMa3Kej+NqJOv+/Ixc8m7
         3YwqMoPS0wfx/OmuIOEtqhX5zTtxyqHcEG5I7S9BchKPuXJOoE4G1dSZrv6IP4cJJY
         8rEJav84fNde49QXjhO85ssR9qaEM2FN3mq/yk9E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j7PIm-008YY2-QX; Thu, 27 Feb 2020 19:58:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 19:58:32 +0000
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
In-Reply-To: <20200226132947.29738-4-ionela.voinescu@arm.com>
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-4-ionela.voinescu@arm.com>
Message-ID: <46b89d0c9704e0a0fb7a4ac2a1fb5b7a@kernel.org>
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

Hi Ionela,

On 2020-02-26 13:29, Ionela Voinescu wrote:
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
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Marc Zyngier <maz@kernel.org>

A small comment below:

[...]

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3e909b117f0c..44354c812783 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1003,6 +1003,20 @@ static bool access_pmuserenr(struct kvm_vcpu
> *vcpu, struct sys_reg_params *p,
>  	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
>  	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
> 
> +static bool access_amu(struct kvm_vcpu *vcpu, struct sys_reg_params 
> *p,
> +			     const struct sys_reg_desc *r)
> +{
> +	kvm_inject_undefined(vcpu);
> +
> +	return false;
> +}
> +
> +/* Macro to expand the AMU counter and type registers*/
> +#define AMU_AMEVCNTR0_EL0(n) { SYS_DESC(SYS_AMEVCNTR0_EL0(n)), 
> access_amu }
> +#define AMU_AMEVTYPE0_EL0(n) { SYS_DESC(SYS_AMEVTYPE0_EL0(n)), 
> access_amu }
> +#define AMU_AMEVCNTR1_EL0(n) { SYS_DESC(SYS_AMEVCNTR1_EL0(n)), 
> access_amu }
> +#define AMU_AMEVTYPE1_EL0(n) { SYS_DESC(SYS_AMEVTYPE1_EL0(n)), 
> access_amu }
> +
>  static bool trap_ptrauth(struct kvm_vcpu *vcpu,
>  			 struct sys_reg_params *p,
>  			 const struct sys_reg_desc *rd)
> @@ -1078,8 +1092,10 @@ static u64 read_id_reg(const struct kvm_vcpu 
> *vcpu,
>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
>  	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
> 
> -	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
> -		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +	if (id == SYS_ID_AA64PFR0_EL1) {
> +		if (!vcpu_has_sve(vcpu))
> +			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);

This will definitely conflict with some of the ongoing rework I have[1].
I'm happy to provide this as a stable branch for you to rebase on top,
or use an arm64 provided branch to rebase my stoff on top.

Just let me know how you want to proceed.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/debug-fixes-5.6&id=454fb7398d3626328f7f771c07d21e894e4e1a3b
-- 
Jazz is not dead. It just smells funny...
