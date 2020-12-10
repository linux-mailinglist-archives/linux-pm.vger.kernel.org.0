Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9C2D6B81
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 00:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLJXEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 18:04:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389035AbgLJXEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 18:04:20 -0500
Received: from zn.tnic (p200300ec2f0d4100324f6551f32106f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:324f:6551:f321:6f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A70E41EC0380;
        Fri, 11 Dec 2020 00:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607641418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QHCDS5xknLkQSxrIZmTflSOoir1pkSLjwuD4Z1gvOmQ=;
        b=d3y7sXGGaX0ykclPID3Ma6JCsxGeZQPsM99z8xsROYspdcvDANHUUgSU2MHkJ0VtlmduYt
        00YPFiBU1BivZbLK7Q5BRmQTZD5078R/W7vWSoE3P/amVV1yEbyRD/wJVGbTnPFvGPLzdF
        RftBMJGpk9hNjR4BK3uhAMlZ4SS2hIw=
Date:   Fri, 11 Dec 2020 00:03:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: acpi-cpufreq: Add processor to the ignore
 PSD override list
Message-ID: <20201210230332.GH26529@zn.tnic>
References: <20201210225640.317719-1-punitagrawal@gmail.com>
 <20201210225640.317719-3-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210225640.317719-3-punitagrawal@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 07:56:40AM +0900, Punit Agrawal wrote:
> Booting Linux on a Zen2 based processor (family: 0x17, model: 0x60,
> stepping: 0x1) shows the following message in the logs -
> 
>     acpi_cpufreq: overriding BIOS provided _PSD data
> 
> Although commit 5368512abe08 ("acpi-cpufreq: Honor _PSD table setting
> on new AMD CPUs") indicates that the override is not required for Zen3
> onwards, it seems that domain information can be trusted even on
> certain earlier systems. Update the check, to skip the override for
> Zen2 processors known to work without the override.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Wei Huang <wei.huang2@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

What about answers to those questions first?

https://lkml.kernel.org/r/20201208233216.GH27920@zn.tnic

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
