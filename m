Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274B0210015
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgF3Wc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 18:32:58 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:41432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbgF3Wc6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 18:32:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A75F18029131;
        Tue, 30 Jun 2020 22:32:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1560:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3871:4321:4384:4605:5007:6119:6120:10004:10400:10848:11026:11657:11658:11914:12043:12048:12297:12555:12726:12737:12740:12760:12895:13069:13200:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: step63_201156426e7b
X-Filterd-Recvd-Size: 1899
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jun 2020 22:32:55 +0000 (UTC)
Message-ID: <e0bc6b4fa54612a09f1f05a779b8d506d9e0ac2f.camel@perches.com>
Subject: Re: [PATCH v14 2/4] dt-bindings: power: Convert battery.txt to
 battery.yaml
From:   Joe Perches <joe@perches.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, sre@kernel.org,
        pali@kernel.org, robh@kernel.org
Cc:     afd@ti.com, dmurphy@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sspatil@android.com
Date:   Tue, 30 Jun 2020 15:32:53 -0700
In-Reply-To: <20200630215426.26450-3-r-rivera-matos@ti.com>
References: <20200630215426.26450-1-r-rivera-matos@ti.com>
         <20200630215426.26450-3-r-rivera-matos@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-06-30 at 16:54 -0500, Ricardo Rivera-Matos wrote:
> bindings/power/supply/battery.txt

Do any of these also need updating?

Documentation/devicetree/bindings/power/supply/bq24190.txt:  See also Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/bq27xxx.yaml:       See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml:#   See also Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/sc2731_charger.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt:  See Documentation/devicetree/bindings/power/supply/battery.txt
Documentation/power/power_supply_class.rst:Documentation/devicetree/bindings/power/supply/battery.txt. This is

