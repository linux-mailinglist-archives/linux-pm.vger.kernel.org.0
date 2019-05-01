Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2710717
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfEAKnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:43:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42151 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEAKnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:43:42 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 271f481359e6c7cd; Wed, 1 May 2019 12:43:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, dongjian <dj0227@163.com>
Cc:     linux-pm@vger.kernel.org, dongjian@yulong.com, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Fix centrino_setpolicy to centrino_target
Date:   Wed, 01 May 2019 12:43:39 +0200
Message-ID: <3427892.b7B7MQlyXi@kreacher>
In-Reply-To: <20190429054203.wwjpqkotbmmpcij2@vireshk-i7>
References: <20190428085417.16156-1-dj0227@163.com> <20190429054203.wwjpqkotbmmpcij2@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 29, 2019 7:42:03 AM CEST Viresh Kumar wrote:
> On 28-04-19, 16:54, dongjian wrote:
> > From: dongjian <dongjian@yulong.com>
> > 
> > The code is using centrino_target rather than centrino_setpolicy.
> > 
> > Signed-off-by: dongjian <dongjian@yulong.com>
> > ---
> >  drivers/cpufreq/speedstep-centrino.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
> > index 7d4a315..26fab0c 100644
> > --- a/drivers/cpufreq/speedstep-centrino.c
> > +++ b/drivers/cpufreq/speedstep-centrino.c
> > @@ -412,7 +412,7 @@ static int centrino_cpu_exit(struct cpufreq_policy *policy)
> >  }
> >  
> >  /**
> > - * centrino_setpolicy - set a new CPUFreq policy
> > + * centrino_target - set a new CPUFreq policy
> >   * @policy: new policy
> >   * @index: index of target frequency
> >   *
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!



