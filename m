Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF71927E1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 13:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCYMKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 08:10:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:22513 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYMKC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 08:10:02 -0400
IronPort-SDR: QXua8mzFNe3+v6gT1/siQzDxkxC2uoP/c3sjve7+EaD/mclfo+szJpsjO2vmqi6vmsD2oHRxmb
 6p0vM0J6PlKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 05:10:01 -0700
IronPort-SDR: JWY0bYTgTNAnnMjOP7rGOn9/5/e2QmbdcVopUj7fg1C6x8ANNUjdhDMPh24+KOoqGppZVkbxEN
 VSimLIQwgV9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="238506221"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 05:09:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH4r6-00CoRq-BW; Wed, 25 Mar 2020 14:09:56 +0200
Date:   Wed, 25 Mar 2020 14:09:56 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
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
Message-ID: <20200325120956.GW1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
 <20200324103557.GH1922688@smile.fi.intel.com>
 <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 11:36:46AM +0000, Vaittinen, Matti wrote:
> On Tue, 2020-03-24 at 12:35 +0200, Andy Shevchenko wrote:
> > On Tue, Mar 24, 2020 at 11:50:24AM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen wrote:
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/of.h>
> > > 
> > > I didn't find any evidence of use of those two, otherwise, missed
> > > property.h
> > > and perhaps mod_devicetable.h.

...

> > > > +MODULE_DEVICE_TABLE(of, bd9995x_of_match);
> > > > +MODULE_DEVICE_TABLE(acpi, bd9995x_acpi_match);
> > 
> > I have to add since you are using those macros without ifdeffery, you
> > should
> > get warning in !ACPI and/or !OF cases.
> > 
> > So, drop those of_match_ptr() / ACPI_PTR() and thus above headers.
> 
> Sorry but I don't follow :/ I did drop whole ACPI table as the battery
> information is not fetched from ACPI anyways.

Okay, let's forget then about ACPI bits.

> But I don't know what you
> mean by dropping the of_match_ptr?

Literally do not use this macro. Otherwise you make a dependency to OF which
should be then in the Kconfig like

	depend on OF || COMPILE_TEST

but in this case you will get compiler warning without ugly ifdeffery around
OF ID table (as you pointed below you didn't test that scenario).

> I for sure need the of_device_id as
> in many cases both the device matching and module matching are done
> based on  of_match_table and of_device_id.
> 
> I admit I didn't try compiling the !OF config. Are you suggesting I
> should put the of_device_id array and populating the of_match_table in
> #ifdef CONFIG_OF? Or maybe you suggest that I will put of_device_id
> array in #ifdef CONFIG_OF and use of_match_ptr() when populating the
> of_match_table pointer? I guess that would make sense. I'll do that -
> can you please explain if this was not what you meant.

One of us needs a morning covfefe, I think :-)

-- 
With Best Regards,
Andy Shevchenko


