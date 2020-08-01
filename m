Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F117F23511C
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgHAINS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHAINS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2020 04:13:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53877C06174A;
        Sat,  1 Aug 2020 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rA6LIWaj6NSoXDFoGEeq69LV6z47VtwE27PbIzDh8u4=; b=ZKmhv7//ua/x37fqCEw1Hs7Uxv
        tH46EcTer8hBWN4g76z9anhwAQtJ4nYqMmgc8iOGub6cSJsGkzlf3Zeky0hdUASN67VsnReixM8kS
        czFF4I0nPDYM/EkO9Houn/aOqUHHq7IFImMXuJauEKvztuVYKG7xzYYhcZoGDEHeLY7B5MIHnT1T4
        Hyv8/L5ZDXqNq4CuJXBQEhJqP12EjFzPmVs77iHRgG5KHm7ABb4JZVWwUQ19Ai5KOICl8BnS1ka0U
        hFc4gDatZwzDeg24ZjWqsyLVqOiJKEqnahinfsRRRDmb0e1Nw81Vxa1G1vbi6aTFRQyfRUgzzSoxo
        xoAFjY3g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1mda-0008Ik-OJ; Sat, 01 Aug 2020 08:13:02 +0000
Date:   Sat, 1 Aug 2020 09:13:02 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        yangdongdong@xiaomi.com, tanggeliang@xiaomi.com, taojun@xiaomi.com,
        huangqiwu@xiaomi.com, rocking@linux.alibaba.com,
        fengwei@xiaomi.com, zhangguoquan@xiaomi.com, gulinghua@xiaomi.com,
        duhui@xiaomi.com
Subject: Re: [PATCH v2] Provide USF for the portable equipment.
Message-ID: <20200801081302.GA31778@infradead.org>
References: <cover.1596196060.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1596196060.git.yangdongdong@xiaomi.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

You can't modify non-staging core code just for staging code.
