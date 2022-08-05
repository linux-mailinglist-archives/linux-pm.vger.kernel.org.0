Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6B58AFA7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbiHESTT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHESTP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 14:19:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9384B0E7
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 11:19:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso8990453pjq.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=txBSSlPi9N0tLAXNG57y6lypgehVa7JGTAdbDr+j5+8=;
        b=fQ7RIIHrOL1i9QeCS7tZjsW67dtHMIhDDo4bjG5JUp9Q5HNatNLQAnXxPK4mckKylz
         Lb+/kokSY56il+IAOJwwyNZshWvuZCuqG/cjhbdARX8vPuU+MzpSqcEJ3LqRf9/nyqyC
         qwkGYzcAuW0O9ZjhoDnGDCEfuMW5C6FZHro1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=txBSSlPi9N0tLAXNG57y6lypgehVa7JGTAdbDr+j5+8=;
        b=DrXFlziLGtyinz1EaOmp4r/dSRvN6LOWmxOhuCgeXrcA1iX1EkWsDWhRr0DLaUrySd
         9VdyrL/M/wuMqrXuMC1E2U5kXVAdge3YdSWyOdYdRJ9MDz8M1anp7Dpgfv9dwg9zM2VL
         4eypOGZTG3lslEgPxfB43FMopyX5SBsNtOKuYuEOspZ2U+o1tLVduHLq+ld8m0WNdCm7
         Q1Vic5wovz5u9pxGEE0LxY3UUPUksvBAyYLZsR+Ob4tr+zbUnLegIhyzOhAqhUb7Wvyi
         6XyVVcB8uN8/MvD4MTz0p3zblwho7bWPMSJKyCNeSG/v7Fi9rnXO/XazW0NvnbPDx7XI
         UnTQ==
X-Gm-Message-State: ACgBeo0HYYTHCcQTqI3OVJIjwFpj4Nd5KFV6HSNNngTApJh5AXIsWZ2W
        sFfgY51D/TVR9zfkWLzsqmBxMg==
X-Google-Smtp-Source: AA6agR4ajfhww8mXkkKGjPREY71JwB9cb8109A4VW7GPRXwogcSVriXwLjIoASIQEAQZepqc1CvYCw==
X-Received: by 2002:a17:90a:ca85:b0:1f3:1058:5048 with SMTP id y5-20020a17090aca8500b001f310585048mr8882686pjt.40.1659723550262;
        Fri, 05 Aug 2022 11:19:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e17-20020a63e011000000b0041a8f882e5bsm1780730pgh.42.2022.08.05.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:19:09 -0700 (PDT)
Date:   Fri, 5 Aug 2022 11:19:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM: core: Do not randomize struct dev_pm_ops layout
Message-ID: <202208051111.F6768D49@keescook>
References: <2643836.mvXUDI8C0e@kreacher>
 <FA016A79-B2B1-42A4-A63F-3A44B3EC57CB@chromium.org>
 <CAJZ5v0j0ebQMWeR2VWjdRufYEoQ_viysYjsvFSVFX11ef2R17Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j0ebQMWeR2VWjdRufYEoQ_viysYjsvFSVFX11ef2R17Q@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 05, 2022 at 04:10:29PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 5, 2022 at 4:12 AM Kees Cook <keescook@chromium.org> wrote:
> >
> >
> >
> > On August 4, 2022 10:15:08 AM PDT, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > >From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > >Because __rpm_get_callback() uses offsetof() to compute the address of
> > >the callback in question in struct dev_pm_ops, randomizing the layout
> > >of the latter leads to interesting, but unfortunately also undesirable
> > >results in some cases.
> >
> > How does this manifest? This is a compile-time randomization, so offsetof() will find the correct location.
> 
> Well, I would think so.
> 
> > Is struct dev_pm_ops created or consumed externally from the kernel at any point?
> 
> I'm not sure TBH.  I have seen a trace where pci_pm_resume_noirq() is
> evidently called via rpm_callback() which should never happen if the
> offset computation is correct.
> 
> The driver in question (which is out of the tree for now) is modular,

I'm not a fan of making core kernel changes for out of tree modules, but
that said, there is clearly a bug somewhere that I'd like to help solve.

> so in theory it could be built separately from the rest of the kernel,
> but I think that this still should work, shouldn't it?

It should work, yes. This implies something is not working in the build
process, though. Either the external module was built without randstruct
and was somehow allowed to be loaded, or the kernel's randstruct seed was
not present in the module build so a new one was chosen. What do

	modinfo -F vermagic name-of-out-of-tree-module

and

	modinfo -F vermagic some-module-built-with-kernel

show?

-- 
Kees Cook
