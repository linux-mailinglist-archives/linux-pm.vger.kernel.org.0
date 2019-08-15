Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519118F363
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfHOS3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 14:29:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40955 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOS3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 14:29:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so3041263wrd.7;
        Thu, 15 Aug 2019 11:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oPqIja1djSFQaMHzmMB5elWLAxM9w+CqqDsALBkXNM=;
        b=rtpuSWsaObGfKOalCRkf3e/KsKkCMPys1sLJqtwJTjLE/KiOSoeYOYEO2cIvjc5D7K
         Zk6VIscQjnQ2+DS43mBtVzPgAk8VLjXlSu+fB31X2DCe9rThnem5gZEkZFA029ERCwYC
         E1FjplEZY+XNojvcS2PhzZjLN9hC4Mo8q7yvueRrkJSOtdnI+FER1x2TdCrKtAZf4oKh
         66Of6pQXWMFeaFMGJhXvtEpqycBfC7NPsLCUSE9W1MEC/IJ+9+Bis1JwZBv2YAzvDC/S
         IAPz4+iPkFd7If3aw3dP4aNQ4Tsu7XX8SVSaSScEEef/tc2PzvvKgE4zAEJHxEOy3E8z
         uwbg==
X-Gm-Message-State: APjAAAW27kWxFx4X/Iz1syVX+aJADl7N8gAMsZBxALSueDk7fYUP/Sr/
        fxXLp+zJP9wk9AnMky3z+BVQ2MOu
X-Google-Smtp-Source: APXvYqzVdGk/Xra/7epYLGeIObvfQ8NARFdB+GJ+YoiQV4cu4USoeofq7Sxzvi/YrrseIcujrhWICQ==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr6967593wrw.64.1565893772726;
        Thu, 15 Aug 2019 11:29:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id a23sm3724705wma.24.2019.08.15.11.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:29:32 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:29:29 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 4/9] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Message-ID: <20190815182929.GE14360@kozik-lap>
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
 <CGME20190813150854eucas1p14716609be6697222ae5795328cb2ed04@eucas1p1.samsung.com>
 <20190813150827.31972-5-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813150827.31972-5-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 05:08:22PM +0200, Sylwester Nawrocki wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> As now we have chipid driver to initialize SoC related information
> let's include it in build by default.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1 (RFC):

Thanks, applied.

Best regards,
Krzysztof

