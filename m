Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6A82C8625
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 15:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgK3ODE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 09:03:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgK3ODE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 09:03:04 -0500
Received: from zn.tnic (p200300ec2f0c0400b0063e9f0046aa3d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:400:b006:3e9f:46:aa3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 749601EC0473;
        Mon, 30 Nov 2020 15:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606744943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hbVilBsYbgMVMYEltX7p8R2H84M0rXfY7mrsu4hQtgI=;
        b=pIF6MUQHFwCKW2n6rOdNkhMQyndiabB32fJyFcn+0FW1CFAjOmX6YFky3LtrZgx/ie50Xv
        2T5kb+Dwwo1kwQzD6h5aFBAZDZzDe6PX5jsUhCKCJ3ad9/dQkjbulWyzCej0ALyOFG+UDN
        +sSWNUD1BXc5TjEQYSHliKdftXH/loU=
Date:   Mon, 30 Nov 2020 15:02:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 4/4] cpufreq: acpi-cpufreq: Use identifiers for AMD
 processor family
Message-ID: <20201130140224.GD6019@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125144847.3920-5-punitagrawal@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 25, 2020 at 11:48:47PM +0900, Punit Agrawal wrote:
> Replace the raw values for AMD processor family with recently
> introduced identifier macros to improve code readability and
> maintainability.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 29f1cd93541e..d8b8300ae9e0 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -202,8 +202,8 @@ static int override_acpi_psd(unsigned int cpu_id)
>  		 * CPU's before Zen3 (except some Zen2) need the
>  		 * override.
>  		 */
> -		return (c->x86 < 0x19) &&
> -			!(c->x86 == 0x17 && c->x86_model == 0x60 &&
> +		return (c->x86 < AMD_FAM_ZEN3) &&
> +			!(c->x86 == AMD_FAM_ZEN && c->x86_model == 0x60 &&

This is what I mean - that's Zen2 as the comment above says so having

		c->x86 == AMD_FAM_ZEN

is not enough. And you have a comment above it stating which CPUs are
matched here so I'm not sure those family defines make it any better...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
