Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0441856
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407228AbfFKWnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 18:43:24 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53325 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406846AbfFKWnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 18:43:23 -0400
Received: by mail-it1-f194.google.com with SMTP id m187so7709117ite.3;
        Tue, 11 Jun 2019 15:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nxxEn9GbgHo/c/uHaViVZVzYLwnyBcVj1tzUwyfTXE=;
        b=c3mEdVCp3UUzdxxiYTEg4Ts4PjAe3PScFq5AwVysmnxUG2EmdknEosaqmnjI2xIrL/
         WGypynFhGfcwINJgsvQBqSEe6s+7ulDmhy8qpsgmXo+qcafgH3WCIEt17SLZG0QCGCNI
         ic6Lmq8Jw+5TXJxKhNXzZvS+szgzfh3fhOg1fEvUXzU5YlNKuSD3oPbshS5DpJwkUu9R
         dKZ1AWEBOmiR4bzi4O2a2B6BryTkAsA8/hl0JLNsZfDgScVLYZ3pBGIWQi6PdqY/60WQ
         8IUChAbVJt28NiQr502UQyryNuzdGKSlEeNWR5WHz46SbPE4k74iY8p4BWtK8MTM/jpz
         G8uA==
X-Gm-Message-State: APjAAAWi6G6TkDwETTbmxKAWBUf+MkUpvKYWh27yYqred08rl9dyKin3
        8nKg4E2W+jpZRHEAm0I57g==
X-Google-Smtp-Source: APXvYqyYPzDNwyp2U254GigZfLpKWCiymLDeTo+GeW4sOy8Lv5bahE3i4I8XtJNJgmS7OnNw0C3Hjg==
X-Received: by 2002:a05:660c:343:: with SMTP id b3mr15423273itl.52.1560293002720;
        Tue, 11 Jun 2019 15:43:22 -0700 (PDT)
Received: from localhost (ip-174-149-252-64.englco.spcsdns.net. [174.149.252.64])
        by smtp.gmail.com with ESMTPSA id d133sm1933774itc.27.2019.06.11.15.43.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:43:22 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:43:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org,
        kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v9 07/13] dt-bindings: memory-controllers: add Exynos5422
  DMC device description
Message-ID: <20190611224319.GA7484@bogus>
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
 <CGME20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a@eucas1p1.samsung.com>
 <20190607143507.30286-8-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607143507.30286-8-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  7 Jun 2019 16:35:01 +0200, Lukasz Luba wrote:
> The patch adds description for DT binding for a new Exynos5422 Dynamic
> Memory Controller device.
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../memory-controllers/exynos5422-dmc.txt     | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
