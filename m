Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B22516B0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHYKf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:35:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:12272 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgHYKfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598351753;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8p4pt70rYl2YWhdxdIzzZLImHV6uhJpM2ohDsVuBjnM=;
        b=TXosNAgAo/T9uQzZsbMr0ZLipFPQrDv40/x2H7s8E/3KuMD1kPmfIpe3uT47RERljE
        R38kNnsl1BX7hCj7ZKlDuVji7CZE2eEgUVzqkgxQ4S8DuEFC3Z5Xbu8T0jXfyWX+BKfe
        rSnaOjLZ9XIS5m2ax+7qZhdQaNpd3XBkXrZp7Nh96JtAZPrSGiRx2qN4drTWAyOi7pA0
        krf+Z3ZeTJmpdebiBgaLdX4koM87KsRWgeB1R0DLjjJkjoUTPDoyUFeGWUXFKvhnDcir
        DcbOdnHVRcwUZvFU3bkfxDu6iO9QqtbExgQQj0srUi3pqiV8uxuDpXEWhVe6lOnXN1Mz
        VJqg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IcjDBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7PAZre9f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 12:35:53 +0200 (CEST)
Date:   Tue, 25 Aug 2020 12:35:44 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200825103407.GA847@gerhold.net>
References: <20200825074452.GA1322@gerhold.net>
 <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
 <20200825085740.GA855@gerhold.net>
 <20200825095633.wzlpsxhabkfd27km@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825095633.wzlpsxhabkfd27km@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 03:26:33PM +0530, Viresh Kumar wrote:
> On 25-08-20, 10:57, Stephan Gerhold wrote:
> > but it doesn't mention anything about the problem I described
> > ("conflicting" ranges for one of the "sub-versions").
> > 
> > I have to admit that I keep getting confused with these bit masks...
> > I think this is also one option I considered but actually it doesn't
> > work:
> > 
> > Essentially you suggest to encode a version using:
> > 
> > static int ver(int version1, int version2) {
> > 	return BIT(version1) << 16 | BIT(version2);
> > }
> > 
> > Now let's take a look at my example again:
> > 
> > So for the versions I mentioned we get:
> >   - ver(0, 1) = 0x10002
> >   - ver(1, 0) = 0x20001
> >   - ver(1, 1) = 0x20002
> >   - ver(0, 0) = 0x10001 (this one should be excluded)
> > 
> > So to mark v0.1, v1.0 and v1.1 as supported I'd set:
> >      opp-supported-hw = <(ver(0, 1) | ver(1, 0) | ver(1, 1))>;
> > i.e. opp-supported-hw = <0x30003>;
> > 
> > Now let's say I'm running v0.0 = 0x10001. This version should not
> > support the OPP. But actually 0x30003 & 0x10001 = 0x10001 != 0,
> > so the OPP would consider it as supported.
> > 
> > I tried many different approaches, but you end up being unable to
> > control subversions independently for most of them.
> 
> This should work fine for your case I believe, with two 32 bit words.
> 
> static int ver(int version1, int version2)
> {
> 	return BIT(version1 * 8 + version2); //Here 8 is size-of version2
> }
> 

Actually this does not work properly either, at least if you have
64 possible versions :-)

Let's take version v5.0 for example:

	ver(5, 0) = BIT(5 * 8 + 0) = BIT(40) = <0x00000100 0x00000000>

For each of the two masks the OPP core checks:

	if (!(version & opp_table->supported_hw[count]))
		return false;

The second 0x00000000 will always run into "return false",
because 0 & <something> = 0.

I suppose something like this could work if you need 63 versions only.
For all versions > 32 you would set one particular bit in the second
version, e.g. <0x00000100 0x00000001>, only to make the check happy.

For 64 versions it would work with three 32 bit words, in my case
I could probably ignore one of the versions and fit it into the two
32 bit words with some weird glue code.

But at least in my opinion this is getting to the point where this will
be terribly complicated to understand from looking at the device tree.

> Okay, the binding doesn't really work well with subversions properly (as I
> believed earlier), but because the implementation was simple enough and very
> basic we can still work around it in your specific case. I am not sure I want to
> touch the bindings at this point of time, unless they aren't workable for
> someone.
> 

Note that my original suggestion does not change the behavior of the
bindings for any of the existing uses. It just lets you define multiple
such version ranges for one OPP definition.

We know the number of version masks we want to check
(opp_table->supported_hw_count), then we check the number in the device
tree and if it's a multiple of supported_hw_count we check those ranges
separately.

While it's certainly not ideal to list several version masks there,
I think this would be the most readable and flexible way to handle
the "subversion issue".

Or I could just do it like in tegra20-cpu-opp.dtsi, and specify the OPPs
multiple times with different ranges. It works as-is, it's just quite
a bit of duplication. At least it's quite easy to understand.

What do you think? :)

Thanks!
Stephan
