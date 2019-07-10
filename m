Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D357644F3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGJKLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:11:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54674 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfGJKLK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:11:10 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id b3935117ca5db99f; Wed, 10 Jul 2019 12:11:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Anson.Huang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Add i.MX8MN support
Date:   Wed, 10 Jul 2019 12:11:07 +0200
Message-ID: <7456362.ddI0K1WBKD@kreacher>
In-Reply-To: <20190708035057.h2lgadm56tgdqsor@vireshk-i7>
References: <20190708030308.1815-1-Anson.Huang@nxp.com> <20190708035057.h2lgadm56tgdqsor@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, July 8, 2019 5:50:57 AM CEST Viresh Kumar wrote:
> On 08-07-19, 11:03, Anson.Huang@nxp.com wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> > 
> > i.MX8MN is a new SoC of i.MX8M series, it also uses speed
> > grading and market segment fuses for OPP definitions, add
> > support for this SoC.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/cpufreq/imx-cpufreq-dt.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> > index b54fd26..4f85f31 100644
> > --- a/drivers/cpufreq/imx-cpufreq-dt.c
> > +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> > @@ -44,10 +44,11 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
> >  	 * According to datasheet minimum speed grading is not supported for
> >  	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
> >  	 *
> > -	 * Applies to 8mq and 8mm.
> > +	 * Applies to i.MX8M series SoCs.
> >  	 */
> >  	if (mkt_segment == 0 && speed_grade == 0 && (
> >  			of_machine_is_compatible("fsl,imx8mm") ||
> > +			of_machine_is_compatible("fsl,imx8mn") ||
> >  			of_machine_is_compatible("fsl,imx8mq")))
> >  		speed_grade = 1;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael: Can you pick this one directly, no point sending another pull request
> for just one patch. Thanks.

Done, thanks!



