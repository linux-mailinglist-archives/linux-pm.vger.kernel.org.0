Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731626D7EDC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Apr 2023 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjDEOMb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Apr 2023 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjDEOM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2023 10:12:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE686187
        for <linux-pm@vger.kernel.org>; Wed,  5 Apr 2023 07:11:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545cb3c9898so603956327b3.7
        for <linux-pm@vger.kernel.org>; Wed, 05 Apr 2023 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680703915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMf3CEm47nTLug6fCPtN+WxmLwlongS4K4cghIdEwTU=;
        b=b2+D20d+G3y26sJt0PGAqN2BwPks7gQqkoFULGuxRE92c66/T8BoUIIZsvO/x2OWF9
         ULoCwNY6uCF9YDTaNjV5EbaWg6yjghvOKu+xCeB73pXQmXaCmSp2cnsYUZ22R69fni32
         tY+D4WAb0Lc3TtW+qk0Tam+O8p1h3eWpEQw0yvNZKXM7rZtHXsoKRu9oHiI7PwXWBgZH
         /s/7SggpWitW+kAqzqtNCtao2mI8DVZXM/Cqhn97f/0436Qiga2MD2M/xiZnQNbBIYLS
         OQFJ8iTfybzfaBbK/qOkgKogYYi8J1Y21p/48dTudnw8zPhBNbl33Cqin6/wkmP1dMpb
         SVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMf3CEm47nTLug6fCPtN+WxmLwlongS4K4cghIdEwTU=;
        b=5hVv6sR9fy2WGceyMvv37hvZPsWaTxw+dF/DBV18aC0Y9Xl0cmUdyYA6ainv7dzVlD
         0EmWIU2/jS4gFFA6+v5sOKpJTBPbTli3z1AX2gkuTzo7fp0XcQPaetBjACF2wuwYZ4b4
         wKGtw0YnN4NQi3ZqKnmQQ5YnlL1yJuMtqVZvNKGqbGbSjGpO08QX0vBiXGBIs8/p4RQE
         +jmONMUZokj2EcdxRo0AbmgatD4/vEltdeOulVvxAjhCSt9bC3lrTSZAxcjREimQ7EID
         UeJmsIZbltB9GLlA19Xfbmv8C1kYjGstCaR1L3PSXxHXEbFkyxoXO2+YLYomK+X79/rP
         GBMw==
X-Gm-Message-State: AAQBX9eeGL7+3s1LPIEOJWh7wSIg/1klvjPa4IzyQEXJ9o3A0JFhnbyC
        NCUDMSD2ipYmJ2nGpc2g6y80Bwmn5V3kG8/sBtQonQ==
X-Google-Smtp-Source: AKy350YIM3whqkVRkgoliO4ELqOTHysvMP2mHMSt3HJC9fOJRdlX3dZXSC6LOSHQXd5zBwLeL+SU3/ZlW/2/8tJ+/Lw=
X-Received: by 2002:a81:c509:0:b0:549:143f:3d3 with SMTP id
 k9-20020a81c509000000b00549143f03d3mr3685321ywi.0.1680703914860; Wed, 05 Apr
 2023 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
 <ZCVyBuKMvDV0gQPW@linaro.org> <CAGETcx-mxzzZ_FU6Agju9gMhFOEDhY6Rj78BnvAVJjNtZhif=w@mail.gmail.com>
 <ZCZolyDL/awnt73K@linaro.org>
In-Reply-To: <ZCZolyDL/awnt73K@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Apr 2023 16:11:18 +0200
Message-ID: <CAPDyKFprQwBfya-TpaVJfn82LgM9N_iE8npO9r-HzAyJXpb-hQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on sync state
To:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Abel, Saravana,

On Fri, 31 Mar 2023 at 06:59, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 23-03-30 12:50:44, Saravana Kannan wrote:
> > On Thu, Mar 30, 2023 at 4:27=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org=
> wrote:
> > >
> > > On 23-03-27 17:17:28, Saravana Kannan wrote:
> > > > On Mon, Mar 27, 2023 at 12:38=E2=80=AFPM Abel Vesa <abel.vesa@linar=
o.org> wrote:
> > > > >
> > > > > There have been already a couple of tries to make the genpd "disa=
ble
> > > > > unused" late initcall skip the powering off of domains that might=
 be
> > > > > needed until later on (i.e. until some consumer probes). The conc=
lusion
> > > > > was that the provider could return -EBUSY from the power_off call=
back
> > > > > until the provider's sync state has been reached. This patch seri=
es tries
> > > > > to provide a proof-of-concept that is working on Qualcomm platfor=
ms.
> > > >
> > > > I'm giving my thoughts in the cover letter instead of spreading it
> > > > around all the patches so that there's context between the comments=
.
> > > >
> > > > 1) Why can't all the logic in this patch series be implemented at t=
he
> > > > framework level? And then allow the drivers to opt into this behavi=
or
> > > > by setting the sync_state() callback.
> > > >
> > > > That way, you can land it only for QC drivers by setting up
> > > > sync_state() callback only for QC drivers, but actually have the sa=
me
> > > > code function correctly for non-QC drivers too. And then once we ha=
ve
> > > > this functionality working properly for QC drivers for one kernel
> > > > version (or two), we'll just have the framework set the device's
> > > > driver's sync_state() if it doesn't have one already.
> > >
> > > I think Ulf has already NACK'ed that approach here:
> > > [1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir=
-G+GoxkCvpN=3DiiA@mail.gmail.com/
> >
> > I would have NACK'ed that too because that's an incomplete fix. As I
> > said further below, the fix needs to be at the aggregation level where
> > you aggregate all the current consumer requests. In there, you need to
> > add in the "state at boot" input that gets cleared out after a
> > sync_state() call is received for that power domain.
> >
>
> So, just to make sure I understand your point. You would rather have the
> genpd_power_off check if 'state at boot' is 'on' and return busy and
> then clear then, via a generic genpd sync state you would mark 'state at
> boot' as 'off' and queue up a power off request for each PD from there.
> And as for 'state at boot' it would check the enable bit through
> provider.
>
> Am I right so far?

I am not sure I completely follow what you are suggesting here.

Although, let me point out that there is no requirement from the genpd
API point of view, that the provider needs to be a driver. This means
that the sync_state callback may not even be applicable for all genpd
providers.

In other words, it looks to me that we may need some new genpd helper
functions, no matter what. More importantly, it looks like we need an
opt-in behaviour, unless we can figure out a common way for genpd to
understand whether the sync_state thing is going to be applicable or
not. Maybe Saravana has some ideas around this?

Note that, I don't object to extending genpd to be more clever and to
share common code, of course. We could, for example, make
genpd_power_off() to bail out earlier, rather than calling the
->power_off() callback and waiting for it to return -EBUSY. Both of
you have pointed this out to me, in some of the earlier
replies/discussions too.

>
> > > And suggested this new approach that this patch series proposes.
> > > (Unless I missunderstood his point)
> > >
> > > >
> > > > 2) sync_state() is not just about power on/off. It's also about the
> > > > power domain level. Can you handle that too please?
> > >
> > > Well, this patchset only tries to delay the disabling of unused power
> > > domains until all consumers have had a chance to probe. So we use syn=
c
> > > state only to queue up a power-off request to make sure those unused
> > > ones get disabled.
> >
> > Sure, but the design is completely unusable for a more complete
> > sync_state() behavior. I'm okay if you want to improve the
> > sync_state() behavior in layers, but don't do it in a way where the
> > current design will definitely not work for what you want to add in
> > the future.
>
> But you would still be OK with the qcom_cc sync state wrapper, I guess,
> right? Your concern is only about the sync state callback being not
> genpd generic one, AFAIU.
>
> >
> > > >
> > > > 3) In your GDSC drivers, it's not clear to me if you are preventing
> > > > power off until sync_state() only for GDSCs that were already on at
> > > > boot. So if an off-at-boot GDSC gets turned on, and then you attemp=
t
> > > > to turn it off before all its consumers have probed, it'll fail to
> > > > power it off even though that wasn't necessary?
> > >
> > > I think we can circumvent looking at a GDSC by knowing it there was e=
ver
> > > a power on request since boot. I'll try to come up with something in =
the
> > > new version.
> >
> > Please no. There's nothing wrong with reading the GDSC values. Please
> > read them and don't turn on GDSC's that weren't on at boot.
>
> Sorry for the typos above, I basically said that for this concern of
> yours, we can add the 'state at boot' thing you mentioned above by
> looking at the GDSC (as in reading reg).
>
> >
> > Otherwise you are making it a hassle for the case where there is a
> > consumer without a driver for a GDSC that was off at boot. You are now
> > forcing the use of timeouts or writing to state_synced file. Those
> > should be absolute last resorts, but you are making that a requirement
> > with your current implementation. If you implement it correctly by
> > reading the GDSC register, things will "just work". And it's not even
> > hard to do.
> >
> > NACK'ed until this is handled correctly.
> >
> > >
> > > >
> > > > 4) The returning -EBUSY when a power off is attempted seems to be
> > > > quite wasteful. The framework will go through the whole sequence of
> > > > trying to power down, send the notifications and then fail and then
> > > > send the undo notifications. Combined with point (2) I think this c=
an
> > > > be handled better at the aggregation level in the framework to avoi=
d
> > > > even going that far into the power off sequence.
> > >
> > > Again, have a look at [1] (above).
> >
> > See my reply above. If you do it properly at the framework level, this
> > can be done in a clean way and will work for all power domains.
> >
> > -Saravana
> >
> > >
> > > Ulf, any thoughts on this 4th point?

Please, see my reply above.

[...]

Kind regards
Uffe
