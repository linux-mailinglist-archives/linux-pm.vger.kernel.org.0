Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C6192985
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCYNWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 09:22:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:38450 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbgCYNWH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 09:22:07 -0400
IronPort-SDR: YxEKrTLf3PAXvrZTMRBA/wCi9yDnuLJEt2zVPTT3Cy4uhuPjLGwPS+K/pOb9rzkAEpe4vLc9wX
 DRdvvDM/ZVkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 06:22:06 -0700
IronPort-SDR: 0Jzf9dk7Gw11erDkTbA58HlkoOJOAyD+fbLjqw4wV+NtoG9lCMpstQFrQFVAR7RGPO+8CdVpgk
 FvMGZnNApHwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="393625854"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 06:21:57 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jH5yo-00CpHP-VS; Wed, 25 Mar 2020 15:21:58 +0200
Date:   Wed, 25 Mar 2020 15:21:58 +0200
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
Message-ID: <20200325132158.GZ1922688@smile.fi.intel.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
 <20200324095024.GE1922688@smile.fi.intel.com>
 <20200324103557.GH1922688@smile.fi.intel.com>
 <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
 <20200325120956.GW1922688@smile.fi.intel.com>
 <d533c18dcd7b4d4ca453661b3f9495a840b3313b.camel@fi.rohmeurope.com>
 <20200325132033.GY1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325132033.GY1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 03:20:33PM +0200, andriy.shevchenko@linux.intel.com wrote:
> On Wed, Mar 25, 2020 at 01:00:21PM +0000, Vaittinen, Matti wrote:

> But why?
> 
> You really uglify the code with ifdeffery, make a dependency to OF (yes, you
> will have to have of.h include) only because of that silly
> macro and save 64 bytes of memory footprint.

And on top of that for !OF configuration you prevent your driver to be usable.
(Consider PRP0001 ACPI case, for example)

-- 
With Best Regards,
Andy Shevchenko


