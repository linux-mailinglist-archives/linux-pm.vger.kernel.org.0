Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE53215BB03
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgBMIsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 03:48:24 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45344 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgBMIsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 03:48:23 -0500
Received: by mail-pg1-f172.google.com with SMTP id b9so2579375pgk.12
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 00:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8oTvXJmJIs72ZXqYyI6M/eqqn1QbR3Wgo79uVf+d91w=;
        b=Xfi8Mfpu6dGPYf21wffVyUhbNzobawlxTlSV0zFqqg5EOfB+JNEX32h+OUtqCxiZDm
         VtiRhkgJGBZe1r41fmKFiGvGGjSXwynOGIV6oJ2Hh+v+vAE5HtRi9PTzqgdy0N8NxMWs
         q9dlHOEPJanUGx+lJphH/9hdw4GMv+OywJWveZQyHs5RMj2DMcAsoDJo+J9FdFzGmNuE
         DqkR23AOwQBXnlX+kN21GzPZiB9WkmNExkTU5SKrbziVFMLWS65EbGYUGVFj/WzuPCKI
         grL8m67kKTbdvFJB67dB9iMaXWI2DWeYdtWpezIFS3JyDZgOnEX0zWRjWOQmZ91jL86+
         CyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8oTvXJmJIs72ZXqYyI6M/eqqn1QbR3Wgo79uVf+d91w=;
        b=j8NhW39bm88RiuQOOkHLBi43xXP7h1pZlKMGLTYpbeYVh9HSaQYx258TjeULjsx0b7
         8RxJMoUXtJ27w52e+0QpnKSJINZcRiz5DkfHveHjFi0+lojvsRvW8FwENYqVdUvaP4Ft
         3bEbPkdBJ+1fEiLcuerzqAjN0EDaFa1Vm9Dgt9EIBcGjrBa4zcfxzckkgzxGRylahrRN
         Tv5TQT9e188PCAUd760fFE3tKDZYNVhNeVBu1NpUHku5w8ltWFKX5C+9reWoCMrds+SF
         UFbigU4FcnIt9wbh4kxADIS+av5qAB2Yd/DVkshISMHwDHr+bKoHq3EEwOEFSe8Le5LN
         ic5A==
X-Gm-Message-State: APjAAAWG9HaqIQLKVB3yvpN3abuAFP8/Sop1tA6mnF8G2kZLkXqHfIWa
        2EmtNVbpM9TYrlOn0Q/+ei4shQ==
X-Google-Smtp-Source: APXvYqwuXHZ5UdvtFrkYGwAHsV+uYi4PeNrTxDTROtZxCE2klgEaoRlagLAsaTslvluWV9RfxQdYLA==
X-Received: by 2002:a63:5818:: with SMTP id m24mr17042082pgb.358.1581583701979;
        Thu, 13 Feb 2020 00:48:21 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id b23sm1956313pgw.45.2020.02.13.00.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 00:48:21 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:18:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200213084819.jveurrsvtv72ssug@vireshk-i7>
References: <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-02-20, 08:18, Andy Tang wrote:
> I keep monitoring cpu usage for several minutes, by top and mpstat tool, and found
> most of the cpus are 100% idle, once in a while one of the cpus increases the load to about 18%.

I don't think top will be a good way for doing this test as we are
talking about load on a CPU in interval in milliseconds. Please check
with tracing and see what's keeping the CPU busy..

> Technically if the cpu usage is not more than up_threshold(80), cpu won't increase its frequency and keep
> at the lowest frequency when cpu is at the lowest frequency and conservative governor is used. 

I agree. Which means that there are some spikes of work getting
scheduled on CPUs. The load will increase slowly and will also
decrease slowly (step-by-step) with conservative governor.

> So I can't understand why cpu frequency increased?

Tracing or debugging cs_dbs_update() in conservative governor is the
only way out I would suggest.

-- 
viresh
