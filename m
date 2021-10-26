Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8981C43BC14
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbhJZVKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 17:10:53 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44733 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbhJZVKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 17:10:50 -0400
Received: by mail-ot1-f47.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so513835otl.11;
        Tue, 26 Oct 2021 14:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qf+MGZOD+EH/QKVd28ocI18hHDKyyZZiCGxPxM8SVbU=;
        b=zlg74YHyju3b+ZLMOqTImEXDkiw1EMGtG96dbxtw6BfWwWkRNHuHg8SubPxbdUizpT
         io0JlX2ENHDuotE9KwcGSmfMOw4ez12SQaPeVXNIsiK0Dsjl4vQKYPF8qi/PMDn4lC02
         Xita2efsjqviNWk9yOg4OpjG6WmbT+lezgSlprP2cL1PEw1ukuPDdVEsxsDA+Q3xUwzT
         orIn0TbR8HYSrnta0WL/iLOGwKQekO63zjxnGnUGS0h+IBxZKJ1kBegkdVTLT/tNLa00
         emhsp46JSr/A5mvzevXlFFtsI0VG3/GriDYg83MRK164D131jGloHxhAtFF9+Cq0oLgo
         P2GQ==
X-Gm-Message-State: AOAM531eIHDv13Qa/20dhqm0MUqBGUYtE9YhQ0zX57/5jM0mdCuzc8AA
        /qjoYfKzqy2smBwkihypdunc8mOsBw==
X-Google-Smtp-Source: ABdhPJyckgJ+AIErGvmZtooqTIMJc/q8dE1Aqmg98CxlLU/4B7oGlLnt7dwY8Y59W9EZXZUPAbYqmw==
X-Received: by 2002:a05:6830:4011:: with SMTP id h17mr21921166ots.208.1635282505533;
        Tue, 26 Oct 2021 14:08:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h17sm4078739oog.17.2021.10.26.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:08:24 -0700 (PDT)
Received: (nullmailer pid 3252327 invoked by uid 1000);
        Tue, 26 Oct 2021 21:08:23 -0000
Date:   Tue, 26 Oct 2021 16:08:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Ilia Lin <ilia.lin@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH 1/8] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Message-ID: <YXhuR2DXfzszSgYf@robh.at.kernel.org>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083016.137441-2-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Oct 2021 08:31:32 +0000, Yassine Oudjana wrote:
> Add CBF clock and reg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
