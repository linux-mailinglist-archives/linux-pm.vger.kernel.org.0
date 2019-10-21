Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22CFDE971
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfJUK2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:28:08 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48316 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfJUK2H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 06:28:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CD4493;
        Mon, 21 Oct 2019 03:27:35 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017BE3F718;
        Mon, 21 Oct 2019 03:27:34 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:27:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191021102730.GA21581@bogus>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus>
 <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus>
 <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 07:45:51AM +0530, Viresh Kumar wrote:
> On 18-10-19, 12:06, Sudeep Holla wrote:
> > Callstack is:
> >
> > (cpufreq_notifier_max)
> > (notifier_call_chain)
> > (blocking_notifier_call_chain)
> > (pm_qos_update_target)
> > (freq_qos_apply)
> > (freq_qos_remove_request)
> > (cpufreq_policy_free)
> > (subsys_interface_unregister)
> > (cpufreq_unregister_driver)
>
> @sudeep: I see that the patch is merged now, but as I said earlier the
> reasoning isn't clear yet. Please don't stop working on this and lets
> clean this once and for all.
>

Sure.

> What patches were you testing this with? My buggy patches or Rafael's
> patches as well ? At least with my patches, this can happen due to the
> other bug where the notifier doesn't get removed (as I said earlier),
> but once that bug isn't there then this shouldn't happen, else we have
> another bug in pipeline somewhere and should find it.
>

I just tested now with today's linux-pm/bleeding-edge branch.
And even if I move cancel_work_sync just after freq_qos_remove_notifier,
it works fine now. It was not the case on Friday.

Is that what you wanted to check or something else ?

Regards,
Sudeep

-->8

diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
index 829a3764df1b..48a224a6b178 100644
--- i/drivers/cpufreq/cpufreq.c
+++ w/drivers/cpufreq/cpufreq.c
@@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
        freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
                                 &policy->nb_min);

+       /* Cancel any pending policy->update work before freeing the policy. */
+       cancel_work_sync(&policy->update);
+
        if (policy->max_freq_req) {
                /*
                 * CPUFREQ_CREATE_POLICY notification is sent only after
@@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
        }

        freq_qos_remove_request(policy->min_freq_req);
-       /* Cancel any pending policy->update work before freeing the policy. */
-       cancel_work_sync(&policy->update);
        kfree(policy->min_freq_req);

        cpufreq_policy_put_kobj(policy);

