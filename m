Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903B1279CE3
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIZXlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIZXlz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2020 19:41:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D8C0613CE;
        Sat, 26 Sep 2020 16:41:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u8so6935468lff.1;
        Sat, 26 Sep 2020 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lgP48LmDi6OR55TkF8fuCZFClfYwvs7R4PpuOgG5rOo=;
        b=BMIuhpxy9MD5mQ4V49vciGHOcDWUM2qZo2fGc2jnthCCTB+vfK9Yb42Gc8K2EmFiRa
         iJozIDjoYKcXU8d5JwtodiwIG/Md4KmhSA+qRBvYWWR5l8XQ7G07O+pH+aQjWaq+Esew
         l0YMWqJjofUqzp7VmGZVIg9rfNmDACHjOxO/d4GRxhu962dxiivWi90HOWbdOf2VO/z0
         otpv2b27/C3v671FncQifBdp3bBVZ2uCoQB44/YXrKZocVlV5FoBoltu/jkHmO0Sj/K9
         67oJy/43pRSGdmSsLCW/h2kwMi8u+7OvHWQu7354jQDraZ7bNl9dfDcI3CKaRFhskREq
         yYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lgP48LmDi6OR55TkF8fuCZFClfYwvs7R4PpuOgG5rOo=;
        b=HiSdOVnAebHttvkfxgG91mYXdopnG7V49p08awlnk75pHD52nSMUgyztINZUMmVOFk
         ql1QkASQrCILvhOE7rAldIBFP8Yh4vfZh6We8Jf9y45MIgQrs7S/XwUNCv3T3h3cpKxh
         6x0bzTH1IDnBOemzjW4Frd1j54IpF3ihlUpv9D7XHuQW2SYOSdGFY2pfmJS/FRCT5/EX
         vi4qy61KYjFl1uUWQoZPrZX0JrYrU5S4bZ5SS2QF27N8JBfCuc07U04nn7/BpbbovUuL
         71qHzVrFcEqf3ybd/ju9KRDWIywxLduqqXAVZJCKKKisGybosO5ezkR7WtB4efZeBaqL
         Qq5g==
X-Gm-Message-State: AOAM533coaMROvDgnllJqyjJbKafXrIb0aCgXIqntrH9Y7h6fxlIPliM
        Cd7LuV4MoQMoeszOOjx75tRaHD58kxaFWKwYIF0=
X-Google-Smtp-Source: ABdhPJyi8Qg/4C/eCF2XezRHXtKYOEgyHWgsmnY7E7R1VZ2MKMvVQMATSNs2tYCCfBe8pPSJrUdwp/H8v0IG3Z4sDq4=
X-Received: by 2002:ac2:5458:: with SMTP id d24mr1572771lfn.446.1601163712190;
 Sat, 26 Sep 2020 16:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200924100342epcas1p42ad5d9bf5f2316f8c9e3909dfaa49a75@epcas1p4.samsung.com>
 <2dc9eeae-159e-c886-0278-f3c85d20bab5@samsung.com> <CAJZ5v0h3yLJjaxshWUdYAzGW2RhjWqeKv+iEumKQyOs16pc2oQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h3yLJjaxshWUdYAzGW2RhjWqeKv+iEumKQyOs16pc2oQ@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 27 Sep 2020 08:41:16 +0900
Message-ID: <CAGTfZH3u3i1V6UXmf0KvXwQ4=ytA7DPTdLKO3nnkKmbQ80kJyg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq fixes for v5.9-rc7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25, 2020 at 11:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 24, 2020 at 12:03 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> >
> > Dear Rafael,
> >
> > This is devfreq-next pull request for v5.9-rc7. I add detailed description of
> > this pull request on the following tag. Please pull devfreq with following updates.
> > - tag name : devfreq-fixes-for-5.9-rc7
>
> Pulled, thanks!
>
> I would appreciate receiving pull requests a bit earlier before the
> target -rc, though.

I'm sorry for late pull request for rc. I'll send pull request as you commented.

-- 
Best Regards,
Chanwoo Choi
