Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02F1D8767
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 20:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgERSlg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgERSlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 14:41:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6AC05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 11:41:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b190so5362992pfg.6
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BbV/LEIOeouRXOmK+GKN6o5kBO4anE2Qst31rAC/h8s=;
        b=wpk1EG3wH9AfuuSAZTKJ+/n0Q9IjxGLodBjTu4ynOAG7Oao8ePt7F7SjaPQi9rYFBW
         vTCGn5jpPiGn8sP5TKR4fBIzl8X9fsFTOYKFPTb5F3AHf4SMLBDa30kiGOOx9gMf0vy1
         aCFLjZgohKiam+RjD+RPJxjAMEV3Movg6BLoGWxnmo9SwsN7aYuVgFyq3fhx2D23ln2S
         YfMxuQDebgG45W/1YRp1agw9YqdJ9v0+swjux9ma+c/ER6RwDShQ18qxv2t9S/AHctoO
         lxbR3qnHIIx8VG8ImM0hPjjD/EYgZ8jlOYCuvhtqOm3rlT2aF+H9ymdN8ob3LH3KMKPa
         NDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BbV/LEIOeouRXOmK+GKN6o5kBO4anE2Qst31rAC/h8s=;
        b=A7kyTtu++XKHJoZqGZO/7tg3F5mI9oiDxDvFTZ0gNElTH303FoNgGJgoJzv8icU9nP
         30TcjS4IRhw6tnfFjz6QFXphLcDJWSi0hU5RDovAA6tgKZKYwcQKr6mvaABJQfmXSr1z
         5t15IRKyHmaXJMaZZ2OMiQuvdoytUntaUcBD5/haXoZe5rJGGLbFGSu5VAgN3W/YyhOY
         iHUCdJQU8FIgIkEXNTVjoy0mEmmA69nY+RDKtwgEouLfdnIxhWrliK8Qe7HvXT2ZaNqr
         sScZcB6B/T0YcDzp9WkAtOrSL64oVsocxFZXwr5hlZkJz82GfQwY15XyQr3YQA6tbUzh
         NN/Q==
X-Gm-Message-State: AOAM5304VHtMEbjLGi0QOtPc+QoseM4BBeMaHsjpm6Jm8Eing2vTjFmW
        B9MXH5WApWEnyEaxdHlzrqwCtYDrIxM=
X-Google-Smtp-Source: ABdhPJz0TbunwEJ3QS58Piw9hJtSVbZ5pMCjwwHgcI7aZsqjDXKf1WlgVOn75F7erOVKbayPWGlQIA==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr15918251pgj.151.1589827294403;
        Mon, 18 May 2020 11:41:34 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x62sm9251663pfc.46.2020.05.18.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:41:33 -0700 (PDT)
Date:   Mon, 18 May 2020 11:40:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200518184010.GF2165@builder.lan>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515071152.GA1274556@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 15 May 00:11 PDT 2020, Greg Kroah-Hartman wrote:

> On Fri, May 15, 2020 at 07:48:47AM +0300, Georgi Djakov wrote:
> > On 9/12/19 19:33, Bjorn Andersson wrote:
> > > On Thu, Aug 29, 2019 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >>
> > >> Building individual drivers as modules is fine but allowing a core
> > >> framework to be built as a module makes it really complex and should be
> > >> avoided.
> > >>
> > >> Whatever uses the interconnect core APIs must also be built as a module
> > >> if interconnect core is built as module, else we will see compilation
> > >> failures.
> > >>
> > >> If another core framework (like cpufreq, clk, etc), that can't be built
> > >> as module, needs to use interconnect APIs then we will start seeing
> > >> compilation failures with allmodconfig configurations as the symbols
> > >> (like of_icc_get()) used in other frameworks will not be available in
> > >> the built-in image.
> > >>
> > >> Disallow the interconnect core to be built as a module to avoid all
> > >> these issues.
> > 
> > Hi Greg,
> > 
> > We had a discussion [1] a few months back about frameworks being built as
> > modules. IIUC, you initially expressed some doubts about this patch, so i
> > wanted to check with you again on this.
> > 
> > While i think that the possibility for a framework core to be a module is a
> > nice feature, and we should try to be as modular as possible, it seems that
> > handling dependencies between the different core frameworks becomes difficult
> > when one of them is tristate.
> > 
> > This of course affects the drivers which use it (every client should express
> > the dependency in Kconfig as a "depends on framework || !framework"), in order
> > to avoid build failures in the case when framework=m and client=y. However, this
> > is not a big issue.
> > 
> > But it gets more complex when another framework2 becomes a client of the modular
> > framework and especially when framework2 is "select"-ed in Kconfig by it's
> > users. When selects are used in Kconfig, it forces the option, without ever
> > visiting the dependencies. I am not sure what we should do in this case, maybe
> > we can continue and sprinkle more "depends on framework || !framework" also for
> > every single user which selects framework2.. But i believe that this is very
> > inconvenient.
> > 
> > Well, the above is not impossible, but other frameworks (regulator, clk, reset,
> > pinctrl, etc.) are solving this problem by just being bool, instead of tristate.
> > This makes life much easier for everyone. So i am wondering if it wouldn't be
> > more appropriate to use the same approach here too?
> 
> Ok, if it makes things easier, perhaps this is the best way to handle
> it.
> 

It most certainly does.

With INTERCONNECT as a bool we can handle its absence with stub
functions - like every other framework does. But as a tristate then
every driver with a call to the interconnect api needs an entry in
Kconfig to ensure the client driver must be a module if the interconnect
framework is.

Regards,
Bjorn
