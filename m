Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C115A11BB91
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfLKSUZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 13:20:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41430 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfLKSUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 13:20:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so20220083eds.8;
        Wed, 11 Dec 2019 10:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCq+YLmjndsqzVRfIXx595cSZyYTIfyoVBGa1n3MlZo=;
        b=csOvR/hhPlWuwKRi5xvRzIXhe54IBHinIQVS++u/nqij0gEe7+NhVVrdwAPiYX1tm/
         qhsyxp4hwZhIqmmDNi+llI8SyQc9n9+eJAjpCQlw19B4H4Y/NuSBsRydcebyYenFQf4z
         J/4YOYDF2l53ju3wm7OQGr6s9x3hmbCiyM7hbaYQ7sSgxsC0QnlI/S+1PU+ciZnrWq+D
         lW7ULnqTMY8YH1p8wqJ4vXoJ6vLqA8iSMh46qZkD6M4Ojpprso6VrBI+e4gl4rfkuqcq
         ppDEQ52H4NBo8RGIuqDo5vjFWM/LYNKJ/BM5cY71Wtm/zWKiq+XsmTGYhHGJto0GAccv
         bjOg==
X-Gm-Message-State: APjAAAXdM85IdqATnJJ3Pg+v9xodkLAciDgdgFCCCi0RXOV+QJTGtGqU
        QL1Q9UZkTuJxyMq8OIeKbjA=
X-Google-Smtp-Source: APXvYqxSrBfPuZyxedBUFXHa4HwHCjZ0I74AtbkA+bPFUbpLrYb2Uyy2G8q4PvOG2wVqT+P/uDRiBA==
X-Received: by 2002:a17:906:c791:: with SMTP id cw17mr4796655ejb.69.1576088422783;
        Wed, 11 Dec 2019 10:20:22 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id b17sm67400edr.42.2019.12.11.10.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 10:20:22 -0800 (PST)
Date:   Wed, 11 Dec 2019 19:20:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Andreas Faerber <afaerber@suse.de>,
        Arjun K V <arjun.kv@samsung.com>
Subject: Re: [PATCH 0/2] Increase CPU frequency in Exynos5422/5800 SoCs
Message-ID: <20191211182019.GA2427@kozik-lap>
References: <CGME20191210114035eucas1p213dc81b3934969baf2bb9235d5ab8d28@eucas1p2.samsung.com>
 <20191210114027.14910-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210114027.14910-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 12:40:25PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> This patchset is a resurrection of the patch posted about 3 years ago:
> https://patchwork.kernel.org/patch/9475909/
> 
> That time it was not possible to merge it, because a few minor pieces
> were still missing in mainline kernel. This has been finally resolved
> and there should be no blockers for adding the higher CPU frequencies
> in Exynos5422/5800 SoCs:
> 
> 1. support for coupled regulators (and all its dependencies) landed
>    in the regulator framework and patch #1 adds needed coupling for
>    the Exynos5422/5800 based boards;
> 
> 2. support for the Exynos ASV has been merged to v5.4
> 
> Patches has been rebased onto the v5.5-rc1 kernel release. They were
> tested on the following boards: Odroid XU3, XU3-lite, XU4, HC1 and
> Chromebook Pi.
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> 

Thanks, applied both.

Best regards,
Krzysztof

