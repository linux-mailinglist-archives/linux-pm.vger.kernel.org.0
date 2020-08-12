Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9172426A9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHLIWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgHLIWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 04:22:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31AC061787
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:22:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so2622626pjn.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Qt2PjikeIkI2EUX4ADEcXn16jTvw0LsjlGfLtlN38oE=;
        b=F038C5a+nLvJOfAonRrqZA0FIkVAhCSoLb2/qlDVx5+e7m6jSFI+IRIAk71igRv6VC
         iv1dtE8ZfnqpA2aqjolHpYjxJ7laKe1EDMvbqz1d/jOyTSrGQRAktKXnb2ca86SL3w8w
         BdNiVpzce1xc8tt46zlmoSpB/BdiN8H0f1TiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Qt2PjikeIkI2EUX4ADEcXn16jTvw0LsjlGfLtlN38oE=;
        b=B6ZCg721XIZJblUtMs5in+i9tOzzScuk1hoG6n8maSOGVlIEXWH6YuzTXdOBj0Tghw
         FpkWsXghd/Mzf5H1anxFd9+U0StgxjoXziI+z1YsNxjoi34b/bAEt2VXEunL/aYiS/Jx
         h0DN5rQt1TTocDUalbu6sAO71pXklhs29NHfSFnS1qqZC8Ey/SMyf/mswAh4UqbIRU5/
         Yf8aLm1n3oY+T6ZkjWkjd8amAJ+vIYZ5yeNNSqG5pIBLlLXz0cR6ijpHCmHbybKLGml3
         dQZB5cjOwcOaHSuJM4shKkKWbrQJ66U3l1zmzhnLzpsers78aqUYLFBqKFzEoBNrkccB
         A3Mg==
X-Gm-Message-State: AOAM531Of9YRz1Mk00wxGsT8gS5SC8jXCdRyn5TXjIN8DosvMxsgtoav
        mPFfQW7pF85IdQMCBu20XKAGDQ==
X-Google-Smtp-Source: ABdhPJxUu7oGLLG5+Yc0JrlYpmac2lDJvq+Yfl+8kSn6NlG+H76p87SJVx3Xmg+Duprs/I1Obmm+Fw==
X-Received: by 2002:a17:90a:80c4:: with SMTP id k4mr4808663pjw.222.1597220529963;
        Wed, 12 Aug 2020 01:22:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 144sm1498207pfu.114.2020.08.12.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:22:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200812082013.64xc6hmt4nchcmab@vireshk-mac-ubuntu>
References: <20200811212836.2531613-1-swboyd@chromium.org> <20200812082013.64xc6hmt4nchcmab@vireshk-mac-ubuntu>
Subject: Re: [PATCH] OPP: Put opp table in dev_pm_opp_set_rate() all the time
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 12 Aug 2020 01:22:08 -0700
Message-ID: <159722052820.33733.14125029118837266849@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2020-08-12 01:20:13)
> On 11-08-20, 14:28, Stephen Boyd wrote:
> > @@ -905,7 +907,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigne=
d long target_freq)
> > =20
> >               ret =3D _set_opp_bw(opp_table, NULL, dev, true);
> >               if (ret)
> > -                     return ret;
> > +                     goto put_opp_table;
>=20
> This was broken by a different patch.
>=20
> Fixes: b00e667a6d8b ("opp: Remove bandwidth votes when target_freq is zer=
o")
>=20
> I did split the patch into two and applied the correct tags (not yet
> pushed though).

Ok, makes sense. Thanks!
