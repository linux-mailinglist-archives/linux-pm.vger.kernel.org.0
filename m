Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3052E7742
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL3I5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 03:57:06 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:41855 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3I5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 03:57:06 -0500
Received: by mail-ej1-f42.google.com with SMTP id ce23so21093626ejb.8;
        Wed, 30 Dec 2020 00:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41sMND7+zfV2+vzUQ4YKIJSzXqV3wvxskgd8Zjie29E=;
        b=fCND5xsZzgtrk1RdgXnUJQbDdiYntqpf6Jvadx7MzwId/WKg0Cn7boJdMijsYCLxUI
         5vceNuiO19NtHvxJSMPO6lx1x/R0UJbKrog2YKgRDmspSpe68kLumZe/DRce8aPnyL3c
         EesLA2hbVkfVDQkCqbLIv/fN6vsZCG8HirHbyp2sxMFTHCdau7PUB0ckel68QQ1qw8oj
         W2hUkphd7jfgkF+SGv1Nt3/VPkYUFo6cy4Y9c+GUcGEKzoG4XeYZ61tc77GqL7nqdz9z
         xd51RYNSQ0fQYxrZ46j/qRn5CSmYRuMkqPf0KjgdEiqhZBRSXekUeNfNvqp5971Gwe2l
         IAPw==
X-Gm-Message-State: AOAM532orumEl8t4xiwPFKzBNcdCLEzlyDnTxSr69MbFMkQ/HTePOFrw
        Nob1X/otZAB/lbzto/6sfy3iHdV+fM4/ZA==
X-Google-Smtp-Source: ABdhPJys7IJcM+bvZYtIDbeV9Qx0Cx7gWpIGqIys9g+rTxq1va4CRQSY20A2wbEHIqfQsyPhNGIjvw==
X-Received: by 2002:a17:906:3999:: with SMTP id h25mr49371263eje.146.1609318583820;
        Wed, 30 Dec 2020 00:56:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id rs27sm19201480ejb.21.2020.12.30.00.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 00:56:22 -0800 (PST)
Date:   Wed, 30 Dec 2020 09:56:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/8] extcon: max8997: Add CHGINS and CHGRM interrupt
 handling
Message-ID: <20201230085621.GC9214@kozik-lap>
References: <20201228113507.1292506-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228113507.1292506-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 28, 2020 at 11:35:38AM +0000, Timon Baetz wrote:
> This allows the MAX8997 charger to set the current limit depending on
> the detected extcon charger type.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/extcon/extcon-max8997.c | 4 ++++
>  1 file changed, 4 insertions(+)

It's already a v5 but what are the changes here? You must provide the
changelog for your patches - either in the cover letter or in each patch.

Best regards,
Krzysztof
