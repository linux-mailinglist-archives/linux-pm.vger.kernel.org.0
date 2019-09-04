Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA117A8184
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfIDLwY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 07:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDLwX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 07:52:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DAA2186A;
        Wed,  4 Sep 2019 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597942;
        bh=kuCVKYWh39HzDMNH8mGuQqkKXwZBKKGFW1o2IwBcDNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oPxsAZPafFSsKg2yN0LcN0yRhMK6udynUICY5+314QrRk7gXHyPCNjgweDqCfI6z
         /9cgxpryogget7bzs9QSfNXEm8WXn0EwnYWxXKlK+tq5dz0f67o1pCQAir8cZ9MtmQ
         szy59+6QxWHJx6QXkp8fxhlZQHVY+Zs8lGuuExsY=
Date:   Wed, 4 Sep 2019 13:52:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v10 06/13] drivers: memory: extend of_memory by LPDDR3
 support
Message-ID: <20190904115220.GA9370@kroah.com>
References: <CGME20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f@eucas1p2.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com>
 <20190614095309.24100-7-l.luba@partner.samsung.com>
 <CAJKOXPcDDyYmuX-RpkpxKSBK2JfV=tYakn+g8FM5Lau+rmkm+g@mail.gmail.com>
 <2e35d4bc-92b9-cba7-bd05-a41a1dcb300e@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e35d4bc-92b9-cba7-bd05-a41a1dcb300e@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 03:34:48PM +0200, Lukasz Luba wrote:
> 
> 
> On 6/14/19 2:43 PM, Krzysztof Kozlowski wrote:
> > On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >>
> >> The patch adds AC timings information needed to support LPDDR3 and memory
> >> controllers. The structure is used in of_memory and currently in Exynos
> >> 5422 DMC. Add parsing data needed for LPDDR3 support.
> >> It is currently used in Exynos5422 Dynamic Memory Controller.
> >>
> >> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
> >>   drivers/memory/of_memory.h |  18 +++++
> >>   include/memory/jedec_ddr.h |  62 +++++++++++++++
> >>   3 files changed, 234 insertions(+)
> > 
> > Previously this was going through Greg, so if I am going to take it
> > along with drivers/memory/samsung patches, I need some acks.
> > 
> > Greg, Rob,
> > Are you okay with this patch and with taking it through samsung-soc?
> 
> Greg, Rob: gentle ping.
> 
> Currently there is a v13, with only minor changes to this patch:
> https://lkml.org/lkml/2019/8/21/289
> (you are on cc list of the patch set)
> 
> Could you please have a look. Thank you.

I don't seem to be able to find this anywhere in my tree.  And I don't
remember being the maintainer of drivers/memory/ so don't wait for
anything from me!

greg k-h
