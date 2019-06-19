Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB02E4B809
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 14:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfFSMUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 08:20:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35811 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSMUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 08:20:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so19065814otq.2;
        Wed, 19 Jun 2019 05:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11N2FHKz5axww920Vj/09PmaE8usnGFHqN7+I0skSBM=;
        b=SQ3QPDxBYRS9wibNzOuyW1hCWzRYlF0tRrdB8y9MoiLo52fNbprB75FmvZ5Sgb8yNU
         JcOL/aQ9zc2/uvbaYtCuJAGtXU9GCfEcJOY5NFIGuQPVv7izA/BYDfwDWOC+Ek5YCi+8
         t20okbpV0ee59Pk6qf8OWYlY5sXox0GsVXx+aHy46t9+rgzntHhQamdQjO81zB8fObRe
         ZENUEwAQmWLSA5/gpj3oPcYDVBp30+bFd+x7W5CTaKLgRQphgofX7pQ5LzcL2V0pC7kP
         c1plEWCPyQe4C+QbDo33GsLMQ0C3WrF/8/b5Jl+b/PSxpScYSB09Z5DOJShB4JCV7ael
         T5mA==
X-Gm-Message-State: APjAAAVqOw7mI2gAQglWNj9eeOWQVj704Z2vD9ertPjnio4KVAHjY1ae
        mkw+xZEvXQQLBnWpnAUv0o1UU+EA722acWlMBNG8moh8
X-Google-Smtp-Source: APXvYqzibyJQU6vCsaCq5ik9iC3Ck2M8DmeFFXiQIMjcIiCKyU8IuWtRcMSJC3MuoPKBPlihMP0ib07yX9DwXndLP5o=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr45196743oto.118.1560946829999;
 Wed, 19 Jun 2019 05:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560944014.git.viresh.kumar@linaro.org> <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
In-Reply-To: <0660b023a0d80c63ec7a1f7fcb692de9a9f4d604.1560944014.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 14:20:18 +0200
Message-ID: <CAJZ5v0g1avBwjezWpMimGbs1NHOchib9pmTKoxaixKtpw_CGJw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 1:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> CPUFREQ_CONST_LOOPS was introduced in a very old commit from pre-2.6
> kernel release commit 6a4a93f9c0d5 ("[CPUFREQ] Fix 'out of sync'
> issue").
>
> Probably the initial idea was to just avoid these checks for set_policy
> type drivers and then things got changed over the years. And it is very
> unclear why these checks are there at all.
>
> Replace the CPUFREQ_CONST_LOOPS check with has_target(), which makes
> more sense now.
>
> Also remove () around freq comparison statement as they aren't required
> and checkpatch also warns for them.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54befd775bd6..e59194c2c613 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -359,12 +359,10 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>                  * which is not equal to what the cpufreq core thinks is
>                  * "old frequency".
>                  */
> -               if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> -                       if (policy->cur && (policy->cur != freqs->old)) {
> -                               pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> -                                        freqs->old, policy->cur);
> -                               freqs->old = policy->cur;
> -                       }
> +               if (has_target() && policy->cur && policy->cur != freqs->old) {
> +                       pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
> +                                freqs->old, policy->cur);
> +                       freqs->old = policy->cur;

Is cpufreq_notify_transition() ever called if ->setpolicy drivers are in use?

>                 }
>
>                 srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
> @@ -1618,8 +1616,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>         if (policy->fast_switch_enabled)
>                 return ret_freq;
>
> -       if (ret_freq && policy->cur &&
> -               !(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> +       if (has_target() && ret_freq && policy->cur) {
>                 /* verify no discrepancy between actual and
>                                         saved value exists */
>                 if (unlikely(ret_freq != policy->cur)) {
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
