Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA48A5CB1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIBTbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:31:24 -0400
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:35161 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbfIBTbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 15:31:24 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 15:31:23 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 30F80182888A2
        for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2019 19:24:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 848D3999D;
        Mon,  2 Sep 2019 19:24:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3871:4184:4321:5007:7903:8531:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:14915:21060:21080:21451:21611:21627:30022:30054:30070:30090:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: idea71_260a5d3da1f24
X-Filterd-Recvd-Size: 1675
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Sep 2019 19:24:21 +0000 (UTC)
Message-ID: <6c8bbcbe2f3af638d2286baf1acc9bfb723bf95b.camel@perches.com>
Subject: Re: [PATCH] power: reset: reboot-mode: Fix author email format
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sre@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     matwey.kornilov@gmail.com,
        "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Sep 2019 12:24:20 -0700
In-Reply-To: <20190902190622.vvl7hcgfqayf6xmk@earth.universe>
References: <20190713154248.24382-1-matwey@sai.msu.ru>
         <20190902190622.vvl7hcgfqayf6xmk@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-09-02 at 21:06 +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Jul 13, 2019 at 06:42:48PM +0300, Matwey V. Kornilov wrote:
> > Closing angle bracket was missing.
> > 
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> 
> Thanks, queued.

This is relatively widespread.

There are 80 more of these in the kernel tree.

$ git grep -P 'MODULE_AUTHOR.*<[^>]+$' | wc -l
81

Here's a trivial little script to fix them all:

$ git grep -P -n 'MODULE_AUTHOR.*<[^>]+$' | \
  while read entry ; do \
    file=$(echo $entry|cut -f1 -d:); \
    line=$(echo $entry|cut -f2 -d:); \
    sed -i "${line}s/\");/>\");/" $file; \
  done

