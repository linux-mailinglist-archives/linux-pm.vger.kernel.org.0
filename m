Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3F64A1D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGJPwr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 11:52:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:1529 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfGJPwr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 11:52:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 08:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="193093515"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2019 08:52:46 -0700
Message-ID: <7bf4e1099fb5892446e1202ec0743367c77f9e6e.camel@linux.intel.com>
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore
 file
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        David Arcari <darcari@redhat.com>
Date:   Wed, 10 Jul 2019 08:52:46 -0700
In-Reply-To: <b0d763a8-7f07-db47-3a99-6bb21db3bb0b@redhat.com>
References: <20190708231725.11353-1-prarit@redhat.com>
         <CAHp75VeyUK_ohxPwTg988gXugRh=y5QxT1zhSCmKoG5-CutRnQ@mail.gmail.com>
         <b0d763a8-7f07-db47-3a99-6bb21db3bb0b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let me send this patch on your behalf.

Thanks,
Srinivas

On Wed, 2019-07-10 at 08:21 -0400, Prarit Bhargava wrote:
> 
> On 7/9/19 12:39 PM, Andy Shevchenko wrote:
> > On Tue, Jul 9, 2019 at 2:17 AM Prarit Bhargava <prarit@redhat.com>
> > wrote:
> > > 
> > > Add a .gitignore file for build include/ and final binary.
> > > 
> > 
> > It has improper Cc list (No PDx86, no its maintainers, no LKML,
> > which
> > is also requirement to send patches to PDx86).
> > Please, gather the tags you got and send v2 with properly formed Cc
> > list.
> > 
> 
> The problem is that get_maintainer.pl is throwing an error when I run
> it on this
> patch so I had to make a guess at the cc list.
> 
> ie) Bad divisor in main::vcs_assign: 0
> 
> I'll backup a couple of versions of get_maintainer.pl and see if that
> works.  If
> not, should I just copy the cc list from Srinivas' original patchset?
> 
> P.
> 
> > > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Cc: David Arcari <darcari@redhat.com>
> > > ---
> > >  tools/power/x86/intel-speed-select/.gitignore | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
> > > 
> > > diff --git a/tools/power/x86/intel-speed-select/.gitignore
> > > b/tools/power/x86/intel-speed-select/.gitignore
> > > new file mode 100644
> > > index 000000000000..f61145925ce9
> > > --- /dev/null
> > > +++ b/tools/power/x86/intel-speed-select/.gitignore
> > > @@ -0,0 +1,2 @@
> > > +include/
> > > +intel-speed-select
> > > --
> > > 2.21.0
> > > 
> > 
> > 

