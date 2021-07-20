Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E13CF354
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 06:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbhGTDum (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 23:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbhGTDuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jul 2021 23:50:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78073C0613DD
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 21:31:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u14so21361235pga.11
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 21:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcvcTNKU/F2RKt/RmkG+At3l4CoJejuKhB7w1RypCN8=;
        b=Sx/gJA9HcbmCmuQGmp62XskYmYz4CywjWF19PpEZRNKyEOrQ6iJT87aEwyPwXz0LfX
         w04jtUsW2BaHdzi8gwh1XgIqD79qOWo0OrR9c1VCNwH4Ew74CB+bPlVenFjPxAnbLbO4
         Mdwg+4wq686xdcHmOSY4y59ZFDvX6Ig5cAQscZuNarTLdRqpMQQOKKsBXb4O3gmflAhZ
         zdkum0rWN+uP8cMKejWLjQ1D88NfmhuYBMBVNb0dMJt12z/xEHp0qvH9D+AJ4znZErsc
         bYApMy2mo0TVnSKh6rwdqcZT9SJ4zusfB0Los1xsdgkLmEWL4qhRt0fDNluSnpc6cZ3b
         LH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcvcTNKU/F2RKt/RmkG+At3l4CoJejuKhB7w1RypCN8=;
        b=SVQAH1udEbZu/0axyM1ejYGTSamgK6RFhs79XQevvM0kVse8VXm17rVUgpMLb61BRG
         v7PXyADH8wmHHC5yAvUJAKuEkq7D6MFUYieuEhEyyidmC5dJr0rQtZwnrsX+O377WR5l
         UMUzMxQK6gkwYbuAUB5FkB+lyTt5nmUNfq5uSJbv04HyV3oFDOHyGKNCQLbDSsdkW1Qp
         iYzkKXawRLk3wg9SxD7ZAbixObr+7oMAysKDfbsvgj4GS9LTaL/l5NESrSBRyCuDWthN
         Or+66Cep8Pt9NFT/RhpOD3HO2d3piu6XCJOfcKVSzpk19FN3PZyDKTF+bLeIw3eRkHqL
         es/g==
X-Gm-Message-State: AOAM532hwl6iHfBDVHvrxlt+nRVjNzKnOewcyjb0J3cBEUacDuEqGCed
        1BZkc92no6ZUCxSCAFYhzk28QA==
X-Google-Smtp-Source: ABdhPJysz1iW7BlxcGrZOzQHEEHs+B6gk0BAxURN9YRsRRV3t6/jJRke+sTMnGh3PxII2EGDluQHDw==
X-Received: by 2002:a65:62da:: with SMTP id m26mr28616661pgv.370.1626755470972;
        Mon, 19 Jul 2021 21:31:10 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id g18sm21192639pfi.199.2021.07.19.21.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 21:31:10 -0700 (PDT)
Date:   Tue, 20 Jul 2021 10:01:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: opp: Convert to DT schema
Message-ID: <20210720043108.bmoydy3a2r3gqhnq@vireshk-i7>
References: <20210719202732.2490287-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719202732.2490287-1-robh@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-07-21, 14:27, Rob Herring wrote:
> Convert the OPP v1 and v2 bindings to DT schema format. As the OPPv2 binding
> can be extended by vendors, we need to split the common part out from the
> "operating-points-v2" conforming compatible.
> 
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - move opp-peak-kBps next to opp-avg-kBps. Also add a dependency schema.
> - Correct the opp-microamp schemas. It's always a single value for each
>   regulator.
> - Add missing type for '^opp-microamp-'

Applied. Thanks.

-- 
viresh
