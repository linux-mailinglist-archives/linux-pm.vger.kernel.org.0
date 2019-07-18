Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B376D07B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390440AbfGROwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:52:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46657 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGROwm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:52:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id c73so12733754pfb.13;
        Thu, 18 Jul 2019 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kdlQ+ZPSDRxy+hMQiUFO3ksp/qaRtATcUb/dMo1TYd8=;
        b=G+uVkXPjAw9NiiNh0jU82g/OdTfB+WNeo3P9z2cDgfiGo9WeXQE3bYhkBh5ly/uz6E
         CL4byZQIvhkL6bhSQ5x4P1do4jCpVslucPVrCK+dKvNTDD9FGQk05KOByR6qOcdIezJf
         AtCYmAtuQvopQ7T3Wfb5d9dv0Cn1se0lZUpn3wzHFoLbpNum61jVlOvxcmwL9i4rbLKh
         wzaNXh8a5pY5+7uv58oX35qtG17b0hCwt1kZD8xVEKgGj+NeRPcWVDWuCmyzlcNvaBCe
         v/XvA6/r2kh4U9h6d24kXXxgwwf7Ndkq0ZTQxz0R4jfbXF4BgwlDFwWjy4JogJVzoSh3
         IAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdlQ+ZPSDRxy+hMQiUFO3ksp/qaRtATcUb/dMo1TYd8=;
        b=Lt1imdreh9TeM8Nlvm+xOzpCM0LGNtj94F2eeyncL+Fu5PxjxQQp6aGsxPdk/ykQp+
         6wgXtx+wScw5bALGrbf3VIHSpg2Mat5P+u/VCwC/he2nk9a8sx2cfjkEMcvPvWRurVB9
         bUDiiaLObsZlTSGFv9KQYM2Oska1H7D1meMRgdwgSv61qZ8RuHPtFQc12haSHuKrNpEf
         wSsN0Ce3fmkfk6/tlwUwjdktAdUtJ5P6yJz0yD9xq9OyntMvVSZLwFAFI9M0XzR2WWCb
         UVTJWz4wDe4lVG6JaOQCkg3UNTVLq5bYjo1L86Vd9d1C65Y0ElXM8Zk5DWp1K2XQmNh2
         BKTQ==
X-Gm-Message-State: APjAAAXv7JnhFG1qGQr1tY6IE/7t+XHvEpiRsT/6IdsgRoj2lLrmI8gs
        kEQgNI53yO/SFoNTD5FTWuY=
X-Google-Smtp-Source: APXvYqySnzdXAX4u91l+VhDPTH/tfBFQlI/XuZZomIx2iYuA2XchF451YLajdmdVBI0K3ZquysErGQ==
X-Received: by 2002:a65:500a:: with SMTP id f10mr17214847pgo.105.1563461561641;
        Thu, 18 Jul 2019 07:52:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:ef9b])
        by smtp.gmail.com with ESMTPSA id z24sm49803845pfr.51.2019.07.18.07.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 07:52:40 -0700 (PDT)
Date:   Thu, 18 Jul 2019 07:52:38 -0700
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
Subject: Re: [PATCH v11 1/5] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190718145238.GD696309@devbig004.ftw2.facebook.com>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708084357.12944-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, Patrick.

On Mon, Jul 08, 2019 at 09:43:53AM +0100, Patrick Bellasi wrote:
> +static inline void cpu_uclamp_print(struct seq_file *sf,
> +				    enum uclamp_id clamp_id)
> +{
> +	struct task_group *tg;
> +	u64 util_clamp;
> +	u64 percent;
> +	u32 rem;
> +
> +	rcu_read_lock();
> +	tg = css_tg(seq_css(sf));
> +	util_clamp = tg->uclamp_req[clamp_id].value;
> +	rcu_read_unlock();
> +
> +	if (util_clamp == SCHED_CAPACITY_SCALE) {
> +		seq_puts(sf, "max\n");
> +		return;
> +	}
> +
> +	percent = uclamp_percent_from_scale(util_clamp);
> +	percent = div_u64_rem(percent, 100, &rem);
> +	seq_printf(sf, "%llu.%u\n", percent, rem);

"%llu.%02u" otherwise 20.01 gets printed as 20.1

Thanks.

-- 
tejun
