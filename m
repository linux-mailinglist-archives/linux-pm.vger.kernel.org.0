Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653126392E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIQSw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 12:18:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:6798 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQSw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 12:18:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 09:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="192735402"
Received: from spandruv-mobl3.jf.intel.com ([10.252.137.76])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2019 09:18:51 -0700
Message-ID: <699e770258725ae8e7c9597e0e4a4cb17e08de5e.camel@linux.intel.com>
Subject: Re: [PATCH v2] tools/power/x86/intel-speed-select: Add .gitignore
 file
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Arcari <darcari@redhat.com>
Date:   Tue, 09 Jul 2019 09:18:51 -0700
In-Reply-To: <CAJZ5v0j4fsqK=AwqtytDM-T-HwcsCzmyGamQ3ZOMNZngh=2oeQ@mail.gmail.com>
References: <20190708231725.11353-1-prarit@redhat.com>
         <CAJZ5v0j4fsqK=AwqtytDM-T-HwcsCzmyGamQ3ZOMNZngh=2oeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-07-09 at 10:17 +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 9, 2019 at 1:17 AM Prarit Bhargava <prarit@redhat.com>
> wrote:
> > 
> > Add a .gitignore file for build include/ and final binary.
> > 
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: David Arcari <darcari@redhat.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
> > ---
> >  tools/power/x86/intel-speed-select/.gitignore | 2 ++
> >  1 file changed, 2 insertions(+)
> >  create mode 100644 tools/power/x86/intel-speed-select/.gitignore
> > 
> > diff --git a/tools/power/x86/intel-speed-select/.gitignore
> > b/tools/power/x86/intel-speed-select/.gitignore
> > new file mode 100644
> > index 000000000000..f61145925ce9
> > --- /dev/null
> > +++ b/tools/power/x86/intel-speed-select/.gitignore
> > @@ -0,0 +1,2 @@
> > +include/
> > +intel-speed-select
> > --
> > 2.21.0
> > 

