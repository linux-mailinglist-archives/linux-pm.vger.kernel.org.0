Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF329A769
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895430AbgJ0JKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:10:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35281 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895389AbgJ0JKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:10:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id w25so644564edx.2;
        Tue, 27 Oct 2020 02:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80MoAHpRIeqlhSgipeCIrI2Ose88TsV9gGfciJMAXKc=;
        b=g4VTy3ozSVAwqFhW9CsOiUhicQD2m5zS+pi6oalCXY8Hz5NfNOkvjyt5QX4rObnFe5
         3AhVaJOqrTPiw+vUVGOyzR3ZKEKslqy3lDPrdvD7o7EbcVH527wG7+oLDfmmTjTK+QdH
         Wug7OQQxdNNnOjULHlll1q8UIbXCZxzL9KVo6asW/+gedahvLBrpj30r0EsEZ/hXWQ8e
         4vnMJ7HY8clEFyP7KY4rcfjAZkXgMDcveN52wLl2FUX2jebipucRMU9TD4lFizNUbZWz
         sqYffG+BHixXem4SQ0OnrVHcVmhDXohYGJKYJIwP+ymhNVY8Ev42NXiJix5OarN7g/AE
         7iQg==
X-Gm-Message-State: AOAM530Z4VB3QwfKpLHANxydXMWN65T1RwRTKOarFPRD+ujgWFAsX86k
        /9VuX7dPSIgrYPgMDUVZHf4=
X-Google-Smtp-Source: ABdhPJw03tfNHJKHN+5zfYTStAM0PG5LZVKh+f4qwv2zvA3WLkTvXoFxO2psRHm1gjX9/9IivEvJ5g==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr1176678edt.141.1603789846609;
        Tue, 27 Oct 2020 02:10:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id dn20sm671769ejc.63.2020.10.27.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:10:45 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:10:43 +0100
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 20/52] ARM: tegra: Correct EMC registers size in
 Tegra20 device-tree
Message-ID: <20201027091043.GJ4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-21-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-21-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:03AM +0300, Dmitry Osipenko wrote:
> The Tegra20 EMC registers size should be twice bigger. This patch fixes
> the size.

Don't use "This patch" (this appears here). Better to use:
"Fix the size of ..." or just "The size should be twice bigger" as it is
obvious that you fix it.

https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
