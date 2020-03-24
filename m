Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CDC190B2B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 11:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCXKgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 06:36:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:62844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgCXKgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Mar 2020 06:36:06 -0400
IronPort-SDR: dcAOxkDoSZK05LN2jKE2yreu9ci2Af/De+eW6dywMIXZst/rDpaEMLosM6CbL9PxaGPb7PMHZX
 eXci96JS2C9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 03:36:05 -0700
IronPort-SDR: zht+CM67eDL0WyqMDvo8EzEqKBTQrdKyZEvlUHQrDxhdF91Nm+Yg/36Y4EV9R5v02T7UU2XIbV
 S8ba3qhgWZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="393240574"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 03:35:56 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGgub-00CVDz-DA; Tue, 24 Mar 2020 12:35:57 +0200
Date:   Tue, 24 Mar 2020 12:35:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Message-ID: <20200324103557.GH1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324095024.GE1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 11:50:24AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen wrote:

> > +#include <linux/acpi.h>
> 
> > +#include <linux/of.h>
> 
> I didn't find any evidence of use of those two, otherwise, missed property.h
> and perhaps mod_devicetable.h.

...

> > +MODULE_DEVICE_TABLE(of, bd9995x_of_match);

> > +MODULE_DEVICE_TABLE(acpi, bd9995x_acpi_match);

I have to add since you are using those macros without ifdeffery, you should
get warning in !ACPI and/or !OF cases.

So, drop those of_match_ptr() / ACPI_PTR() and thus above headers.

-- 
With Best Regards,
Andy Shevchenko


