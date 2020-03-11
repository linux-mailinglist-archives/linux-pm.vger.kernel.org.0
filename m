Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9418143D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgCKJLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 05:11:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:36178 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJLb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 05:11:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 02:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="443491350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2020 02:11:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBxOk-008hB5-Ey; Wed, 11 Mar 2020 11:11:30 +0200
Date:   Wed, 11 Mar 2020 11:11:30 +0200
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
Message-ID: <20200311091130.GC1922688@smile.fi.intel.com>
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
 <20200309160346.2203680-3-t.schramm@manjaro.org>
 <20200310101050.GG1922688@smile.fi.intel.com>
 <eb732216-dd19-f18d-9ace-e14c7e8de991@manjaro.org>
 <20200311081450.GZ1922688@smile.fi.intel.com>
 <503baadb-b8f2-f4bd-a1a8-44b2dc77b933@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503baadb-b8f2-f4bd-a1a8-44b2dc77b933@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 09:48:30AM +0100, Tobias Schramm wrote:

> was just about to send v3.
> 
> > 
> > 	__be16 value;
> > 
> > 
> > 	ret = regmap(..., (...)value, sizeof(value));

Just checked this, simple &value works.

> > 	if (ret)
> > 		return ret; // note, you missed this in above.
> > 
> > 	*val = be16_to_cpu(value);
> > 	return 0;
> > 
> 
> That implementation looks pretty clean. I'll take it.

Thank you.

-- 
With Best Regards,
Andy Shevchenko


