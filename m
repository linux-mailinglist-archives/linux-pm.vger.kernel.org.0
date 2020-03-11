Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99231815B2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 11:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgCKKWc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 06:22:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:56992 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgCKKWc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 06:22:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 03:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="231648107"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2020 03:22:26 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jByVQ-008i2l-Ab; Wed, 11 Mar 2020 12:22:28 +0200
Date:   Wed, 11 Mar 2020 12:22:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200311102228.GF1922688@smile.fi.intel.com>
References: <20200311093043.3636807-1-t.schramm@manjaro.org>
 <20200311093043.3636807-4-t.schramm@manjaro.org>
 <20200311101830.GE1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311101830.GE1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 12:18:30PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 11, 2020 at 10:30:43AM +0100, Tobias Schramm wrote:

...

> > +	ret = device_property_read_u32_array(dev,
> > +						"cellwise,monitor-interval-ms",
> 
> It's fine to have it on one line.
> 
> > +						&value, 1);


Actually this is simple
	ret = device_property_read_u32(dev, "cellwise,monitor-interval-ms", &value);
(You can use one or two lines on your choice)

-- 
With Best Regards,
Andy Shevchenko


