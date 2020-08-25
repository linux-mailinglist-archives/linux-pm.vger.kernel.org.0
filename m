Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C77250EB8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHYCJv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 22:09:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46479 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHYCJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 22:09:50 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so1576661iop.13;
        Mon, 24 Aug 2020 19:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p24wmINxw5ACsrgiOLfq84gw2srTWDcxVk5SINBeDzc=;
        b=d+QPmzzr6rTzmiqxMRhLvqUr0EoBhvZlDJoPcVYsoSKdHjl6XTzSGZw5KlPy4+SeXC
         mf5/+dkSv2M1hInB5RRrp9CGiLo8JR/8E+tfYeivFSt+2RCd12vEz1asF66NxHBzQu5+
         nDNjyfkQeI27YWewkHSMYUFCogdIu/hFvmADS3XEDvL+w0AZQlGpmGo4ZqZqApFmCrTL
         iuIV3JV0XKMjJ9X+VgR088nn4OmGDAecJPXZAaECvf3I94nGiRKFpoN+TlRT+axVA+JJ
         ApjCX8OLjp0m4+YlAwx4gbb/BhCNPV5jjvcVXi4SOdviB5RdBi2a4NXCmbbTjQnBKFcd
         KDKg==
X-Gm-Message-State: AOAM532yVE+klvyWWDCQ0RhRishWD65RgMWhp25sDL8iftOZpxE8wSeD
        fpMERFN2XaBwD3GZVDfRgg==
X-Google-Smtp-Source: ABdhPJyR64UEBk7XMJS3xaNhsQOHAvXTybO+KgsxIlNUDqaIOvnKq7x6Bf0G/VyGmP353HDAmwZHfQ==
X-Received: by 2002:a5d:88da:: with SMTP id i26mr7193353iol.158.1598321389515;
        Mon, 24 Aug 2020 19:09:49 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r9sm8205705iln.18.2020.08.24.19.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:09:49 -0700 (PDT)
Received: (nullmailer pid 3789123 invoked by uid 1000);
        Tue, 25 Aug 2020 02:09:45 -0000
Date:   Mon, 24 Aug 2020 20:09:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, devicetree@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-tegra@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v5 22/36] dt-bindings: host1x: Document new interconnect
 properties
Message-ID: <20200825020945.GA3789072@bogus>
References: <20200814000621.8415-1-digetx@gmail.com>
 <20200814000621.8415-23-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814000621.8415-23-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Aug 2020 03:06:07 +0300, Dmitry Osipenko wrote:
> Most of Host1x devices have at least one memory client. These clients
> are directly connected to the memory controller. The new interconnect
> properties represent the memory client's connection to the memory
> controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
