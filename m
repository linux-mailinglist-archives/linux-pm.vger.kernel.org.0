Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29A522F9B1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 21:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgG0T7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 15:59:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45473 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgG0T7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 15:59:00 -0400
Received: by mail-io1-f66.google.com with SMTP id e64so18277550iof.12;
        Mon, 27 Jul 2020 12:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wDpeNiqqoyeATLrnrgf/k8/QCkhhtDi8rG/MLzLuc0k=;
        b=DbmK052MzAjToZdvnG5RRb7lV+Wuzv+9oczMEOkSv1zvGxO+KgmsuAs4Jssn4fzeqn
         MHg9cEjmd1HLRQR1ALrWmIpfCT/wcDUCnzmaBDKP9ZFGlTPgqsAnl19c1GBQo7GVFXlA
         mHYvS78zINdfJJu0/AzpqmMsE3CIxnyfnUsPSfl2rnhPdEDSbA/hdO/ysI/475+GOoXi
         oOXYqEEpqlYGmdwhAyDnSHkfIft3mQYTemuWzLV9TKGnq1NjzA+W6PF5JHX+RfcHHeBI
         UWFmUbb5R1qjYA2ZbNphJscuGhb8TU0hhKtd7FLlT0TEdKeR7UclTuUtmF6BegkgUM7r
         Jl7A==
X-Gm-Message-State: AOAM5323DKbpDdz3Yn4QcAD+7zE5Te6hXA1k5GIlmgP++/K4sP1kbxtj
        RnJ5sSXKKg6VdZr5zoujSA==
X-Google-Smtp-Source: ABdhPJzW1pwaSNHbDZJzfOwWrG5ejhNl/nfoqakxm3RP0kGW2cWYySQVZ/+lFw/AjRp7TIf0aRuasQ==
X-Received: by 2002:a05:6638:1414:: with SMTP id k20mr28371172jad.76.1595879939825;
        Mon, 27 Jul 2020 12:58:59 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v5sm5428475ilg.88.2020.07.27.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:58:58 -0700 (PDT)
Received: (nullmailer pid 782176 invoked by uid 1000);
        Mon, 27 Jul 2020 19:58:56 -0000
Date:   Mon, 27 Jul 2020 13:58:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH v5 7/7] dt-bindings: thermal: tsens: Document ipq8064
 bindings
Message-ID: <20200727195856.GA782129@bogus>
References: <20200725181404.18951-1-ansuelsmth@gmail.com>
 <20200725181404.18951-8-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725181404.18951-8-ansuelsmth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 25 Jul 2020 20:14:03 +0200, Ansuel Smith wrote:
> Document the use of bindings used for msm8960 tsens based devices.
> msm8960 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 50 ++++++++++++++++---
>  1 file changed, 43 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
