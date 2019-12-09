Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49512116C3A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 12:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfLILXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 06:23:41 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33783 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfLILXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 06:23:41 -0500
Received: by mail-oi1-f182.google.com with SMTP id v140so6009050oie.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 03:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVs0Mab48Fi5Cs2XOaWyWXATTx6g5oPZhpX0z076AkY=;
        b=iORjoImR4P7PDstj++uR5MpQAfro7RzdpkI/2627IHJnSkIET7zbZG7iNe4TyTlBD0
         8VkPp4Vxt8CzD3T5IigoEBoH4o2CO/IHrT5JsuI7N4G9Nl81Brex17gtfJShNLqlNC/W
         1YC2k3mI72oTGU2iya3Ir+jKx10CvnaI9cBv171y2PHOUMdLZxNolldDF2UK379wOgWh
         aZNOuOMyTBA5rlwSAMlQrRoZXXSV7lVowhCIXjEy0GnFIajx7g7MmRYkH836RRer4wsj
         IuSLWZG5RnghlsX3b8JfSjOEBcTH+fiFErA2QWRdXcQNyoVVOucYmQw/8a40ReIg3QZ+
         X4+g==
X-Gm-Message-State: APjAAAXQck4SL7oti7nuU/PagkljfoCxBrN1foEEHq3cdq7cggyPhQ4i
        OF3ZCucq1ZxnixttdeHUKjKv00UHxwQeubp71Sw=
X-Google-Smtp-Source: APXvYqxpwNEWe/5TLgTdJT41+3+qCpot1mRH8G8ri2/P+prDLYwPStns0qanQljERV0zkQxFdoxLUjosHZzECB48QSY=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr18734889oij.110.1575890620181;
 Mon, 09 Dec 2019 03:23:40 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher> <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 12:23:29 +0100
Message-ID: <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 11:57 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Forgot to mentioned that below patch on v5.4 can easily reproduce the panic() on our platforms which I think is unexpected, as the policy->cpus already be updated after governor stop, but still try to have irq work queued on it.
>
> static void dbs_update_util_handler(struct update_util_data *data, u64 time, unsigned int flags)
> +       if (!cpumask_test_cpu(smp_processor_id(), policy_dbs->policy->cpus))
> +               panic("...irq work on offline cpu %d\n", smp_processor_id());
>         irq_work_queue(&policy_dbs->irq_work);

Yes, that is unexpected.

In cpufreq_offline(), we have:

    down_write(&policy->rwsem);
    if (has_target())
        cpufreq_stop_governor(policy);

    cpumask_clear_cpu(cpu, policy->cpus);

and cpufreq_stop_governor() calls policy->governor->stop(policy) which
is cpufreq_dbs_governor_stop().

That calls gov_clear_update_util(policy_dbs->policy) first, which
invokes cpufreq_remove_update_util_hook() for each CPU in policy->cpus
and synchronizes RCU, so after that point none of the policy->cpus is
expected to run dbs_update_util_handler().

policy->cpus is updated next and the governor is started again with
the new policy->cpus.  Because the offline CPU is not there, it is not
expected to run dbs_update_util_handler() again.

Do you only get the original error when one of the CPUs goes back online?
