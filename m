Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94F82A9C3D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgKFSb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:31:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39972 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKFSb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:31:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id p93so2244155edd.7;
        Fri, 06 Nov 2020 10:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ksREXILjDbgZ4Gen6Qp8nquIOlE9XtM49f933fBtxc8=;
        b=KzdDibjywqcpptocTyEElGBNGKvAk5m4VDguI5BaLMlhUHm/S6hbZX8aQHPp6Vn5cv
         AE5T/8xQMwW6ImIXna9THTNFz9OpuM55b1bsOtvkF+mml2m6VyPcEHBS6NzQEpORpqfJ
         42bDs0g+G/RMn9WRjCZ4wluPUbTY/d9oZI/3B73HY674FQBlLNsI2jkjWF8/Exq5CHKl
         e2LvVeHoziawq26NnAdFubMDA0D8JXUBS5cNrTmq9lqGGXFrktIXiQb+FdIDFguXEbjD
         CfeR8fu5cdurtWAFGTdkPFrJmohhdAb7OV4SRzUs3e+GHIUpv6HPU2yb5kOwPkJEF8s1
         Xbzw==
X-Gm-Message-State: AOAM530A3gJMGRzAkAFtFriF4hOB2ma7T16iFJlnuRXkiiRDlB9FbbhP
        Ok4YIKspmVOiLCNk1RaqcaQ=
X-Google-Smtp-Source: ABdhPJytVUHuz7iwUNDClUjPiESutNNy9BlIv4ZaWJMy8XF5HVAcYZoy8MtjogURRGcIAxPciYleQg==
X-Received: by 2002:aa7:de86:: with SMTP id j6mr3564915edv.353.1604687514023;
        Fri, 06 Nov 2020 10:31:54 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x2sm1470514ejb.86.2020.11.06.10.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:31:52 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:31:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 10/47] dt-bindings: memory: tegra30: emc: Document new
 interconnect property
Message-ID: <20201106183150.GJ65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-11-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:46PM +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> External Memory Controller into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

