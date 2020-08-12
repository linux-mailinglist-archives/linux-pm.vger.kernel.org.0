Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BAA242467
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLDvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 23:51:37 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:40552 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgHLDvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 23:51:37 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 0AAFF18005B1E;
        Wed, 12 Aug 2020 03:51:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3ED6C8378BB9;
        Wed, 12 Aug 2020 03:51:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:4184:4321:5007:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14659:21060:21080:21222:21451:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crow00_520afc026fe8
X-Filterd-Recvd-Size: 2088
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 03:51:33 +0000 (UTC)
Message-ID: <d5af6b286fa6c9de8d71075b657b952bf775e557.camel@perches.com>
Subject: Re: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
From:   Joe Perches <joe@perches.com>
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Date:   Tue, 11 Aug 2020 20:51:31 -0700
In-Reply-To: <d7a19f05497b4137bacd639e576b7166e4a19842.camel@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
         <20200811153149.12242-3-rui.zhang@intel.com>
         <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
         <d7a19f05497b4137bacd639e576b7166e4a19842.camel@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-12 at 11:29 +0800, Zhang Rui wrote:
> Hi,
> 
> Thanks for reviewing.
> 
> On Tue, 2020-08-11 at 11:19 -0700, Joe Perches wrote:
> > On Tue, 2020-08-11 at 23:31 +0800, Zhang Rui wrote:
> > > There will be more platforms with different fixed energy units.
> > > Enhance the code to support different rapl unit quirks for
> > > different
> > > platforms.
> > 
> > This seems like one quirk per platform.
> > 
> > Should multiple quirks on individual platforms be supported?
> > 
> enum rapl_unit_quirk is just used as a flag.
> multiple quirks can be deployed with the same flag, just like what I
> did in patch 3/3.
> Also different platforms can either have different flags or share the
> same flag.

Sure, but it does lead to possible code duplication in the quirks
as enums can not be combined like bit flags.

No worries, your code, your choice...

