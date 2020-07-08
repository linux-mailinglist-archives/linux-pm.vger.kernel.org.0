Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6863F218766
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgGHMdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 08:33:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgGHMdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 08:33:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id d15so41670947edm.10;
        Wed, 08 Jul 2020 05:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhieJsQuOEwSP81dBdl01exBUOB4h6MMR09/FyCdqmQ=;
        b=YVCvV4MN3N2tL0HKzC96nnjQaH6/IDXO4hRNbeRAlpejGVkma+D0XmufKGWzhdN+HD
         ffohPw837EGoEaeQzX+7M7JndF7rZ8y2OmQbyU1WKsRKygyNBsW9neYZll4ikRPKwzgM
         I3H6iyp/FxgGRVJ4faQ9gbOPx/bgPiY9PY/2cRtfgoq4N6BBptwYtzn8ZneFG6pQV1Ka
         hWVrswjypRbt5zo2ax9xDPnoLi3dVeyjYIC3jiE1D+fokLRLNu4XBRn4ck4rCF3EZjR2
         AOufotVMPTe++p+otloGTpk+26odJ25TKCCg/qil71hjbDZn4ZtyWn69gtxxEDMzA4DJ
         MMiA==
X-Gm-Message-State: AOAM5328c+DXaJIux0SeF2fc91HngnGAeexGJRwsa7JiCYrTqjyWQZU/
        awBKC7nf3sZZ1Wqen5aIDTw=
X-Google-Smtp-Source: ABdhPJwu6Uv1QKLJxfMUiLAIi03G94R2XS09hZ5lEYX5Hc7T85mzMl53BpuQKvDyP6DYQMjvb7M+nQ==
X-Received: by 2002:a05:6402:31bb:: with SMTP id dj27mr2097888edb.387.1594211586998;
        Wed, 08 Jul 2020 05:33:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id a1sm1893441ejk.125.2020.07.08.05.33.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 05:33:06 -0700 (PDT)
Date:   Wed, 8 Jul 2020 14:33:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     lukasz.luba@arm.com, k.konieczny@samsung.com, kgene@kernel.org,
        s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] memory: samsung: exynos5422-dmc: Use delayed
 timer as default
Message-ID: <20200708123303.GB29033@kozik-lap>
References: <20200703062622.11773-1-cw00.choi@samsung.com>
 <CGME20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb@epcas1p3.samsung.com>
 <20200703062622.11773-3-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703062622.11773-3-cw00.choi@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 03, 2020 at 03:26:22PM +0900, Chanwoo Choi wrote:
> Use delayed timer as default instead of deferrable timer
> in order to monitor the DMC status regardless of CPU idle.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 1 +
>  1 file changed, 1 insertion(+)

If you want to take this through devfreq tree, I'm fine:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Otherwise I could grab it through samsung-soc after devfreq change ends
in mainline.

Best regards,
Krzysztof
