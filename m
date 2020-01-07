Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5E1324E5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgAGLa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 06:30:59 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51671 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgAGLa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 06:30:59 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so8915810pjs.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CFy1pR/mUKifsWanixLIxsRfu8vBAo/7nQcugx7uxF4=;
        b=zjN7fK1aycPlWKKwWN804iiRxLL3zkh44PacYSS1Q7i8cXOLQExAkv/+jGikURk2OV
         xusZ6d2MQSt158IDRrPFcLMs7xoCGniBbKqytmHsX+HK609m1jlkquPDNLnmMmC+Zmf5
         xwW2G4wYjQOTOOjNI0uH1gd9Wle5ETNUIO6xBDH7Obywjokb9CxuUlJxbEfg4EIsqJJ2
         fnBS9rScJp2whRqAWlNrWbVDz5xYQTDAku2k//1nhMXn/KdqtUX98zV1X1DP9M/D2OL0
         fDwvjGut3XvrC2dj5/rmfGnm4mnteSl91ct3uRCGC8C8zvoPULmJojj5KUYmzCWJlBe3
         Mo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CFy1pR/mUKifsWanixLIxsRfu8vBAo/7nQcugx7uxF4=;
        b=AME81su2PV2e1RumMf8c1+mLIEaUb7iuFLF5A097CqX8I2F9VQkYpPyWaN4FfxDuu6
         Hhcu9IEtTnQ4lPyBt0/UkOCs14HoPmJ+zqBe6XS6gI1D/0H+8J36pHpRsHRkjaC30FCE
         ouxfAkgkuS/onueQTLna+qmWGpjMebMKCFymKILR5jUTL+1zYWIGPNm7+Xbre7wv8sMo
         g928ziYWOinDaYZVIhNzvTcucl6aNj/PAhB9Pg5O/No8Van2f+FWpFs6ZqK6gMlhiufp
         Q1rW1K1QQMfj4YmsmvVq/zwf6+1nyi7ClWzljA/joLW+xlToG+mKQ6g5TfacXAT03bjC
         yp8A==
X-Gm-Message-State: APjAAAXLnPcgUG2WD0KNWL6rT5DztxSoMxpl5pHHYealtNtTclDA6xZO
        4gqtfZpz0I++y+tv8TDB4QIqdg==
X-Google-Smtp-Source: APXvYqydidMoNbGIWOCdA5fNBoB4E7vhZzPi4AiT8kkWtX1b+GY1VrUNPsOHU1LXVK0LCROFRxiJeg==
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr48910582pjd.77.1578396658380;
        Tue, 07 Jan 2020 03:30:58 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id 68sm75907796pge.14.2020.01.07.03.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 03:30:57 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:00:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
Message-ID: <20200107113055.d4ebweisve73yf3m@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
 <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
 <20200107064128.gkeq2ejtvx4bmyhj@vireshk-i7>
 <20200107095834.GB3515@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107095834.GB3515@qmqm.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-01-20, 10:58, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 12:11:29PM +0530, Viresh Kumar wrote:
> > On 03-01-20, 20:36, Michał Mirosław wrote:
> > > Per CPU screenful of backtraces is not really that useful. Replace
> > > WARN with a diagnostic discriminating common causes of empty OPP table.
> > But why should a platform have an OPP table in DT where none of them works for
> > it ? I added the warn intentionally here just for that case.
> 
> Hmm. I guess we can make it WARN_ON_ONCE instead of removing it

I am not sure this will get triggered more than once normally anyway, isn't it ?

> , but I
> don't think the backtrace is ever useful in this case.

Hmm, I am less concerned about backtraces than highlighting problem in a serious
way. The simple print messages are missed many times by people and probably
that's why I used a WARN instead.

> Empty table can
> be because eg. you run old DT on newer hardware version.

Hmm, but then a big warning isn't that bad as we need to highlight the issue to
everyone as cpufreq won't be working. isn't it ?

> This is why
> it's still communicated via dev_err().

-- 
viresh
