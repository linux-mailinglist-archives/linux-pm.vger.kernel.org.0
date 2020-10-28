Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CB29D6D7
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgJ1WSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbgJ1WSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:18:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514A5C0613CF;
        Wed, 28 Oct 2020 15:18:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so680540wrp.10;
        Wed, 28 Oct 2020 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crsJn958YPx+DfiUeCUXF8zFkw8B7ZgM1ok7UnCgjBc=;
        b=SpU9X23c0TEXgzS51opwaIWf2xC0Vz5Mon/ZEP0E0lIupE5LmXZrhj7AOIdodA/mzF
         SPMP5bd+zN5zwp6EoeedpLXqljCllRH1ennrUZ1C1gIrcbywAcJDLtvAsvE7h6PwR9Ge
         HQKj+nRElMTqbeFrx2zkyvP/HGotboA9G3EV2fm61FDxdW224daICDMqU3YyN4uiZ2Qf
         qSvGnPqK6Xc+GZQx9O1oWc+ko4hUfTcYiu3KwHsGXuzXZt2pAJnLaRGNLEZ6C/cHruBz
         P/n3NREfc2KNd/zJeaJ11ebVmxIKxuLUz+1la0xdkxxDf3YzNzwUs7Qpoafwc2YAX4yU
         W13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crsJn958YPx+DfiUeCUXF8zFkw8B7ZgM1ok7UnCgjBc=;
        b=p4AJPLVbZlVOfXnkq8091Oj22pvoJ3niDzJD5TCC0mldMd6NnKRy5QiLkGbHp91Xch
         BKJe2hocoiGRYTfcMiOeefOGiRcu1cMWheWPK5C1sOsfC0Evk5U3JBb3ZNwtN8F/0kDV
         mzvkfTipVgm+Q8e5LxG4quIChCxK/eoJFKaIjBWvd02Jze3XWHDTkMPKH2fhDv88NZTL
         eSpZ6o9D00hM4EkNREHWTRnjAnZ2xdAp8F/VAMTxJWesyyYaBwREOuIDxuAvp2v87acc
         tvCd7bpoFbaUzTkmfOjrdAIGEHW77H2APJu2C3D+6xDLsng8S0r80/q8TJzjJIkprn8j
         haBg==
X-Gm-Message-State: AOAM531AX8kd5RIiHd/QErez3rtdMV71hWJ0rwOYVc9by+ymaGPagjUK
        XhBeniBZGf0qLqs0C/gkozMen/5LbqA1RsGSLmPNzcIL2wAnUQ==
X-Google-Smtp-Source: ABdhPJwoGVdRqfsqvWuWzdPRnNZe3lb2Vi57v7g4MvL1w570aMKiksqMTfhLx8AO2bJTRqclXeS9Facr25x2VLhnKkk=
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr6992083eji.400.1603882986071;
 Wed, 28 Oct 2020 04:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201012135517.19468-1-frank@allwinnertech.com>
 <20201012135517.19468-3-frank@allwinnertech.com> <20201028102942.zc5hgqpo2bfrn6in@vireshk-i7>
In-Reply-To: <20201028102942.zc5hgqpo2bfrn6in@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 28 Oct 2020 19:02:54 +0800
Message-ID: <CAEExFWvNgK2wbvmxZjsJR4g-VBq=ggsBLew77rzmNdkpqTRuDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] opp: Add devres wrapper for dev_pm_opp_set_prop_name
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        airlied@linux.ie, daniel@ffwll.ch,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        eric@anholt.net, kholk11@gmail.com, emil.velikov@collabora.com,
        gustavoars@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 6:29 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-10-20, 21:55, Frank Lee wrote:
> > From: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Add devres wrapper for dev_pm_opp_set_prop_name() to simplify driver
> > code.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > ---
> >  drivers/opp/core.c     | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  6 ++++++
> >  2 files changed, 45 insertions(+)
>
> On a second thought I am looking at dropping this one as you haven't
> added any users yet and I am afraid it will stay unused.

Now it looks like that dev_pm_opp_set_prop_name() is used relatively less.
Maybe we can wait until a caller, and then pick up the patch.

MBR,
Yangtao
