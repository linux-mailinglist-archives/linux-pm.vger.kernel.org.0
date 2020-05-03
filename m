Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943DB1C2E5A
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgECRZX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgECRZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 13:25:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2D3C061A0E
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 10:25:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so5724701wmb.4
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBJwk1f560Kl/Mp1W9X0i0aTlx7TM73egresLUSpamk=;
        b=cFOQk5jEn1w6eKi51VwnlLbqKOjETU9EbLf608ljWuQErnnpEzoFVe7kiZzrpQ+x3v
         ufOGwEvyBt3gGi+RRbDRnTf/PDaG+4U5uDK3il+CBPDKIgFj5rfF2s6Ht9xgtG0jhTPQ
         g3OpY0aH1gDpkyOQpeC1q/Gopyru92nF9gSE6ujWD3+32WKm8X4CR/H8q0nlqUhwPAJs
         l+mDrAQGcqaQVYMRtWIU/se7z12tfJSmcIStjTmpAK2q3CDGaSL6DWkJ4EaRxSrOwqNA
         Kr78urrAsA6c5U20eSvt57lP5TzZzBtVy9Yrjp5WKbStqFdb1pmVcdd+CDBgp8KaK8nG
         fuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBJwk1f560Kl/Mp1W9X0i0aTlx7TM73egresLUSpamk=;
        b=Qs20T0LbSARtzWBdr/8MpfqLSIZieOajCdjP2ie7gPsz3ImfAfuu2dWhHzJMD7ZYEv
         gIm3aBet+5ZPeH3JkQAwjwSaMsp5wP7ULlKoAhGcv4yp9CxqJJHX0twKq2DeeDyDOkwT
         s9fq+OeBWMroE0IDs1LQhhKYyc5QPgwuIh2QLOepYVRqDN2BS57ib3k/UNpJx3iHIYBi
         0pIfnXMqcbCPFGo9Qp0P4u0lj3skUq7rcqHSRQ+ZCj6OYfhHguOosNSzFSb190oMDwxi
         zWiweCBFJqY5KjAg7iWzyoA0z5+qdujNoT1Swdb6aXC3noD+h8Xb47kVOXeB35Z/vdwU
         i4CA==
X-Gm-Message-State: AGi0PuatESy0NWaq5KxM06yWfxz9cflFyCtDdrbFNhtCRTjCvmQIQf0Q
        Z9UEjtuTH9VVw40s4pHQJvsLMUUxa+s=
X-Google-Smtp-Source: APiQypJ6ItRfjkkv2gd+FO52dZNWQAa0DnQ8tfMXvazmN43TfD0+VqJIGCuIstUTV4BNwCia0F9OzQ==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr10098314wmq.175.1588526720813;
        Sun, 03 May 2020 10:25:20 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2:2::1])
        by smtp.gmail.com with ESMTPSA id n2sm14566983wrt.33.2020.05.03.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 10:25:19 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jVIMf-0003X9-R5; Sun, 03 May 2020 19:25:17 +0200
Date:   Sun, 3 May 2020 19:25:17 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
Message-ID: <20200503172517.GA9498@dumbo>
References: <20200413190843.044112674@gmail.com>
 <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher>
 <20200427094840.GA29259@dumbo>
 <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com>
 <20200501071052.GA20585@dumbo>
 <CAJZ5v0itdtHTsMhbrgThR76YRDv-BBH2VSiU413d+K9K0VFyAA@mail.gmail.com>
 <20200503133104.GA24480@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503133104.GA24480@dumbo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 03, 2020 at 03:31:05PM +0200, Domenico Andreoli wrote:
> On Fri, May 01, 2020 at 04:54:13PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 1, 2020 at 9:10 AM Domenico Andreoli
> > <domenico.andreoli@linux.com> wrote:
> > >
> > > On Wed, Apr 29, 2020 at 01:20:53PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Apr 27, 2020 at 11:48 AM Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > > > >
> > > > > On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> > > > > >
> > >
> > > [...]
> > >
> > > > > >
> > > > > > It is possible in theory that two processes write "disk" to /sys/power/state
> > > > > > concurrently.
> > > > > >
> > > > > > Is there enough mutual exclusion in place to handle this gracefully after the
> > > > > > above change?
> > > > >
> > > > > No, indeed.
> > > > >
> > > > > It looks like hibernate.c needs the mutual exclusion and user.c could
> > > > > just use it. Should I move snapshot_device_available to hibernate.c
> > > > > and rename it hibernate_available?
> > > >
> > > > There is hibernation_available() already.
> > > >
> > > > Maybe switch over to the refcount_t API, call the variable
> > > > hibernate_refcount and use refcount_add_not_zero() on it for the
> > > > mutual exclusion.
> > >
> > > I'm doing as you ask but I'm not understanding what we actually gain
> > > from using the refcount_t API.
> > >
> > > I'm reading about relaxation of memory ordering and there is no mention
> > > on what this implies for the add_not_zero operation that we use.
> > 
> > The details probably don't matter, but what we use here effectively is
> > a refcount which is not allowed to grow above 1,
> > 
> > That's why it'd be reasonable to explicitly define it as a refcount,
> > now that there is a suitable API.
> 
> The logic above looks fine to me and AFICT I implemented it in
> https://lore.kernel.org/linux-pm/20200501152304.523890160@gmail.com/.
> 
> What I noticed only after I posted the patch, it triggers a warning
> (the ">>>>>>" traces are only in my local code):
> 
> | May  3 15:06:10 dumbo kernel: [  318.272438] >>>>>>>>>> release refcount-pre 3221225472
> | May  3 15:06:10 dumbo kernel: [  318.272441] ------------[ cut here ]------------
> | May  3 15:06:10 dumbo kernel: [  318.272442] refcount_t: saturated; leaking memory.
> | ...
> | May  3 15:06:10 dumbo kernel: [  318.272531] Call Trace:
> | May  3 15:06:10 dumbo kernel: [  318.272537]  hibernate_release+0x52/0x64
> | May  3 15:06:10 dumbo kernel: [  318.272540]  snapshot_release+0x47/0x70
> | May  3 15:06:10 dumbo kernel: [  318.272545]  __fput+0xe1/0x250
> | May  3 15:06:10 dumbo kernel: [  318.272547]  task_work_run+0x76/0xb0
> | May  3 15:06:10 dumbo kernel: [  318.272551]  exit_to_usermode_loop+0xeb/0xf0
> | May  3 15:06:10 dumbo kernel: [  318.272554]  do_syscall_64+0x162/0x180
> | May  3 15:06:10 dumbo kernel: [  318.272558]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> | May  3 15:06:10 dumbo kernel: [  318.272560] RIP: 0033:0x7fc0c064eb54
> | ...
> | May  3 15:06:10 dumbo kernel: [  318.272570] ---[ end trace 9b4a89152f05edb2 ]---
> | May  3 15:06:10 dumbo kernel: [  318.272571] >>>>>>>>>> release refcount-port 3221225472
> 
> If I switch back to atomic_t, I get the expected values (my traces of
> two hibernation cycles):
> 
> | [   42.836678] >>>>>>>>>> acquire refcount-pre 1
> | [   42.836683] >>>>>>>>>> acquire refcount-post 0
> | [   47.313636] >>>>>>>>>> release refcount-pre 0
> | [   47.313638] >>>>>>>>>> release refcount-post 1
> | [   58.069508] >>>>>>>>>> acquire refcount-pre 1
> | [   58.069513] >>>>>>>>>> acquire refcount-post 0
> | [   63.661207] >>>>>>>>>> release refcount-pre 0
> | [   63.661209] >>>>>>>>>> release refcount-post 1
> 
> I'm still trying to understand why this difference between refcount_t
> and atomic_t in our context. I must be missing something big.

The problem is in refcount_add():

| static inline void refcount_add(int i, refcount_t *r)
| {
| 	int old = atomic_fetch_add_relaxed(i, &r->refs);
| 
| 	if (unlikely(!old))
| 		refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
| 	else if (unlikely(old < 0 || old + i < 0))
| 		refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
| }

She clearly does not like to add anything to zero. Which does not make
much sense to me.

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
