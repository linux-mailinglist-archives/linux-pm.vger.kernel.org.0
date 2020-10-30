Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E82A03F2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3LTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgJ3LTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 07:19:14 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6242C0613D2;
        Fri, 30 Oct 2020 04:19:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a71so864660edf.9;
        Fri, 30 Oct 2020 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Bio/v4ZtLiE540NPLGsg4zm25sQfEKR1TzDT+ehFjU=;
        b=QCqN2JeZ6j0DKHQQS+CXVkzwXNCyGppBlDRFLsJCyR2l9dE5eFsvnEHprWAVITNHe/
         b50Q3kEgVDD6NwuI5vvun1/5aoLMKNHH51y7ZLfS1xhQ+D37ky96V5fQeosYD+GWrICj
         d+CCE0RDtC32PSHk2wOC8lPM8MrktC1Cp8yLSN+NrL3hmuUwEC8jVFDPyQ0jwl4gfFV4
         I5cpmUk1hOO+SkpJ7HNfSnGq1yy7UY3H5jYdk/NX4TlFhvKX1Z9d9Oxj+o3gf8WH20XY
         uey60IW6twCqrClT/hVDpxRC10ZVYHM1axzHd4hPxiMUQ17T/vSBCFEkC8Wd3M0WaUIv
         8NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Bio/v4ZtLiE540NPLGsg4zm25sQfEKR1TzDT+ehFjU=;
        b=XTj+F/KfBk2jLyuY/uBOYmPTJgVRDZZafQ2BqzkMF7B9dd3R18cnf17ubwEtG9Knjl
         3tqe6/W448tDCpgOlKy1J7ASpCIEYwYmfCw+wWMQQvC/cKOeXLjapKV3V6p+CP8qgQZT
         8MluHu2K3NiUkUjmSI8kPQqC8a+a2sRL9ApCaDh+1tSewH1ziG2Dq5nleLv9Y8SN9tfo
         KAAeHGc6r5DSlKz6Ep4qz1ym71jezqibERtzlEq0IDSzTXGY4VDmLhWCpJMe4xHKvDmX
         ADV/aZy9VVFi3HZy5aVHngn04iB+rIz6RlECw+oJ4faxztnnEB8xMjeCaB6LugPien4n
         DFNw==
X-Gm-Message-State: AOAM531w8uUUlgoon9EFjraHkQ9XTJSpbKTKIyYuzNYOl7mI1O79rTP1
        Yr1sTs4KudBjv/tGD7l3MowOMMJxz9nNq79+NSefMAoplwIRKQ==
X-Google-Smtp-Source: ABdhPJwvqEm5pZuWmeOrmp8SDuL5ILCfj40cZZI7zsZuebllxG6q1P0isA2txHkQgJiWvHzXhJYWWc31Zq+h4UhXDNA=
X-Received: by 2002:a50:9e82:: with SMTP id a2mr1681188edf.117.1604056752432;
 Fri, 30 Oct 2020 04:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201012135517.19468-1-frank@allwinnertech.com>
 <20201012135517.19468-3-frank@allwinnertech.com> <20201028102942.zc5hgqpo2bfrn6in@vireshk-i7>
 <CAEExFWvNgK2wbvmxZjsJR4g-VBq=ggsBLew77rzmNdkpqTRuDA@mail.gmail.com> <20201028144628.qm2t2hbzmouqkciy@vireshk-i7>
In-Reply-To: <20201028144628.qm2t2hbzmouqkciy@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 30 Oct 2020 19:19:00 +0800
Message-ID: <CAEExFWtYrT3psuLC0fd7cX2GrmPaYxqZK65OLUv+2s97ehz97g@mail.gmail.com>
Subject: Re: [PATCH 2/3] opp: Add devres wrapper for dev_pm_opp_set_prop_name
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        eric@anholt.net, kholk11@gmail.com, emil.velikov@collabora.com,
        gustavoars@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 10:46 PM Viresh Kumar <viresh.kumar@linaro.org> wro=
te:
>
> On 28-10-20, 19:02, Frank Lee wrote:
> > On Wed, Oct 28, 2020 at 6:29 PM Viresh Kumar <viresh.kumar@linaro.org> =
wrote:
> > >
> > > On 12-10-20, 21:55, Frank Lee wrote:
> > > > From: Yangtao Li <tiny.windzz@gmail.com>
> > > >
> > > > Add devres wrapper for dev_pm_opp_set_prop_name() to simplify drive=
r
> > > > code.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > > ---
> > > >  drivers/opp/core.c     | 39 ++++++++++++++++++++++++++++++++++++++=
+
> > > >  include/linux/pm_opp.h |  6 ++++++
> > > >  2 files changed, 45 insertions(+)
> > >
> > > On a second thought I am looking at dropping this one as you haven't
> > > added any users yet and I am afraid it will stay unused.
> >
> > Now it looks like that dev_pm_opp_set_prop_name() is used relatively le=
ss.
> > Maybe we can wait until a caller, and then pick up the patch.
>
> I am even wondering if we should be adding any of the devm_* helpers
> for now to be honest. Even for the other one we have only one user.
> Them major user of the OPP core is the CPU subsystem and it is never
> going to use these devm_* helpers as the CPU device doesn't get bound
> to a driver, it is rather a fake platform device which gets the
> cpufreq drivers probed. So the only users of these devm_* helpers is
> going to be non-CPU devices. Considering that we have only one user
> right now, it may be better to just fix it instead of adding any of
> the devm_* helpers.

GPU is also a relatively large number of opp consumers.
Most of the time, the dev_pm_opp_set_* functions will only be set once.
If don't need the driver to dynamically manage and release the opp, it
may be OK=EF=BC=9F

Yangtao
