Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53767351122
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhDAIua (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 04:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232585AbhDAIu1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 04:50:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D366100C;
        Thu,  1 Apr 2021 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617267027;
        bh=WLeEOkXRnQggZlpQiabWsxB4X+Trc5s5h6NpQ7uPC/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrD9WP/wfF1ggVOG+wpY13YqFGnUzJk4XsS/B3Rz6Xdq15Pk7oitvp+TEXOmmz2wg
         Tzqp+ilPBe1bVCmK5rnMxvcCnXVx/htZx5yP4ZzIA3imoXQutqPzxV2rQS5ISy285+
         ZTeOHl2F5TAR3eAQ3Q5RtEQJJMvh3jkCfj1LH9JEEXUIf90BJhLXYA9vdbnUsrM+ll
         a6OBJDcfSkZrqz5QMEaDYe9r7TR5nz/tyn8WceOrQSDkZDeZrOCLOph9fzbU6maXNU
         RUEx3rqtusY6NdzuK47ULLGchSZAlFlZA86tXJqr1j5KXFAWqaK+bVzzwGs+Jp9f8G
         mGpBCvp5roZbA==
Received: by pali.im (Postfix)
        id 92E1C825; Thu,  1 Apr 2021 10:50:24 +0200 (CEST)
Date:   Thu, 1 Apr 2021 10:50:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        Sebastian Reichel <sre@kernel.org>, kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq27xxx: Return the value instead of
 -ENODATA
Message-ID: <20210401085024.r3u26yftibbxvhnr@pali>
References: <20210331135141.8063-1-chenhui.zhang@axis.com>
 <20210331140238.jl3qprpqhqave4bf@pali>
 <3acaabf2ec63418891e3f698c16b9a21@XBOX01.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3acaabf2ec63418891e3f698c16b9a21@XBOX01.axis.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 01 April 2021 01:51:28 Hermes Zhang wrote:
> On 3/31/21 10:02 PM, Pali Rohár wrote:
> > @@ -1655,9 +1655,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
> >  		return tval;
> >  	}
> >  
> > -	if (tval == 65535)
> > -		return -ENODATA;
> > -
> >  	return tval * 60;
> > I'm not sure if this is correct change. If value 65535 is special which
> > indicates that data are not available then driver should not return
> > (converted) value 65535*60. If -ENODATA is there to indicate that data
> > are not available then -ENODATA should not be used.
> >
> > And if there is application which does not handle -ENODATA for state
> > when data are not available then it is a bug in application.
> 
> Yeah, I just have a feeling return -ENODATA for time_to_full/empty is
> not good here. Because:
> 
> 1. From chip datasheet, it mentioned return 65535 when it's not
> available (e.g. read time_to_full when discharging), but the driver
> changes behavior here.

So if chip reports that value is not available (by special value 65535)
then driver should not report that data are available with value 3932100s.

> 2. There is other case will return -ENODATA (e.g. the gauge not
> calibrated), so it will confuse application which is real failure.

In both cases, driver does not have (meaningful) value, so it reports
-ENODATA. If you think that some other error code is better for 2. then
we can discuss about it.

But -ENODATA seems a correct error code for reporting when data are not
available.

> Could we change the value in minute instead of seconds in
> bq27xxx_battery_read_time(), so that means driver do nothing but only
> pass the value from the chip?

No, according to API, driver must report value in seconds, not in
minutes, see documentation: Documentation/power/power_supply_class.rst

  All voltages, currents, charges, energies, time and temperatures in µV,
  µA, µAh, µWh, seconds and tenths of degree Celsius unless otherwise
  stated. It's driver's job to convert its raw values to units in which
  this class operates.

There is no API for reporting value in minutes.
