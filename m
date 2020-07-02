Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B774212E23
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGBUtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 16:49:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44339 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBUtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 16:49:45 -0400
Received: by mail-io1-f67.google.com with SMTP id i4so30304555iov.11;
        Thu, 02 Jul 2020 13:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LcghXyXfCa/GZL8tIugSaW69esQhyOuAw/JPt6KOaZc=;
        b=Qt1Z9AeHfkzD+aKuAXmcCe8/qv8giEiheoMUyphxZqBHlDZrD/VYefVNdDL3Lwxo9U
         val8tsnzndCYoZHAcSpw5w/2PFqf+pLtQPn4/fPcv2JlBzzR/yleZDFqk20UlsohiwMP
         rl97BX3qILMLcKO0B/jPHAb5yn6C3lu8B53t47/v3GYCgiJeTyGYXbxOjCK3MoVGtoSm
         Rj5qbrTAeSl/2y7H/pt4r11y/2Yo7nMUhkaGbAKysRTfJczaOCqzaUbKdFLC4E0xpttq
         YYgg3GnkD5o8qqSRu3M/GjYuM3oK+MthZFBYEIPrMGnq47Pv+F0IorsMeRgg7Pwfdk7k
         DuMw==
X-Gm-Message-State: AOAM531j7JsScSTAhWYwD6S7IXPzC4lck/gYYbNn/btTfOayi2MJWFCg
        1nVu9Vm3a8Uu+GaHw7u62g==
X-Google-Smtp-Source: ABdhPJzaq9TnW0hU92Y++yLGQTLjRou/NVTm6HYYccoRuHI87bvj7id3AmY4IWdkkImX/gLKYoCnvw==
X-Received: by 2002:a02:108a:: with SMTP id 132mr14004791jay.131.1593722984634;
        Thu, 02 Jul 2020 13:49:44 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f9sm5429139ilq.9.2020.07.02.13.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:49:44 -0700 (PDT)
Received: (nullmailer pid 1668439 invoked by uid 1000);
        Thu, 02 Jul 2020 20:49:42 -0000
Date:   Thu, 2 Jul 2020 14:49:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "open list:INTERCONNECT API" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: interconnect: Add Qualcomm SM8250 DT
 bindings
Message-ID: <20200702204942.GA1667979@bogus>
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701134259.8055-3-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 01, 2020 at 09:42:51AM -0400, Jonathan Marek wrote:
> The Qualcomm SM8250 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.

Again, looks like these 2 could be combined.

> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../bindings/interconnect/qcom,sm8250.yaml    |  86 ++++++++
>  .../dt-bindings/interconnect/qcom,sm8250.h    | 186 ++++++++++++++++++
>  2 files changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8250.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h
