Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB751812B3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKIOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 04:14:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:11849 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCKIOv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 04:14:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 01:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="236215354"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 01:14:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBwVu-008gZ3-U2; Wed, 11 Mar 2020 10:14:50 +0200
Date:   Wed, 11 Mar 2020 10:14:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: add CellWise cw2015 fuel gauge
 driver
Message-ID: <20200311081450.GZ1922688@smile.fi.intel.com>
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
 <20200309160346.2203680-3-t.schramm@manjaro.org>
 <20200310101050.GG1922688@smile.fi.intel.com>
 <eb732216-dd19-f18d-9ace-e14c7e8de991@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb732216-dd19-f18d-9ace-e14c7e8de991@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 10, 2020 at 07:55:42PM +0100, Tobias Schramm wrote:

> >> +static int cw_read_word(struct cw_battery *cw_bat, u8 reg, u16 *val)
> >> +{
> >> +	u8 reg_val[2];
> >> +	int ret;
> >> +
> >> +	ret = regmap_raw_read(cw_bat->regmap, reg, reg_val, 2);
> >> +	*val = (reg_val[0] << 8) + reg_val[1];
> >> +	return ret;
> >> +}
> > 
> > NIH BE type of readings? Can REGMAP_ENDIAN_BIG help?
> 
> Not really, or can it? Registers on the cw2015 are a wild mix of single
> bytes and words. There does not seem to be a per register override for
> reg_/val_bits.

I see.
Perhaps

	__be16 value;


	ret = regmap(..., (...)value, sizeof(value));
	if (ret)
		return ret; // note, you missed this in above.

	*val = be16_to_cpu(value);
	return 0;

-- 
With Best Regards,
Andy Shevchenko


