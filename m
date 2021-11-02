Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2370442640
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhKBD6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 23:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhKBD56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 23:57:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B1BC0613B9
        for <linux-pm@vger.kernel.org>; Mon,  1 Nov 2021 20:55:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so13914518plq.11
        for <linux-pm@vger.kernel.org>; Mon, 01 Nov 2021 20:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8cVtkWKgPUMZJ3AtVb3knoep8UoSR2rrED4LPbjbkI=;
        b=GHiBd4jBYqQVyoTuEDOCGYv7kgWm3OdNrGRL353yRlewVRaowwKQixpzN/LH6AFpid
         m4WzVFrdeu3ZX3bHBHAUmBPp5xLmoaSPRwyZfQxrnuShScp+Q6ZxSuWHX2bfXDQOCgLC
         3USNfB9kUE0AnWcziU5RZ7rqGzmPTEZI5Ip96KwSfOdOttBqaQXwfXCxTIZsAag/JzDC
         7AvG9MMdZBTuPzHtwmdIii/ejhX1Ml/P8Xn1aKA+7W2mRFTI3n5GfeUIPBrumqQtf82b
         QM1l/EF3ixqxynaAGncd18LbuBwGngkBA/KKg0fssdb8VLYbZZKleUmlY4nL4vgkp29F
         FRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8cVtkWKgPUMZJ3AtVb3knoep8UoSR2rrED4LPbjbkI=;
        b=4gWEiVJ4mIQ1mlm6YZj1l3RqW6fYuemNb+y57JzUt7as3/LUlLzHKBIM5qz+mUeV73
         CYtyA0M7YuhYHxbAPhHxFBdVLWWS1mfb55qXlwiHxWT7cZZXk96whF6ewwKL+E8PafRM
         7WaxhCJ97DPDjuo0DZCNamMExnasmkPRCTZpz2RdUGoVG9r8HcNfsQ7zHgpT5kpTcmjC
         s3T5dDrH0l5Wy2l1VMQdiGwFkgfpdGpbOdd1HR70hH2P9SYdwXt55jxqDrU35v4/u6Xv
         Ro3kTHIkNnQMaPprZu6Ef/eVRM+Nv4Fp87m2U0i4UqLqwWCH+GSO1yXWyKKar6ykXo4T
         UGKw==
X-Gm-Message-State: AOAM530IePuIwHcILFkYBVcwQtFSE6mFai3Z+5yFhoWYIPhfqQAuBfiY
        9vF5IKzKh6RdB0BGM07amYAiPQ==
X-Google-Smtp-Source: ABdhPJxYfBW/c6mWtHDy4XXyKl3wz+a7WMN6k3KSAwhuYnuossmKhj2QHWFZWPxEOROKs7wzZIA0fg==
X-Received: by 2002:a17:90b:1d86:: with SMTP id pf6mr3688966pjb.20.1635825324232;
        Mon, 01 Nov 2021 20:55:24 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id c3sm3264992pfv.25.2021.11.01.20.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:55:23 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:25:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: opp: Allow multi-worded OPP entry name
Message-ID: <20211102035522.z3nemnrz6r5ycf6z@vireshk-i7>
References: <20211028221547.22601-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028221547.22601-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-21, 01:15, Dmitry Osipenko wrote:
> Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
> tables use multi-word names. Allow OPP entry to have multi-worded name
> separated by hyphen. This silences DT checker warnings about wrong naming
> scheme.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied. Thanks.

-- 
viresh
