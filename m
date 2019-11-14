Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84342FC1BB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 09:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfKNIl2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 03:41:28 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:37459 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNIl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 03:41:27 -0500
Received: by mail-pf1-f182.google.com with SMTP id p24so3706219pfn.4
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3gNp5AR/thc+L1y5xJjdkSqmT/cSSY4HgpMILU6J9U=;
        b=Al5B8Qg4R5gQsFCbxN/pHpsDKNFwZ10mLNdMavt/+yuE6k0ExngJOThOUHL7n6lZg3
         ZU7+n8seQ2AL/lbEsseWajReb5h1yF8FFr6MifBW95o8tPh93CMmlVXU2Zcleqg3QY9D
         Gklu287gnR/i0bFVsTyJNtHLVFFYLvHs1b9XmbGFfg/jEXTiZaqWSC25RaUsre6Xrl7u
         yxMtX6Raud8jJmD4QoPc790p8cmGaYc5U/tkbVMCEERLAPJ/XhbqjAqKdeym23Pbq0gc
         IW/vFZjZKnEIOXDGUOI5NA6ePn5kvRDj+ZpVXQnaZng8q4nvVhLBgmmjv3FoM62lD+Uz
         UYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3gNp5AR/thc+L1y5xJjdkSqmT/cSSY4HgpMILU6J9U=;
        b=cJ7m1hxvptQwW3bab5Obbjg0XfJMpnZylN5PTQgO6FUMCLG0+GMNNhRjz1azK0CItv
         t8PPPUJcIrUCthZiTU+3fcJ3qfqo1vopqZVf7hO4oHi+UgGJwUlwsbLlosAu6qqKyPow
         hgvh5oLs05NBXx0+y5TiJ0fi1dORzEYBHBqRHvHEdrYHVhJ6DpwuWHDHTY4MnGpU+hjX
         tiTSVShooMPICOrgoBYHHm42202CiEiqB0Oul1bItMFTPlRzQqkQpu5PP0JhbK1HOQ+H
         C9hPBtO4cqVKIl+LzYnXA3vDzEsgh8FLBljD8cX6YRjDuYLuSLbijnN09RO8lcEKoLIg
         yTLg==
X-Gm-Message-State: APjAAAV6Ng8pwxSlOjuIDEiNodJ1zW8Re7AfvUU9NWjE7Xmd9HEmfSIS
        r/H1e+d5rbe9JS+7EjG6UylxOA==
X-Google-Smtp-Source: APXvYqyh0xLsR6j8VPQoMgv8oLAbGBK9NPzoD9pymbIVMrICUXmU2iKFKWK+gAshxQ1D8ygYH5BUtw==
X-Received: by 2002:a63:64c3:: with SMTP id y186mr8636135pgb.409.1573720884695;
        Thu, 14 Nov 2019 00:41:24 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id j20sm5132254pff.182.2019.11.14.00.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 00:41:24 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:11:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191114084122.35myncenejt54hht@vireshk-i7>
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
> On Sat, Nov 09, 2019 at 12:27:29PM -0800, Bjorn Andersson wrote:
> > As your question shows, everyone gets this wrong and the build breaks
> > all the time (it's not "depends on framework", it's "depends on
> > framework || framework=n" - and everyone you'll talk to will be
> > puzzled as to why this is).
> 
> Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> express that type of dependancy.

Maybe we can use

depends on framework != m

-- 
viresh
