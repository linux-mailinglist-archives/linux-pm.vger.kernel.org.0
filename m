Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A3DAFAE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfJQOTA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 10:19:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44031 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbfJQOS7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 10:18:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so2256794oih.10;
        Thu, 17 Oct 2019 07:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vBnB+M7MeMjHtBV/3UgIfk1bQ4OQXkYxZtSD9bLiIiw=;
        b=BFM68eQVeXPT24RYF+GS6ZktmxxxJOlLTmUi4vFMDqp2D3A3XrfvAsuOCpWJsK669D
         mw36lgw5jyXs6g1xhUWa0ZQ1p0f7pgzcknF3Iu7gPDaZFTaW1EKRzGMf+KUE5Mn8EDJm
         JvcCdDObfh8lOV/+5FMXiqpPpUdG3yRLPL27cskeFjb29cTdKjpan+6f3kVw0amAidYg
         x3ONbhW0v+g8V7zyo1uKrCfbt9qkDZb2sg+P62pukFaFeRv4K/JeK+P7IayxGXZseFW/
         g0zqb9c7kH76wLBA+Hsxn0fH0XbLpl/5PhoB3AGmsWclxBBF/DsJrccvpm8Sz54XDdRe
         /KrQ==
X-Gm-Message-State: APjAAAWEGgVgoE1UV72BDk9iFQJfy2i7PswpTVxOznt5aLmUiURg5A8e
        egacdEyPJDJJ1RDdq0oP9Q==
X-Google-Smtp-Source: APXvYqwaOguDWjHAKjE7AWREkIBbr2Yeq2vvJPgI6fWhcE6lyU2zTIaG3F0EzOUbwG9aXEHyckG1Aw==
X-Received: by 2002:aca:370b:: with SMTP id e11mr3318457oia.96.1571321938730;
        Thu, 17 Oct 2019 07:18:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm620307otc.37.2019.10.17.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:18:57 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:18:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v6] dt-bindings: arm: samsung: Update the CHIPID binding
 for  ASV
Message-ID: <20191017141857.GA8828@bogus>
References: <CGME20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc@eucas1p2.samsung.com>
 <20191017092939.25899-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017092939.25899-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 17 Oct 2019 11:29:39 +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of new optional "samsung,asv-bin"
> property in the chipid device node and documents requirement of
> "syscon" compatible string.  These additions are needed to support
> Exynos ASV (Adaptive Supply Voltage) feature.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Depends on patch ("8d0daa4c89c9 dt-bindings: arm: samsung: Convert
> Exynos Chipid bindings to json-schema") already applied to Rob's
> dt/next.
> 
> Changes since v5:
>  - removed uneeded allOf from 'compatible' property section
> 
> Changes since v4:
>  - converted to YAML
> 
> Changes since v3:
>  - none
> 
> Changes since v2:
>  - corrected patch summary line prefix, the patch moved in the
>    sequence
> 
> Changes since v1 (RFC):
>  - new patch
> ---
>  .../bindings/arm/samsung/exynos-chipid.yaml   | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 

Applied, thanks.

I dropped 'select' because I fixed the tooling to ignore 'syscon'.

Rob
