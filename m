Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7512521BBFB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJRN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 13:13:56 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:60414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgGJRN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 13:13:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 25435182CED2A;
        Fri, 10 Jul 2020 17:13:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2376:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3870:4250:4321:4362:5007:6742:7903:10004:10400:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21939:30045:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shade61_3512d3f26ed0
X-Filterd-Recvd-Size: 1831
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Jul 2020 17:13:52 +0000 (UTC)
Message-ID: <db753175946cf53e77999d1fbb3cf949f777ef61.camel@perches.com>
Subject: Re: [PATCH v2] genpd: Fix up terminology with parent/child
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jul 2020 10:13:51 -0700
In-Reply-To: <202007081629.0840B4CB78@keescook>
References: <202007081629.0840B4CB78@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-07-08 at 16:32 -0700, Kees Cook wrote:
> The genpd infrastructure uses the terms master/slave, but such uses have
> no external exposures (not even in Documentation/driver-api/pm/*) and are
> not mandated by nor associated with any external specifications. Change
> the language used through-out to parent/child.

Thanks.

Perhaps change a couple more references:

$ grep -i -P '(?:master|slave)' drivers/cpuidle/cpuidle-psci-domain.c
	/* Link genpd masters/subdomains to model the CPU topology. */
$ grep -i -P '(?:master|slave)' drivers/opp/core.c
	 * genpd and its master have one to one mapping of performance states


