Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF117355D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgB1Kcj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 05:32:39 -0500
Received: from foss.arm.com ([217.140.110.172]:36262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgB1Kcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Feb 2020 05:32:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E58D4B2;
        Fri, 28 Feb 2020 02:32:38 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C973F73B;
        Fri, 28 Feb 2020 02:32:36 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:32:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        rjw@rjwysocki.net, pkondeti@codeaurora.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/7] arm64: add support for the AMU extension v1
Message-ID: <20200228103234.GA3904776@arrakis.emea.arm.com>
References: <20200226132947.29738-1-ionela.voinescu@arm.com>
 <20200226132947.29738-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226132947.29738-2-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On Wed, Feb 26, 2020 at 01:29:41PM +0000, Ionela Voinescu wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dbc22d684627..49f0c436928f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -318,6 +318,15 @@
>  			Format: <a>,<b>
>  			See also Documentation/input/joydev/joystick.rst
>  
> +	amu=		[ARM64]
> +			Enables or disables detection, enablement and access to
> +			counter registers of the Activity Monitors Unit (AMU).
> +			Format: amu=[0/1/on/off/y/n]
> +			amu=[0/off/n] ensures access to AMU's counter registers
> +				      is not attempted.
> +			amu=[1/on/y] (default) enables detection and access to
> +				     AMU's counter registers.

Is the only reason for this parameter to be able to disable the feature
if the firmware doesn't support it? According to the Kconfig entry, you
may see weird behaviour, firmware lock-up. Is the user supposed to try
again with amu=0?

I'm not particularly fond of adding kernel parameters to work around
broken firmware. We have other architecture features (e.g. PtrAuth) that
need enabling at EL3 but we don't have such parameters. If it's likely
that we hit this issue in practice, I'd rather have the firmware
describing the presence of AMU via some DT entry. But I'd rather not
bother at all, just get the vendors to update their firmware.

If we drop this parameter, patch 1 would need to change. Otherwise the
patches look fine.

Thanks.

-- 
Catalin
