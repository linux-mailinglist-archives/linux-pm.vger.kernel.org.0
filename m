Return-Path: <linux-pm+bounces-12378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26669554ED
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 04:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796CA284177
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2024 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4211713;
	Sat, 17 Aug 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FJs1vkA1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F14653A;
	Sat, 17 Aug 2024 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723862539; cv=none; b=jsKh31r3HanbGCfD/om6JZX4DzWS9aO/A+t74cq3nLCJKyX1BJr9HATLA0pupV/gubDQWw6vXwhDruCX262N7WGvb0IoJlnXELlvVMZT/GtmSdrFevGzJGI8iXIB/2WKim14dXDMON+jyACZCJnwElcJ4vE4CaffJs3iU1z3ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723862539; c=relaxed/simple;
	bh=C286EmAyP/FNAORtOpe5XqhVBh9YZxbtRsVtQFWHtY4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CBGfplwC8UTzYsUD54bi8cyA6aONzkNk3KHx9TAAUPhXKWo3HwxFdCvQbXCCD+yUn9rtjLaT/gBXJSU9gK6RN1JuwcTctNK5ncNmitaUR3x0XB5l6AKEL/h9+qoeWUQuofI1WIUwJazmOLgvAPYvAd+JT5Rj6mO6/bJhDkblCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FJs1vkA1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723862526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3PBtFS4FGd7SCAA1CPDEsl/8k7nrplme33HqFORp+I=;
	b=FJs1vkA1ZlGCNKZAgEddbKLErQb+R2TpueJ69yhDSU/8qvqN6yc+rb9cvSRe+hGqQIogQL
	C531SWWND+q9RZL08oOSEFLg1y1KDiqUv1XmBJk5tftvbhaq5At+MhZ/pF9+Jykv3EsRKB
	p/KusXYhHVegnH+HI86MJWEUgi3DVGiI1YuTNgwUqfpOB3z0OuaVi1zj6fGS9VJVbSFM+3
	RoCW1WPhJLbqPdoivlBRqSWHRjzC3ZiWFuhbo3uvhW0QLE8NOZcE+MEVYClMOK9wlbiPc1
	NDnCFAukjD7cI8cA+oRLGoNp0pmRfRoeKhwX4lAd/IV4djT90xKhpcfUEDgvzA==
Date: Sat, 17 Aug 2024 04:42:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Icenowy Zheng
 <uwu@icenowy.me>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Pra?=
 =?UTF-8?Q?do?= <nfraprado@collabora.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Hsin-Te Yuan
 <yuanhsinte@chromium.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] thermal/of: support thermal zones w/o trips subnode
In-Reply-To: <CAGXv+5GQixa389nudKk=U3Rh2jN8VuWQGKb9rsixhvj3KGFQDg@mail.gmail.com>
References: <20240809070822.2835371-1-wenst@chromium.org>
 <b00273d65dfc4b48cca474784184c62b@manjaro.org>
 <CAGXv+5ERoH=jQGzo=mo2K-r3Meh2-5Kgvjf9Eh7bfNgcQYfWoA@mail.gmail.com>
 <CAGXv+5GQixa389nudKk=U3Rh2jN8VuWQGKb9rsixhvj3KGFQDg@mail.gmail.com>
Message-ID: <35a2ef84aaa9f650bd63bfc25e336ef3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-08-15 06:45, Chen-Yu Tsai wrote:
> On Mon, Aug 12, 2024 at 12:46 PM Chen-Yu Tsai <wenst@chromium.org> 
> wrote:
>> 
>> On Mon, Aug 12, 2024 at 9:22 AM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>> >
>> > Hello Chen-Yu,
>> >
>> > Thanks for the patch.  Please see one comment below.
>> >
>> > On 2024-08-09 09:08, Chen-Yu Tsai wrote:
>> > > From: Icenowy Zheng <uwu@icenowy.me>
>> > >
>> > > Although the current device tree binding of thermal zones require the
>> > > trips subnode, the binding in kernel v5.15 does not require it, and
>> > > many
>> > > device trees shipped with the kernel, for example,
>> > > allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64,
>> > > still
>> > > comply to the old binding and contain no trips subnode.
>> > >
>> > > Allow the code to successfully register thermal zones w/o trips subnode
>> > > for DT binding compatibility now.
>> > >
>> > > Furtherly, the inconsistency between DTs and bindings should be
>> > > resolved
>> > > by either adding empty trips subnode or dropping the trips subnode
>> > > requirement.
>> > >
>> > > Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
>> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>> > > Reviewed-by: Mark Brown <broonie@kernel.org>
>> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> > > ---
>> > > Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.
>> > >
>> > > Changes since v1:
>> > > - set *ntrips at beginning of thermal_of_trips_init()
>> > > - Keep goto out_of_node_put in of_get_child_count(trips) == 0 branch
>> > > - Check return value of thermal_of_trips_init(), if it is -ENXIO, print
>> > >   warning and clear |trips| pointer
>> > > - Drop |mask| change, as the variable was removed
>> > >
>> > > I kept Mark's reviewed-by since the changes are more stylish than
>> > > functional.
>> > > ---
>> > >  drivers/thermal/thermal_of.c | 19 ++++++++++++-------
>> > >  1 file changed, 12 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/drivers/thermal/thermal_of.c
>> > > b/drivers/thermal/thermal_of.c
>> > > index aa34b6e82e26..f237e74c92fc 100644
>> > > --- a/drivers/thermal/thermal_of.c
>> > > +++ b/drivers/thermal/thermal_of.c
>> > > @@ -128,16 +128,17 @@ static struct thermal_trip
>> > > *thermal_of_trips_init(struct device_node *np, int *n
>> > >       struct device_node *trips, *trip;
>> > >       int ret, count;
>> > >
>> > > +     *ntrips = 0;
>> > >       trips = of_get_child_by_name(np, "trips");
>> > >       if (!trips) {
>> > > -             pr_err("Failed to find 'trips' node\n");
>> > > -             return ERR_PTR(-EINVAL);
>> > > +             pr_debug("Failed to find 'trips' node\n");
>> > > +             return ERR_PTR(-ENXIO);
>> > >       }
>> > >
>> > >       count = of_get_child_count(trips);
>> > >       if (!count) {
>> > > -             pr_err("No trip point defined\n");
>> > > -             ret = -EINVAL;
>> > > +             pr_debug("No trip point defined\n");
>> > > +             ret = -ENXIO;
>> > >               goto out_of_node_put;
>> > >       }
>> > >
>> > > @@ -162,7 +163,6 @@ static struct thermal_trip
>> > > *thermal_of_trips_init(struct device_node *np, int *n
>> > >
>> > >  out_kfree:
>> > >       kfree(tt);
>> > > -     *ntrips = 0;
>> > >  out_of_node_put:
>> > >       of_node_put(trips);
>> >
>> > It might be a bit cleaner to keep the "*ntrips = 0" assignment
>> > in the error handling path(s) only, with the positions of the goto
>> > labels adjusted a bit, and then assign -ENXIO to "ret" and jump
>> > to the right label when of_get_child_by_name(np, "trips") fails,
>> > instead of returning from there.
>> >
>> > If it's unclear what I'm talking about, please let me know and
>> > I'll send back the proposed hunk.
>> 
>> I think I understand: move "*ntrips = 0" to after of_node_put() in the
>> error path, and have the "!trips" branch jump to "out_of_node_put" as
>> well. That works since of_node_put() checks the pointer first.
>> 
>> I'll wait a bit and see if there are any more comments.
> 
> Actually, Krzysztof (+CC) is cleaning up this function using scoped
> variables. So it might actually make more sense to move "*ntrips = 0"
> to the top once the error path is completely removed.

I see, it would make sense to move "*ntrips = 0" to the top, but what
bugs me with that approach a bit is that we's still have another 
instance
of "*ntrips = 0" in the error paths.  Thus, it might be cleaner to have
only one instance of "*ntrips = 0", in the error paths, and use "ret = 
..."
plus "goto ..." pairs instead of single "return ..." statements.

That way, we'd keep "*ntrips = 0" in the error pathso only, which would
clearly show that's part of the error handling only.  Though, I'd be 
also
fine with moving "*ntrips = 0" to the top, if you find that cleaner.

>> > > @@ -490,8 +490,13 @@ static struct thermal_zone_device
>> > > *thermal_of_zone_register(struct device_node *
>> > >
>> > >       trips = thermal_of_trips_init(np, &ntrips);
>> > >       if (IS_ERR(trips)) {
>> > > -             pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> > > -             return ERR_CAST(trips);
>> > > +             if (PTR_ERR(trips) != -ENXIO) {
>> > > +                     pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> > > +                     return ERR_CAST(trips);
>> > > +             }
>> > > +
>> > > +             pr_warn("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> > > +             trips = NULL;
>> > >       }
>> > >
>> > >       ret = thermal_of_monitor_init(np, &delay, &pdelay);

