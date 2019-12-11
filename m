Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2817F11A8AE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfLKKNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:13:06 -0500
Received: from foss.arm.com ([217.140.110.172]:52332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfLKKNG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 05:13:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEAF1FB;
        Wed, 11 Dec 2019 02:13:05 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 521A83F6CF;
        Wed, 11 Dec 2019 02:13:04 -0800 (PST)
Date:   Wed, 11 Dec 2019 10:13:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/15] cpufreq: scmi: Match scmi device by both name and
 protocol id
Message-ID: <20191211101302.GD20962@bogus>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-14-sudeep.holla@arm.com>
 <20191211023909.7iun7kdk6pjkync6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211023909.7iun7kdk6pjkync6@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 08:09:09AM +0530, Viresh Kumar wrote:
> On 10-12-19, 14:53, Sudeep Holla wrote:
> > The scmi bus now has support to match the driver with devices not only
> > based on their protocol id but also based on their device name if one is
> > available. This was added to cater the need to support multiple devices
> > and drivers for the same protocol.
> >
> > Let us add the name "cpufreq" to scmi_device_id table in the driver so
> > that in matches only with device with the same name and protocol id
> > SCMI_PROTOCOL_PERF. This will help to add "devfreq" device/driver.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index e6182c89df79..61623e2ff149 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -261,7 +261,7 @@ static void scmi_cpufreq_remove(struct scmi_device *sdev)
> >  }
> >
> >  static const struct scmi_device_id scmi_id_table[] = {
> > -	{ SCMI_PROTOCOL_PERF },
> > +	{ SCMI_PROTOCOL_PERF, "cpufreq" },
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>
> Applied. Thanks.

This will break the build without patch 1/15, so preferably must go as
part of the series. Sorry for not missing to specify that detail.

--
Regards,
Sudeep
