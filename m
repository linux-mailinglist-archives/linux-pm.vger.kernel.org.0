Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94041C2CC8
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgECNbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728697AbgECNbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 09:31:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071CBC061A0C
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 06:31:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so17685728wrt.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iL441ZHEjqqhc9onwR5wRRAIZJSdTohouYt/NklR/MY=;
        b=YiKU5Z41h1qAvVy3SOPRC2RPQFCL2jFJfnQQzT3TelXCmL1HcvhVGRLZCdfHOjqw+i
         OqyunoHhEhV1MnxsRLhh11XRqyxTA+kcF1kc7aesO5YPkjsejdP8qzGjBE3muhYdqxtW
         syAegEHwzmC02v7lX690kixHXg5CHmnpY6EiAfPBtyQSjP7bNrhHPq/d4shrxm0WXP0B
         9No/vcg/9B5IeyCOqv+onxr1oLboupbodp+Rc9FFyI2mC/KRhT4bDkRGJ3KDEKhu4ig+
         4RhauPSITJmSPmNXvd7l/lItfXDnvWPcGo2mTu+b2l0yZCHD26xtsq/ICuP+F19FkTQx
         oOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iL441ZHEjqqhc9onwR5wRRAIZJSdTohouYt/NklR/MY=;
        b=Hd2Oy9Q7ZNZ5rJY51dqhZDvxRzwzmpo51LtIz71IHWXAvLVz9D3RUFDgvZvJiW1tQR
         hK5E0/Rv3zpAPybdzlfcAGdpRa/XxyM0Z4OCUbcAmo9W1ttRQ/yyB0uz5K0xXLxzrWmc
         3n83NRYX6642+sCFRo1EnY5qexdmH9CxK5T6hyPMZQ0DIdbhDBxQ+7M1WwKMAb8B7JGr
         4JJkDuNEQqDhreyI8SzTr0DiVTInHf819hw4A87be6GD4Hl67I92sOUSHYtSrQNGjXTj
         zrnqLscqhgL3YpQI7KnphvjDggt+HHhe6NcYBX9lyVR3MY8loPhNqTJWzWXcqcjPFew1
         mjIA==
X-Gm-Message-State: AGi0PuZ6L//Hg47qVPmMs4tr2VnzU+F5oGHoG3JAG7Rx2xTVQPLenDAh
        d4X6UACohog5OxgZLuIHbt0=
X-Google-Smtp-Source: APiQypK/czLu7d49oyVZb0tbDscYTWxT6yYrUP45nWF+oFv/ISwoNfrEdAFn2oRTbsEsKW4zOB7a8g==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr15321781wrt.394.1588512667726;
        Sun, 03 May 2020 06:31:07 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2:2::1])
        by smtp.gmail.com with ESMTPSA id k23sm8633870wmi.46.2020.05.03.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 06:31:07 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jVEi1-0006aP-2w; Sun, 03 May 2020 15:31:05 +0200
Date:   Sun, 3 May 2020 15:31:05 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
Message-ID: <20200503133104.GA24480@dumbo>
References: <20200413190843.044112674@gmail.com>
 <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher>
 <20200427094840.GA29259@dumbo>
 <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com>
 <20200501071052.GA20585@dumbo>
 <CAJZ5v0itdtHTsMhbrgThR76YRDv-BBH2VSiU413d+K9K0VFyAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0itdtHTsMhbrgThR76YRDv-BBH2VSiU413d+K9K0VFyAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 01, 2020 at 04:54:13PM +0200, Rafael J. Wysocki wrote:
> On Fri, May 1, 2020 at 9:10 AM Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> >
> > On Wed, Apr 29, 2020 at 01:20:53PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Apr 27, 2020 at 11:48 AM Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > > >
> > > > On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> > > > >
> >
> > [...]
> >
> > > > >
> > > > > It is possible in theory that two processes write "disk" to /sys/power/state
> > > > > concurrently.
> > > > >
> > > > > Is there enough mutual exclusion in place to handle this gracefully after the
> > > > > above change?
> > > >
> > > > No, indeed.
> > > >
> > > > It looks like hibernate.c needs the mutual exclusion and user.c could
> > > > just use it. Should I move snapshot_device_available to hibernate.c
> > > > and rename it hibernate_available?
> > >
> > > There is hibernation_available() already.
> > >
> > > Maybe switch over to the refcount_t API, call the variable
> > > hibernate_refcount and use refcount_add_not_zero() on it for the
> > > mutual exclusion.
> >
> > I'm doing as you ask but I'm not understanding what we actually gain
> > from using the refcount_t API.
> >
> > I'm reading about relaxation of memory ordering and there is no mention
> > on what this implies for the add_not_zero operation that we use.
> 
> The details probably don't matter, but what we use here effectively is
> a refcount which is not allowed to grow above 1,
> 
> That's why it'd be reasonable to explicitly define it as a refcount,
> now that there is a suitable API.

The logic above looks fine to me and AFICT I implemented it in
https://lore.kernel.org/linux-pm/20200501152304.523890160@gmail.com/.

What I noticed only after I posted the patch, it triggers a warning
(the ">>>>>>" traces are only in my local code):

| May  3 15:06:10 dumbo kernel: [  318.272438] >>>>>>>>>> release refcount-pre 3221225472
| May  3 15:06:10 dumbo kernel: [  318.272441] ------------[ cut here ]------------
| May  3 15:06:10 dumbo kernel: [  318.272442] refcount_t: saturated; leaking memory.
| ...
| May  3 15:06:10 dumbo kernel: [  318.272531] Call Trace:
| May  3 15:06:10 dumbo kernel: [  318.272537]  hibernate_release+0x52/0x64
| May  3 15:06:10 dumbo kernel: [  318.272540]  snapshot_release+0x47/0x70
| May  3 15:06:10 dumbo kernel: [  318.272545]  __fput+0xe1/0x250
| May  3 15:06:10 dumbo kernel: [  318.272547]  task_work_run+0x76/0xb0
| May  3 15:06:10 dumbo kernel: [  318.272551]  exit_to_usermode_loop+0xeb/0xf0
| May  3 15:06:10 dumbo kernel: [  318.272554]  do_syscall_64+0x162/0x180
| May  3 15:06:10 dumbo kernel: [  318.272558]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
| May  3 15:06:10 dumbo kernel: [  318.272560] RIP: 0033:0x7fc0c064eb54
| ...
| May  3 15:06:10 dumbo kernel: [  318.272570] ---[ end trace 9b4a89152f05edb2 ]---
| May  3 15:06:10 dumbo kernel: [  318.272571] >>>>>>>>>> release refcount-port 3221225472

If I switch back to atomic_t, I get the expected values (my traces of
two hibernation cycles):

| [   42.836678] >>>>>>>>>> acquire refcount-pre 1
| [   42.836683] >>>>>>>>>> acquire refcount-post 0
| [   47.313636] >>>>>>>>>> release refcount-pre 0
| [   47.313638] >>>>>>>>>> release refcount-post 1
| [   58.069508] >>>>>>>>>> acquire refcount-pre 1
| [   58.069513] >>>>>>>>>> acquire refcount-post 0
| [   63.661207] >>>>>>>>>> release refcount-pre 0
| [   63.661209] >>>>>>>>>> release refcount-post 1

I'm still trying to understand why this difference between refcount_t
and atomic_t in our context. I must be missing something big.

Thanks,
Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
