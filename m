Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB3F2A9C51
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKFSeQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:34:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41852 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgKFSeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:34:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id j20so2245032edt.8;
        Fri, 06 Nov 2020 10:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gggth8N856NOPikPqWnt6Bbjz++xWNk4Uqw0X6wMS00=;
        b=cIkmoTySw5YfnTUUs/tjmnfhg9+Y5I5HqgPtPn0hf0IN5556paMImv1Hx8Clbsbd7b
         nB4MkulbmfNyK94iGllu+zlMdlsvkMrCLn5w6WXgDD1waGvzQm5539paFxChov4vXZvv
         /Mb9yFRSIbY3NKkjjUYRTYpnvpnlwke5O6W6td6fKiA0rkn3f91j+xOS3Ebo5N6+R86y
         CO/yX1cAnF/ymo2ul+6uG+GBJQedrJo3whH7rGsJpKuhdn1qBhFEv3R4zmZvHxVf6mhJ
         +sQXkJUidpnVk5UxT5LVnpUCtQNFaGB7bhMCUlqJo6LSE8fSEIe9EolnZfBQJMXJTYLu
         HL+Q==
X-Gm-Message-State: AOAM532BhkmoQGL4BS+fY23kWqA9BGrzYfUbojLM/DbQZ1bc61Jf+FLb
        3qSDkmlFg9kOImTQ55Cf4B0=
X-Google-Smtp-Source: ABdhPJxtnzFCJVuS3gP9PJPBWtXKcv9g6kJif9bUF3VhgPoftWE9c4k48AfsDv7kZIaSYT1XuyHcfg==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr554602edr.70.1604687653933;
        Fri, 06 Nov 2020 10:34:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e13sm1639605edc.9.2020.11.06.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:34:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:34:11 +0100
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
Subject: Re: [PATCH v7 13/47] dt-bindings: memory: tegra124: emc: Document
 new interconnect property
Message-ID: <20201106183411.GM65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-14-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:49PM +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> External Memory Controller into interconnect provider.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml    | 6 ++++++

Thanks, applied.

Best regards,
Krzysztof

