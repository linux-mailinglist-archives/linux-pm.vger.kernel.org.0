Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2922571E2B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfGWR67 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 13:58:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37677 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGWR67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 13:58:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so39272063wme.2;
        Tue, 23 Jul 2019 10:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFpgVgUuyNvxrMZCyKWuK3LuxqE0J5JekFNJ3K5eJds=;
        b=K5GeyaF3MQzyfh8HKPHkp7UVdhhleiUyCDOpzd6uOWw/WuP+BP0sKx60NcAI75X5pW
         +tMKLg647jsKWxebnxW9Upm3ewV4KelzdIRyQ3cEntTXNHuHC1DlhA0CXtJ8tXMsZfqS
         KA2T8k3PnDujoXy3oeRJfZUymWKvo+wPbgMbUbODEwO723x3JSCwk+8/rARpNWxI5t6C
         KduPQL+WvmVh0Dq7F3p/0h/lP75ABdD/diowYfQr+RdVPA1eQrjb/9OdEwWvzt9IOHOp
         oJLCEfUW8LhzIS9fGNhyDGq4U4VsDFO5q0T2lMvUMIpwrO/sqLsTRstkCSg9z6juA5MT
         9xjQ==
X-Gm-Message-State: APjAAAX5LC1VIORWAgc56qTUgB81yFAY5zjxzdqdrL87NA6A6b7ZBQ1B
        5QIgvPHWy+4S/xli7PEunhI=
X-Google-Smtp-Source: APXvYqxGy6ti+aro/+Ugouk2LFlHDkwecPIxNJNr4s2bexkT5TLGoN0A8azJ3yLVlYBc1LN2slYaiA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr68446436wmk.32.1563904736737;
        Tue, 23 Jul 2019 10:58:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id o26sm84382672wro.53.2019.07.23.10.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:58:55 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:53 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v4 5/5] DT: arm: exynos4412: add event data type which is
 monitored
Message-ID: <20190723175853.GA29195@kozik-lap>
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
 <CGME20190605091305eucas1p136332cc3d1a299d90617bddcb365bee0@eucas1p1.samsung.com>
 <20190605091236.24263-6-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605091236.24263-6-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 05, 2019 at 11:12:36AM +0200, Lukasz Luba wrote:
> The patch adds new field in the PPMU event which shows explicitly
> what kind of data the event is monitoring. It is possible to change it
> using defined values in exynos_ppmu.h file.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

I tried to apply this... but prerequisites were not merged into
v5.3-rc1. This one will have to wait then till next release.

Best regards,
Krzysztof

