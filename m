Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E850F4F663
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFVPDj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 11:03:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33819 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 11:03:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so10078046qtu.1;
        Sat, 22 Jun 2019 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FVTuTNdvRO7lY3BbG5AjnCHBA84pn1nQYYctYdei0r4=;
        b=fa/uNAZJCZtDKCeD5SaUkxuDNN+vtJXUsFoD0Bs4hdUH03xu4C4Z+aVv/PhMADATr/
         VlS5cziXs4nMB3DjBBdDu/ei0nySM6XUH9OdNK8zq0ebYXAaOkvEaGmNDRRCw+SNKPBJ
         effRrVVwNL3ch/adu0uge/u/nvmJFgYZJsKvCZrdHEigH0Qg7qSmrqT2Ut5SbjFE+nWN
         DjRyDx1s58g3/6YPdX29b1n72pHViaRMcDzThl3sgJHLf+JRFTE0h8R4TDVUSM5zCkKR
         e57AXhSfxTntRRoMzarIgTqCTm9F+5D/bbipXLLniftRkDO/+S4sFQlkOR22b2ytzalI
         B/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVTuTNdvRO7lY3BbG5AjnCHBA84pn1nQYYctYdei0r4=;
        b=UeQKqfxW7p8CMdKVLNFttKCC8hXpAbmlt6z20Fg6AWIe8wezSWMPZxY7ndRkea2Z/M
         4iUZ/VyPr2rAkN3kL0Y8DoXQ69/SkFc1olck4f3exT07Uis9jyyjiBE3yk5Pq7QJmGp/
         VfOO/YVdo41pFreYvlqMP8WIjBZXEHfHUMTSMAgKlR+M/ipgWal1Cl6mBE43i91ADZhO
         lQY/qOq5FYk9ifX7LjIQdrh89KQg2uMa2pfxHEg87Lvr/1Zp9+zgSCewcOWxl6/ClDr5
         Jbtlri2KX5X1QdT1iNLSKT7MVTyPP2YQw42Pr55TxsIYdvZoTN893XNTGL1npKxWlmCp
         trIA==
X-Gm-Message-State: APjAAAWU55TbBFzpoCsjm9bfC4foEr5fM+OVXU47ao7MuJC1R3GGDPQZ
        XpJjd1CZ+lMDy6f2INkCNf4=
X-Google-Smtp-Source: APXvYqwF8m6EeNn/uUxvuuStLKthN3CpXLOV5bsHKLkXRWaTYQ3CBf4PPUCrJj8KPgkbTb3lmrn5lg==
X-Received: by 2002:ac8:234a:: with SMTP id b10mr67518851qtb.261.1561215817595;
        Sat, 22 Jun 2019 08:03:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e3ca])
        by smtp.gmail.com with ESMTPSA id o12sm2700002qkg.99.2019.06.22.08.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 08:03:35 -0700 (PDT)
Date:   Sat, 22 Jun 2019 08:03:32 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190622150332.GM657710@devbig004.ftw2.facebook.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-13-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621084217.8167-13-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Generally looks good to me.  Some nitpicks.

On Fri, Jun 21, 2019 at 09:42:13AM +0100, Patrick Bellasi wrote:
> @@ -951,6 +951,12 @@ controller implements weight and absolute bandwidth limit models for
>  normal scheduling policy and absolute bandwidth allocation model for
>  realtime scheduling policy.
>  
> +Cycles distribution is based, by default, on a temporal base and it
> +does not account for the frequency at which tasks are executed.
> +The (optional) utilization clamping support allows to enforce a minimum
> +bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
> +which should never be exceeded by a CPU.

I kinda wonder whether the term bandwidth is a bit confusing because
it's also used for cpu.max/min.  Would just calling it frequency be
clearer?

> +static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
> +				    char *buf, size_t nbytes,
> +				    loff_t off)
> +{
> +	struct task_group *tg;
> +	u64 min_value;
> +	int ret;
> +
> +	ret = uclamp_scale_from_percent(buf, &min_value);
> +	if (ret)
> +		return ret;
> +	if (min_value > SCHED_CAPACITY_SCALE)
> +		return -ERANGE;
> +
> +	rcu_read_lock();
> +
> +	tg = css_tg(of_css(of));
> +	if (tg == &root_task_group) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

I don't think you need the above check.

> +	if (tg->uclamp_req[UCLAMP_MIN].value == min_value)
> +		goto out;
> +	if (tg->uclamp_req[UCLAMP_MAX].value < min_value) {
> +		ret = -EINVAL;

So, uclamp.max limits the maximum freq% can get and uclamp.min limits
hte maximum freq% protection can get in the subtree.  Let's say
uclamp.max is 50% and uclamp.min is 100%.  It means that protection is
not limited but the actual freq% is limited upto 50%, which isn't
necessarily invalid.  For a simple example, a user might be saying
that they want to get whatever protection they can get from its parent
but wanna limit eventual freq at 50% and it isn't too difficult to
imagine cases where the two knobs are configured separately especially
configuration is being managed hierarchically / automatically.

tl;dr is that we don't need the above restriction and shouldn't
generally be restricting configurations when they don't need to.

Thanks.

-- 
tejun
