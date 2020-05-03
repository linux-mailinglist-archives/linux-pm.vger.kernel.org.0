Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC71C2B97
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 13:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgECLTO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 07:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgECLTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 07:19:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF4C061A0C
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 04:19:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so5134142wmc.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 04:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qP1MRrLLrbUAl5gkkOUt0RQz2ai3Wb6/GB+tjQOX60E=;
        b=c0WrlK3rKHKQOa4ioMf83Bk3KEnFNkbrm+gfAq1sdqz/xzo1nV8cPC3L4obSMLBppf
         TAal6IhCdX1yR9YRv21T+rgo4IOf1AcCuif/rbShc91nDE/p4rkQsajvhmFj7Cyrl3Jx
         Lsxbw5wItJxtUj4pRxtPm2KzVo/itqHEWTXoJKb7XmM5S8f4j4N7UMCd7eD34VWDckCf
         mlnwF9UhYpR2wdGSwln0rdrND0QQ3fB7xCTtBomb5H7k1PL2cwiPMvnatRCwTV8BoRDd
         YrfqXJVUB0f5mUN1AYGzUWDnmPJTb11+KGK146/sM/lcyVdzVrlDnYqSwV4utg0Fn/hH
         S2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qP1MRrLLrbUAl5gkkOUt0RQz2ai3Wb6/GB+tjQOX60E=;
        b=P4hYodxX1yzfFyVrpFDIWEhCSD4lM6DsinRZmtEZL6sqsDq56pUlas1AUhfwvIakB6
         zFp0DmeKE5fwWYraBnJDMZ/iHWP87OXIfrrxK8dDr6qgF2kDxCYgfzSoZUTDqC/KF0m8
         lBZIFJvVPTkqdJvEB5u0qJQ9bktCOE4AMx7sPQQ62crJQjJbOn3E8bA0uHJX1UgT/oHe
         SSdun+C/6m7fZ2MJMtR2DmmF4R1Qhlz3XRbvO4psRGtsnDVcmVKWsfQf/Uito4mlPwHI
         /3busGvFxPuEsiR6BIDnvjTpzPYzv4ZFKGVwE9WE16EAtmESsHMSqWT9YE7t0hzDGWxG
         aicQ==
X-Gm-Message-State: AGi0PubeoPePkvB53j6TcjuZ7UiXvtpI51YIlCCZh/B9usbO3uvST8hI
        z4S00ZmAp1oi7AhGxyOg00pDihe4on0=
X-Google-Smtp-Source: APiQypKVXKSUjEZDAtkJ8t0C3RTo7c95uEWuSx/68TPZxh8jLL5G9pj8/b6vBbbUHJ2E8tGe1OVxXQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr9475610wmg.110.1588504751084;
        Sun, 03 May 2020 04:19:11 -0700 (PDT)
Received: from dumbo (tor-exit-5.zbau.f3netze.de. [2a0b:f4c0:16c:5::1])
        by smtp.gmail.com with ESMTPSA id t2sm8246641wmt.15.2020.05.03.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 04:19:10 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jVCeK-0006ML-N2; Sun, 03 May 2020 13:19:08 +0200
Date:   Sun, 3 May 2020 13:19:08 +0200
From:   Domenico Andreoli <cavok@debian.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>, 954061@bugs.debian.org
Subject: Re: [PATCH 0/2] Preparing to phase out uswsusp
Message-ID: <20200503111908.GA8066@dumbo>
References: <20200413190843.044112674@gmail.com>
 <1636190.8qWULXYmPk@kreacher>
 <20200427095306.GB29259@dumbo>
 <CAJZ5v0g4GyaxtKvbdS7u0rWtMbd075hPzFO-+Cz0q+zM1WbE-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4GyaxtKvbdS7u0rWtMbd075hPzFO-+Cz0q+zM1WbE-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 01:06:01PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 27, 2020 at 11:53 AM Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> >
> > On Sun, Apr 26, 2020 at 05:46:37PM +0200, Rafael J. Wysocki wrote:
> > > On Monday, April 13, 2020 9:08:43 PM CEST Domenico Andreoli wrote:
> > > > Dear maintainers,
> > > >
> > > >   it is my understanding that the usermode software suspend is not any
> > > > more the first choice for suspend/hibernate needs (uswsusp tool did
> > > > not receive any update in years).
> > >
> > > While the last part is true, the user space utilities are still usable.
> > >
> >
> > Indeed I've been using them until now and work perfectly.
> >
> > > Moreover, the kernel-based hibernation is still missing one important
> > > piece with respect to the user space variant, which is image encryption.
> > >
> >
> > Interesting, is it advertised anywhere?
> 
> I'm not sure what you mean by "advertised".

Wrong and misinformed wording, encryption is also mentioned on uswsusp
web page http://suspend.sourceforge.net/.

> 
> There is a way to combine hibernation with dm-crypt which is kind of
> described by Documentation/power/swsusp-dmcrypt.rst, but the lack of
> encryption support in the built-in hibernation code is not documented
> otherwise AFAICS.

I use a full disk encryption on Debian, swap included. I've to say
that everything works flawlessly, after the pass phrase is entered it
resumes from hibernation whatever system I used to hibernate: it works
either with uswsusp or in-kernel mechanism.

Is there any advantage in the approach of swsusp-dmcrypt.rst?

Thanks,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
