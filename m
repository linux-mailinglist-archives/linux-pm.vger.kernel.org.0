Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4182E0753
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 09:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLVIi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 03:38:28 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46086 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgLVIi2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 03:38:28 -0500
Received: by mail-wr1-f41.google.com with SMTP id d13so13627798wrc.13;
        Tue, 22 Dec 2020 00:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X0BA0e9T0mQVaLBo1ALvv+cuK8jlEU6aVrK+/b+CSMc=;
        b=sGzpvwW2gFcqGNduoinnrgcFopV2fNgXguQ9qUSBA+hovRmuESeJS8K9jri2zDQCON
         2+CHNUFhhCzi/PzvWBx0QcJoi6O0agMXPbHwr+iuqe4mTuk3ftjeT1kD/1Uuj8F2QT0T
         Bpknrl9RhqSXLBmvdGhmTLqh032g4ED/F1H+4YqJSlGEkRxOIUHl79I6yTdRdIshSpob
         iqMP+t6RXtaxH14YJcmPmTh49uSolMNhYtUlgvg1ugmp3NvRFkS6x7Rht+qrZl7an2f/
         0J0G0rKikD7JJ9rGifXMA34jyz5HJMadAQq75w7hD5JPlYYpY7dZDvKFfwO85VYj4gep
         1l1w==
X-Gm-Message-State: AOAM533PgtARlyOczmLKOYoELbppkPm8bm2cGoVpaHu+nHbIvTs1nOTO
        sN2GrBsjUREH71kqB+A2Sfk=
X-Google-Smtp-Source: ABdhPJyp6WE8a8cAWoUct9vPX3lw1Fm7xVJrnYEtIyZyySix2X64WFkd6wr4a35UBKbIbVhazY4zgQ==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr23200208wrx.310.1608626265452;
        Tue, 22 Dec 2020 00:37:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t188sm25215830wmf.9.2020.12.22.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 00:37:44 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:37:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: Re: [PATCH v3 3/7] mfd: max8997: Add of_compatible to extcon and
 charger mfd_cell
Message-ID: <20201222083743.GC5026@kozik-lap>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
 <20201222070520.710096-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222070520.710096-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 22, 2020 at 07:31:32AM +0000, Timon Baetz wrote:
> Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
> of_node set in the extcon driver.
> 
> Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configure
> the charger driver.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/mfd/max8997.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

