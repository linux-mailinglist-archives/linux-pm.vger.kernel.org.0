Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05E1927B7
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYMF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 08:05:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:22365 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgCYMF4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 08:05:56 -0400
IronPort-SDR: VCHfbvJLGDsretCvkxFYWJVPq/+1iFsA5C0oAt8617vFd/L47HJsrYIMT6sAyrvlDux0Yzyun1
 WSh/j/hIVGKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 05:05:37 -0700
IronPort-SDR: i88nw5H8sqH2VYxcP9e0AcuEUBa22Z1lVAvYDYqEVCil8RQo5FpG8SCoRmeFHdhqdwlLHN8DQI
 nQLA15ze1Vbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="448246117"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 Mar 2020 05:05:30 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH4mp-00CoNt-8E; Wed, 25 Mar 2020 14:05:31 +0200
Date:   Wed, 25 Mar 2020 14:05:31 +0200
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
Message-ID: <20200325120531.GV1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
 <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
 <20200324115653.GI1922688@smile.fi.intel.com>
 <f3490f4e7900e463540330665ecf99737070fedd.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3490f4e7900e463540330665ecf99737070fedd.camel@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 10:14:35AM +0000, Vaittinen, Matti wrote:
> On Tue, 2020-03-24 at 13:56 +0200, andriy.shevchenko@linux.intel.com
> wrote:
> > On Tue, Mar 24, 2020 at 10:53:09AM +0000, Vaittinen, Matti wrote:
> > > On Tue, 2020-03-24 at 11:50 +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 24, 2020 at 10:32:19AM +0200, Matti Vaittinen wrote:

...

> > > > > +	if (!dev->platform_data) {
> > > > 
> > > > dev_get_platdata()
> > > > 
> > > > > +		ret = bd9995x_fw_probe(bd);
> > > > > +		if (ret < 0) {
> > > > > +			dev_err(dev, "Cannot read device
> > > > > properties.\n");
> > > > > +			return ret;
> > > > > +		}
> > > > > +	} else {
> > > > > +		return -ENODEV;
> > > > 
> > > > So, existing platform data leads to an error?!
> > > 
> > > Yes. As currently we only use DT. If someone needs platdata they
> > > need
> > > to improve the driver
> > 
> > I think the idea to avoid platform data in new code as much as
> > possible.
> > And it's unusual to have somebody to use this driver with
> > platform_data set.
> > Why not simple ignore it?
> 
> Because if someone _is_ using platform data here (and we still provide
> this mechanism) - then we should inform him that he's doing something
> which is not correct.

Up to maintainer, but once more time to put an accent that above is quite
unusual practice in Linux kernel.

-- 
With Best Regards,
Andy Shevchenko


