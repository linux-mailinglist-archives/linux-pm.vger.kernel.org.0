Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC616798A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBUJgl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:36:41 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42697 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgBUJgl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 04:36:41 -0500
Received: by mail-wr1-f52.google.com with SMTP id k11so1181135wrd.9
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 01:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fttQOOv4xbgc3N7wuWKLpsK6IZKSEPyxzY4b9QO9DYU=;
        b=IMqj2Yl0hEDrKfeqmpxtr1P8viwDcVAQYUbiYJc2kBAeIbp5Hhqp/BoS2/V6WC1RtL
         APbAPzB1AwekuvLpxc5t+kRmhvcA1MDDAWw8U5R8nREWr/iVAhxtAYfpjrzQbXYY1JEm
         ET46wbU2sOh3yMAri7zlqOmWq4JSizqEiSNiV+JtgUV8dcN1DJoshsr+pjWlQQ+m2O2Z
         RNvL7VMSX2na/bn6Mx49Ts+355euET8Wq4TSGm5Dxj+HdbeYg78h43GKYzd/mCp+aqF6
         muG+3TjIP29/K64TwljMYG6+mQhjFAwgZEy6KiJsHtJwcjOvOgT6jfjnQneczOmq0mmJ
         1Vjw==
X-Gm-Message-State: APjAAAX0skN1DfwhrmK/bjc03aPbRGm+ih3on+wTnj5JpyUUYJABV3LU
        1zQNwLkNxnJqR8e24Hl1ZUI=
X-Google-Smtp-Source: APXvYqwMB/j+4OtqvPIvMMYYGCukRtGpa/JsmfkBlrXsYAC/ivaoy+IatxHgOn7v0lN1eed3/4qMqA==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr45764094wrv.86.1582277798833;
        Fri, 21 Feb 2020 01:36:38 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h13sm3293314wrw.54.2020.02.21.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 01:36:37 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:36:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: is hibernation usable?
Message-ID: <20200221093635.GN20509@dhcp22.suse.cz>
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
 <20200221084910.GM20509@dhcp22.suse.cz>
 <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 21-02-20 10:04:18, Rafael J. Wysocki wrote:
> On Fri, Feb 21, 2020 at 9:49 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 20-02-20 09:38:06, Luigi Semenzato wrote:
> > > I was forgetting: forcing swap by eating up memory is dangerous
> > > because it can lead to unexpected OOM kills
> >
> > Could you be more specific what you have in mind? swapoff causing the
> > OOM killer?
> >
> > > , but you can mitigate that
> > > by giving the memory-eaters a higher OOM kill score.  Still, some way
> > > of calling try_to_free_pages() directly from user-level would be
> > > preferable.  I wonder if such API has been discussed.
> >
> > No, there is no API to trigger the global memory reclaim. You could
> > start the reclaim by increasing min_free_kbytes but I wouldn't really
> > recommend that unless you know exactly what you are doing and also I
> > fail to see the point. If s2disk fails due to insufficient swap space
> > then how can a pro-active reclaim help in the first place?
> 
> My understanding of the problem is that the size of swap is
> (theoretically) sufficient, but it is not used as expected during the
> preallocation of image memory.
> 
> It was stated in one of the previous messages (not in this thread,
> cannot find it now) that swap (of the same size as RAM) was activated
> (swapon) right before hibernation, so theoretically that should be
> sufficient AFAICS.

Hmm, this is interesting. Let me have a closer look...

pm_restrict_gfp_mask which would completely rule out any IO
happens after hibernate_preallocate_memory is done and my limited
understanding tells me that this is where all the reclaim happens
(via shrink_all_memory). It is quite possible that the MM decides to
not swap in that path - depending on the memory usage - and miss it's
target. More details would be needed. E.g. vmscan tracepoints could tell
us more.

-- 
Michal Hocko
SUSE Labs
