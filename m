Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064AB2DFCBA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgLUOVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 09:21:38 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33384 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgLUOVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 09:21:38 -0500
Received: by mail-wr1-f53.google.com with SMTP id t30so11259633wrb.0;
        Mon, 21 Dec 2020 06:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ewiW74906x1++gP791fj9PLs6tTKhYh32TyRNms0o0=;
        b=ePT/P+eckCPEj0RyjoCtGkJJxFZk+OATezQ5W0jqn6ry8bXjt9EqYArJ0Yb8RqvzYn
         2yg+CE8L5djdzi4a9DHvX0SNyV1VitF3+5Elst5KTFQ8LbcSw+7dHYubYbPfV87nqnx4
         bcgnULDi4U1kH6ziVpX7GpzuFP+9Hg1U3L9wXjF8CMNvmWhS7k9HG2J1h4Oil1x30nMv
         qvNz4DOLoLUCQpK7BfahcvprSpAGHUlCphy/UsiHxhViEV9d1+vZb6q3vSq1z9o63eov
         0s/9/P5+pDlGMywBsqaZBb6dgfte2LRpsX91xdlKYEanotiR7he6fR8w7Nb1zCOl76yx
         gsbg==
X-Gm-Message-State: AOAM5330kNnA23Jy8pTUdD6Eq6n9FWmIgW9rEHnC9/DxzfQUCk5g4Qx+
        Rk49UMtqFsDDhKzVfSWQ2Gg=
X-Google-Smtp-Source: ABdhPJyWuFQKjoX+E4KuV3uYrs65VH4s7/Y9xZqQroMiJ2K4+FKekfhlWixn4hIsr6+PnHla09pACA==
X-Received: by 2002:a5d:6cd4:: with SMTP id c20mr18037560wrc.57.1608560455465;
        Mon, 21 Dec 2020 06:20:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y13sm22618540wrl.63.2020.12.21.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:20:54 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:20:49 +0100
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
Subject: Re: [PATCH v2 4/6] ARM: dts: exynos: Added muic and charger nodes
 for i9100
Message-ID: <20201221142049.GD33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-4-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095001.595366-4-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 09:53:28AM +0000, Timon Baetz wrote:
> muic node is only used for extcon consumers.
> charger node is used to specify muic and regulator.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Arrange your patches within the patchset in a way preserving
bisectability. If 3/7 is applied, the charger will be off because kernel
disables unused regulators.

Best regards,
Krzysztof
