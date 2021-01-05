Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036B2EB0DF
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 18:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbhAERCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 12:02:47 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44560 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbhAERCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 12:02:47 -0500
Received: by mail-wr1-f52.google.com with SMTP id w5so36826259wrm.11;
        Tue, 05 Jan 2021 09:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYopY2fL6CXBBPr+Io7iofacq52SjkW+6qo7DnbLuZg=;
        b=VtFmJtej8f2aW6sWfqWmE3P87z5sbNbcucjYf6E09GJU8XB3ASgRxI18YIPWhTepUT
         3wgmTFisncRDXXiCbVQe4T8CT15jk7hWqbprrhq72F2Jo+jD3JJO9BBAF7l1qGpPTZ47
         LUpce8Kb/QzWY3J4dEMiEUtgwecXA/LC06b7T/icyqgd9fSxPouB7+EeggZLe7uwIwAr
         TUkQjvo5bql0MMd3p4Id+7EWjCa+awkRxi6ikknZwqwQwSaJ5Ml5VPdBGVKiITEmlmqY
         ZjYHrDzuewmOFgmXbMHCE2FqOm7RcHCaHzisvQuKqaPl2LDu0ei6GEQ+81ihdInu3PSA
         Urlw==
X-Gm-Message-State: AOAM533AQ8NajxdDEiCcpeODWXmt5nNI1lR4RVuJRbHCX2aM7tC/iZdE
        MtCyW2/O4/UbGtP9KO5GEGc=
X-Google-Smtp-Source: ABdhPJw3khmjPZic1mPiMYLc4bWxpVK1upa/cveVFaPiOk/3t+tr7TLU+XjQIi2pQmR9ANetF6J2vw==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr461023wrr.319.1609866124790;
        Tue, 05 Jan 2021 09:02:04 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h9sm177309wme.11.2021.01.05.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:02:03 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:02:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
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
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 2/5] memory: tegra124-emc: Continue probing if
 timings are missing in device-tree
Message-ID: <20210105170202.GB20651@kozik-lap>
References: <20201228154920.18846-1-digetx@gmail.com>
 <20201228154920.18846-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228154920.18846-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 28, 2020 at 06:49:17PM +0300, Dmitry Osipenko wrote:
> EMC driver will become mandatory after turning it into interconnect
> provider because interconnect users, like display controller driver, will
> fail to probe using newer device-trees that have interconnect properties.
> Thus make EMC driver to probe even if timings are missing in device-tree.
> 
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

