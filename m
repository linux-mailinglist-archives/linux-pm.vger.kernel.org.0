Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F09113A16
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 03:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLECv3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 21:51:29 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45573 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfLECv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 21:51:29 -0500
Received: by mail-pg1-f171.google.com with SMTP id b9so452692pgk.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 18:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YXOwxN1kP+K4jqhxg2yhpfqPO6sP7d2qL2AC9K9utQ4=;
        b=qjq9QecI/wOJmuVH8+2KuOKZd77fkfhSNfn75KhTqEhICZ1dJqZObyHA6YA6REPVQI
         qUmsq/SmFCy9XPAFYfIXDM60S+OakybcZPUjZwNhLBKA/7paGXMi9QCzMMNKwIcy84KA
         qrUzznkALn//5SzE7Y0GRlKUOBJLtRKsJ+exXKT4ZeCTjv8MzL3d1bJ0gFGpG2AVAWW8
         VSnlqKn3T7sw0ROo3Ch5kfswp5/6Wg/11JgpwIPSKHj2Cle8tT7pYIc3jUCsQQNHRp50
         wcr4hxUQOifunSOuS23mTqe6Ex44OF3flMKDSiwqg0UF5UA0JxQVvbhHThGa8VT2rXIp
         whyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YXOwxN1kP+K4jqhxg2yhpfqPO6sP7d2qL2AC9K9utQ4=;
        b=E9vYBu4S7BXgCUn5YhGnScjco31eRBw8gFobUF3doqmkuLxtmccs2OgZda0XvjbHx3
         qDBe93+Zd5D2YWqWDsf5NfVDYYS5PA30nrSqNN7SQKG+EhlLQUpcazuHJWYAviuqBKzk
         G/xuTMWXcUdn4IaShJVpmd+0sJUHxz0FCi30gz3CJjbB/bhW7bN92UGtI4jLl+TUYVlS
         Qgf5NPQAKhz0JPiCfXvzWcy9FpLwcqV1EClwiy54WKWQmpVJKLErGEAwyyExdjOGwsjZ
         5x5OOPNdCVBXyJGXwkI+IUnmFjRGsquJh9y7DhiQmbQ81D5VOG9cHhPQ8Q3xsNszuRDI
         hlKg==
X-Gm-Message-State: APjAAAV/prPiv9NaN4DhfNpN2hbPgffrafRn/eTV0n9TS/1x0c7K1UGi
        JHx4Q3o71dYzl6uGhOdbJJ4vtw==
X-Google-Smtp-Source: APXvYqyiIzUgOpbu5JKLdnKDPxQgFqCYX1OfETQq1MaukN74rbD9OAIBcUgXHGPceCG2ufABoZTxow==
X-Received: by 2002:a63:fc5d:: with SMTP id r29mr7055870pgk.282.1575514288156;
        Wed, 04 Dec 2019 18:51:28 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id o31sm6605986pgb.56.2019.12.04.18.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 18:51:27 -0800 (PST)
Date:   Thu, 5 Dec 2019 08:21:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     sumitg <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20191205025125.imxnao2qwyons5zl@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
 <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
 <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b634341-ea2b-e9cd-4986-dc9a01c839bb@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-12-19, 16:57, Dmitry Osipenko wrote:
> 04.12.2019 14:27, Viresh Kumar пишет:
> > On 04-12-19, 16:25, sumitg wrote:
> >> In T194, CCPLEX doesn't have access to set clocks and the
> >>
> >> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
> >>
> >> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
> >>
> >> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
> >>
> >> used to read the counters and calculate "actual" cpu freq at CCPLEX.
> >>
> >> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
> >>
> >> given by node "scaling_cur_freq".
> > 
> > Right, but why can't this be hidden in the CPU's clk driver instead,
> > so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?
> 
> What about to make use of dev_pm_opp_register_set_opp_helper()?

It has a different purpose where we have to play with different
regulators. And that won't help with clk_get_rate() anyway.

-- 
viresh
