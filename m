Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2D84ADD0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 00:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfFRWXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 18:23:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRWXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 18:23:09 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id eae589eea3e5fdbe; Wed, 19 Jun 2019 00:23:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS framework
Date:   Wed, 19 Jun 2019 00:23:06 +0200
Message-ID: <3176289.QFhGQadiPc@kreacher>
In-Reply-To: <20190618112522.4odrysf7wmxgjlb2@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org> <3504053.Rmt1Mul0J4@kreacher> <20190618112522.4odrysf7wmxgjlb2@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, June 18, 2019 1:25:22 PM CEST Viresh Kumar wrote:
> On 18-06-19, 01:26, Rafael J. Wysocki wrote:
> > On Monday, June 10, 2019 12:51:35 PM CEST Viresh Kumar wrote:
> > > +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> > > +				void *data)
> > > +{
> > > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> > > +
> > > +	return cpufreq_update_freq(policy);
> > > +}
> > > +
> > > +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> > > +				void *data)
> > > +{
> > > +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> > > +
> > > +	return cpufreq_update_freq(policy);
> > > +}
> > 
> > This is a bit convoluted.
> > 
> > Two different notifiers are registered basically for the same thing.
> > 
> > Any chance to use just one?
> 
> The way QoS is designed, it handles one value only at a time and we need two,
> min/max. I thought a lot about it earlier and this is what I came up with :(
> 
> You have any suggestions here ?

In patch [3/5] you could point notifiers for both min and max freq to the same
notifier head.   Both of your notifiers end up calling cpufreq_update_policy()
anyway.



