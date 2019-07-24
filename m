Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAD73796
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfGXTPj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:15:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfGXTPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:15:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so38485926wme.1;
        Wed, 24 Jul 2019 12:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PWx99XZq+fN9B+Oe8W7y8sLgenk5724DKP3Xv5BSiDY=;
        b=jwxuWodJfcW/bQ3uzgs1h1CxiNbNxBbHeOOfdj3JnIr5mWW4k1r69ono7uv3FKZKqs
         d8LNmaClXw/3naIzwg86yO/wopIGzTrpU3MxKKK3QrfGXFVr+97OuR8vq286txuDjTda
         Wqmbcmv3bpyq3g9vWioKvLKZPQutUVeP4j1fPnicCt29iEMsj4GuByluyM7DCCN3J5fZ
         bunhp6S2oFTS1GX3QrTcEJOkdb41LADab8oG3G4NKf40QMrOvgTgk6hK2QNjPBgo4h3d
         B0wCswwHHdKjT6gJ6Mv5yy0O8NKl1F+AFGOUlJTOF/mRsSKUssJdUuowSoppAVK2UpRt
         fAeg==
X-Gm-Message-State: APjAAAWNwngXBXV3Eb4DqGT00UH2gVKyPG314TMoB1Y7u/WepopFpNiN
        iJ9mj7nrnj0z/zbv/at/fuU=
X-Google-Smtp-Source: APXvYqyyLA4OKohlQbHOKG/b+iP0vPhb3YzM7QiNcuaGJ/Ghmpo2+PH/lTWrGKV/KjM/oPB6uYz8QA==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr75123545wmf.115.1563995736502;
        Wed, 24 Jul 2019 12:15:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id t3sm37844851wmi.6.2019.07.24.12.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:15:35 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:15:33 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 05/11] icc: Export of_icc_get_from_provider()
Message-ID: <20190724191533.GH14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122025eucas1p251df372451e0b27ad7f2e3c89df60b64@eucas1p2.samsung.com>
 <20190723122016.30279-6-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-6-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:10PM +0200, Artur Świgoń wrote:
> This patch makes the above function public (for use in exynos-bus devfreq
> driver).
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/interconnect/core.c           | 3 ++-
>  include/linux/interconnect-provider.h | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
