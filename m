Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A211BB95
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 19:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfLKSVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 13:21:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33176 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfLKSVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 13:21:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so9590203edq.0;
        Wed, 11 Dec 2019 10:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9sVToONd+fTEwhYvsJ/8k0wg86wy07LtQtX5S1NlxU=;
        b=KBGSx15+7gGmDC1XdV2rKOqYqA6FhTb0qs633B65HiQgs+uYWtvKQusjC9QlqphqJv
         mh6pcCbw3J2ILk9r7h2uCKBuVCMdYiEsNRdhFJJO+t0GGoGtIoG+DQQdA8K8kuICKjxH
         P02JfyiexWFeKFcLULHIBFHHVtcWZA851KcANe67B+s6z5FPZQrTyDtfOV43AZeGBxZ4
         qBuXxUVVmErhqYQfBYq66G+pqbsdbhxqqKFcro2ApUnDwHpzRtHDQMBotzq9fRLCh8gh
         eiNNiN/4r152UQZ0h6riLUisz5+HG4rIlBiSjC3dVCxVXlAd2BhgGtq5OqqjefT2Lp5d
         5aJg==
X-Gm-Message-State: APjAAAXjCnyicd14+5kYfrSp/uzpZ5L+CiNVB9hlkl/FpOhDpUiLeAh8
        Y0KLuDZDRlSM/YVoK+4OyX0=
X-Google-Smtp-Source: APXvYqwVUE8J5FCuoKASkA48pjyAQ91Qg6Fc1R2pY0YltL8SDnG4jJfjRhmh/4RHa1sFybNMqZ48pA==
X-Received: by 2002:a05:6402:1659:: with SMTP id s25mr4814152edx.219.1576088459075;
        Wed, 11 Dec 2019 10:20:59 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id 2sm65676edv.87.2019.12.11.10.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 10:20:58 -0800 (PST)
Date:   Wed, 11 Dec 2019 19:20:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Remove syscon compatible from
 chipid node on Exynos5
Message-ID: <20191211182056.GB2427@kozik-lap>
References: <20191028152050.10220-1-s.nawrocki@samsung.com>
 <CGME20191028152059eucas1p2b48166c35f61dfc8edfa99f54434e8ee@eucas1p2.samsung.com>
 <20191028152050.10220-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028152050.10220-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:20:49PM +0100, Sylwester Nawrocki wrote:
> The "syscon" compatible string was introduced in commit ("cdcce1ee977b
> ARM: dts: exynos: Add "syscon" compatible string to chipid node on Exynos5")
> to allow sharing of the CHIPID IO region between multiple drivers.
> However, such sharing can be also done without an additional compatible
> so remove the syscon entry.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 2 +-

Thanks, applied.

Best regards,
Krzysztof

