Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86E51D1005
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEMKkU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgEMKkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 06:40:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBCC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:40:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mq3so10922950pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6g/OGCA0weL6m6n6S755OJmFzP9BvEzGrA24GPzUGNY=;
        b=iB+KdYDjUW2GBWW9t/adgQSxRJqm6spzWd+L/IA/IqgzRZD4rqPAtLzmWRu1vGvVJO
         JNkkvr/0qSTJ/dFczGlVs3q3LYbM6WFzp5TwBbAnafKOgLdyLjfDUN3c7ZolrXS+DTDd
         WP4e3Uy+c+Lj9K0v/t9kupB9Fkybj41KcysjFv3OP2iXhzElLIsvNFem9vAD9rm9U2nb
         KlgEigdtFsp992bdc37Ln8aBBDznF8L49mfoQRXTH1bBO2O1YFuzJOPTxZQzzO8wU6oT
         cpmE7nYwycJ71fY+gJ2givZlgS0ZQ0JTblvV3IAUJhBAMvKR+FXqpbYPU6OeMwyi/JRx
         Y8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6g/OGCA0weL6m6n6S755OJmFzP9BvEzGrA24GPzUGNY=;
        b=Cg+xHWXLP7m7piArTXwaXIbhHfE4N0p4P8Bg60cZQaF4i6ZOmxhvBefy1aG9T4ePLo
         cFZustdEXnYEY+fovL2a0POADgxTqK8Uu2Vv4tlZZ1eBvv/yGHA3ay3Kq6i0XFIB/9qM
         YGkBSd0pIG6cKRfGqglMXhCwwo6PN4HYh7sL2qr3x9WsCKFHXRr8/42nGhTSH6VO/Ugt
         Jbuy7PriJNjcchuxy+QNMlEGWNyxvYsSEdKt1ZXCBq3A40oCbYpGwKj6Ymr8TF3jbU1Y
         PoWvQqWzAeZCln9qqvSh6Ld+7wBEJxZNce0aLJh6yTPPrLv/tLF1XDNP8gPVCraUHLW3
         c+Fw==
X-Gm-Message-State: AGi0PuaUByLGmhvXW7d1OSdWyxR7x1f3IbwnXHWXbvLaIztPodN0TWKR
        +07J0aIWhcWbEtF4Tgq4mocnDw==
X-Google-Smtp-Source: APiQypJeRDyrz5oT8oCS8fVUt8F7CtGs+r7numgjMwTHrocsBFPYXaxYrKTqPtp08cKjMVD+TeKyxg==
X-Received: by 2002:a17:90a:8a06:: with SMTP id w6mr35352914pjn.191.1589366418256;
        Wed, 13 May 2020 03:40:18 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id ev5sm33247446pjb.1.2020.05.13.03.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 03:40:17 -0700 (PDT)
Date:   Wed, 13 May 2020 16:10:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513104015.oyiaimjpspablq5p@vireshk-i7>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
 <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
 <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
 <20200513101805.GA4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513101805.GA4803@sirena.org.uk>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-05-20, 11:18, Mark Brown wrote:
> On Wed, May 13, 2020 at 02:49:22PM +0530, Viresh Kumar wrote:
> 
> > @Mark: Regarding enabling/disabling regulators from the OPP core, what
> 
> My name is spelt Mark.

Hmm. But isn't that what I wrote ? I used @ as that's what people use
to address questions to someone. :)

> > about skipping that only for the regulators that are enabled at boot,
> > i.e. to avoid the issue we faced earlier, (by exporting a helper from
> > regulator core for that first) and then applying this patch again: 
> 
> As ever if you have requirements for the voltage of a regulator you
> should use regulator_set_voltage() to tell the core about it.  The core
> cannot be expected to infer these requirements without being told by the
> users.  If you need the voltage to be a particular level when you enable
> the regulator you should set that voltage.  Why can't the code do that
> instead of trying to add these complex and fragile bodges?  Randomly
> skipping applying configurations some of the time is not going to make
> anything more robust or easier to understand.

Right.

Clément is facing a problem where his regulator isn't getting enabled
and he was asking why the OPP core can't call regulator_enable(), when
it handles everything else around them. Can you suggest to him on what
he should be doing here ?

Thanks.

-- 
viresh
