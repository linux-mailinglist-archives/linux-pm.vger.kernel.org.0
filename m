Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0C263C7D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIJFer (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgIJFeV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 01:34:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5AEC0613ED
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 22:34:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so2454117pjh.5
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 22:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5lEi/XoDUJ11Wa7F5s06RrCLa2hPWxpKnO1zR9YxyoY=;
        b=CAEWlx6IuBLlkVsW+lOwMOeCTijAw1MpiQ3Ubb2OiqpnJtMewM1XNtUAhSIg1ikgvE
         JpQ79qJ6W+TpKYmuBH7/eBcz5WKzj9GaDsUqhxos2YpwlQsr8aEn9N36PdsFS0hDWe6y
         cNhiV778PgC5as9xtK6R0NroTicROjr76SN0u0Pi4chuP8X3ibTcn/DO0e02C6/yTFtK
         q0uHIk25Jr73tNAPDUqN0E/KWZ2FKnNQcJBseJJm25c6Sm0RT8fYscQXhoYRyGZbGG83
         SI6aRY5TTQMwlVObPlooDffFy48lbHaXcaYOfHW0nENuCCHAJsdeecPwwCjiEoRllUoh
         P+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5lEi/XoDUJ11Wa7F5s06RrCLa2hPWxpKnO1zR9YxyoY=;
        b=RPfOih89ACVh0XzHcQimqlD1JRyyQJUDPwP5Klm1zyrSpzjiNLWpUkx51XPTUbTfMx
         iR1R3SX9wSrNhDjsHqQf4qDXBQPssQBBunQ1/m7fEEnhnubasjpA/Pn1gA0xuoxxsEBg
         lxaJRDZaL18PT8OXoOV6nLiGwnNksaSXMsuSfHbjJIGTGrl7BFc2PZyB+lUgaFnEUjf9
         9nSqt3A/KA/CKGxblzoLKqlPinvte8hq1Ua3c81gmHNtdJuVjSXmjMO7hiv4sLqLlI08
         3ktj/7JxPPPftgk9Jd+i13sU4vPhmNMjy3an6Y4HLCkqC4A5WZS6fKVF3VwSDBuUInxR
         8WLA==
X-Gm-Message-State: AOAM531AWGTk1oPxzFl5uk0TJpy5A2RCjHrd+Jp5CZUEX4UNzSQ9sk44
        RkA6Ouj2fXI84BDiZl81s5K38w==
X-Google-Smtp-Source: ABdhPJz3EgNE/dzdl1waBSoWGoWNzDHErjWDYYygsBmeO19Q5FRz5rTWYfVjdhPhDSbWLy3fyrzRsA==
X-Received: by 2002:a17:90a:d315:: with SMTP id p21mr3945874pju.88.1599716059106;
        Wed, 09 Sep 2020 22:34:19 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w203sm4575162pff.0.2020.09.09.22.34.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:34:18 -0700 (PDT)
Date:   Thu, 10 Sep 2020 11:04:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200910053406.t37rgioykzvk3oem@vireshk-i7>
References: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
 <20200910050341.pgyieq3q7ijitosn@vireshk-i7>
 <1599715851.7042.9.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599715851.7042.9.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-09-20, 13:30, Hector Yuan wrote:
> On Thu, 2020-09-10 at 10:33 +0530, Viresh Kumar wrote:
> > On 10-09-20, 12:31, Hector Yuan wrote:
> > > The CPUfreq HW present in some Mediatek chipsets offloads the steps necessary for changing the frequency of CPUs. 
> > > The driver implements the cpufreq driver interface for this hardware engine. 
> > > 
> > > This patch depends on the MT6779 DTS patch submitted by Hanks Chen
> > >  https://lkml.org/lkml/2020/8/4/1094
> > 
> > Thanks for hanging there. Looks good to me. I will apply it once Rob
> > Ack's the binding patch.
> > 
> 
> Many thanks for your help. May I know if you can add Reviewed-by tag to
> this patch set.

Since this patchset is going to get merged via my tree (ARM cpufreq
tree), a reviewed-by isn't required here. I will queue it up for
5.10-rc1 after I receive an Ack from Rob.

> I would like to prepare some patches for more features
> based on this. Is that okay to you? Thanks again.

That should be fine.

-- 
viresh
