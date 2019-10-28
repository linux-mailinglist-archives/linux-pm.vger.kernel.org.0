Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE9E77B0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfJ1RgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 13:36:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43220 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1RgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 13:36:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id f25so3157456edw.10;
        Mon, 28 Oct 2019 10:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OAsEaZPXZx2ykx4Hduijb09lsGu9L40MOJoDfA4h76I=;
        b=NqVUKe8AAwg3/e5kY88622dMhzzgUlYS3DU25SnI7zBTMDf43TCbzIhHX88RPpV9Co
         BC/htzXURJuAnrnpn8jHBmR1oFdL4UJnyf2I4JL5scEz9AnMeRPXAWTgVZovILxy7kj3
         fUetDNdRoRBszQZhxiH/rjmwlgTHW5Gvx8ZWdF7GDjCRfIGPYeam5ivheDIYk5Pf46el
         hHkFPQLWFHxChN7ERyypWsO887L5d4rocM6iroJemBbQGq4Smt/8DSknmH5ke4GlBTvH
         r47ySri5vkhrF4qk3K24cz3rT+jNh2pwAjWSnOsvd1pChMJ+++515ArC9GDNyZkuiyKH
         NfzA==
X-Gm-Message-State: APjAAAWcwWDffOVYGwHzRlx7qgtYm5cjFQYWywP+1Unn18zYQBpzBNU2
        tS35N/RgyXz9jLwPutNkeOM=
X-Google-Smtp-Source: APXvYqwJ3rGCTA5Ugojohtfi7BCoIjiTdyuBPtySkjGp2LNe5eVrME1DaNBUpbKCPFdjUbhwuwe2Nw==
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr20955345edr.274.1572284169385;
        Mon, 28 Oct 2019 10:36:09 -0700 (PDT)
Received: from kozik-lap ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id rp21sm84757ejb.17.2019.10.28.10.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:36:08 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:36:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v6 2/2] ARM: EXYNOS: Enable exynos-asv driver for
 ARCH_EXYNOS
Message-ID: <20191028173606.GC14395@kozik-lap>
References: <20191028151534.9920-1-s.nawrocki@samsung.com>
 <CGME20191028151555eucas1p2178f1a2cfe9e09c5c03c39f0896ab289@eucas1p2.samsung.com>
 <20191028151534.9920-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028151534.9920-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:15:34PM +0100, Sylwester Nawrocki wrote:
> Enable exynos-asv driver for Exynos 32-bit SoCs.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1 (RFC):
>  - none
> 
>  arch/arm/mach-exynos/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied.

Best regards,
Krzysztof

