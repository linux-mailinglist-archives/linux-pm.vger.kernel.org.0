Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D011112A1C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 12:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLDL1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 06:27:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDL1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 06:27:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so3530175pff.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 03:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmL6FENNnhbTO3NJFWaBCMeUeCpAJ1jRa9dqlxupymE=;
        b=F3wvtw5GZoxf/uf0Pmwgl8Sgdb2uZeqJuALUi7H5DfUT9+ehxmg/T47TyL5+c3q1Ih
         Oximl2z0EHmem6mOsESeiCxY/P6jjXUr53EcmB1XRZlPaqWuYcX2IcD6lb/6XiS+Lhop
         GXhfgUWo+IFBaYb+uknsisZRdEoOCREeSyjf5s6u7OzI6vy6cM9mS1DbaoPdubdUGP8F
         eWcrE6S+UH7zBD6l3o3Xu2gDXc1Y1lvaRcvLUbo6KrZSEZN4oNn75/GFa/NR9s+q/ca7
         Vpkf/nYpOGDXOZcSKXs1QMq8q7dwMuVWi4xaK1D02mgAdcs78nJeCig/fd50RmX1fSRj
         6zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmL6FENNnhbTO3NJFWaBCMeUeCpAJ1jRa9dqlxupymE=;
        b=epBWU2ryUj2WcUtAAnatg/wi+wAORgW+zCxV8nOs8rx/OtF88sAtIS0pqsFZfyshxI
         MXgON9a45Wac85a1T4sGtM/VRmLz5p8paokl2KfR1L0IbQZhqcdru4oW4QiFQa9PQeXJ
         E79TRqgB2xMzp7QejnfL10rwCvltRQaBRRWFUwgNwlhFSSUbIHf+vJsfwToBDw2Ce37W
         PyNCSdbXucHcCdxFZ0VobLIjm5qRrMZ8qyIgSJ9T5LaJiYUzo0aWj7tpmc69VBMJMNEr
         oXqv2+eD6j3+DFtN3Nm1aM7VfRPg/+hFpVxHdBjSLjkY+C4jAiXaPiVFFAtFWWkbKDPR
         tgaw==
X-Gm-Message-State: APjAAAXICu/BfeAhsO94W9fkL3bcRBR72cgph8Cx4nsf/YYY2Vv5ea2F
        dLqJ7/IxrlMhsuPMBG6BRNt0uA==
X-Google-Smtp-Source: APXvYqx2l3xqPWb2zgRYIdgfveDuPG39UrTm1xwZbsR5SVMAAemiNkQQ+ORdf0MMO3IbWeN143i9rw==
X-Received: by 2002:aa7:8a8b:: with SMTP id a11mr3012908pfc.207.1575458872541;
        Wed, 04 Dec 2019 03:27:52 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id b98sm6294031pjc.16.2019.12.04.03.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 03:27:51 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:57:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     sumitg <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
Message-ID: <20191204112749.jkwlyteal4hfvnhb@vireshk-i7>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20191204054043.o4ff7pnqec3fwdgu@vireshk-i7>
 <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7347caa6-43a3-f761-de83-481b45f7b22a@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-12-19, 16:25, sumitg wrote:
> In T194, CCPLEX doesn't have access to set clocks and the
> 
> clk_{get|set}_rate() functions set clocks by hook to BPMP R5.
> 
> CPU freq can be directly set by CCPLEX using MSR(NVFREQ_REQ_EL1).
> 
> As DVFS run's on BPMP, another MSR (NVFREQ_FEEDBACK_EL1) is
> 
> used to read the counters and calculate "actual" cpu freq at CCPLEX.
> 
> So, "cpuinfo_cur_freq" node gives the actual cpu frequency and not
> 
> given by node "scaling_cur_freq".

Right, but why can't this be hidden in the CPU's clk driver instead,
so cpufreq driver can just do clk_get_rate() and clk_set_rate() ?

> > 
> > - populating cpufreq table, you can probably add OPPs instead using
> >    the same mechanism
> 
> We are reading available frequencies from BPMP to populate
> 
> cpufreq table and not using static opp table.

Right and lot of other platforms read it from firmware (I believe BBMP
is a firmware here), and create OPPs at runtime. Look at this for
example:

drivers/cpufreq/qcom-cpufreq-hw.c

and search for dev_pm_opp_add().

-- 
viresh
