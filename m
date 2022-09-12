Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029575B528F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 03:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILBm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 21:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiILBmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 21:42:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9825287
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662946974; x=1694482974;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GJpcgyMcQhv+B7DkUwoFDt+TdqwaCSJkF6qgSB39hZI=;
  b=OKp+pkff0rEUTICR5uf26HyYGqjFu49I1dm7XyQCe5nIBfMhla96U2uM
   /wcwp/au0jrGRM6ouNPnGK9pvytteOLYpSePkrqKXmxRUV25Xp3dc/e0u
   7NwSo9Zflxz9L/m4e3mIZ++1HCucR69NHRul60kFD0YjTA6gClCzFVLvq
   zmZOjNcpAgfzsbKRmXm5gUqY0WTztpoHbeAKP3yd1I0eXhqLwupzkhJvH
   YEueTtyfd0maoCCNyRSBnaIVTPwus/vSDvdYchheDe3uwH43jpQOj+HHm
   m1cmaiSK4X+0ZfoUhjTnkOqvUwsihZBrCqT/woREacAz0gQPjInmSu7qj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="297768530"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="297768530"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:42:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="566998935"
Received: from weiyangt-mobl1.gar.corp.intel.com ([10.213.44.106])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 18:42:51 -0700
Message-ID: <8054a5995388eca30f15de1cbc465bb101c6dbbc.camel@intel.com>
Subject: Re: Is Tigerlake Missing From intel_idle?
From:   Zhang Rui <rui.zhang@intel.com>
To:     Xhivat Hoxhiq <xhivo97@gmail.com>, linux-pm@vger.kernel.org
Date:   Mon, 12 Sep 2022 09:42:46 +0800
In-Reply-To: <CAGtpHi=bj9W3J-OcUW8UNDoXXVY3rMazktEwoEcagZ6BZXDzTQ@mail.gmail.com>
References: <CAGtpHi=f1+HCL+4kbfYGCC+qrLZasrpdT4peMF6t8-h-5h8KWA@mail.gmail.com>
         <87b82371d2a209dda3d63f57a3cc259783577616.camel@intel.com>
         <CAGtpHi=bj9W3J-OcUW8UNDoXXVY3rMazktEwoEcagZ6BZXDzTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2022-09-11 at 12:35 +0200, Xhivat Hoxhiq wrote:
> Hi Rui,
> 
> Thanks for the reply!
> 
> > intel_idle driver works with the cstate provided via _CST ACPI
> > control
> > method on any platform by default.
> 
> I see. Does this mean that C-States are entirely up to the vendor?
> 

Note that the _CST is also used by windows, and the cstates described
there have been validated.

> > I recalled that I did some measurement for TGL, but didn't find any
> > power/performance improvement using the measured latency numbers.
> 
> In terms of laptops, how device dependent is this? Would a customized
> table
> provide more consistent results over many different machines?
> 
> > May I know why you need a customized table?
> 
> To squeeze as much battery life as I can! I'll be honest, I am very
> new to this
> so I assumed the missing table for TGL was an issue. I wasn't aware
> _CST ACPI
> control is a thing. Would you say it's a wasted effort to have a
> customized
> table for TGL? Every other platform seems to have them.
> 
table for previous platforms were introduced at the time we don't have
_CST support in intel_idle driver.
table for AlderLake platform is introduced because we found some cases
that can not be handled by the _CST.

> Any other pros/cons to having a customized cstate table?

We have the base support from _CST.
custom table is an optimization, we will add it only if there is data
showing the benefit of doing so.

thanks,
rui

