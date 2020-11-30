Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AB2C8025
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgK3Ihb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 03:37:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37358 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgK3Iha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 03:37:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id h21so23528782wmb.2;
        Mon, 30 Nov 2020 00:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hGLe4cToDIvo4HB3a/5ZfuG6qTk6bfRGM4GcipNY+6Q=;
        b=k4LE2unixW68NAWpykc9oTelX+Hjqghw7abbqz9Iwr1rwVgDtfgyss8c788RxodOeh
         5h6ldUCUXu8NKQ7SxOqD2qj3o4iAy82Of4SSe68ydkHyscDjZh9OhuX4jIxYIK7N4pth
         E4BxaTuQe3WGPxct7R2tzv2tCPrm/kyotkwv7dh1SAZPaUcgGPbjHAcJkPeU2M2zWZXh
         DC9KV7CE6iAXIxAmMAc0KN3gUJPhAHjWNgZlMMYKfM1DYHL0XKW6rNiR9JCIqBhf4w/C
         0tTHDQbwRfEvpN3JfJxSYrUYh+tQOJu2RzYWvDz0z2gNN7KMg1JEWiZk8ps1kTBo5lqp
         V9sA==
X-Gm-Message-State: AOAM530463+3yOcmD1E2iG5/GlD/TYcPmMOoLrwpKgjJKtwflw+Co8v5
        D9/I3PTr+JT8mAJcDbjUFhc=
X-Google-Smtp-Source: ABdhPJyIIikaJAewDDxbe7eDP7AKT83BXDJQ2y9y2Mtw+U8S4nGzCPJAQAG2vZ+ozkayNtJFvTW3gQ==
X-Received: by 2002:a05:600c:58e:: with SMTP id o14mr22175684wmd.47.1606725408530;
        Mon, 30 Nov 2020 00:36:48 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r1sm26179377wra.97.2020.11.30.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:36:47 -0800 (PST)
Date:   Mon, 30 Nov 2020 09:36:46 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 00/19] Introduce memory interconnect for NVIDIA Tegra
 SoCs
Message-ID: <20201130083646.GA6711@kozik-lap>
References: <CGME20201123003254epcas1p1763e1ce693d7cb8e2f20d521e701ad5f@epcas1p1.samsung.com>
 <20201123002723.28463-1-digetx@gmail.com>
 <d12880ba-6780-cfee-7667-3723fcad9f3a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d12880ba-6780-cfee-7667-3723fcad9f3a@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 05:44:39PM +0900, Chanwoo Choi wrote:
> Hi Dmitry,
> 
> The v5.10-rc6 was released from linus git tree.
> Generally, I will send the pull-quest about devfreq to linux-pm.git maintainer
> after releasing the v5.1-rc7 for the integration test on linux-pm.git.
> 
> The icc patches in this patch have not yet merged. If these patches
> are not merged before v5.10-rc7, Maybe, I'll apply the devfreq patches
> for v5.12-rc1.

None of the patches here are going to be merged to Linus' in the current
cycle. They will only go to the next so if there is dependency,
everything will be broken and non-bisectable.

However no such dependencies or merging requirements were mention in the
cover letter.

Best regards,
Krzysztof

