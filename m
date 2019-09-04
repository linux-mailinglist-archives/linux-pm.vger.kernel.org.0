Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0FA91D5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 21:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfIDSbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 14:31:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38443 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfIDSbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 14:31:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id o184so4949008wme.3;
        Wed, 04 Sep 2019 11:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hsJdVa01uomsFV9ahOXalHDfMaTyQcIwI+m2ZgSZm1o=;
        b=IMGfQjZMM/rwo/iIhT2xgttUTu01BNIpib3yfQNY5PsbwkZ1Rw4mUGm5O59bo+HNUR
         J3HBJ+M3Wt4LRmtR+zbj+15jVFvtC7M++7FL6T+QTQVqqSsBoJLij6tYMpPlmBpocgFu
         Wmx8/sDSGuVsl1XEj5rQjCs/3An+MDLZijmsjKzgOOTMcJTEq+GoZTNmg8L162+BAgWx
         mNu25WUe56CUztAjvkzFhMG00+0pJLlyrAYsbSfCeQgap7aVK43lIRcSU+rliYnZCh3H
         pdBBeuRWpaCP1UjjY0+/o2L4aqIO4ijGxMY71/eaFhZBfLyIbJ3wUTERWh0c4ZetkIbY
         /1BA==
X-Gm-Message-State: APjAAAVcEcN8UteqElFgLW4SfmUEbePvVWB6FTChnvpQrwhTEbDE9OIf
        4rwJuC2k/gNgk+b8olfp/Mg=
X-Google-Smtp-Source: APXvYqx50kGyewoRhEfHRm1dIpaYZpn3D+gdSEGrCOzZ/nz1uVLkScoUS0FqBfE7Wg150Co82Xs4eg==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr5625501wmb.73.1567621879136;
        Wed, 04 Sep 2019 11:31:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id f24sm3252156wmc.25.2019.09.04.11.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:31:18 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:31:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v13 3/8] drivers: memory: extend of_memory by LPDDR3
 support
Message-ID: <20190904183114.GB12918@kozik-lap>
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
 <CGME20190821104320eucas1p10c911c2ce59007bcf6c039f52b869656@eucas1p1.samsung.com>
 <20190821104303.32079-4-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821104303.32079-4-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 12:42:58PM +0200, Lukasz Luba wrote:
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.

Thanks, applied, with commit msg fixes.

Please do not write "This patch" (submitting patches mentions preferred
format). Also at this point, this is not "used currently in Exynos 5422
DMC" because there is no such driver. Just say that it is necessary for
upcoming DMC driver.

Best regards,
Krzysztof

