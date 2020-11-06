Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D32A9C57
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgKFSep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:34:45 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36319 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgKFSep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:34:45 -0500
Received: by mail-ej1-f65.google.com with SMTP id o21so3274339ejb.3;
        Fri, 06 Nov 2020 10:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FkzNqxSfyMo55uSFo/RaS7wC0Mk7oJJx/7MeeIEWsa4=;
        b=cgXbp65mFJ7LQIY2QqwTlUIIKPaBClXn93XL8w8PfKIQv9ZLYdGhb7MWhST2JHAYCp
         CJ93tpOqChqrPY4q1OjNam3D3n4UxKVx7NhjmdD1XCSBWtackkmMc+WbzcOrf8uC2U41
         yL80G4oNyJZbcQt8TtyP6jC5twWKSRqW5QTXwCT0z2rtCv3jt0EbkCn6++Qs7wWxmLl5
         VU5MO84PCAxGA4Sed2ViEeTiO/os1eBvSpto6w6r6Iy9Qx7Ihivkn7sASJZvd4jlG4we
         Wb6hPlNM98nvworRkbxnPs07tXvgdXI/2r07SXAJz2x7metFjQvgpLX+TuJyaWo8/KgU
         8Ycw==
X-Gm-Message-State: AOAM531UDbQl41lezzpCHQUwSxqyVa7rTPgfBoV6ED9W0mjK3zL176pM
        xRn79IngmgrLMYy0zfs0M/8=
X-Google-Smtp-Source: ABdhPJy3Lu/emveh4xDrPGSELPBmtgh1n9Y46JBkYcuVt7osEk6IGboPfP6TMtvtKJf6JLY+T06mUg==
X-Received: by 2002:a17:906:934d:: with SMTP id p13mr3275824ejw.245.1604687682790;
        Fri, 06 Nov 2020 10:34:42 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t3sm1588459edv.59.2020.11.06.10.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:34:41 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:34:40 +0100
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
Subject: Re: [PATCH v7 15/47] dt-bindings: tegra30-actmon: Document OPP and
 interconnect properties
Message-ID: <20201106183440.GN65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-16-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:51PM +0300, Dmitry Osipenko wrote:
> Document EMC DFS OPP table and interconnect paths that will be used
> for scaling of system's memory bandwidth based on memory utilization
> statistics. Previously ACTMON was supposed to drive EMC clock rate
> directly, but now it should do it using interconnect framework in order
> to support shared voltage scaling in addition to the frequency scaling.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

