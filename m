Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB812645B8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIJMHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 08:07:43 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33352 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgIJMGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 08:06:44 -0400
Received: by mail-ej1-f65.google.com with SMTP id j11so8384972ejk.0;
        Thu, 10 Sep 2020 05:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+fUzVwQJmucEEQIw/NyyHNfb0Qbx8DuzRUvQWjs5o8=;
        b=kLmHX8Uwo8oJWODKjTPeJuo0OkbGGlsM2xc429GSWOL/SVgiGwCVkjciy/OxqO2JlY
         lwKY/lPv8FM9qWEuvDZUjGj+dGsCu628ADmplDcdw9eEzkGWRI/2T0h3kzmOv43yO6eN
         8TY3hHT+QaXAc4B173xLnA/cEkpOBZ2Vw2IAo7Llwq2PzEsQwHaZxvXdVEVV+BbcF1sH
         x2T0JawmTBhc927CoZOqST4kPvGjtkSnTxTh+C8SWMZCp2yw7xV1xvcjvJpB748wQqee
         +mSKokyl6Aapw1BCD1WDRO8RiClqF4gtnLBe8V59sp3mtBGgZ4g6OxNenqJv3FsTmLk2
         07SA==
X-Gm-Message-State: AOAM530XkFkrH7I/CacBl6CamWsZiueM3pJpnv0YkuZ8wg3OMOh86G/i
        Oaegur6LVn1K2e/YBCJAAzO6v9bs+oI=
X-Google-Smtp-Source: ABdhPJwtuFRyTrMqvc/UdO33zlq0mzonMys8w3IYNwmkAjlZc23qLG4IKlvH/+Dii3/bFcv7ViFNzQ==
X-Received: by 2002:a17:906:354c:: with SMTP id s12mr8438562eja.370.1599739588694;
        Thu, 10 Sep 2020 05:06:28 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id o93sm7069314edd.75.2020.09.10.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:06:27 -0700 (PDT)
Date:   Thu, 10 Sep 2020 14:06:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PM / devfreq: Change prototype of
 devfreq_get_devfreq_by_phandle function
Message-ID: <20200910120625.GB2206@pi3>
References: <20200908102447.15097-1-cw00.choi@samsung.com>
 <CGME20200908101230epcas1p3d1fc20eb523c4bccf043ada808611e96@epcas1p3.samsung.com>
 <20200908102447.15097-3-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908102447.15097-3-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 08, 2020 at 07:24:46PM +0900, Chanwoo Choi wrote:
> Previously, devfreq core support 'devfreq' property in order to get
> the devfreq device by phandle. But, 'devfreq' property name is not proper
> on devicetree binding because this name doesn't mean the any h/w attribute.
> 
> The devfreq core hand over the right to decide the property name
> for getting the devfreq device on devicetree. Each devfreq driver
> will decide the property name on devicetree binding and pass
> the their own property name to devfreq_get_devfreq_by_phandle function.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c    | 11 +++++++----
>  drivers/devfreq/exynos-bus.c |  2 +-
>  include/linux/devfreq.h      |  5 +++--
>  3 files changed, 11 insertions(+), 7 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
