Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEA4BB1E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFSOSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 10:18:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSOSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 10:18:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so7283185plb.12
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mlNb/IaItSyqkmca1yT8QCZfXO867q6hvVBmX/nB+c4=;
        b=PXycLjrhAM+mZu18Pk5r0Od9xKOFKkduE9WzkYHJ+odD7+1IRtjO4DeJCKBNBl3JHx
         MyFgo7eGQcG0sQ1v7ihSGKKMlr8obsid9FYzfjVsDrlyC9sf4IZ+z+eY2SiGxKvVZ7WC
         dn7L00CNezvaaSwh2MnzUqCs079oy4zciUBqKvkppkuLpfvyyYYdLePxiQqBvmlC9ZSJ
         8PS96NAHVgpfyrqt7VqB+pZB9SuCEkLSPIE57z4760HJYsp3EL/p+LV5jD8IabQex6Yy
         Wch6Es7GeVkfWy+smOE9y8t1vr7gUItR7MyOzKJr73c//uQhEmvYEvKHyyhhyMPMozJb
         /qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mlNb/IaItSyqkmca1yT8QCZfXO867q6hvVBmX/nB+c4=;
        b=XzqZXwr+qNxCkFjWRMjQqUCvmK26tkYKFHFVptOD7wT24Z2/xNvM7pebIRpXKEjHtr
         1Cbw5PCd6hoMA7F6GdNa3PR+UHK5GGFwsjev7ZKoRgJEtP5E7DmZ6rMG2/uPidwMa9Vr
         NeIeDrVs/hk4egzvQS4MG9RgYtlgI6h6UXrWG1MIP3LIGS/NxHVAfCfB4sBMLbjIn5FR
         bKPxfa9bjhmxZMrmcofKw8I+eylLkg0IChj1EakIM7kpRBJF+Ha3qrUbmjdtJ0Dk9b4u
         jIzGDZ75KzEHwC5YxKIZPWdjEqB47yvFKVjIKn618EzkoN9fdVAom1Ex7QNAjW7EOO6S
         dOug==
X-Gm-Message-State: APjAAAVFT8u9xD5MIlwAITtKc0oRy91WbSFZ7k0j4U2uSVwMyRikCrxx
        FXp5UMAVUUE6bNPXi4xeWk8VnA==
X-Google-Smtp-Source: APXvYqzFqF0kPamb4VkHuPaXiQxrSC5szQYQtdITcGzbILhiG/SpxFzTNoiwSg0DTPW+Cc7LtHv3Kw==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr83369858pld.16.1560953886202;
        Wed, 19 Jun 2019 07:18:06 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id r6sm2247795pji.0.2019.06.19.07.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:18:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:48:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with
 has_target()
Message-ID: <20190619141803.ywsod6ayhrqdreck@vireshk-i7>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
 <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
 <CAJZ5v0g1avBwjezWpMimGbs1NHOchib9pmTKoxaixKtpw_CGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1avBwjezWpMimGbs1NHOchib9pmTKoxaixKtpw_CGJw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-06-19, 14:20, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 54befd775bd6..e59194c2c613 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
> >                  * which is not equal to what the cpufreq core thinks is
> >                  * "old frequency".
> >                  */
> > -               if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> > -                       if (policy->cur && (policy->cur != freqs->old)) {
> > -                               pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > -                                        freqs->old, policy->cur);
> > -                               freqs->old = policy->cur;
> > -                       }
> > +               if (has_target() && policy->cur && policy->cur != freqs->old) {
> > +                       pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> > +                                freqs->old, policy->cur);
> > +                       freqs->old = policy->cur;
> 
> Is cpufreq_notify_transition() ever called if ->setpolicy drivers are in use?

I tried to find it, but I couldn't find any driver from where we can
get this called for setpolicy drivers.

-- 
viresh
