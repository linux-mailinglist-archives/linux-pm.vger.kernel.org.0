Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE978F365
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfHOS3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 14:29:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39562 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOS3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 14:29:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so3051127wra.6;
        Thu, 15 Aug 2019 11:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+ti5MoYAXo5Gey/THUpmV9/n/MyYAX4cVlRNM3ewyk=;
        b=kenpdG4zz+zDKowXgcmj7UlWEl408gEFB2M50TpE/sSbfSmUZqxDRMEC9M3mzW4c1b
         yhC3B+U3rqwfd8xhx/TexIe0Hfv1H8KKzTydU0Bg4UJtk3IRnSputNkKrBF0dH/YIh58
         LdvhJdLdOZ2N4xKgwdWxuMEgmkBdLPKPHnPxqL3lgu7uFaDbnoeaPMowo6/NZNbCmKhD
         48lJfG7oaF3UDeqjr0LvFP299t2fAyocWazXuNakUGYRAt+LUQowsTbPXO6JbvUrrlK9
         +5kqU4Lkta6k3vPgEECYJrrl9+/5+h7j69ogkGx63gawb0bM6ENYxufrHjcE98oTn3BU
         aKbA==
X-Gm-Message-State: APjAAAVGNfVPrRd8D6wV23+8kJNoUlM33F+YicIXaoeDbgOchmNd2Nsi
        HzkoM8NXfqDdzmzhAWXngu4=
X-Google-Smtp-Source: APXvYqzcm8U/A1Qgplcw2RiLILIE0EgMkCH1v2MhQN4StF7iqTRUm9rJjXSeZuEZ0RWP8wo36QOmyw==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr6497885wrr.300.1565893783407;
        Thu, 15 Aug 2019 11:29:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id h97sm9341511wrh.74.2019.08.15.11.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:29:42 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:29:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 5/9] ARM64: EXYNOS: enable exynos_chipid for
 ARCH_EXYNOS
Message-ID: <20190815182940.GF14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150856eucas1p1a8957cfe50e3b421ccbc3084404de43b@eucas1p1.samsung.com>
 <20190813150827.31972-6-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-6-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:23PM +0200, Sylwester Nawrocki wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> This patch enables exynos_chipid driver for ARCH_EXYNOS
> based SoC.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1 (RFC):
>  - none
> ---
>  arch/arm64/Kconfig.platforms | 1 +

Thanks, applied.

Best regards,
Krzysztof

