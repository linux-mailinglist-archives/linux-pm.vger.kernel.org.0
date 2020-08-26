Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC800252CE9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgHZLvy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHZLvr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 07:51:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4767C061574
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:51:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o13so926701pgf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5syma3Hm2xgpjYoCUfH5dx/fNvVtugVzGMU+rBDjb4=;
        b=lQG780WbiVqGfjwKV6LroLuIY3BVig9byZ5oVDCFMGK3nIVflGCp64lH3lxSdOTw9V
         e4kFeBYitXXNHSqx6Jsm/b3jgeUopo/gwIXUP3EJM8vF44yJw29+xNZr7JUblr9cIuNf
         sYsx5ebT0trr3Fljajn3EJccf9TakxAiQM8Fu2DNuxb2cBqlCBuEM/nZDCv7blfSCJzS
         yeVKscKogFC7EIEu22lLW7kOGkP16OfRiNlEJCGVWwZjuw4fYlKBwrUmjteZQbLwohU0
         r2EOfEiAGg6H4caq6Px8EWQwDOmA8X7TCl1uPhZeshiosMS/2Yt5laBHksA4kwbgX1Z1
         PbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5syma3Hm2xgpjYoCUfH5dx/fNvVtugVzGMU+rBDjb4=;
        b=eF/YS5nQDyvcBESsnKggnny9pH/RfcZDZSOZ8Rc071Jabos7DBrCEQCXNV95jdSb1K
         owwcZ/3pM0pKKmwTp5uY5iqzhYXvs+c9SWUdpxxBxzzfWbcuiyhfm0owhyi9g51OzWRm
         iQ1z/pS34OhBEyLCi9i/1qnFt+B/odlr5R9kzt8hvJKQKexwJvOKsKMzvYDBE7EJuw+f
         Kc1EVMhL3w30GJTNX9pMW4ff5RPHBp6oIWuH4Bxb87XAhkip33KMqMoi+dCa8nAI0x+y
         tjAYK72HxH1YIyzxWx/AjAtiOw3D24PMquklg6OoqBWSJjOQFxSQIC4lhcR3nLPSM6Kg
         sAMg==
X-Gm-Message-State: AOAM532hTHda2M9xnimgNyZVtmrtEuhGQiHW+rQNcl/G3x6WqRczubVR
        jrJTz0N49V3IS4elOyQBPJxqSA==
X-Google-Smtp-Source: ABdhPJxW+8PNMdyqhaG+5tXru5ltIFVeIrhcF+B6nSKr9/33OvHJxPKi9pnj47apZOMcd7m9BlZlzw==
X-Received: by 2002:a63:6346:: with SMTP id x67mr10344346pgb.121.1598442704021;
        Wed, 26 Aug 2020 04:51:44 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id o30sm2401619pgc.45.2020.08.26.04.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:51:43 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:21:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: opp: How to use multiple opp-supported-hw versions properly?
Message-ID: <20200826115140.n4zgz2dutu7xxfew@vireshk-i7>
References: <20200825074452.GA1322@gerhold.net>
 <20200825081637.opfmtccwczn6jtlo@vireshk-i7>
 <20200825085740.GA855@gerhold.net>
 <20200825095633.wzlpsxhabkfd27km@vireshk-i7>
 <20200825103407.GA847@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825103407.GA847@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-20, 12:35, Stephan Gerhold wrote:
> Actually this does not work properly either, at least if you have
> 64 possible versions :-)

I must have been very crazy yesterday :)

I think your idea was the only sensible approach and I have sent a patchset with
relevant updates. Please let me know how it looks.

-- 
viresh
