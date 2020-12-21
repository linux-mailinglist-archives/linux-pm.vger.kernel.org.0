Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F12DFCC8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgLUOZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 09:25:05 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:53070 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgLUOZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 09:25:05 -0500
Received: by mail-wm1-f50.google.com with SMTP id a6so10036947wmc.2;
        Mon, 21 Dec 2020 06:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CvRMCV104BD8xk88qQjQ5BDp5+7YcRca/1Tu6Fd7bvY=;
        b=m4qYkM/DwJIvFdzus7SPmGCPBZ9NuC77CcYWbNHWRRyM+ALPSOxME8nmFAwBPhVdf7
         EarG7zr5FQUr4MeW5wSJfRsomgQFeqwurtKbuAO+cq2jlmINYUPDt93Ttg+oYPQ+Trsz
         1jLCz8FG+KIuUe36gCPgNZ15FwUDwuSkXHjBmqt2pdsqpE3mfL3LI8uerNOgn/YS7T2o
         /m7XlG09VE+WsdYtff+Vhkzr7LpXjlCmUmtbahWPw7ltwk9ch05xDwUKDTbS3huuiL5S
         pS+/D28zBSNt7opmQYIbYgtS/9nsZotDT7GnFmjq6YhCMqtVnZLRZMmyLoqHu+i+PZrX
         T+tw==
X-Gm-Message-State: AOAM533FvX2DY07+3LjtXZNPNXJ60PvLV2uRWN/CTzXzTA+B9wKGlTFM
        b7IPS+jr5Vx0EA86FkvR4cjwlM/cjuFxfg==
X-Google-Smtp-Source: ABdhPJyPBUzATeJBJykCZRmee7Zw/sZ8T3De+W4xUN7Ps8ZAZqWKQhG90ksjbFHhx3GLLj1wzRno1w==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr17309053wmi.45.1608560663609;
        Mon, 21 Dec 2020 06:24:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h5sm28216030wrp.56.2020.12.21.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:24:22 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:24:20 +0100
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
Subject: Re: [PATCH v2 6/6] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20201221142420.GF33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-6-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095001.595366-6-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 09:53:41AM +0000, Timon Baetz wrote:
> Add maxim,max8997-battery and maxim,max8997-muic optional nodes.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  .../bindings/regulator/max8997-regulator.txt          | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I see you updated the bindings. However if you run scripts/checkpatch,
it would say that bindings go as first patch, so please re-order.

Best regards,
Krzysztof
