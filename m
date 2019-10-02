Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411A6C900A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfJBRiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 13:38:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJBRiU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 13:38:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so13215wrt.2;
        Wed, 02 Oct 2019 10:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTmH8EafQxbdYgDMckejIA27/8MmwdAdTeYHGHhQuPA=;
        b=gWY1xml5LcvInf3O4tQ/lV/rFRNxLTuNPhucXdb89v/v6mcIdga8/m89+L3rCJ73/f
         ADT8gWPf4pAVp7cWcVAx1p+fOb7cjqKmfezu9AgrqTAqvBkb3Yb/L+uC6xV3VL5CEnai
         1K27G5W7167AgUHudwoiZUqzULu1N6AMrPgHhw7PrzwFEeZDsVLJ83MVlXVO/1z2E9Yh
         pqr+Oe5fIHauPMBTLM1asAG/ybJcm5CcaXE9xbmjR1oU3YNcrOh1z4D9NaAFALBB3boK
         /N+luVkh8RWKolGmdABfcu79SsPgkxshVrY0fCYZ6NrVNLcx/LmYeBUGXIOAiMuKpIz2
         ajew==
X-Gm-Message-State: APjAAAX1XhY85fE8mscCNcTpxbj589Vye3znTEBKX/8cL3yVngoLfaje
        N0BdE8G3+jrgjgzNEgi6s94=
X-Google-Smtp-Source: APXvYqylJhVMEK3ifyltGwEzTf9OuJVwke1QEVnvk2FVIatTz4vfsE+ISc2rNCBhpXG9RhGqGRoxkQ==
X-Received: by 2002:adf:fe92:: with SMTP id l18mr3630971wrr.369.1570037898167;
        Wed, 02 Oct 2019 10:38:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id q66sm6742037wme.39.2019.10.02.10.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:38:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:38:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 4/4] memory: samsung: exynos5422-dmc: Add support for
 interrupt from performance counters
Message-ID: <20191002173814.GF21463@kozik-lap>
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
 <CGME20191002060507eucas1p169394dec59f010e112eb38d83e3fb8ba@eucas1p1.samsung.com>
 <20191002060455.3834-5-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002060455.3834-5-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 08:04:55AM +0200, Lukasz Luba wrote:
> Introduce a new interrupt driven mechanism for managing speed of the
> memory controller. The interrupts are generated due to performance
> counters overflow. The performance counters might track memory reads,
> writes, transfers, page misses, etc. In the basic algorithm tracking
> read transfers and calculating memory pressure should be enough to
> skip polling mode in devfreq.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 345 ++++++++++++++++++++++--

Thanks, applied.

Best regards,
Krzysztof

