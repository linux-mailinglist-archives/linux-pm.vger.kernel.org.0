Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582792A1735
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 13:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgJaMMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 31 Oct 2020 08:12:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35420 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgJaMMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 08:12:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id h22so5193695wmb.0;
        Sat, 31 Oct 2020 05:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NA2mk2ojzZgcrMT2zOu7idEhtXsilJ2RZg5gFMOuQu0=;
        b=npSi9acScqv3T750caVXhbrrpeBcNbaDmcCPzjn/buViDm4NOh3WSx3OedyPncQdN3
         1jptu0k+ln1VOLKLLhUP4RrDmW/0r2bBWC6rDp+fG41f+cspvbbvRnDrcOVFopEPSey/
         FtT3UUkQftb7wK+KyQU80ndxwHSg9FWp1LnyuPG6T5tFTot4rMPbUUB2ihFZ10H+ZcUR
         z5xJ+bAMxE51EFal0mn5B3SSdgLmhPZUHcRzpc880YppfjHjKjK/y6YCWQWZi/aQGXDp
         wOnGgKGUjLT34PQ2vfzPtNAng335GPToTRyjfbegX7/AYHlxT371fe092LUZHjCVYOD+
         0Dgg==
X-Gm-Message-State: AOAM531BHDyCVflpaw6QBEfRUZ+IxXz0wI0w/o9cqZ84WBQB6Gt/K1Uo
        UERJ2zs712yU8+CRPyYsFEIoyPkoWeN+tQ==
X-Google-Smtp-Source: ABdhPJzxJPowOvxVIGz2k7PdLFq9XdeI2/pqi8+tEqW8uyXw33OGR632eyR2MsZ3cnVcMWXiIVpgvg==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr8099208wmc.32.1604146322961;
        Sat, 31 Oct 2020 05:12:02 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m8sm14272394wrw.17.2020.10.31.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:12:01 -0700 (PDT)
Date:   Sat, 31 Oct 2020 13:12:00 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 1/6] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Message-ID: <20201031121200.GA9399@kozik-lap>
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
 <CGME20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830@eucas1p2.samsung.com>
 <20201030125149.8227-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201030125149.8227-2-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 01:51:44PM +0100, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> interconnects, #interconnect-cells, samsung,data-clock-ratio.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v7:
>  - bus-width property replaced with samsung,data-clock-ratio,
>  - the interconnect consumer bindings used instead of vendor specific
>    properties
> 
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
> 
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
