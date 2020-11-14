Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5A2B2E27
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKNPj6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:39:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55538 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKNPj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:39:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id c9so19075946wml.5;
        Sat, 14 Nov 2020 07:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2epbZ3+UnndJ7TIcZlKuCPOVDuT8GqG7Cpc8DUIEdTs=;
        b=CC1LhKtyV+6JwjJLGkaVY1Ssx3ncbbtMHqqKAyg3FdtpKloKBgWFmNP3g6VNkTR9XE
         tWcxqzXLKlAMKjpk+LTx58qQEhoR/J46WGDgpL1GGAI+/Xbu9gPoV5gtY1DxYdRHv7ca
         +dV//Y1t5ON6dyzPHxVHx7j29r7Na/UeDZKvPBVRjSMca8a/0zaMHw49dSAOOs1pQfEv
         ux+mCK/yD/mffTmxkwEBCLpgW5hdNDYSsA5Q+hVFMEQ50jkp2ZscwDJr1mKA3yjtu7XE
         vwEp/mYP6e8CvZivMigd1ZXdK+79vK8bNJFvE9wr5cvnjwvgKB0Q7wJwDtsHPwFunJW2
         yp9g==
X-Gm-Message-State: AOAM533/USgNQOhZOrjas0ljwL2NJ7hUCskuSM+uewGd/MrI8QhFGjqA
        0a+3cFSEzGtoL1QhTD7Drcc=
X-Google-Smtp-Source: ABdhPJykOlHO4MbKp8wxNIyMEoiv/tohAotAvK9fvlbalM9OUcEQMMQezZ0QLYuDEpRm/iiCeDsBkg==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr7305741wmb.122.1605368395400;
        Sat, 14 Nov 2020 07:39:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s8sm15757236wrn.33.2020.11.14.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:39:54 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:39:52 +0100
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
Subject: Re: [PATCH v8 06/26] memory: tegra30: Add FIFO sizes to memory
 clients
Message-ID: <20201114153952.GF4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:36AM +0300, Dmitry Osipenko wrote:
> The latency allowness is calculated based on buffering capabilities of
> memory clients. Add FIFO sizes to the Tegra30 memory clients.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra30.c | 66 ++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

