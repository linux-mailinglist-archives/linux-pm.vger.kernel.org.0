Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E884D257834
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHaLW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgHaLEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 07:04:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565DC06123B
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:04:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n12so403635pgj.9
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SQHLmew/+Uw02hOPwl2KHpbtxwjKEHifcexkv1FCU6c=;
        b=qu9xuHsiVO1/lhFmOB3Y3peMVj53ZshahjOB6elhp66R5CgK9whhOLPoUy9hJDwOml
         Xx52NED74g9DEWtob9uJW3arR10F4ZGioAyQqYEs5SvJ1RjzcZA2QrePfX+NC69hXOpx
         T2ZqORq8P48EJWSjC8u3HyAakTJWOPBND8tw/CDs4nTIDPYu0fE46kWrXoL+o5XVsLiq
         ztj4QCcWejcIcr3s62PLOOcoR4zkUTdUUajQzYFsgdxoSYCfFfbcUWznqhF0ABqFnXPE
         OHlJ3s1cAKonQKGi4+iTZ+TeuRQIbX3NmSxTqk9xxswBLaw7kbqZlhRogYMkOY2qzObd
         Qt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SQHLmew/+Uw02hOPwl2KHpbtxwjKEHifcexkv1FCU6c=;
        b=AOsWITH0VX/rCbRVEaaBmdeiwgXoY1dexyuSAMfIAbKI+H8TbYCKSXkWomxNoE602n
         aiM5fZ5OmbaKBc69+bnM8QyZ2itNq5NNZO1AMmtU2ZFjlmSedsH2EoruI1lp19ael268
         2A8/2EOVPPHv5/IRDgVoUL2Q4RuJMFZgXJz2tmpLZ/uDwCqn3gGg35H9UfxyZhzYuvE2
         aZW2aRYWyF/vISBz6RDa6OmD5p1fEmvGWpwa32HgTByDa+CLEDxOVwLIThILIaaZCZyb
         u41tL03z39qHQbdxNfkGWHB34f6pO1RdDLiCg8BWoMOQ8U3Tji9x/KucDk7OAIdzRBVz
         OamA==
X-Gm-Message-State: AOAM530S1E7EDBZV3EgHZGpAcjWIdGMMzsjWERLO0f8xjpmjX+GHFlJF
        e+KuVedSybCvIksIB9bUmfoJzA==
X-Google-Smtp-Source: ABdhPJxeSefAgzvdXk9S266/E7KO0kwk+YEMEr+ulK04bFCe5SCH5jaiI2wePURUQh3DPfX154nn+A==
X-Received: by 2002:a05:6a00:14d0:: with SMTP id w16mr833159pfu.39.1598871854010;
        Mon, 31 Aug 2020 04:04:14 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id w16sm7665688pfq.13.2020.08.31.04.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:04:13 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:34:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
Message-ID: <20200831110408.a6lwivim4w4jtkdc@vireshk-i7>
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
 <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
 <20200831084111.6udzvrdonxgzju4l@vireshk-i7>
 <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfa012b-8f50-e460-972c-c51fa52bb858@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-20, 12:54, Dmitry Osipenko wrote:
> It's not clear to me how it could be applicable to the Tegra CPU OPP
> because Tegra depends on a combination of SPEEDO + PROCESS versions.
> 
> It's not like all voltages are the same for all OPPs that have the same
> PROCESS ID, otherwise it indeed would be nice to have
> "opp-microvolt-process0", but unfortunately this variant is not suitable
> for Tegra because some freqs have different voltages using the same
> PROCESS ID and the same applies to the SPEEDO ID.

How exactly do you know what voltage belongs to a particular OPP ?

		opp@216000000 {
			clock-latency-ns = <400000>;
			opp-supported-hw = <0x0F 0x0003>;
			opp-hz = /bits/ 64 <216000000>;
			opp-microvolt-fast-process0 = <750000 750000 1125000>;
			opp-microvolt-slow-process0 = <750000 850000 1125000>;

		};

		opp@312000000 {
			clock-latency-ns = <400000>;
			opp-supported-hw = <0x0F 0x0003>;
			opp-hz = /bits/ 64 <312000000>;
			opp-microvolt-fast-process0 = <750000 750000 1125000>;
			opp-microvolt-slow-process0 = <750000 850000 1125000>;
		};

You can make any combinations of such names that come from speedo,
process, or something else. If you can get this done as a fixed
formula then it is workable.

-- 
viresh
