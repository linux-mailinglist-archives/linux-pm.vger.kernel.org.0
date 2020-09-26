Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED82795FA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 03:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgIZBaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 21:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgIZBaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 21:30:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B0C0613CE;
        Fri, 25 Sep 2020 18:30:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bd2so212873plb.7;
        Fri, 25 Sep 2020 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ULKEh+Ecw4DPQy4L6QL+sGqPt4lHGJzlYj9qGMuSRy8=;
        b=vI5hFVRgp2yFl2zQcAgMEaG3b9isCmZGnDGzFV7b8hK/jO2c2RWGG4JKJZtrtBTfsn
         VIKCfikRvyt1gb/FBV6chGzqF3GkRCd8VpXNVFWsulUWdQQUHl3J95uzXSdWPt4WL8y0
         MjcSJ8QdKjvY2tsArgjtuEcQ/EnUbFz0RmriHDK+Ze1qbbp/h8YnQasToJq27oQEjZjC
         Dv9IUwZbmO0Q9nMZ4CYnxWTBLIsALgQRYReCre9NYfrY82gMTXlZt7dm5yZkr4jRvEFD
         zO6USVvBolAd2P7lyCge8r1NJUom+x2vW2uYV9k+2G+IXOZdd7SvdJPf1DVekwPfJQ6K
         ce6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ULKEh+Ecw4DPQy4L6QL+sGqPt4lHGJzlYj9qGMuSRy8=;
        b=FRH+a2R5dlMIDddKXSAacLb7swgm9bXSY2ZiFLe3tuz2R0gxs8Zg97Qxi2JnRzdRR+
         +TdYfh6oTUEU/rkgDiiUtnHOdToQSO/dC88ccOTHd7dnyGOtP3u53awTgPC/MVbPppV6
         JaUhYR0tuNf0b9ln1hcmwT4DnfpYVcwQKq3rvAmCo3d5zPHJZ+SRlv3Y4dxOn3oDzR+W
         anmc7F83keuXICVMv5/YwW48HBF1Ok/kkqRMagrXdp3GnEaMhzjThHnkQDc51hNrN7k3
         IopVQP8MxZttfcgZIfl089YK7QcqjyDwVdnWeKuKY1oQcg8XqPK7J7KhwuiBtLEtGzlh
         9yzQ==
X-Gm-Message-State: AOAM5320nlUmLUfDUVV3BBFJe8j6rNw5sKvqbMqe2dQSWipJFIS4l63Q
        tmMasDUpaeqtps5RvTwjm8k=
X-Google-Smtp-Source: ABdhPJyQnXPlFgMiu78X8Gb6FAtLEp0DyUqvEm3mVrrdcLN7WwnCG7e0lJj50WdNw0/M/Y9oKboaQA==
X-Received: by 2002:a17:902:a5ca:b029:d2:6391:a7f7 with SMTP id t10-20020a170902a5cab02900d26391a7f7mr1985100plq.9.1601083811874;
        Fri, 25 Sep 2020 18:30:11 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id e16sm3432358pgv.81.2020.09.25.18.30.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:30:11 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpuidle: change #ifdef for the declaration of cpuidle_enter_s2idle()
Date:   Sat, 26 Sep 2020 09:30:06 +0800
Message-ID: <00d901d693a4$93195980$b94c0c80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdaTpGstmz1XVlqyTRWaANv4KWFGkQ==
Content-Language: zh-cn
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> On Thu, Sep 24, 2020 at 10:01 AM <zhuguangqing83@gmail.com> wrote:
> >
> > From: zhuguangqing <zhuguangqing@xiaomi.com>
> >
> > Currently, if CONFIG_SUSPEND=n and CONFIG_CPU_IDLE=y, the function
> > cpuidle_enter_s2idle() is declared but not defined, it may cause error
> > when cpuidle_enter_s2idle() is called.
> >
> > If CONFIG_SUSPEND=y and CONFIG_CPU_IDLE=n, the function
> > cpuidle_enter_s2idle() is defined as "return -ENODEV;" which is not
> > supposed to be.
> >
> > Change #ifdef CONFIG_CPU_IDLE to #ifdef CONFIG_SUSPEND for
> > cpuidle_enter_s2idle() in cpuidle.h, which is consistent with its
> > defination in cpuidle.c.
> 
> Well, what about the case when CONFIG_SUSPEND is set, but CONFIG_CPU_IDLE
> isn't?
> 

When CONFIG_SUSPEND is set, but CONFIG_CPU_IDLE isn't, the function
cpuidle_enter_s2idle() is defined in cpuidle.c, but the defination in
cpuidle.c is not used actually because CONFIG_CPU_IDLE isn't set, we
only use its defination as "return -ENODEV;" in cpuidle.h.

> >
> > Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > ---
> >  include/linux/cpuidle.h | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index 6175c77bf25e..2aa8cead1727 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -216,22 +216,26 @@ static inline struct cpuidle_device
> *cpuidle_get_device(void) {return NULL; }
> >  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                       struct cpuidle_device *dev,
> >                                       u64 latency_limit_ns);
> > -extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                               struct cpuidle_device *dev);
> >  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
> >  #else
> >  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                              struct cpuidle_device *dev,
> >                                              u64 latency_limit_ns)
> >  {return -ENODEV; }
> > -static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                                      struct cpuidle_device *dev)
> > -{return -ENODEV; }
> >  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
> >  {
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_SUSPEND
> > +extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > +                               struct cpuidle_device *dev);
> > +#else
> > +static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > +                                      struct cpuidle_device *dev)
> > +{return -ENODEV; }
> > +#endif
> > +
> >  /* kernel/sched/idle.c */
> >  extern void sched_idle_set_state(struct cpuidle_state *idle_state);
> >  extern void default_idle_call(void);
> > --
> > 2.17.1
> >

