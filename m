Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83119DAA2
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgDCPxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 11:53:19 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:46789 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgDCPxS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 11:53:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4GM3sPnz89;
        Fri,  3 Apr 2020 17:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585929195; bh=d1mvuXcABo9A+7DqX5edsvsGXpW0qXYA7TMAadjRxi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCQiqZWG+G5QTy7/i8whHL1yY7nan0GC4agbYshguCNAeiikOXVCIt3vwWiGfX7mP
         2CY6Y6mnGJ3mukjzDpXarMqAbVj7dfaJHkzaYQPspNwkAK6cQzqxVeCS06i7WBtd6c
         yQgn4SUWHZvXV3ZxbE/8jAzLO5USdJ4BAsUStoza7OUHY6UysXeOol569RQmjCCdL2
         FEMDuYoLLQMrX+WiHJ4sEFFGLzHKDUj8reqM4G7c1YBW6eMoaEgsPNHwIhxmW/9amG
         aSKz9c5rz1VSd5OUhE3Anv1KnEmTIh7aG0DB47p/+HVkRGfPqLXEDuofA5yxBTgIGy
         C6/bfkYyMJAMg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 3 Apr 2020 17:53:10 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Sebastian Reichel (maintainer:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS 
        ,blamed_fixes:1/1=100%)" <sebastian.reichel@collabora.com>,
        "Andrey Smirnov (blamed_fixes:1/1=100%)" <andrew.smirnov@gmail.com>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] power: supply: core: fix HWMON temperature labels
Message-ID: <20200403155310.GA19125@qmqm.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
 <4a8ac6700e1503a69146f3eefd7cb515d11bfc9f.1585837575.git.mirq-linux@rere.qmqm.pl>
 <29d67963-c110-553a-fec4-b972953987b1@roeck-us.net>
 <20200402150029.GA8325@qmqm.qmqm.pl>
 <32497230-7c83-4db5-0b0e-113558470d10@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32497230-7c83-4db5-0b0e-113558470d10@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 02, 2020 at 11:29:32AM -0700, Guenter Roeck wrote:
> On 4/2/20 8:00 AM, Micha³ Miros³aw wrote:
> > On Thu, Apr 02, 2020 at 07:52:19AM -0700, Guenter Roeck wrote:
> >> On 4/2/20 7:46 AM, Micha³ Miros³aw wrote:
> >>> tempX_label files are swapped compared to what
> >>> power_supply_hwmon_temp_to_property() uses. Make them match.
> >>> While at it, make room for labeling other channels.
> >>>
> >>> Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> >>> Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> >>> ---
> >>>  drivers/power/supply/power_supply_hwmon.c | 14 +++++++++++++-
> >>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> >>> index 75cf861ba492..83318a21fb52 100644
> >>> --- a/drivers/power/supply/power_supply_hwmon.c
> >>> +++ b/drivers/power/supply/power_supply_hwmon.c
> >>> @@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
> >>>  	}
> >>>  }
> >>>  
> >>> +static const char *const ps_temp_label[] = {
> >>> +	"temp",
> >>> +	"ambient temp",
> >>> +};
> >>> +
> >>>  static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> >>>  {
> >>>  	if (channel) {
> >>> @@ -144,7 +149,14 @@ static int power_supply_hwmon_read_string(struct device *dev,
> >>>  					  u32 attr, int channel,
> >>>  					  const char **str)
> >>>  {
> >>> -	*str = channel ? "temp" : "temp ambient";
> >>> +	switch (type) {
> >>> +	case hwmon_temp:
> >>> +		*str = ps_temp_label[channel];
> >>> +		break;
> >>> +	default:
> >>> +		break;
> >>
> >> That returns "no error" without setting *str, which is really asking for trouble.
> > 
> > This is carried over from earlier version. No bug though, but I'll add a
> > patch while I'm at it.
> > 
> 
> This is incorrect. The previous version does not check the type and always sets *str.
> 
> -	*str = channel ? "temp" : "temp ambient";

The function is called only for channels that have HWMON_T_LABEL set.
This is extended in later patches, though, so the type is going to be
required then. I'll split the addition so its more clear.

Best Regards,
Micha³ Miros³aw
