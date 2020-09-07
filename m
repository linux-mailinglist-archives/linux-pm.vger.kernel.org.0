Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF5260711
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 00:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgIGW6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 18:58:06 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:56178 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727119AbgIGW6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 18:58:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9C6AD837F24D;
        Mon,  7 Sep 2020 22:58:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3874:4321:5007:9040:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13071:13075:13255:13311:13357:13439:14180:14659:21060:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wool49_5e16e12270cf
X-Filterd-Recvd-Size: 1397
Received: from XPS-9350 (cpe-72-134-242-36.natsow.res.rr.com [72.134.242.36])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 22:58:01 +0000 (UTC)
Message-ID: <1f22437045f1782f472291a747664fd3bad9d421.camel@perches.com>
Subject: Re: [PATCH 1/4] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Mon, 07 Sep 2020 15:58:00 -0700
In-Reply-To: <202009080519.SXudMmrU%lkp@intel.com>
References: <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
         <202009080519.SXudMmrU%lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-08 at 05:24 +0800, kernel test robot wrote:
> Hi Joe,

Hi robot.

> I love your patch! Yet something to improve:

Nothing really to improve as these are dependent
on a previous patch that this robot did not apply.


