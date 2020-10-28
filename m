Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1287429D5E2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgJ1WJc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 28 Oct 2020 18:09:32 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:32804 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgJ1WJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:09:29 -0400
Received: by mail-lf1-f50.google.com with SMTP id l2so814986lfk.0;
        Wed, 28 Oct 2020 15:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vP95c5G5AiWt8jFAMoFHGwxXSql0kCQrJ9xpkPgq6gg=;
        b=HUEdEcL9oWOFN5GZBxdIaZuS75HZc1SpYh+XPYjnnLFtT7U0bcCPzpa2vlhwDxDdgk
         yvYmhzdZIGzCPDQKugnJKn3R6erxAIXZYB6L5asjmhG+CNN3o8TOjW+DK110SCBYvO94
         Thd+bpYWL74XjThcUosC0busfnRzkPQC+MmY97PSEALfA758uf2gLrKzegXjCSZbvZKL
         NI2/QBv5TVO2dB3fn0j8dZuoTkBLj5rE1VI1e3Kf6UDmj3dBUyhbM8JfOl3jY7YWVotv
         SI9tuug6nOZPt+NM8OhLG6cVNwMHV452ldJaNOcksWdHTvSwVTS1VZInkVyrTQI8AkIy
         P2Gg==
X-Gm-Message-State: AOAM5334bepW508TC6pThlk8737l4d4hm0IKTe5aplq3YlflMwF8IDXg
        FOMUWXzU1pDtlsM3JnuAXfN8th22ngJeOQ==
X-Google-Smtp-Source: ABdhPJyHdwuuiwRcW53qYzu6ELBzFaASak8bZZ7cUJm7qaJ+2lCiPhJEUbxJ3cDKZqX83Q9tfRG3aQ==
X-Received: by 2002:a05:6402:134c:: with SMTP id y12mr460552edw.344.1603913305471;
        Wed, 28 Oct 2020 12:28:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id p1sm261722ejd.33.2020.10.28.12.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 12:28:23 -0700 (PDT)
Date:   Wed, 28 Oct 2020 20:28:21 +0100
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
Subject: Re: [PATCH v6 41/52] memory: tegra124-emc: Use
 devm_platform_ioremap_resource()
Message-ID: <20201028192821.GB170285@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-42-digetx@gmail.com>
 <20201027102707.GC17089@kozik-lap>
 <d79e4972-acf9-f889-50b8-f0829a0e8e08@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d79e4972-acf9-f889-50b8-f0829a0e8e08@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 11:30:31PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 13:27, Krzysztof Kozlowski пишет:
> > On Mon, Oct 26, 2020 at 01:17:24AM +0300, Dmitry Osipenko wrote:
> >> Use devm_platform_ioremap_resource() helper which makes code a bit
> >> cleaner.
> > 
> > Such cleanups (and few other in this patchset) should be at beginning of
> > patchset or even as part of a separate one.  I think there is not much
> > stopping anyone from applying these... except that you put them in the
> > middle of big dependency.
> 
> Some of these cleanup patches can't be applied separately without a need
> to make a rebase. I think it should be more preferred to have all the
> patches within a single series.
> 
> I'll try to reorder the patches in v7 if this will ease the review, thanks.

If feasible, that would be good. Thanks.

Best regards,
Krzysztof

