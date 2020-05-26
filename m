Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE51E21E8
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 14:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEZMcb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgEZMcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 08:32:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743BC03E96E
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 05:32:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so2963195wmh.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vCPx6qkjkE87GQ9zi7thXK76HafQnhLa7mqK8w32S30=;
        b=jrdqXp9lUpIatzfYVL+cQoa4ruiktjr8CSsE9h+7UL1IiwRuzXFynNx5aC/qF7JDFa
         yyaeKeUNvHnC7/qVjyO6aoXPVNeeZnNIrSVBccy6AMLyV8slMgVi++ys2abbzRjv9BvT
         etiaY3eBReqaPJUX9038zKU8jhcANuTP/YYKmc+yRvJYOTNwk1vuCxTyvI+3nZL0zaH+
         8mMdKQZ0oOzrun9ioR9EeHyP8bPZpmG0C8DeTYwdj6YEP3qsFcWiuymGjdUw0XXpkKXx
         5/YOoe4kJW3/WotL2f2gGmzcwmYWHgt6rIo3Fd8RyKdXYdNxNXDDVlQRu6GiQqh1WOTo
         sGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCPx6qkjkE87GQ9zi7thXK76HafQnhLa7mqK8w32S30=;
        b=sDq/2EzNCNgKleiY1OCFGayHw4/Z5xO3k6ilPcQp9PREswy19gcHoZ6KjPL/Qf/kvr
         RxIjBPri5lTVZBg2BdMnGMIgmCLYYA8ijtkMtGPmVeMXDX/Zx98sYKW0hIpZgWKGx6kx
         eb1YsS23QT+6i1jha9qeyHlohu2f2Oa+2oftA6xP/L/sxOCgc881l60qBoCmCoJ/chhL
         w12x90DvWYtJVrrEV8nyhCPAB72TWpWQEZt03YSVJrMY+loyvFFS9MwGy6IES2s0Z5V7
         c5gP4gOjeSiIg6IbHlIl0o1f4ZGiudXRkPtvuNiWtJwJ1K5hjzjk6VC/fGjr5hjZAVwX
         YHTQ==
X-Gm-Message-State: AOAM533DdjLYIyvbJ5y9Zs876Kc1i16a65rQ1k/gVWt2VWzkqsM9FkBg
        EW9XSHB5KnhG/QO26yb++lfZ+w==
X-Google-Smtp-Source: ABdhPJwEhE6qT7i0uQZ+ESmFPmcPpC2XBvQ2DEcOeE/E0+JCU4q+/iukwgyZQFnboBg2ZmQxIGbtxA==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr863428wmf.163.1590496349257;
        Tue, 26 May 2020 05:32:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:20c0:f1c8:831b:d98f? ([2a01:e34:ed2f:f020:20c0:f1c8:831b:d98f])
        by smtp.googlemail.com with ESMTPSA id d13sm20821509wmb.39.2020.05.26.05.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 05:32:28 -0700 (PDT)
Subject: Re: [PATCH v4] thermal: qoriq: Update the settings for TMUv2
To:     Yuantian Tang <andy.tang@nxp.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200526060212.4118-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <62609db2-52e6-3982-7241-8b812e024c34@linaro.org>
Date:   Tue, 26 May 2020 14:32:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526060212.4118-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/05/2020 08:02, Yuantian Tang wrote:
> For TMU v2, TMSAR registers need to be set properly to get the
> accurate temperature values.
> Also the temperature read needs to be converted to degree Celsius
> since it is in degrees Kelvin.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Applied, thanks!




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
