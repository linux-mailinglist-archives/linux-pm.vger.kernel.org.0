Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A650401C1E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhIFNNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 09:13:07 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242248AbhIFNNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 09:13:06 -0400
X-UUID: 914c3f745aa7413a9e4f4783199892d9-20210906
X-UUID: 914c3f745aa7413a9e4f4783199892d9-20210906
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1333497375; Mon, 06 Sep 2021 21:11:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Sep 2021 21:11:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Sep 2021 21:11:56 +0800
Message-ID: <6d178fd86ea5874ddcac7515d461d00c441cfadc.camel@mediatek.com>
Subject: Re: [PATCH v15 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 6 Sep 2021 21:11:56 +0800
In-Reply-To: <20210906094309.rcacbme27zpvdd4a@vireshk-i7>
References: <1630658364-6192-1-git-send-email-hector.yuan@mediatek.com>
         <1630658364-6192-3-git-send-email-hector.yuan@mediatek.com>
         <20210906094309.rcacbme27zpvdd4a@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-09-06 at 15:13 +0530, Viresh Kumar wrote:
> On 03-09-21, 16:39, Hector Yuan wrote:
> > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > 
> > Add of_perf_domain_get_sharing_cpumask function to group cpu
> > to specific performance domain.
> > 
> > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > ---
> >  include/linux/cpufreq.h |   46
> > +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> To speed things up, I have applied this with following changes.
> Please
> test my branch and see if something breaks:
> 
> 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq*arm*linux-next__;Ly8!!CTRNKA9wMg0ARbw!1FkaXVRm8cyf4CDTMMNDmFZ3X8eLd3gf1jK92brq9m-OryGK_peVZW963ettt0DF588$
>  
> 
Hi, Viresh:

I've tested the code in your branch and its okay. Thanks for the review
and your guideness. Thanks.

