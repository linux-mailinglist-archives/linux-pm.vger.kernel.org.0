Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96610567433
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiGEQ1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiGEQ1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 12:27:09 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6A938B5
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 09:27:07 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l7so14431224ljj.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCmdLvD+CZhBNcXAmnKE1PV+rsjhI0sGwhqQ2SS/Z9g=;
        b=bbYk8sexBJXDdnRmBs3GnMLPvXkXi3efBVHbNjp5clK7mP+UNoHVmwcbRFZfYmeK//
         zIBgWFV4SN2TUcNDS/nuXGzN5fVZMeJMDL0e7pn+AXIQ9BF7mxcm1wWfWeFHoQbuJhgF
         DXNmQhY4QtCAw7RN+UYSQYQ9iMnVylU/cn9vNhnkoPYwG3wrOTMWpEZdWSrAtHdWaRNT
         gI7kO6xtC4zWYacQWUm4ggqwhiSujfzg3HdipUDXaP23hGgFb3Y1HqBMaXS9/m0Sa/SE
         2tmbMSimITwB2PEe72DMkzEpxh3OVA7HGjA3eFVzXlR/PTQX1ETQEwx9Y8wMCPyHARu2
         +avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCmdLvD+CZhBNcXAmnKE1PV+rsjhI0sGwhqQ2SS/Z9g=;
        b=hrxXJLsBGczSGsSS2N+i/2woUGA0C1nxSwBXhoRyx2r17ReMFcvBe0FJdugzOqwqnx
         +yukMNQkpk87gmIGpPaPuoq605brsbx2Jf8hPi1OJWWKZPBngp9CdKAj5GEihhFnvBn/
         MGCAi5FbWk0TB0qbekNP9OsXYibS9srrhevBO4ZOoYWPjO8j2A2ABmsYxHgNrnCG6y0h
         YvcxTxyHAvLB0W5xwXfnxTCD9CbTf2Eh0olMAttitkPuNRpWkBZYYBvT16LjQokma+B2
         G2QxgjAB/u5vfoOpszN2dDzezTbzfoP6s3pcGK4U9CF64oIfFnJtedqCXqPCzs2GK7+k
         ASMA==
X-Gm-Message-State: AJIora+pHbeWvSRns++XVzZ3pmjQC03RfdLa2zds8CCrZZyLrIQeZ/T9
        hJH9QjaTNwLHVmg4uVA/Qphh0150Bv0EQMIZWMfS9A==
X-Google-Smtp-Source: AGRyM1tykMb5FVYbgYlG+bBdLLTs/soofIBDzbtWccD9fY0BHu4+OiU0KpC+/bbAJvCupXk5dhLF/BbHYA5+1aKhD0A=
X-Received: by 2002:a05:651c:179a:b0:247:d37b:6ec5 with SMTP id
 bn26-20020a05651c179a00b00247d37b6ec5mr156963ljb.112.1657038425820; Tue, 05
 Jul 2022 09:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-6-daniel.lezcano@linexp.org> <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
 <e2d81210-a969-fe9d-a4fb-1826c991fbce@linexp.org>
In-Reply-To: <e2d81210-a969-fe9d-a4fb-1826c991fbce@linexp.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 5 Jul 2022 09:26:54 -0700
Message-ID: <CAHRSSEy7dU_x=1i5HiOfLOJ7_ZoR0m+9LM6RHDdhNNhfjDW+xA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
To:     daniel.lezcano@linexp.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Wei Wang <wvw@google.com>,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 4, 2022 at 2:14 PM Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
>
> On 04/07/2022 09:35, Lukasz Luba wrote:
> > Hi Daniel,
> >
> > (+Todd and Wei on CC)
> >
> >
> > On 7/3/22 19:30, Daniel Lezcano wrote:
>
> [ ... ]
>
> >>   }
> >> -EXPORT_SYMBOL(get_tz_trend);
>
> [ ... ]
>
> >>   }
> >> -EXPORT_SYMBOL(thermal_cdev_update);
> >
> > I wouldn't remove that export. I can see in my Pixel6 modules dir, that
> > it's called in 7 places.
> >
> > I assume that in Android world this is common use.
>
> It is not possible to do changes taking into consideration out of tree
> code. Moreover there is logically no good reason to use the
> thermal_cdev_update() function from outside of the thermal core code.
>

I agree. It is totally appropriate for the export to be removed for
these functions if the exports are only for out of tree code. If they
are needed for Android, they can be carried in the Android kernel
trees.
