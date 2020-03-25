Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC13192977
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYNUk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 09:20:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:58786 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgCYNUk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 09:20:40 -0400
IronPort-SDR: uUkrfYZf/U74xuzKblAGZ7r7nqNzMe8yLo9FgYOWKfPadnu7Byo9eXgz3tA3Mqq2M6CoUFSgD1
 /o+f/MovJ4/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 06:20:39 -0700
IronPort-SDR: q4jygQ88msBkLt0I3jnpcRrGOpIldQMYrEWtr3aZWFcuq3fwhlPz8D7KOD8ThR7Xpd+h2X36Cg
 HfkAhqqJUapA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="235935013"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 06:20:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH5xR-00CpGR-1Q; Wed, 25 Mar 2020 15:20:33 +0200
Date:   Wed, 25 Mar 2020 15:20:33 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
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
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Message-ID: <20200325132033.GY1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
 <20200324103557.GH1922688@smile.fi.intel.com>
 <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
 <20200325120956.GW1922688@smile.fi.intel.com>
 <d533c18dcd7b4d4ca453661b3f9495a840b3313b.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d533c18dcd7b4d4ca453661b3f9495a840b3313b.camel@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 01:00:21PM +0000, Vaittinen, Matti wrote:
> Well, Good morning Andy :)
> 
> On Wed, 2020-03-25 at 14:09 +0200, andriy.shevchenko@linux.intel.com
> wrote:
> > On Wed, Mar 25, 2020 at 11:36:46AM +0000, Vaittinen, Matti wrote:
> > > On Tue, 2020-03-24 at 12:35 +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 24, 2020 at 11:50:24AM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen
> > > > > wrote:
> > > > > > +#include <linux/acpi.h>
> > > > > > +#include <linux/of.h>
> > > > > 
> > > > > I didn't find any evidence of use of those two, otherwise,
> > > > > missed
> > > > > property.h
> > > > > and perhaps mod_devicetable.h.
> > 
> > ...
> > 
> > > > > > +MODULE_DEVICE_TABLE(of, bd9995x_of_match);
> > > > > > +MODULE_DEVICE_TABLE(acpi, bd9995x_acpi_match);
> > > > 
> > > > I have to add since you are using those macros without ifdeffery,
> > > > you
> > > > should
> > > > get warning in !ACPI and/or !OF cases.
> > > > 
> > > > So, drop those of_match_ptr() / ACPI_PTR() and thus above
> > > > headers.
> > > 
> > > Sorry but I don't follow :/ I did drop whole ACPI table as the
> > > battery
> > > information is not fetched from ACPI anyways.
> > 
> > Okay, let's forget then about ACPI bits.
> > 
> > > But I don't know what you
> > > mean by dropping the of_match_ptr?
> > 
> > Literally do not use this macro. Otherwise you make a dependency to
> > OF which
> > should be then in the Kconfig like
> > 
> > 	depend on OF || COMPILE_TEST
> > 
> 
> Hmm... Why is that? In of.h we have #ifndef CONFIG_OF section which
> defines:
> 
> #define of_match_ptr(_ptr)	NULL
> 
> So, this macro is well defined even if !CONFIG_OF, right?

Because your driver makes nonsense in non-OF cases AFAICS, did I miss anything?

> > but in this case you will get compiler warning without ugly ifdeffery
> > around
> > OF ID table (as you pointed below you didn't test that scenario).
> > 
> > > I for sure need the of_device_id as
> > > in many cases both the device matching and module matching are done
> > > based on  of_match_table and of_device_id.
> > > 
> > > I admit I didn't try compiling the !OF config. Are you suggesting I
> > > should put the of_device_id array and populating the of_match_table
> > > in
> > > #ifdef CONFIG_OF? Or maybe you suggest that I will put of_device_id
> > > array in #ifdef CONFIG_OF and use of_match_ptr() when populating
> > > the
> > > of_match_table pointer? I guess that would make sense. I'll do that
> > > -
> > > can you please explain if this was not what you meant.
> > 
> > One of us needs a morning covfefe, I think :-)
> 
> So in !CONFIG_OF case we will have
> .of_match_table = of_match_ptr(bd9995x_of_match),
> preprocessed to form
> .of_match_table = NULL,
> 
> right? So with this macro we can omit introduction of bd9995x_of_match
> when !CONFIG_OF - meaning we only build #ifdeffery arounf the match
> table and not around this assignment.
> 
> So I'll just do 
> 
> #ifdef CONFIG_OF   
> static const struct of_device_id bd9995x_of_match[] = {
>         { .compatible = "rohm,bd99954", },
>         { }
> };          
> MODULE_DEVICE_TABLE(of, bd9995x_of_match);
> #endif

But why?

You really uglify the code with ifdeffery, make a dependency to OF (yes, you
will have to have of.h include) only because of that silly
macro and save 64 bytes of memory footprint.

> and let the
> #define of_match_ptr(_ptr)	NULL
> fix assignment
> .of_match_table = of_match_ptr(bd9995x_of_match),
> 
> when !CONFIG_OF.

-- 
With Best Regards,
Andy Shevchenko


