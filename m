Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AF32EEBB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCEPYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 10:24:50 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33323 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCEPYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 10:24:36 -0500
Received: by mail-ot1-f46.google.com with SMTP id j8so2155811otc.0;
        Fri, 05 Mar 2021 07:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=quVCV0I7lj6jCfburMRjdQI6nYTa64wdVEOmdpejras=;
        b=LurI1Q1b8mKEg+oNjuHTN2A1Op/8GNcGt1yTQlGxXbklb8ulyE96SrkdwSWWZuj1iy
         p1YRhWqpdZXr32ftdLwluxvwLxun4UeJiM0erG2Js4hpHDBfEubj3x70gYZlioOVm27S
         N/qUS8WBg3Y3za0FNONbs/KJfJAXt3UcgZjZB83V5/BLL+m2B93akkzb55zfVeeCEsx9
         MZXjRoz3O6SK5SfzGJseEljrHgFKjpHhAfh79106Yphg+RkFzNiJIcs+Ptg9mwKpq3uz
         Im4ihT0BlTY3gxCvtDtAmPscstKAXS4pl47TCdknNOhlbEi/uDhLUD1BvaIdtGgcU8vU
         GMUg==
X-Gm-Message-State: AOAM532yCcKbaeylAdIM3rvzUPSP8khZ80j8R1wROIgXSdOTkXjP9HZm
        h2jcoRRpsE8ezdYGW8p+3Q==
X-Google-Smtp-Source: ABdhPJyFbBvtTNTuTtyQ/MJel+9PoFHbBrd4tQeC7uXkeJZtWp3mXJtgyNcNhSW2KciROY+m3bCloA==
X-Received: by 2002:a9d:6308:: with SMTP id q8mr8174085otk.160.1614957875976;
        Fri, 05 Mar 2021 07:24:35 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm529641oiw.18.2021.03.05.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:24:35 -0800 (PST)
Received: (nullmailer pid 182642 invoked by uid 1000);
        Fri, 05 Mar 2021 15:24:34 -0000
Date:   Fri, 5 Mar 2021 09:24:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 8/8] dt-bindings: thermal: tsens: Document ipq8064
 bindings
Message-ID: <20210305152434.GA182458@robh.at.kernel.org>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
 <20210217194011.22649-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217194011.22649-9-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Feb 2021 20:40:10 +0100, Ansuel Smith wrote:
> Document the use of bindings used for msm8960 tsens based devices.
> msm8960 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 56 ++++++++++++++++---
>  1 file changed, 48 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
