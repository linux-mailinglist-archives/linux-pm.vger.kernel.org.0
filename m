Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F271277CB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfLTJPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:15:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55789 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfLTJPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 04:15:47 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3ef3e23fc2895822; Fri, 20 Dec 2019 10:15:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH 1/2] x86/cpu: Add Jasper Lake to Intel family
Date:   Fri, 20 Dec 2019 10:15:44 +0100
Message-ID: <10825235.GLIYtX2vNs@kreacher>
In-Reply-To: <20191216083345.2782-1-rui.zhang@intel.com>
References: <20191216083345.2782-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, December 16, 2019 9:33:44 AM CET Zhang Rui wrote:
> Japser Lake is an Atom family processor.
> It uses Tremont cores and is targeted at mobile platforms.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index c606c0b70738..4981c293f926 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -111,6 +111,7 @@
>  
>  #define INTEL_FAM6_ATOM_TREMONT_D	0x86 /* Jacobsville */
>  #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
> +#define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
>  
>  /* Xeon Phi */
>  
> 

Applying this one along with the [2/2] as 5.6 material, thanks!



