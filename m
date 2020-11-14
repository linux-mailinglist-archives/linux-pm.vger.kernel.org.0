Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846A2B2E0F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKNPg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 10:36:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgKNPg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2020 10:36:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id k2so13664552wrx.2;
        Sat, 14 Nov 2020 07:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6P1mcO2kNRJbbh/T0XZ9QtQQ26OuRe5uLfwAgAsxH8Q=;
        b=K9Cbseo2cRhdtKcdjgY1tdqr1Pra1M/ugDiNOp7DpHDDHqX6pJaeWQsAjRUItgw5l+
         cJWdTDDyat1pfIGY7k83khLeq4jUumPVwiGsLHcZRhgVwv+WGu7BQJoK2z4jQ3NOuT3T
         WWV1iNycrxb41i/S8Bi9M0052mhNimFFm6ugGhnTOWmbD/szA+0jdiRfirOz15z2kN4I
         3ZBXmVNHTPeSPDwhMf0Qlyh4arw9U09cyT2r5VafDhb95UBeOhWc20fK/SaH/Ihnt5SS
         zfghxe8SRLrBc7YCKEyMsvz9JeXN5q6nPa05rXH34aqXEzIYAPfOByYNQq5pCK4s88U4
         541Q==
X-Gm-Message-State: AOAM530WDUDKcgkWGIrCoLr4qx3UDumjNKLIYpoJcFLF1F7y/0t7G2JX
        I1cykHLGBKQRunnECiMl6wstLb7RSTy6UA==
X-Google-Smtp-Source: ABdhPJw/ztErj0PDs063eF71cDChBodWTwASgTPBkCh49ytR3SgplH/2PxKc4YKX8d3OpILcg9/WqA==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr10404788wru.345.1605368217307;
        Sat, 14 Nov 2020 07:36:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l16sm14975132wrx.5.2020.11.14.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:36:55 -0800 (PST)
Date:   Sat, 14 Nov 2020 16:36:54 +0100
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
Subject: Re: [PATCH v8 01/26] memory: tegra: Correct stub of
 devm_tegra_memory_controller_get()
Message-ID: <20201114153654.GA4106@kozik-lap>
References: <20201111011456.7875-1-digetx@gmail.com>
 <20201111011456.7875-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111011456.7875-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 11, 2020 at 04:14:31AM +0300, Dmitry Osipenko wrote:
> Correct typo in a stub of devm_tegra_memory_controller_get() to fix a
> non-ARM kernel compile-testing.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/soc/tegra/mc.h | 2 +-

Thanks, applied.

Best regards,
Krzysztof

