Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F92260D9A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgIHIda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 04:33:30 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:48892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729234AbgIHId0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 04:33:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 89BF218224D99;
        Tue,  8 Sep 2020 08:33:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2351:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3872:4321:5007:6119:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21433:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shake14_071231d270d3
X-Filterd-Recvd-Size: 1575
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Sep 2020 08:33:22 +0000 (UTC)
Message-ID: <cb6c0af0c9e729f87f3fdd8417115d66e3dc8b93.camel@perches.com>
Subject: Re: [PATCH 1/4] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 08 Sep 2020 01:33:21 -0700
In-Reply-To: <20200908082722.GA704757@kroah.com>
References: <cover.1599501047.git.joe@perches.com>
         <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
         <20200908082722.GA704757@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-08 at 10:27 +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 10:58:05AM -0700, Joe Perches wrote:
> > Convert the various sprintf fmaily calls in sysfs device show functions
> > to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.
> 
> But no sysfs_emit_at() calls are used in this patch :(

Try patch 4.

No instance where it was appropriate to use sysfs_emit_at
matched the cocci script requirements in this directory.


