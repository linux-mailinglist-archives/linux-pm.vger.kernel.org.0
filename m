Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C993112AB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 21:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBES6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 13:58:39 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43286 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhBES62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 13:58:28 -0500
Received: by mail-ot1-f45.google.com with SMTP id v1so8134446ott.10;
        Fri, 05 Feb 2021 12:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sm6NpdOnTtwSXORx8mTFH6un3hRG8XHN59PuT9PxTHY=;
        b=ZiOPJE00cF5eWIq91x1XoXARyeQfeoutVToDfKzAD7LoW1SebwgCr5FPAv8wAdHVtU
         F0yYUgTb4Z+ojDzrB44KCAVu11JA2iG13Cb5rqhpHbJru3WNFH/BMPEvRJX2hqniAWgG
         AR2/sUm3yklvLBq4e0EcTEp2isz/HkTVCwVcBRhNwPwxSLQaTgwzL1OXRanCfUhNjiIk
         qTOsukOodw+34V8XFa0NFh3kCTM0HU2K0lHTb7mP0jbK8S9s7mgcgWxzPOJ0O2rK3Sus
         R1FcExNZMewQSzUjFfKn5UV9KJUVEI+kuaZqXvTwKkSjFAMYk0gmNoe7kSqalg89h0+6
         UMUQ==
X-Gm-Message-State: AOAM531ncUr0wLlACXvccMi30C0mY6WsIWJBtB0K+rQnO+baPM13t1Gn
        jeY7DF0uXo5fSYRNvOYb1EICY4TxqA==
X-Google-Smtp-Source: ABdhPJwSZjklLi0OGnD3BND6Th44dDLWc0079PTTrz8plDrDN/FVp4rS9kWi3YGddwujHwSNSyuuYg==
X-Received: by 2002:a9d:6b02:: with SMTP id g2mr4477933otp.19.1612557612724;
        Fri, 05 Feb 2021 12:40:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n93sm1986681ota.37.2021.02.05.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:40:11 -0800 (PST)
Received: (nullmailer pid 3691439 invoked by uid 1000);
        Fri, 05 Feb 2021 20:40:09 -0000
Date:   Fri, 5 Feb 2021 14:40:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v9 8/8] dt-bindings: thermal: tsens: Document ipq8064
 bindings
Message-ID: <20210205204009.GA3691379@robh.at.kernel.org>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
 <20210122145558.4982-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122145558.4982-9-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Jan 2021 15:55:57 +0100, Ansuel Smith wrote:
> Document the use of bindings used for msm8960 tsens based devices.
> msm8960 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 56 ++++++++++++++++---
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
