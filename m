Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7234D2A9C30
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFSbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:31:15 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44345 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKFSbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:31:15 -0500
Received: by mail-ej1-f66.google.com with SMTP id o23so3238705ejn.11;
        Fri, 06 Nov 2020 10:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEft+6XOFbVGdGN5mjfjNtpuHd4aAsAtWuXObA5Y2L8=;
        b=hx0kAn3B2m08v/PLHABqccEHwu0yImjjmr+lxkWzur+rtsVSgUQDCntVLiNq+qoWoz
         QopL+w5wzWNDnChYUU5PZSHaJeV78oa2leTXiDB+hGaTZRRU7ndcDZjSJFAdR1SmfGw7
         ad2B131b6tnHnWuagdrQTKVem0y+7hS/S6qmIFqKF15nEmQf3dI2bW2nJ2q+DXlM3KLw
         3mgmJbhHj+a3qJWmvNBuise7US862vdV/Syk2hK5nqaLEj9uoAyrijVUg7KS8Rb+8U6m
         RcPWivYOWW5a6N4OCLFA2qFa3uoP3d2nS5zovGS6hQpUVwN47T2BJd1bV8Ee1OiqWyLZ
         jw0g==
X-Gm-Message-State: AOAM533A1X4y8elbjyvj4p7AF8SEyoQKgZyw+4nq5kJc5EvHWbC/T50R
        lOZCBS+JkqUkgzu/yDgS34I=
X-Google-Smtp-Source: ABdhPJxPIV5PiN7jLWbfWUx3Y5g4rMFf+UvCHU9pX4oEQ+v3q8JGHpKeNO2AvYwjZE6lCCqq1PFpFg==
X-Received: by 2002:a17:906:2490:: with SMTP id e16mr3307521ejb.17.1604687472735;
        Fri, 06 Nov 2020 10:31:12 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h2sm1465606ejx.55.2020.11.06.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:31:11 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:31:09 +0100
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
Subject: Re: [PATCH v7 08/47] dt-bindings: memory: tegra20: emc: Document OPP
 table and voltage regulator
Message-ID: <20201106183109.GH65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:44PM +0300, Dmitry Osipenko wrote:
> The SoC core voltage can't be changed without taking into account the
> clock rate of External Memory Controller. Document OPP table that will
> be used for dynamic voltage frequency scaling, taking into account EMC
> voltage requirement. Document optional core voltage regulator, which is
> optional because some boards may have a fixed core regulator and still
> frequency scaling may be desired to have.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt    | 16 ++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

