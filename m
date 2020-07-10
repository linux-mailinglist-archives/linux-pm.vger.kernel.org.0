Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0621B8EE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJOtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 10:49:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40388 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJOtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 10:49:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id b15so4854607edy.7;
        Fri, 10 Jul 2020 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0L02eYp2FXJKKzBL1qGWhW4jXZNBM3c5JNgOSVLBJk=;
        b=UvgrXf5crwKKj2uiVPkPMutLBdqWE/GldZhbRjSchQeN74T/q0ORywzwjYggXkua6O
         Gn0ytfAkLWz9YQkP14KzGbU1gLXYBmC7TWFnuilt0T23wwONI6IWe7Cz70LldZQYtcTI
         b24Rbt8Its1XyJ/Ps0YHluIV5OH7XLs7Y+vmrfHxkszgSgmYyNyuZ9HIx3bnzJw9Zz4P
         lTxsduY1bwgvEKOpIOx2eWa4724n76UMIWE7FmQKNIlHia0A5FxrVY/gKXyDqkbt8EKP
         eaEgkP53tM1Pp7ceot6xyOHSfOiHzwVqFI7FkzfiNdKZF8SDExV3QYr0tT3J/C5GTTX8
         Qnog==
X-Gm-Message-State: AOAM533NOv4klJHdYsObRbX1AuSZbuVRU13RGgIfPk7XxLH875CcFQrA
        cfkX7Vzj0LYTFfdjlwE8vzc=
X-Google-Smtp-Source: ABdhPJzfrOZr2BJlKt7oYzb98l2zku0wX9Qcv4HhloRbWdfkrics+QXOAgmJUixj5yfoA1KriY5Xkw==
X-Received: by 2002:a50:9a82:: with SMTP id p2mr76216460edb.130.1594392590723;
        Fri, 10 Jul 2020 07:49:50 -0700 (PDT)
Received: from pi3 ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id e22sm3848826ejd.36.2020.07.10.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:49:50 -0700 (PDT)
Date:   Fri, 10 Jul 2020 16:49:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
Message-ID: <20200710144947.GB23140@pi3>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
 <20200710131921.GA23039@pi3>
 <4bfa227e-3a6b-dfe2-140b-b402dea52231@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bfa227e-3a6b-dfe2-140b-b402dea52231@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 02:41:28PM +0100, Lukasz Luba wrote:
> 
> 
> On 7/10/20 2:19 PM, Krzysztof Kozlowski wrote:
> > On Fri, Jul 10, 2020 at 03:13:18PM +0200, Marek Szyprowski wrote:
 > In such case, maybe as you said, let's switch to polling mode
> > unconditionally?
> 
> I can make happen that the polling mode will be unconditionally
> set as default.
> 
> Do you think that the interrupt mode code can still stay in the
> driver, because maybe in future could be fixed?

How interrupt mode would exist in such case? Or rather: how would it be
used? There is no point to keep dead code and code once removed, can be
easily brought back.

Best regards,
Krzysztof

