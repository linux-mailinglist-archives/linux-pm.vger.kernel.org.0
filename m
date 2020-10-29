Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E729F8E6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 00:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJ2XLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 19:11:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2XLX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 19:11:23 -0400
Received: from zn.tnic (p200300ec2f0ce900b7c12963b584fd72.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e900:b7c1:2963:b584:fd72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE19C1EC0258;
        Fri, 30 Oct 2020 00:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604013082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=koqRWZmo0e5vtCu9n2okG5w+NCun2XvjE+ynY2NDFTo=;
        b=Tng99f1xnIXhDLMhQYqYej0lMYHojGpbM0FXsH8zevIe+6rSq5bYSHYQuAlCprRXSvXGrl
        XqdXnzgTJNzvj5Ye/9wZ4iZy3Sw9ORKg3w1mkSbn7BTmeDYyafLOS4fPY4K/v+1mHKwGp7
        vNyay3oV2Cumj6CViMn8mq9G/8JPEAk=
Date:   Fri, 30 Oct 2020 00:11:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
Message-ID: <20201029231113.GG31903@zn.tnic>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
 <20201016083754.GB8483@zn.tnic>
 <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
 <20201029215929.GF31903@zn.tnic>
 <e0d61fa5-03b9-1761-1578-f4fb5ce54d96@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0d61fa5-03b9-1761-1578-f4fb5ce54d96@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 04:32:43PM -0600, Shuah Khan wrote:
> if (numwritten < 1) {
> +        perror("write failed");
> 
> Please add filename to the error message.

Yes, you said so already and will do that in the next version.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
