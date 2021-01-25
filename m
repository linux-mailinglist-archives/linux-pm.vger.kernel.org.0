Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4303028B5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbhAYRWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbhAYRTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 12:19:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62269C06174A;
        Mon, 25 Jan 2021 09:18:47 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db004bb0ee0cb7e01378.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:4bb0:ee0c:b7e0:1378])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED1321EC030D;
        Mon, 25 Jan 2021 18:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611595126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3LnLidjXkAWpZ9HKjYtcnNhAdymEIHQ/WYrF4J5x66M=;
        b=mm2Nq3EBHi0K7gEB8Ive52mXMjydmS5uj76BOCqVve73VVHdx2EbT3Fx09OHQ9/xT3uJhI
        FDNkjTiCSfRPVX0hnFtYdr7THy3lzYaW3PL5q2mCMzLj0oN2WWekPStIhpQcPtJPfM2mlY
        F8v67nqIV+ollYUQJ4Z4fsqONzKfT1Q=
Date:   Mon, 25 Jan 2021 18:18:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, X86 ML <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
Message-ID: <20210125171845.GJ23070@zn.tnic>
References: <20210125130533.19938-1-bp@alien8.de>
 <20210125130533.19938-3-bp@alien8.de>
 <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
 <9ee4051f627dd91020139b1d077a1fb01565d670.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ee4051f627dd91020139b1d077a1fb01565d670.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 25, 2021 at 09:14:35AM -0800, Srinivas Pandruvada wrote:
> Can the handler, processing architectural features via thermal
> interrupt, reside in arch/x86 folder or need to be
> drivers/thermal/intel?

Look at...

> > > @@ -718,7 +699,7 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
> > >  				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
> > >  	}
> > >  
> > > -	smp_thermal_vector = intel_thermal_interrupt;
> > > +	thermal_set_handler(intel_thermal_interrupt);

... here. ^

This should answer your question.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
