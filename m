Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15879B5506
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 20:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfIQSN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 14:13:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39812 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfIQSN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 14:13:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so3919179otr.6;
        Tue, 17 Sep 2019 11:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQ6OBeDuode2twYSlA9ipYN3w4W7GeO3ocNtg3ta1d0=;
        b=gkng6OzNloX47S9V78qyUaQcmdIMR1mPZtnUt0kQa6Bd6Dr0+VLWee3sUR5hfCMoDZ
         iswt0Z2WCc8fpm/G01+nzBh7zqAAZzTi9mllZyTK0eD0ogePxhs0w0R9V245ZxKY7pjB
         jGtf3oSlHA6sW63oag+CUyD51BAdiEtb/l1YRKnms9mH8raNL4JWCuOFmzYBY3b0xzKE
         K10ywFxNZEaHWO4La+qSvl4ZPug3ZMFDEIkuBL3VQuKhRSUGmiZmZnCXW2vgJb0ZCQNI
         gLEJrThEDUeVsxn+b4R0UqIMFRPX7YiIGvfRqfKz6JXoa8c74OslyJeJpBRnob0DGG2u
         o7lQ==
X-Gm-Message-State: APjAAAX49mniqTkPL/SpnA7NvhBDYvRO+wRqZkUABEbmPxTHG9ndp8W4
        3m/3HEQJ6e/GO3mQVU/XiA==
X-Google-Smtp-Source: APXvYqzapDf3fokSpvCVuLAz5B7sSKanwGbCWsfa7ySh7AxQQjSWEWwVf940e/gnVHbg7SCtd6pd/g==
X-Received: by 2002:a9d:3f26:: with SMTP id m35mr168799otc.66.1568744004009;
        Tue, 17 Sep 2019 11:13:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e18sm982788oib.57.2019.09.17.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:13:22 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:13:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, vireshk@kernel.org, robh+dt@kernel.org,
        kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: samsung: Update the CHIP ID binding
  documentation
Message-ID: <20190917181322.GA683@bogus>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641@eucas1p2.samsung.com>
 <20190910123618.27985-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910123618.27985-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 10 Sep 2019 14:36:14 +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of a new optional "samsung,asv-bin"
> property in the chipid device node and documents requirement of
> "syscon" compatible string.  These additions are needed to support
> Exynos ASV (Adaptive Supply Voltage) feature.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
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
>  .../devicetree/bindings/arm/samsung/exynos-chipid.txt  | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
