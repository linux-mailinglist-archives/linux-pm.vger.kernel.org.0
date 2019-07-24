Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488D37379A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfGXTQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:16:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40398 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGXTQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:16:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so42618385wmj.5;
        Wed, 24 Jul 2019 12:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LNAmuM+7si//N0400TDsq2MUrZ/1PI7eiz92D6aickY=;
        b=kTvSXQOahR1/dB+rAkHPAElnMplr/uvHOJitNGie4gQo/U3UNvq0bp+XEdQnLA+PGv
         SbQ7lyyk+9UT0z2gFqjnfP0EV1GU6PipTFLC8P008m4tEqHRYkr+3dOB8fbucIJADTgp
         bkTtW1I/wtmc4D75ZHnq6tf7WCbpRri1Z4uFsHck9J20dp9G9w4qHQLRCY4EH2+BTzF+
         XhJSwU2XsToLfFX78ynTndJw7UsQCOaASTR4xdp9HBokDsdJeI8d+c/nsvpTUxIkTIh1
         koBiwhibmkpsR16QxOqs6e3raCB/FxualzQ5aR4PRoDUfI5hBRUJmRiQLk7PpxG5AWzH
         0nNQ==
X-Gm-Message-State: APjAAAWU/3+M3fDHXxzeaHlqIbLz6deHJ3VzirHeiHqj22WNB8Jhl9J+
        Pr2l9p7e4b8JdVo3FGRaFlI=
X-Google-Smtp-Source: APXvYqznKz1ACVYFK8RxfQFmQ7H1Q2wBIzpGBssnn1iwZQnb6SjaP8h75HCTkprLc/WEfC65AVtrsg==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr73188753wmm.108.1563995778325;
        Wed, 24 Jul 2019 12:16:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id f70sm56473772wme.22.2019.07.24.12.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:16:17 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:16:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 06/11] icc: Relax requirement in
 of_icc_get_from_provider()
Message-ID: <20190724191615.GI14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122026eucas1p2acf705de2a47ba54f383d916f5383144@eucas1p2.samsung.com>
 <20190723122016.30279-7-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-7-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:11PM +0200, Artur Świgoń wrote:
> This patch relaxes the condition in of_icc_get_from_provider() so that it
> is no longer required to set #interconnect-cells = <1> in the DT. In case
> of the devfreq driver for exynos-bus, #interconnect-cells is always zero.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---

Makes sense to me:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
