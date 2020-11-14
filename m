Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCF2B2E21
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgKNPhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:37:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNPhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:37:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id m125so7785412wmm.3;
        Sat, 14 Nov 2020 07:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZmlbFh0hWx58b0n2enEM67BSZj4OZbN+MaKTEZMGf/M=;
        b=CAVCmtLL9ffu7b2hSUyPP9s/GiGoii4JPUBQjOlFtL66shdkRU7/dziT8ZC1T7BCyw
         VqpqsE5qKY3dMmL1wVJNx5+tCl1FM82pdMnnYyGOTm7NY74csA+l42tgMmPXSC48QdWw
         HYqbZf0/CSq2aWiXVpe55rh3s4Pt8zJj96rA4fo8lsgFF2WNyB8RQOoK5v+Kie8ZhbnN
         1Y4kMHvKXMNCT022INAtKT/Hrqk+ODSrNOwmqe8QebvwY/8W9Tk1hXyiVceGI2iib9TO
         8F4IKygfnvipbqMwq5qmYMcLLLPLmCoh2QBPAntETTiSzhPo2frU6YCogripgUdrfcfi
         Pbog==
X-Gm-Message-State: AOAM5319zOTGQ8y1XIYADerUKFHjzCHlm8Di8aXZkzWFLRT0mq50ziH+
        EmIJ7LHLxOJcA4c1kD8CSAM=
X-Google-Smtp-Source: ABdhPJyzI7AG4iGUF1QmLcRFpwG9j3+/23Zyv6fGfHY4T0G4UfxJYHELxIV+Rch7MrTMAHHH5in7ow==
X-Received: by 2002:a1c:acc1:: with SMTP id v184mr6898730wme.63.1605368265988;
        Sat, 14 Nov 2020 07:37:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m22sm15946562wrb.97.2020.11.14.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:37:44 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:37:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 03/26] memory: tegra20-emc: Factor out clk
 initialization
Message-ID: <20201114153743.GC4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:33AM +0300, Dmitry Osipenko wrote:
> Factor out clk initialization and make it resource-managed. This makes
> easier to follow code and will help to make further changes cleaner.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 70 ++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 23 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

