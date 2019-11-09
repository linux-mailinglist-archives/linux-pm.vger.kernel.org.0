Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE1F6161
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfKIU1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 15:27:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfKIU1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Nov 2019 15:27:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so8852492edv.9
        for <linux-pm@vger.kernel.org>; Sat, 09 Nov 2019 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+8khpJ1Hz+tMD0njO1mPXhcUz3AaktW0QE8s0RXEy0=;
        b=cAXINlTqhr2dYYRGvd9NyArzc+EEga3e/Nr45Py3EXZQkp8APG66x9NL+TlBrJNRuE
         WMDl88rcOO5QiMtFtuOZGWGdm0PUfwJsY6KNrS9v3OoAIamKh5LFa69MH/du7nB0Vegs
         Ts5glrzo3MD0jk5JV6/lzhHpFCYeH3WI4o0woPVbY8tGPYI8J9UFewDOgRVq6DyowxNf
         KgvNAULB6HecR8O93lRomvc5Ch25S+XIrnY6IHDPqYuiztZdaJZhrZWcbsYBI3ZZc12m
         ISs2hpsm4bcpFCao14BmtTho/xIPg2rgb0U5+uv0vGlxT836+RM2Lr50snCA9TQWEpl5
         5Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+8khpJ1Hz+tMD0njO1mPXhcUz3AaktW0QE8s0RXEy0=;
        b=uLynhI/gpBMkUi0ckB9WxxJi+lnc5mRXNWj8ISiY8jkytQMk9quz6EE+L7qXQiIMiG
         A5ENEApiabgchseAP+jnllSa969uZmKaC5AfEWVtw3Lha2bf9dHhhPUUcHJ2TUc1Hjz6
         sLyaUGNUiRU0GkMR1n7kJ+IEjw8Fa036eq0a3R+jEziPk1caF4ISKP2t2MFGqKmN/ljP
         bxUOy1GUCVk3KbQTAYbw3VwT6nIIFAIXlTBMR71VwJS6t8cDoeMeb1tHfyBAi4YhYZlf
         3jy+1GkPergT7TcMnVPZgLkJd5ZwLsKvz2lO87ULayeLKxRT/5UfmPkEHieYG62x2bvC
         NheA==
X-Gm-Message-State: APjAAAVwWPxtPCHImL7sT5iSt21WGjYz7Z0T8LltVPxHXKs8VgKZIGcM
        5qxZqTlt0+SGUzEvMFNVjGCGuQrme7Hdx5RALPgX0I4s
X-Google-Smtp-Source: APXvYqzHkGJ3thq037poRWi7Fb25K2gOcNkPsCPTR5ycyhsTeNJ5+LOyIylym/6LOuq7Wh1X2CEkYzCBoL15Tpu5SS4=
X-Received: by 2002:a17:906:d93b:: with SMTP id rn27mr3416343ejb.184.1573331260654;
 Sat, 09 Nov 2019 12:27:40 -0800 (PST)
MIME-Version: 1.0
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com> <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com> <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
In-Reply-To: <20191109084820.GC1289838@kroah.com>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Sat, 9 Nov 2019 12:27:29 -0800
Message-ID: <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
Subject: Re: [GIT PULL] interconnect changes for 5.5
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 9, 2019 at 12:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 08, 2019 at 05:36:46PM -0800, Bjorn Andersson wrote:
> > On Fri, Nov 8, 2019 at 2:39 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Nov 07, 2019 at 05:42:13PM +0200, Georgi Djakov wrote:
> > > > Hi Greg,
> > > >
> > > > On 11/7/19 16:21, Greg Kroah-Hartman wrote:
> > > > > On Thu, Nov 07, 2019 at 02:46:53PM +0200, Georgi Djakov wrote:
> > > > >> Hi Greg,
> > > > >>
> > > > >> This is a pull request with interconnect patches for the 5.5 merge window.
> > > > >> All patches have been for a while in linux-next without reported issues. The
> > > > >> details are in the signed tag. Please consider pulling into char-misc-next.
> > > > >
> > > > > I don't know about
> > > > > 0003-interconnect-Disallow-interconnect-core-to-be-built-.patch here.
> > > > > Shouldn't you just fix up the dependancies of subsystems that rely on
> > > > > this?  We are moving more and more to kernels that "just work" with
> > > > > everything as modules, even on arm64 systems.  So forbiding the
> > > > > interconnect code from being able to be built as a module does not feel
> > > > > good to me at all.
> > > >
> > > > Thank you for commenting on this! The initial idea was to keep everything as
> > > > modular as possible. The reasons behind this change is that other core
> > > > frameworks like cpufreq (and possibly others) want to call the interconnect
> > > > APIs. Some of these frameworks are built-in only and it would be easier to
> > > > handle dependencies if interconnect core built-in too. Now each user that
> > > > can be built-in has to specify in Kconfig that it depends on INTERCONNECT ||
> > > > !INTERCONNECT.
> > >
> > > That's fine, when those subsystems start to use those apis, that
> > > dependency needs to be added.  Nothing new here, and you forcing it to
> > > either be "on or off" isn't going to change that.  Let's do it correctly
> > > please.
> > >
> >
> > Please no!
> >
> > Making our frameworks tristate means that we can no longer rely on
> > include file stubs (as framework=m, client=y will fail), so every
> > single client must add the "depends on framework || framework=n" - in
> > contrast to nothing the framework itself is bool.
>
> What's wrong with a single "depends on framework"?  If your code relies
> on this framework, you should depend on it, right?

As your question shows, everyone gets this wrong and the build breaks
all the time (it's not "depends on framework", it's "depends on
framework || framework=n" - and everyone you'll talk to will be
puzzled as to why this is).

But consistently introducing this for clocks, regulators, pinctrl,
resets, etc should be a task so large that people will come out
educated from it - or whatever it is that one feels after fixing
thousands of Kconfig entries.

> Include file stubs
> feels odd for a core functionality, if you can live without that
> functionality, then sure, don't depend on it and all should be just
> fine.
>

Odd or not, it's what we have in all these frameworks.

Regards,
Bjorn

> thanks,
>
> greg k-h
