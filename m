Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31419F6DAA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 05:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKKEy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Nov 2019 23:54:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40723 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKEy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Nov 2019 23:54:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so9816147pfl.7
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2019 20:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S45RXA4zGV7gDprsye+JFjRLdDRo3WVxz530wyGpJP8=;
        b=P7TReUjlHc9dF8PHNzJzV9vA9J8emcI7MGU4VBkJS7ZpTDGkeE1abyae1I+gowgS2Y
         slZNVa09fIkCEtv11NJmVWpFcnWqkh2j3yldAGM7qJSOeEpqMfUMKnU1SWvLXa57PYHz
         fJrjCuosK6+4HxrQL8Wom/RlDRRCS/yIsV34SqA2Z2ysJobEILnAC4YtEM3ws4bT9dgd
         rNd8hiqhQyD6sfNsBofoc3mA1y4lzwQAq4bd/rfkgU+xK6f1xfVIgc0hcsJIApXYuQp6
         RQ2ixHkFKrYhAX63PLoNUPFHutLEU1eQsDvS26piKSeLrF4ZEfRLWMdx1w9CVUVE2Zp8
         3Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S45RXA4zGV7gDprsye+JFjRLdDRo3WVxz530wyGpJP8=;
        b=Rkva0NHE1GfwLPho57WCpRCFgsDjU0Q11yJbUNrJGUV/AMiWn5QyNatoKHaRE72jpI
         l+l2dlhvjS+JJtvWJb5XkfdHTxziD2fch9po/ISukaNz4iJa42BJGsqjjr2e06gw4wf9
         7XDP90zhgZOCRCnmyP7+efyr8xmW2GC2yi/c0rRzI/xsuTLpZmONmzubFQPh74L3wyww
         z/uBYC19Qv0AXt04ywNiAhgMpjaPpBYbPL8lFj23OXpq6nWHr17xQMGKnx7PoZKpbQ7A
         wi0NLMCl6zms8rTWy9xj6vhBc0JxeY0OSyL7kiqUh+HUj253YAbpVaRJZ4xsK9blDVit
         KkuQ==
X-Gm-Message-State: APjAAAW//WYwT/q3ZCGq5V8LIF8AQmh+nxZsevNdJ8mPGEA+i+7kmN8O
        lDT0dsmiL8qoXMpNWPlg3HnXew==
X-Google-Smtp-Source: APXvYqykMoJHUhOeCov71Fd/M57CoIspV1B+HZ07HZOay4M0s/x3pAt0wUtbrCmSDBSVEO31b3ZV9w==
X-Received: by 2002:a63:4104:: with SMTP id o4mr26140789pga.169.1573448067775;
        Sun, 10 Nov 2019 20:54:27 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 21sm18386478pfa.170.2019.11.10.20.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 20:54:27 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:24:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110101647.GA1441986@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
> Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> express that type of dependancy.

So we are going to merge this patch for now ?

@Bjorn, thanks for replying while I was away :)

-- 
viresh
