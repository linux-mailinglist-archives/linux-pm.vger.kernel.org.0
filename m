Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC60C29C90A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781097AbgJ0TeZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 15:34:25 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:39449 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504048AbgJ0TeX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:34:23 -0400
Received: by mail-ej1-f68.google.com with SMTP id bn26so3903666ejb.6;
        Tue, 27 Oct 2020 12:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nHvaL4wmpHKYi5m3WZBTUj9Yr645AuMpS/Lwjl+uNoA=;
        b=Z8496DmppCAr4Yo5LIfJT/Vy0N1RbQYfNm8zh9+tEay4I32IFICZBcBfkPajRlp80L
         z3AOMg03b4SLuUVml97mEKrZNNePC7in84d05dq/djr9frMVaD7U1ESwKGsjL4EDpRcT
         1hBl0iYHv3iQHpg9DBm52jtnFuYhNyOEbKLkb5GEy9AOPfqC2wkgVO/BhXWhV58wjlvB
         Fj1xorF5VPzlrZ9En9ZUAoITyPKnpKrS5ZFvcbKhgfyyXwg+08i6+bAtMaiTRpYjVvFE
         jhf5GceHUDMEWRxcl+Q4yLwqt+cZ2YRkHrSsBr8FBbzcnlCuuXA5rQLLkKPm1nwjEg1E
         hGLQ==
X-Gm-Message-State: AOAM530tEIzzlEfNWIS2YdprBhJT4D+xVS8dbscNeE3qlzY5JfDuiICb
        t3hXpnswX5yCwJWUGwTrgOkUEO6E6r36FS4X
X-Google-Smtp-Source: ABdhPJzSfsy7j2DNep0zqEKUKGZS6bAlWA30JvZmU2UWtQoUwNW/pB7XvrPTG1y6Gt14VNHQQIvGHQ==
X-Received: by 2002:a17:906:b204:: with SMTP id p4mr4185530ejz.214.1603827260969;
        Tue, 27 Oct 2020 12:34:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id r24sm1487476eds.67.2020.10.27.12.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:34:19 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:34:17 +0100
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
Subject: Re: [PATCH v6 05/52] dt-bindings: memory: tegra20: mc: Document new
 interconnect property
Message-ID: <20201027193417.GB140636@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-6-digetx@gmail.com>
 <20201027085548.GE4244@kozik-lap>
 <abf1df6c-3e45-209c-244e-356d88b454aa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <abf1df6c-3e45-209c-244e-356d88b454aa@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 10:17:48PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 11:55, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:16:48AM +0300, Dmitry Osipenko wrote:
> >> Memory controller is interconnected with memory clients and with the
> >> External Memory Controller. Document new interconnect property which
> >> turns memory controller into interconnect provider.
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> >> index e55328237df4..739b7c6f2e26 100644
> >> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> >> @@ -16,6 +16,8 @@ Required properties:
> >>    IOMMU specifier needed to encode an address. GART supports only a single
> >>    address space that is shared by all devices, therefore no additional
> >>    information needed for the address encoding.
> >> +- #interconnect-cells : Should be 1. This cell represents memory client.
> >> +  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.
> > 
> > This is a list of required properties so you break the ABI. All existing
> > DTBs will be affected.
> 
> This is optional property for the older DTBs, but for newer DTs it's
> mandatory.

We do not consider here "older" or "newer" DTBs, but existing ones in
the world using this binding.

If it was optional so far, it cannot be made mandatory without changing
the ABI. Which is an ABI break.

> IIUC, it should be defined as a required property in the
> binding.
> 
> Please see tegra_mc_interconnect_setup() in "memory: tegra-mc: Add
> interconnect framework", which check presence of the ICC DT property.

The implementation indeed does not enforce it (except adding error msg,
about which I commented). Therefore it should be an optional property.

Best regards,
Krzysztof

