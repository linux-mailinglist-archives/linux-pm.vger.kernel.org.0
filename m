Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166F1190CDF
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 12:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCXL5B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 07:57:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:59102 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXL5A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 07:57:00 -0400
IronPort-SDR: wDJAJ0pRgJm+OgyMOSJSBpFmruGNlc1nwaBtRUnJJ55PmIgnQjPFrbY4QrzdTVzg9P/SZArJ2s
 xqYwa/w8cd1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 04:56:59 -0700
IronPort-SDR: 2Sj/qNA+FiNvJUfbIkx9MSE/0ag2nn3/HFOZ0kego6vH4CHtnziZyEAegdZW52/ECsXZWJ0tCp
 /rHHc+E6NNtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="293042063"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2020 04:56:52 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGiAv-00CWGR-Do; Tue, 24 Mar 2020 13:56:53 +0200
Date:   Tue, 24 Mar 2020 13:56:53 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Gary.Hook@amd.com" <Gary.Hook@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "changbin.du@intel.com" <changbin.du@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "bp@suse.de" <bp@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Message-ID: <20200324115653.GI1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
 <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 10:53:09AM +0000, Vaittinen, Matti wrote:
> On Tue, 2020-03-24 at 11:50 +0200, Andy Shevchenko wrote:
> > On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen wrote:

...

> > > +	for (i = ffs(tmp); i; i = ffs(tmp)) {
> > 
> > NIH of for_each_set_bit().
> 
> What does the NIH stand for?

Not Invented Here syndrome :-)

> Anyways, I agree. This is probably better if I use for_each_set_bit()

...

> > > +	if (!dev->platform_data) {
> > 
> > dev_get_platdata()
> > 
> > > +		ret = bd9995x_fw_probe(bd);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "Cannot read device
> > > properties.\n");
> > > +			return ret;
> > > +		}
> > > +	} else {
> > > +		return -ENODEV;
> > 
> > So, existing platform data leads to an error?!
> 
> Yes. As currently we only use DT. If someone needs platdata they need
> to improve the driver

I think the idea to avoid platform data in new code as much as possible.
And it's unusual to have somebody to use this driver with platform_data set.
Why not simple ignore it?

...

> > > +#ifndef BD99954_CHARGER_H
> > > +#define BD99954_CHARGER_H
> > > +
> > > +#include <linux/regmap.h>
> > 
> > It is not the header you have users for.
> > Proper one should be bits.h.
> 
> Huh? struct reg_field is in regmap.h, right?

In that long list of some enums I definitely missed something. Just double
check the users anyway.

-- 
With Best Regards,
Andy Shevchenko


