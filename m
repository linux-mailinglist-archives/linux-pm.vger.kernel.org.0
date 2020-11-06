Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E605D2A9D7F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgKFTHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:07:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35821 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgKFTHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:07:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id ay21so2358664edb.2;
        Fri, 06 Nov 2020 11:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ief/IW6YwZHxDYhLab+9E7np7Olmpv1KaYaqOLTouI=;
        b=mNw8O4AlpQtOPgIaJRvj6BLG4L7OPFOmVFckItgM5Rc+sfxVX9oi4S5mAq0TzQJKkq
         I1rOfEJ2ousEHfiY3ZpHspAsAayM1JgnND6euUEzLfbfdCe3isR+oPgXGoaJGyk3Kp1g
         uD/wJBzOpxELgP1u42Xz06tb1sLncIguWAHoCfXtBoZqqpNvRR5+z63Gr7Ryw3NZwJ6O
         k2Mcg4Ekyqm1p4HsVIgD1J+kxAW1j9ltNbT4Do00duDtZa55nDtbeXxgT0m8lO+ABauo
         oBhWnMRRMOsjlWwxnG7vV1Xb75b1/vPrvGxaT17NMPbcsvVq57QroCgkQfnp6tGYMh4e
         mKOg==
X-Gm-Message-State: AOAM530pLaWmtQZX1IjpQ+9eeRoEdK5SPVgF/1Kdi4lhB+NA7uPQb2kk
        SlLiYUwGk0z7/7UMrXQDdh0=
X-Google-Smtp-Source: ABdhPJxr/EoTQwpT1xyVghBrRW2C5fW2U542Y7PpGvGJttCw6+sgZkXwEqUajELTWWscD2oGm9o8Pg==
X-Received: by 2002:a50:d751:: with SMTP id i17mr3543471edj.337.1604689625715;
        Fri, 06 Nov 2020 11:07:05 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m1sm1642893ejj.117.2020.11.06.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:07:04 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:07:02 +0100
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
Subject: Re: [PATCH v7 32/47] memory: tegra-mc: Add interconnect framework
Message-ID: <20201106190702.GX65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-33-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-33-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:08PM +0300, Dmitry Osipenko wrote:
> Add common SoC-agnostic ICC framework which turns Tegra Memory Controller
> into a memory interconnection provider. This allows us to use interconnect
> API for tuning of memory configurations.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig |   1 +
>  drivers/memory/tegra/mc.c    | 100 +++++++++++++++++++++++++++++++++++
>  drivers/memory/tegra/mc.h    |  22 ++++++++
>  include/soc/tegra/mc.h       |  17 ++++++
>  4 files changed, 140 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

