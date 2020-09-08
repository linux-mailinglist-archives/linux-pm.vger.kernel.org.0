Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C97260DC2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgIHIkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 04:40:24 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:48732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729234AbgIHIkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 04:40:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 35BFF181D330D;
        Tue,  8 Sep 2020 08:40:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3873:3874:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13439:14659:14721:21080:21433:21627:21990:30012:30029:30045:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brass58_2210106270d3
X-Filterd-Recvd-Size: 3468
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Sep 2020 08:40:20 +0000 (UTC)
Message-ID: <97e79472f42c8d4fd04acfbde62d014e4ca33917.camel@perches.com>
Subject: Re: [PATCH 2/4] drivers core: Remove strcat uses around sysfs_emit
 and neaten
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 08 Sep 2020 01:40:19 -0700
In-Reply-To: <20200908083249.GB704757@kroah.com>
References: <cover.1599501047.git.joe@perches.com>
         <4efea815a9fddfc0dc1b29d16f7485de0f8ee866.1599501047.git.joe@perches.com>
         <20200908083249.GB704757@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-08 at 10:32 +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 10:58:06AM -0700, Joe Perches wrote:
> > strcat is no longer necessary for sysfs_emit and sysfs_emit_at uses.
> > 
> > Convert the strcat uses to sysfs_emit calls and neaten other block
> > uses of direct returns to use an intermediate const char *.
[]
> This function is now longer, with an assignment that is not needed
> (type=NULL), so why make this "cleanup"?

It's smaller object code.

[]
> > Again, not a type, it's a state.  And you did not merge all sysfs_emit()
> calls into one here, so it's messier now, don't you think?

You can't because the default type uses an argument and not
a fixed string.  I don't think it's messier, no.

> >  int memory_notify(unsigned long val, void *v)
> > @@ -307,17 +305,16 @@ static ssize_t phys_device_show(struct device *dev,
> >  }
> >  
> >  #ifdef CONFIG_MEMORY_HOTREMOVE
> > -static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
> > -		unsigned long nr_pages, int online_type,
> > -		struct zone *default_zone)
> > +static int print_allowed_zone(char *buf, int len, int nid,
> > +			      unsigned long start_pfn, unsigned long nr_pages,
> > +			      int online_type, struct zone *default_zone)
> 
> Unrelated change :(

No it's not, it's outputting to buf so it
needs len to output to appropriate spot to
be able to use sysfs_emit_at.

> >  {
> >  	struct zone *zone;
> >  
> >  	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
> > -	if (zone != default_zone) {
> > -		strcat(buf, " ");
> > -		strcat(buf, zone->name);
> > -	}
> > +	if (zone == default_zone)
> > +		return 0;
> > +	return sysfs_emit_at(buf, len, " %s", zone->name);

here.

> []

> This is better.

All of it is better. <smile>

> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
[]
> > @@ -255,9 +255,9 @@ static ssize_t pm_qos_latency_tolerance_us_show(struct device *dev,
> >  	s32 value = dev_pm_qos_get_user_latency_tolerance(dev);
> >  
> >  	if (value < 0)
> > -		return sysfs_emit(buf, "auto\n");
> > +		return sysfs_emit(buf, "%s\n", "auto");
> >  	if (value == PM_QOS_LATENCY_ANY)
> > -		return sysfs_emit(buf, "any\n");
> > +		return sysfs_emit(buf, "%s\n", "any");
> >  
> >  	return sysfs_emit(buf, "%d\n", value);
> >  }
> 
> Unrelated change :(

Again, no it's not unrelated, it's consistent.


