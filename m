Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639131E443A
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgE0NqY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 27 May 2020 09:46:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgE0NqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 09:46:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so7377184wro.1;
        Wed, 27 May 2020 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qON6LSJtVCq7nI+6x1yYZ2+6ycr/GduPskOQfhEOUPE=;
        b=kKuOyHxksmpn2viYDm6uBBYiVdhn1GauaVhRQ+yX5DeZnOEhWdoEme0j9Xby4PhXks
         mg7qKwWiv7MFQUHzqZZ/FtiHttTg+213ZYNzix2twb4MW53K5L+G7rG+838qst8umNrU
         JG+w8w8Ts6HYugA05UH0RnbRJeYXS7gdOGfDse6n9goRq2FVBy5wx7aK3jfjj3wKqd0P
         lOVxKx03CbbZtRHLtrUb1NyMPOIPSI57GHsEG+PAnbJrN9VSrinUdrwxU1KbNQeTGbWT
         OuU78RJspm8VZ4Q9nlzJuWLtl+hXmR6giwG4qestZt51Pi80nhngFNphnheRZCCpiAij
         ngrA==
X-Gm-Message-State: AOAM530vmzqydJgQbXcPPfQO42QMYjMYatyj/YItGiZ4bL2FwqQvT2DW
        +R+4sXx+SrJwvcruSNZPiJ52Kxzv
X-Google-Smtp-Source: ABdhPJz/NrNXnuz9gbxIl7rNWK4SnmfMhnN0Rx90dURWqV1qjuX/JkBxGOaGNKZ0A4lQiWmWSWSHFA==
X-Received: by 2002:adf:f389:: with SMTP id m9mr4002908wro.195.1590587181794;
        Wed, 27 May 2020 06:46:21 -0700 (PDT)
Received: from pi3 ([194.230.155.118])
        by smtp.googlemail.com with ESMTPSA id p1sm2989229wrx.44.2020.05.27.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 06:46:20 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, a.swigon@samsung.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] interconnect: Allow inter-provider pairs to be
 configured
Message-ID: <20200527134618.GA4857@pi3>
References: <20200521122841.8867-1-s.nawrocki@samsung.com>
 <CGME20200521122857eucas1p1db29d5dd09e801ca22214e94022a951b@eucas1p1.samsung.com>
 <20200521122841.8867-4-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200521122841.8867-4-s.nawrocki@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 21, 2020 at 02:28:41PM +0200, Sylwester Nawrocki wrote:
> From: Artur Świgoń <a.swigon@samsung.com>
> 
> This patch adds support for a new boolean 'inter_set' field in struct
> icc_provider. Setting it to 'true' enables calling '->set' for
> inter-provider node pairs. All existing users of the interconnect
> framework allocate this structure with kzalloc, and are therefore
> unaffected by this change.
> 
> This makes it easier for hierarchies like exynos-bus, where every bus
> is probed separately and registers a separate interconnect provider, to
> model constraints between buses.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/interconnect/core.c           | 11 +++++------
>  include/linux/interconnect-provider.h |  2 ++
>  2 files changed, 7 insertions(+), 6 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
