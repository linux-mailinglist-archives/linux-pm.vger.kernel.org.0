Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03DB10715
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfEAKmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:42:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64327 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfEAKmt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:42:49 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 6466d29413395393; Wed, 1 May 2019 12:42:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v4] cpufreq: qoriq: add support for lx2160a
Date:   Wed, 01 May 2019 12:42:47 +0200
Message-ID: <13001529.XdfgQYjzVm@kreacher>
In-Reply-To: <20190429051637.d5y4cfiekrysli3w@vireshk-i7>
References: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com> <20190429051637.d5y4cfiekrysli3w@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 29, 2019 7:16:37 AM CEST Viresh Kumar wrote:
> On 26-04-19, 06:55, Vabhav Sharma wrote:
> > Enable support of NXP SoC lx2160a to handle the
> > lx2160a SoC.
> > 
> > Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Acked-by: Scott Wood <oss@buserror.net>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Changes for v4:
> > - Incorporated review comments from Stephen Boyd
> > 
> > Changes for v3:
> > - Incorporated review comments of Rafael J. Wysocki
> > - Updated commit message
> > 
> > Changes for v2:
> > - Subject line updated
> > 
> >  drivers/cpufreq/qoriq-cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > index 4295e54..81f0288 100644
> > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > @@ -284,6 +284,7 @@ static const struct of_device_id node_matches[] __initconst = {
> >  	{ .compatible = "fsl,ls1046a-clockgen", },
> >  	{ .compatible = "fsl,ls1088a-clockgen", },
> >  	{ .compatible = "fsl,ls2080a-clockgen", },
> > +	{ .compatible = "fsl,lx2160a-clockgen", },
> >  	{ .compatible = "fsl,p4080-clockgen", },
> >  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
> >  	{ .compatible = "fsl,qoriq-clockgen-2.0", },
> 
> @Rafael, please apply this version. Thanks.

Done, thanks!



