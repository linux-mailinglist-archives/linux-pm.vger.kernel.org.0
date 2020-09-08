Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAE2609DC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 07:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIHFO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 01:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgIHFOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 01:14:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B3C061575
        for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2020 22:14:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so2029131pff.6
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2020 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GA6Q87SXfiiRyiEUrF3DVxzLNnyqW4kCZ2nOXPNCBoQ=;
        b=DIOIN0M1CLSFoy3Yo1MnXH3JBVqUEH7u6JJ0/EiwRGGfsRI00a9ga2LT4axQ/CALQv
         4Ub6I31zTflE9byo89GvmfPf/c4i7I4de8x0k3md3AKKIvFZVCvSVP45i9tyPIFw+e1J
         /C1tMAWwISPgMBH4Tc3wtONeO3qmoP/tYp4IjSdecTUEsqWoMURL3NkhMvzAf4UNa9CK
         8aNw5bQptDUfmGLd7yhTS5lrMPwhHB0JC6abRCSno2tFBG/uxnuG+GA55fAFS4pY4EUJ
         vSJQJ/s521x04RQVJ5cQSiQtVIP1iqVz5/CzBsumLd2vwaB2aKXtg2FBd6cnb7Sb7umZ
         Ti8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GA6Q87SXfiiRyiEUrF3DVxzLNnyqW4kCZ2nOXPNCBoQ=;
        b=oONN5cUp97urkyZKPeUonXSGiLus7N9sjccPojN+ANW3GD/kg5yJzD5b5C9W9d/Ept
         XcMTvHObWRS+E/eS1DlzmjknP9briBpXbXCEiqBd9ymfEMb0Wbp9Ss7FauKROfq7JzG3
         Nw3DALRCreGN9srsNaUk3xnYhfR7MzbFXzPICSy+9ENlhnV7wTlyYcNsEMPgQ55+MpM4
         nY2w7dkMvou2yMOPTK+nHOBCqFkfv7Rr4o2+UP0Il9kQEaSq6N3cihClUZ4p0fusR0cD
         N2xScZ4EOs8V95YMabpHSfkrkLRcwaFKQ/v4+mOGBzx1jmPT5sJFKJD+6uEdwuxZck3w
         AGzA==
X-Gm-Message-State: AOAM531ef94dap0fnOPvME3xnZS0/Fi3xz1RN1JMDFDkTpZALoEW77pw
        Diqd1EgFy+0YUD02n7qaSUXO/w==
X-Google-Smtp-Source: ABdhPJzWWdFvxTcgmvwbeZhhaPBEwqOapZp0KsHGc4JYEcxUmmMfC+nTLqvQJ5QjGzfo38RFeoHqqg==
X-Received: by 2002:a62:1592:: with SMTP id 140mr3940470pfv.215.1599542063985;
        Mon, 07 Sep 2020 22:14:23 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id c3sm16708857pfo.120.2020.09.07.22.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 22:14:23 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:44:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200908051416.na567g3mr7zbyr6h@vireshk-i7>
References: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
 <1599532510.17707.4.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599532510.17707.4.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 10:35, Hector Yuan wrote:
> Hi, Sirs:
> 
> Please kindly let me know your review thoughts of this patch.
> Appreciated.

Please don't send new patchsets in hurry, it isn't going to help any
of us. V3 doesn't address all the review comments you received in V2
and so there is no point reviewing it.

Please send a new version which addresses all the comments you got.

-- 
viresh
