Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A32A9D92
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKFTJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:09:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgKFTJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:09:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id j20so2339014edt.8;
        Fri, 06 Nov 2020 11:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qK37W3xTCJXp7MUelHSeuVBr0ncAlJOu059iUAhSoPQ=;
        b=QG9e3VbaOPodfRo1oGxsLAScCTytuPDnUttfql9HGO29RDw8GSXfHstExbomyG/eiy
         KJ5NAIl8h8WAr/xd86Ps/jUqtJu+PQffiSuu9ZnITFmuRvBiBQWM783U3gZPfZ/8MhXp
         qzjjHWSBVGvM6lWM2hQyF/y5ZS+MkAF86XupHDbEcL6K64edYiif+WIvmwUcKR+mgKFW
         io0OfYN8mZAS8e/tKh24h7u/07s0plJee4uclIE11TTBkjPmsTLdpIjbdA5yLvHdjNfV
         40QcrMxLSfta57iz+7vMFSM2H0gHKrUOIade1K86KppVYWmovx02xAriqqi/2Xt4Njv/
         Pwxg==
X-Gm-Message-State: AOAM5303M40eC8F2S9dT4en5Ji5TWjkc58ciatbZa/uuo0WUsE/gTW/0
        pRZJc9LJwyhSCJCLZxkmySh8lYUOBIg=
X-Google-Smtp-Source: ABdhPJwdAHZPSXDWTQYtqObDqNkh3xX1JcIZrPeM6I5RcvHVIxwL8vDjKJ29lIgHkpGyN+FLmALthQ==
X-Received: by 2002:aa7:dd4a:: with SMTP id o10mr3580286edw.109.1604689741010;
        Fri, 06 Nov 2020 11:09:01 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a10sm1628669edu.78.2020.11.06.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:08:59 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:08:58 +0100
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
Subject: Re: [PATCH v7 34/47] memory: tegra20-emc: Continue probing if
 timings are missing in device-tree
Message-ID: <20201106190858.GZ65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-35-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-35-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:10PM +0300, Dmitry Osipenko wrote:
> EMC driver will become mandatory after turning it into interconnect
> provider because interconnect users, like display controller driver, will
> fail to probe using newer device-trees that have interconnect properties.
> Thus make EMC driver to probe even if timings are missing in device-tree.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 34 ++++++++++++++----------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

