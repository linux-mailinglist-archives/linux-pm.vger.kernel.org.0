Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4B79E84B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjIMMtw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 13 Sep 2023 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbjIMMtv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 08:49:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE619B9
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 05:49:47 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378560934"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378560934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="809665559"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="809665559"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:49:07 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 039CD580DCD;
        Wed, 13 Sep 2023 05:49:05 -0700 (PDT)
Message-ID: <81abd4de9da3a8e93c80ef67127323e03cf779a0.camel@gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Date:   Wed, 13 Sep 2023 15:49:04 +0300
In-Reply-To: <CAJZ5v0jzJTjOE4zbVnVuhegXC7+n0eu0v9vEsSVTFc37-p29zw@mail.gmail.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
         <52419d763dbd93e91499084c2bf4c04b199857a3.camel@gmail.com>
         <33af8e4b992f766b14b3b42939f5ae7701837847.camel@gmail.com>
         <CAJZ5v0jzJTjOE4zbVnVuhegXC7+n0eu0v9vEsSVTFc37-p29zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2023-09-13 at 14:34 +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 13, 2023 at 1:37 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > 
> > On Mon, 2023-08-28 at 19:43 +0300, Artem Bityutskiy wrote:
> > > Hi,
> > > 
> > > On Mon, 2023-07-10 at 12:30 +0300, Artem Bityutskiy wrote:
> > > 
> > > > Artem Bityutskiy (4):
> > > >   x86/umwait: use 'IS_ENABLED()'
> > > >   x86/mwait: Add support for idle via umwait
> > > 
> > > If these 2 patches are OK now, is there a chance to get them merged?
> > 
> > Hi, I wonder if these 2 patches have any chances to get merged?
> > 
> > May be there is something I am expected to do have not done? If so, please,
> > accept my apologies and give me a direction.
> 
> I think that they were based on the Arjan\s changes that got dropped.
> If so, they need to be rebased and resent.

The above quoted 2 patches are x86 bits, they introduce the basic umwait
primitives. They are not based on Arjan's patches. They still apply cleanly, and
do not need a refresh, as far as I can see.

I was hoping to get arch/x86 bits merged. Then I would send the refreshed
version of the intel_idle patches.

Thanks,
Artem.
