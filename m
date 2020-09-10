Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913742645BB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 14:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIJMKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 08:10:09 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:40184 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgIJMJ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 08:09:57 -0400
Received: by mail-ej1-f68.google.com with SMTP id z22so8327645ejl.7;
        Thu, 10 Sep 2020 05:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fMr7yVrAmB2s1rgrqGSTgH2SeLcG7AUVdmZBn9HXpKw=;
        b=oi11BHVyCYK5OErZsFe84YXQjYFe/5drTSvQ3aI+JjZKA14ukiIzKqf/hsiGuu93mM
         7jCdXvWGq/s9zWW48kIQiE+tZcswJhHHq+hcyKKtWS9z1tpeVQ5Gy6MOPr9QS4Yzhww9
         CaLMFsLSEdU3LqkZd6U2Kq2x/+JZcyvczdgBuWrcRKkTLpY8zviXrNGdALo+uUWlKeOH
         jJKLIJtusz7mH69viwAP7qllebJQSq1aV/dj/wecsnE7E7G5KR+mKXS6FBYtyUOMAeax
         ab1/7f5mOZx9AeFcMa/LhyYEcWdRYAUR5tW6johmmrvCwVubrKKwcvAkNzwrgFnmO3M2
         ix7g==
X-Gm-Message-State: AOAM532/2KdOK74VLwRgw3Ih3u5EMEfvQwg1FJn96u8BBIGehxW+amD3
        DUbxf1UDW/gaVfCVqAnbjtlfDGSkhX0=
X-Google-Smtp-Source: ABdhPJznuwyTY0MUsaJSoqj7g6gSzRl1JGZ3NGHhpIGRwpsjCVqpYLabExRBhxJ0Bt8KNlmwTEOzwQ==
X-Received: by 2002:a17:907:9c3:: with SMTP id bx3mr8658856ejc.164.1599739695700;
        Thu, 10 Sep 2020 05:08:15 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id cf7sm6822005edb.78.2020.09.10.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:08:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 14:08:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PM / devfreq: event: Change prototype of
 devfreq_event_get_edev_by_phandle function
Message-ID: <20200910120812.GC2206@pi3>
References: <20200908102447.15097-1-cw00.choi@samsung.com>
 <CGME20200908101231epcas1p4b6262aae4d5272f6cce366ac1ffbb955@epcas1p4.samsung.com>
 <20200908102447.15097-4-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908102447.15097-4-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 08, 2020 at 07:24:47PM +0900, Chanwoo Choi wrote:
> Previously, devfreq core support 'devfreq-events' property in order to get
> the devfreq-event device by phandle. But, 'devfreq-events' property name is
> not proper on devicetree binding because this name doesn't mean
> the any h/w attribute.
> 
> The devfreq-event core hand over the rights to decide the property name
> for getting the devfreq-event device on devicetree. Each devfreq-event driver
> will decide the property name on devicetree binding and then pass
> the their own property name to devfreq_event_get_edev_by_phandle function.
> 
> And change the prototype of devfreq_event_get_edev_count function
> because of used deprecated 'devfreq-events' property.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq-event.c         | 14 ++++++++------
>  drivers/devfreq/exynos-bus.c            |  5 +++--
>  drivers/devfreq/rk3399_dmc.c            |  2 +-
>  drivers/memory/samsung/exynos5422-dmc.c |  6 ++++--
>  include/linux/devfreq-event.h           | 14 ++++++++++----
>  5 files changed, 26 insertions(+), 15 deletions(-)
> 

Feel free to take it via devfreq tree. I don't expect conflicts around
memory/samsung/exynos5422-dmc.c.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
