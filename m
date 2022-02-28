Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B34C71A6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Feb 2022 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiB1QYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 11:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiB1QYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 11:24:38 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C057B2E
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 08:23:59 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id m195so2864196vka.5
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV/Q71m/7bhKHZFWfYC4fBXKTsntI9VnZ49VMuwpGC8=;
        b=Hv1pjabYYUHR+Dqa+Cx/XQ97FkJIXUj8Q+Cpq5z7XN67k+XG3uteZujdENHqI8k9At
         cnGlQlOWgr3+IA/89hh5F3O03nAaDr+DvtzGs7b0hXNz3t6MIsxBB8wb6lrzF+QsxWka
         zfTIdOfxEAAKMsa0CV17ne/c4+fkfMfQ0A1n+OyFec5PJQLMdOQLIn4BGj7/oxSWBk7r
         ExuC36Fu4TXL9jliIDExN4JSrrVa2YJ48ASAcYS1ezA6dtjTYSKR/mzRdzrOwp1bgwne
         hbOojXXzV4+Dy/Q6c+8LqbwQfLfs8zRDk1/Z7YluFegCj8lQ36vnL2JLh8qXI2raiQ7/
         5fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV/Q71m/7bhKHZFWfYC4fBXKTsntI9VnZ49VMuwpGC8=;
        b=iA8kn6optbupJ6z8aXOlwbB9iJ5ve5KS3RwT9w2kS4i56MLXSxxWofs4TtKX1e14W3
         kN3t4ln08MN2065OC1iaCVmoNhNTxUDVfV0DwNno81KQ1je7NiX0PWrvPCczJfTLgpAi
         k/b5tB/ZevQj6bCNZhMR+fiooFPIVfPJkm6GiSPqAL+lmamKV53RIc2c6MxAqhImTmHw
         Bkr0X3cBfDRNTn9LXhz1ZXdMqqUqOV041bufLgRShFlznXfQYDH9VrgGmcQhvNqqMaQE
         BmZu71qA4rI9M3KxW9mS1Ma8Ruaf1WJgvIeykWQGFWn/IppCGATfQvEmvWK/UpKE9+fI
         Y4TA==
X-Gm-Message-State: AOAM531ZM+iYIEs1ImhzGAG3kKbL0ONMuR4OYFe+sjZUnbkk166OY3M0
        sUGcPesFJd9PrUmrjQL3WQIof4NVcXGJW4y+zME=
X-Google-Smtp-Source: ABdhPJy1LO2q9NnSS6AMNLxnAQ9bJJ5QOYuJEXZi5+uE0VMaFF5rtiMIz//S2gPFSx9k/dtvBVkwp2E8QL8Ff014R7E=
X-Received: by 2002:a1f:2189:0:b0:32d:2398:5262 with SMTP id
 h131-20020a1f2189000000b0032d23985262mr7744425vkh.8.1646065438618; Mon, 28
 Feb 2022 08:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20220210164756.3489848-1-massimiliano.minella@gmail.com> <aa780adc-78f2-98bc-16b2-e0a50d3f2bb6@linaro.org>
In-Reply-To: <aa780adc-78f2-98bc-16b2-e0a50d3f2bb6@linaro.org>
From:   Massimiliano Minella <massimiliano.minella@gmail.com>
Date:   Mon, 28 Feb 2022 17:23:47 +0100
Message-ID: <CAGS_c3Xo9ng9WVdi0J2X6yjM_3oRF9rANPxR7dwYz7ptppQCyA@mail.gmail.com>
Subject: Re: [PATCH] thermal: k3: Add hwmon support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,
thank you for the review.

On Fri, Feb 25, 2022 at 12:49 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 10/02/2022 17:47, Massimiliano Minella wrote:
...
> >               }
> > +
> > +             data[id].tzd->tzp->no_hwmon = false;
> > +             ret = thermal_add_hwmon_sysfs(data[id].tzd);
> > +             if (ret) {
> > +                     dev_err(dev, "thermal failed to add hwmon sysfs\n");
> > +                     goto err_alloc;
> > +             }
> > +
> > +             ret = devm_add_action_or_reset(dev,
> > +                                            k3_hwmon_action,
> > +                                            data[id].tzd);
> > +             if (ret)
> > +                     goto err_alloc;
>
> check out devm_thermal_add_hwmon_sysfs

I've tried to use the devm_thermal_add_hwmon_sysfs but it is not working as I
would have expected: if the driver is built as a module, when the module is
removed the devm_thermal_hwmon_release never gets called.

As a consequence each time the insmod/rmmod sequence is repeated, for every
thermal zone, new temp<N>_crit and temp<N>_input entries appear in the hwmon
sysfs.

Is it a known bug/limitation?

I'm going to have a look at this behavior, so any hint would be appreciated.

In the meantime I can provide V2 of the patch if the described behavior is
acceptable.

Thanks,
Massimiliano
