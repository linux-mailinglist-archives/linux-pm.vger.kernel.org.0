Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716921122DC
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 07:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfLDG0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 01:26:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:8494 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfLDG0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 01:26:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 22:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,276,1571727600"; 
   d="scan'208";a="236167818"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2019 22:26:02 -0800
Message-ID: <dc1bc99ecfc6095d54a43cac1523984f4034dd72.camel@intel.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Eduardo's email is bouncing
From:   Zhang Rui <rui.zhang@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "eduval@amazon.com" <eduval@amazon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Wed, 04 Dec 2019 14:26:01 +0800
In-Reply-To: <c4c94fc3-2b57-188a-1b91-c0889e593049@gmail.com>
References: <20191123154303.2202-1-f.fainelli@gmail.com>
         <CAHLCerPKQSLrgybYhhFDxjXu56BD+iAyz1OYF14rTbjotEkD7g@mail.gmail.com>
         <b146b35e4434a0bf57dfd8052b2b455f06fa46ab.camel@intel.com>
         <744357E9AAD1214791ACBA4B0B90926377666A90@SHSMSX108.ccr.corp.intel.com>
         <c4c94fc3-2b57-188a-1b91-c0889e593049@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-12-03 at 20:56 -0800, Florian Fainelli wrote:
> 
> On 11/26/2019 7:34 AM, Zhang, Rui wrote:
> > Let's try Eduardo' Amazon email account before applying this one.
> 
> How much longer do you want to give Eduardo a chance to respond?
> 
> I would like to draw your attention towards the response time of the
> thermal subsystem maintainers for a subsystem that is say medium in
> traffic.
> 
> You guys need to step up your game and give some feedback within days
> and not weeks of patches being submitted, especially if this is after
> 2
> or 3 requests to get feedback.
> 
> If all of you are busy which is completely understandable then maybe
> it
> is time to seek help from someone else (Daniel?) who gives timely
> feedback to patches submissions.
> 

First of all, I don't want to add any new patch during the merge
window. And this patch will be applied and pushed once after -rc1
released.
Plus, I've already synced with Daniel, in private email though, and I
will send an incremental patch to add Daniel as the co-maintainer of
the thermal subsystem.

thanks,
rui


