Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D82ADDE1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJSMd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Nov 2020 13:12:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39572 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 13:12:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id e18so13790552edy.6;
        Tue, 10 Nov 2020 10:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zVEeBWH4boLoYPklqBLn+QKdlMMMbgHaDTwk4KlhWWs=;
        b=Z9hARbWhZOyPxhAdwvsC7Wo0jj977GDqtwsv6oUkZE3LtQZtlTNvnZUo9icufccOw0
         sjBzlWhW3T/fKpZE3EpXO2k5V1Q55OW6lfzfPjfixCH2GvBWqnuy2OlIQyey/K4ZOSRb
         0rjNGUNQbcfM/5SJzoyvzdaMU9OjZfQr+IYOGSQMKsw0nJl6FNzx+xdvYivQ+lQOQcS1
         cxLL0pTFXHDbTpAGu63vf5iO0nZDnLSZu50h1oVY5OkfL3qg9lyt5udDlj+uU8kealq2
         /vWUkd/d3ePQnEhMCDsAX8aIJTGVALnzJriOC477TszN4P9/UgsNsDJV0jDrNSNAjIKN
         VxCA==
X-Gm-Message-State: AOAM5305VZOvoYlzjgSJjowAk0QbR/BawV38Qf3yYaduCW9BHQsgEi+5
        UNgJLHxeo5AA3pJvbeVlFBE=
X-Google-Smtp-Source: ABdhPJxgbiurBs3VssnS4U50mTvuqR5WeodLBeUgTpzriGzhl6pyvF7kFoWZWHNfMdQRwfXTVx9n2Q==
X-Received: by 2002:aa7:c546:: with SMTP id s6mr611498edr.114.1605031949981;
        Tue, 10 Nov 2020 10:12:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id qx6sm7768963ejb.10.2020.11.10.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:12:28 -0800 (PST)
Date:   Tue, 10 Nov 2020 19:12:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 6/7] ARM: dts: exynos: Add interconnects to Exynos4412
 mixer
Message-ID: <20201110181227.GA23147@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103728eucas1p2f671f29ed9eb06d4c6c991b073be092e@eucas1p2.samsung.com>
 <20201104103657.18007-7-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104103657.18007-7-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 11:36:56AM +0100, Sylwester Nawrocki wrote:
> From: Artur Świgoń <a.swigon@samsung.com>
> 
> This patch adds an 'interconnects' property to Exynos4412 DTS in order to
> declare the interconnect path used by the mixer. Please note that the
> 'interconnect-names' property is not needed when there is only one path in
> 'interconnects', in which case calling of_icc_get() with a NULL name simply
> returns the right path.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8...v5:
>  - none.
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied with Chanwoo's tags.

Best regards,
Krzysztof

