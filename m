Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0A3031EA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbhAYQty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 11:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730898AbhAYQsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 11:48:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF43C06174A;
        Mon, 25 Jan 2021 08:47:46 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db004bb0ee0cb7e01378.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:4bb0:ee0c:b7e0:1378])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E6501EC030D;
        Mon, 25 Jan 2021 17:47:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611593265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rdgdewiP8uEqbySFbsQDrD2mgjAvnq0DN8qikHvj1so=;
        b=MjauNt9evW7EG+RirFgosxdrqg2OAGY1aY2WlBeazQhhY1A/12A8NfhTtOmtEYmcv1JZNj
        6fxXAbjTNAHmkQtfGI9nIY9EdVfc2ZWSbCEWBWN2uwpTxDOZSHZm7fBqCwooQjMmAOchWT
        ngFNuz00TxdLhP52Dmx6j798FMn6e+4=
Date:   Mon, 25 Jan 2021 17:47:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     X86 ML <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
Message-ID: <20210125164739.GG23070@zn.tnic>
References: <20210125130533.19938-1-bp@alien8.de>
 <20210125130533.19938-3-bp@alien8.de>
 <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 25, 2021 at 11:42:14PM +0800, Zhang Rui wrote:
> Agreed.

Ok I'll queue the stuff in tip if there are no objections. It is a lot
easier this way...

> just one question,
> there are many overlaps between this kernel thermal throttling code and
> the x86_pkg_temp_thermal driver, is it possible to combine these two
> pieces of code altogether?

You've CCed the right guy - I think Srinivas should be able to answer
that question.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
