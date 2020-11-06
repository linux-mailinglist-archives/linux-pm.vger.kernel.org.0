Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31A2A9DAD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgKFTN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:13:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKFTNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:13:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id o20so2370742eds.3;
        Fri, 06 Nov 2020 11:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EZhY8MX2ORnPTYlgHuLdEC9xYXRcHwFhL5jilyHyBk=;
        b=bSM3TpMpzsRYb3RmH5ih8TThVDqSriIvMMFCw7RmWCzzGDjDHFjda52hRs8Hj6JC+a
         VhSdHPcxPSuJ90bfwNJ/v+9TrYDihvMq4TYhGkhy0H/ajQF6PHqrHOZYZIFtJuRHzg2M
         MfeZZRjKzyaO1u3+GguvzNmAlnjldkjkHCsFisIiqGUGFTnCPRSXO45bMrTDONARZsLe
         Wk2PbH0mkiP3rtxaYy+cFg4ROuXtY5Xe7js74gKYZuGR+JuNVejAJcetR1aG4On18BXf
         OfvMOMM6c7k2+Q+7lQlX+TPFjnOEK2eUaleqSd2+tSgqX3tFPgG2Zc2p+MNz6c1KZtjQ
         7k7Q==
X-Gm-Message-State: AOAM532M1Uj9WLmk/UDLKqQCn4b0frNWhN+vr8zFDQSW0QNFGCWFDg8U
        uGovuF4tUmu3kkT7NQIi1x0=
X-Google-Smtp-Source: ABdhPJy7Qz/mYqSzbcnBR4NZTFT5VYfhsIq8GGjSYs73p0hgywJkMPbiryDfg2BYkIp0DwxRJWQNUA==
X-Received: by 2002:aa7:d801:: with SMTP id v1mr3516842edq.250.1604690003690;
        Fri, 06 Nov 2020 11:13:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b1sm1635774edw.27.2020.11.06.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:13:21 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:13:19 +0100
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
Subject: Re: [PATCH v7 36/47] memory: tegra20-emc: Add devfreq support
Message-ID: <20201106191319.GB65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-37-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-37-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:12PM +0300, Dmitry Osipenko wrote:
> Add devfreq support to the Tegra20 EMC driver. Memory utilization
> statistics will be periodically polled from the memory controller and
> appropriate minimum clock rate will be selected by the devfreq governor.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |  2 +
>  drivers/memory/tegra/tegra20-emc.c | 92 ++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 

I see this one still received comments. I skipped the DTS patches and
applied everything till patch #35. I understand you will send v8, so in
such case please skip the applied ones (you can rebase on my for-next or
on Monday's linux-next).

Best regards,
Krzysztof
