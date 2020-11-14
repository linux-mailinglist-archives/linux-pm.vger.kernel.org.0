Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45862B2E1D
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKNPic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:38:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgKNPic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:38:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l1so13608468wrb.9;
        Sat, 14 Nov 2020 07:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69qJWYnkpX9ioi+qZUPFiAO05y/pWbxM2in9qciZRJI=;
        b=I8MlNPbP2/VRpAgCvporn1ER0Dh0InQh+L/a3q/RIM5LmsIIHVpwyiPNiRq15ts+n0
         kevoPdDoSdoTEkgJfopBfC5ahtH0s9e5HBkbTEFQcCi89NTXD3R7atM8WRLcvDOGlBDG
         0sQabsa2Gr0BtWCyI5XPghcadUNbDKimdPtzqHejXEMcgHDeDD1MnEN1Bmxm/yYt9B/5
         iR8qH1rofvqVIvngwRYIaGNvrUg/b41vJRUihTjt3PVaFEkFPa0vTdEMgjbP2OFyKWhZ
         bLkGs6w3la99AhPQKG+Af5OSYf3WssBYeRri/sH4TT8GKB87tnDQBNg8IzpT5WuK4K32
         e/vg==
X-Gm-Message-State: AOAM5325lS1craXBMXDzB1EPQP1WHpwwKNPtr23LkDeggaPCYAy8nnSA
        Vjn6LLYNXnteRv+ZaWnAQLU=
X-Google-Smtp-Source: ABdhPJzGD2upHveWozj9/L9++omxHZy6/WMjZ1VlhkXJYpJnfssMc3CoHSdH0lNlmeAn5QKPbKBoCA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr9923823wrv.243.1605368310239;
        Sat, 14 Nov 2020 07:38:30 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 30sm8374755wrd.88.2020.11.14.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:38:29 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:38:27 +0100
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
Subject: Re: [PATCH v8 05/26] memory: tegra20-emc: Remove IRQ number from
 error message
Message-ID: <20201114153827.GD4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:35AM +0300, Dmitry Osipenko wrote:
> Remove IRQ number from error message since it doesn't add any useful
> information, especially because this number is virtual.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

