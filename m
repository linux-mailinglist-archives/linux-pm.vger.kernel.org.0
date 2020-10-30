Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3CE29FCAB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 05:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgJ3EUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 00:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3EUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 00:20:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F45C0613D2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 21:20:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 13so4170172pfy.4
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A7UPbmXdI+eqRuzY6sKRJs9PFgKewHuLB4lD0EbWj1A=;
        b=NLFXEWJf7ld3LjuijyzbNyrvDi+zFyqS6KWQVl5ncYdWN0F1G1M7r88w+89hG5vTdn
         TdCWI1mZHeUhxj1xBrWJPqh9NREd+ulmd7AeqDki8FnGgv4wJ+OicXI/P2mtFtO6X5pO
         rIR9gDmOg+3UA6STqdVgaxN6YZc78z9KZ+zPvrondm4lYku66EIhFuuzCTYchfocWnHT
         9ghG/vUDbRWFAa2wL1zqf8PfjjRXVGCZEvVSPDah4C0bNK6Y+eso6wxixDMZOWg1iozE
         W7M+E/P5JhZdW5cw6EN586/tTm3vzk1S9CG8vi9gz4Zr5/cEy0O9dWAvgmeRIztSzbMO
         +nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7UPbmXdI+eqRuzY6sKRJs9PFgKewHuLB4lD0EbWj1A=;
        b=DzAnNX0sQWVg2cniJEPJAKd9MfNX++mYoPgejkL/SJlCPxzIxRzxfJ6s7+mNZZUQOM
         X4erigu0Prqgkd6hs+85F85E8jyBwGvEBhey7SIWotEHtbXPh5C8uphigHxW6O8GXx+O
         pyCe5kprCSmoX9pXR4CWfHKY6t2Nay4i0SoKRTh9IDpkXs4+26xcxqxNV3XPbeNMxbuW
         BnDuRpeUdomW8nN3kZq+DGwqNB19nmCx4EPmPgzRQUPK3edxvlXhourcUcKkWXPJMiya
         n4afWh8Ntuxk6yPzwtM/lqOq/HtOQrRKSN0i6DahpOv0IRe+ZuB1bc+ugZcL7ND0Fs62
         qoPA==
X-Gm-Message-State: AOAM533s0KFQuRvoS8J9w1OMmxdE7NQlJEbiLBkiVCeBFSKxlLNwKDNY
        /EpQ3fgNo7rCGP4And+4Nt7rhg==
X-Google-Smtp-Source: ABdhPJyG/7Uq+1HblV489jOm9SHT3AjXVwUxt2jrCQdB45iDuFcqly/0fs65QVVOLGM/tcvhdRMqNQ==
X-Received: by 2002:a17:90a:4b45:: with SMTP id o5mr471611pjl.223.1604031605572;
        Thu, 29 Oct 2020 21:20:05 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 16sm1480433pjf.36.2020.10.29.21.20.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 21:20:04 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:50:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Reduce the size of critical section in
 _opp_table_kref_release()
Message-ID: <20201030042000.bo3dwrmi7efoe42v@vireshk-i7>
References: <e0df59de670b48a923246fae1f972317b84b2764.1603785323.git.viresh.kumar@linaro.org>
 <160392797572.884498.11353243518476305974@swboyd.mtv.corp.google.com>
 <20201029041019.xps4dcavkvk6imp5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029041019.xps4dcavkvk6imp5@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-20, 09:40, Viresh Kumar wrote:
> Thanks a lot. I was a bit worried about the crazy idea I had to solve
> this :)

Hmm, I thought this is the other patch where I had that crazy idea.
This one was quite straight forward :)

-- 
viresh
