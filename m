Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D2DCF7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfD2Hhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 03:37:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45491 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2Hhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:37:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id t189so4508023oih.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 00:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOPe5Q1udCneNfttJ46NKWp+NCN/YKvc7HyjlsCSxYk=;
        b=ca6O7WfLKTg6JA0c/I52Qc3+j0uK0WQUXZwNM+tMJMvyMBsWzdbMCV/B27icKpF1xV
         6bsinLrEzQw9GrQdsqk5vmSjd2GAkOYsbRUhU8vN5KzAtCagYuNxpppTSI37ZOGeKZs0
         N3A5NdAhH5t/Q4Iyqa8+tSNzpY9PE6yOyXqyI5oSb+Dw57g3BB/azW4qKiM4MTNq4oc0
         NByUiKAxFmUdnE+bF3taPz2gbwtR9ADuxZwGTyfX8g8nXSXtKymouJJVR8OuvkE9JYW2
         9TR+NAYahib7SCy1i5LVRvoopkcbf/NSLy7ex9HQqrg84xlDcymBXCsZw33zb4NadoRA
         jE6Q==
X-Gm-Message-State: APjAAAWONPyxTs5E4FfjHMb0brz/7+RtiFguBetfP/JDVb/4W8XZ6pyb
        7EvFKPZ/2ZVtRhSgKHlUgXGud8Rr50jpiHRdHMg=
X-Google-Smtp-Source: APXvYqxMdyMHPWz+e+wAi5taWVjAmL3eyVbNhtQslFotrDA9Gh8/vWyTiVjn2e3VCSKaln5SEtQybDhi/pf3LUntWC0=
X-Received: by 2002:aca:4a8a:: with SMTP id x132mr7457259oia.68.1556523458657;
 Mon, 29 Apr 2019 00:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190429072418.7860-1-zbestahu@gmail.com>
In-Reply-To: <20190429072418.7860-1-zbestahu@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Apr 2019 09:37:27 +0200
Message-ID: <CAJZ5v0jLd9gnw_QuD-aK6fFpdDACbKXJOBugrCNtx1tfmBKi5w@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers in cpufreq_init_policy()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 9:24 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> In cpufreq_init_policy() we will check if there's last_governor for target
> and setpolicy type. However last_governor is set only if has_target() is
> true in cpufreq_offline(). That means find last_governor for setpolicy
> type is pointless. Also new_policy.governor will not be used if ->setpolicy
> callback is set in cpufreq_set_policy().
>
> Moreover, there's duplicate ->setpolicy check in using default policy path.
> Let's add a new helper function to avoid it. Also update a little comment.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Have you tested this with the intel_pstate driver (in the active mode)?

> ---
> v2: fix ->setplicy typo.
> v3:
>   - let cpufreq_parse_governor() only handle !set_policy.
>   - fix using {} in the if block.
>   - change helper function name.
>   - update comment, commit message.
>
>  drivers/cpufreq/cpufreq.c | 116 ++++++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0322cce..ce8a01d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -578,50 +578,52 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>         return NULL;
>  }
>
> +static int cpufreq_parse_policy(char *str_governor,
> +                               struct cpufreq_policy *policy)
> +{
> +       if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> +               policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> +               return 0;
> +       }
> +       if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +               return 0;
> +       }
> +       return -EINVAL;
> +}
> +
>  /**
> - * cpufreq_parse_governor - parse a governor string
> + * cpufreq_parse_governor - parse a governor string only for !setpolicy
>   */
>  static int cpufreq_parse_governor(char *str_governor,
>                                   struct cpufreq_policy *policy)
>  {
> -       if (cpufreq_driver->setpolicy) {
> -               if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> -                       policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -                       return 0;
> -               }
> -
> -               if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> -                       policy->policy = CPUFREQ_POLICY_POWERSAVE;
> -                       return 0;
> -               }
> -       } else {
> -               struct cpufreq_governor *t;
> +       struct cpufreq_governor *t;
>
> -               mutex_lock(&cpufreq_governor_mutex);
> +       mutex_lock(&cpufreq_governor_mutex);
>
> -               t = find_governor(str_governor);
> -               if (!t) {
> -                       int ret;
> +       t = find_governor(str_governor);
> +       if (!t) {
> +               int ret;
>
> -                       mutex_unlock(&cpufreq_governor_mutex);
> +               mutex_unlock(&cpufreq_governor_mutex);
>
> -                       ret = request_module("cpufreq_%s", str_governor);
> -                       if (ret)
> -                               return -EINVAL;
> +               ret = request_module("cpufreq_%s", str_governor);
> +               if (ret)
> +                       return -EINVAL;
>
> -                       mutex_lock(&cpufreq_governor_mutex);
> +               mutex_lock(&cpufreq_governor_mutex);
>
> -                       t = find_governor(str_governor);
> -               }
> -               if (t && !try_module_get(t->owner))
> -                       t = NULL;
> +               t = find_governor(str_governor);
> +       }
> +       if (t && !try_module_get(t->owner))
> +               t = NULL;
>
> -               mutex_unlock(&cpufreq_governor_mutex);
> +       mutex_unlock(&cpufreq_governor_mutex);
>
> -               if (t) {
> -                       policy->governor = t;
> -                       return 0;
> -               }
> +       if (t) {
> +               policy->governor = t;
> +               return 0;
>         }
>
>         return -EINVAL;
> @@ -746,8 +748,13 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
>         if (ret != 1)
>                 return -EINVAL;
>
> -       if (cpufreq_parse_governor(str_governor, &new_policy))
> -               return -EINVAL;
> +       if (cpufreq_driver->setpolicy) {
> +               if (cpufreq_parse_policy(str_governor, &new_policy))
> +                       return -EINVAL;
> +       } else {
> +               if (cpufreq_parse_governor(str_governor, &new_policy))
> +                       return -EINVAL;
> +       }
>
>         ret = cpufreq_set_policy(policy, &new_policy);
>
> @@ -1020,32 +1027,39 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
>
>  static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
> -       struct cpufreq_governor *gov = NULL;
> +       struct cpufreq_governor *gov = NULL, *def_gov = NULL;
>         struct cpufreq_policy new_policy;
>
>         memcpy(&new_policy, policy, sizeof(*policy));
>
> -       /* Update governor of new_policy to the governor used before hotplug */
> -       gov = find_governor(policy->last_governor);
> -       if (gov) {
> -               pr_debug("Restoring governor %s for cpu %d\n",
> +       def_gov = cpufreq_default_governor();
> +
> +       if (has_target()) {
> +               /*
> +                * Update governor of new_policy to the governor used before
> +                * hotplug
> +                */
> +               gov = find_governor(policy->last_governor);
> +               if (gov) {
> +                       pr_debug("Restoring governor %s for cpu %d\n",
>                                 policy->governor->name, policy->cpu);
> +               } else {
> +                       if (!def_gov)
> +                               return -ENODATA;
> +                       gov = def_gov;
> +               }
> +               new_policy.governor = gov;
>         } else {
> -               gov = cpufreq_default_governor();
> -               if (!gov)
> -                       return -ENODATA;
> -       }
> -
> -       new_policy.governor = gov;
> -
> -       /* Use the default policy if there is no last_policy. */
> -       if (cpufreq_driver->setpolicy) {
> -               if (policy->last_policy)
> +               /* Use the default policy if there is no last_policy. */
> +               if (policy->last_policy) {
>                         new_policy.policy = policy->last_policy;
> -               else
> -                       cpufreq_parse_governor(gov->name, &new_policy);
> +               } else {
> +                       if (!def_gov)
> +                               return -ENODATA;
> +                       cpufreq_parse_policy(def_gov->name, &new_policy);
> +               }
>         }
> -       /* set default policy */
> +
>         return cpufreq_set_policy(policy, &new_policy);
>  }
>
> --
> 1.9.1
>
