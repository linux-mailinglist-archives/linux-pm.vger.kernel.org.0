Return-Path: <linux-pm+bounces-3235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B404F84704E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D863C1C21697
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9EC145332;
	Fri,  2 Feb 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3P3q7PM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8614462D
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877023; cv=none; b=txR8XuTTCWqQTcq2VpHBT+35TdJeY8iR0baj7p28H6EmdMPpufKmF8n4Y9ykMCQB/GM2UrpIicK/ODK+93QIEVyrieiaQiAoKw32dM5xacstO9jlfuD8zDc5lvEqC5li5iiHEoho6Fj1w9o5KjY8ENHbykHqGmE3MkTRthgACJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877023; c=relaxed/simple;
	bh=IGI9/dQV3qGBVH5j2vJp9yftTikrYa+t8RlZXVoJbpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTfMTEXmR7nx1ZdxkByoANCcdvVfvZK4FnRSX/QBTGRtZ/2WFc6WycX6m2pIRmEJL1REtraPDRsS7ZYQotPHW0Atjds9rSO9cDPzB5YJg1nDX7xx4S5tRjHmcMXNCnEhgAjjJexCO6Z+Yd14SekDCIGJ3Xj5tv1TplWGKJiuLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j3P3q7PM; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60412866c36so20612517b3.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2024 04:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706877020; x=1707481820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8oOpYwr9iTQslYutTkqU0qxshC1/W4QlmLIOUl40bM=;
        b=j3P3q7PMRtEF//DUJSJAzp+q30tS7/3EAyFxKYJoBQ6DJBoU3f3y4Ox3fOvvMxEPps
         o+OAQWjgGd8FDMiNhHIIVHaifSCi5+KmGXoVVELn72zmCcbD0b0UKo1BWEkokh7cB2tY
         sepVIuuXtzUDR18Zmk8pCsQw7ATmexdkQfrD7eY0tx3WpXGNnHQfXN+IQOqn1vvVxlv7
         V439fOeRn9wP+beqbNmfsLHq8hKEbCd8FKcYYn9eYknBPCIL7/Z63TNfCk4RpTOjBTyo
         jPUOTAHYvZPUPgXB+Oj8ja57B1E3WhMgfvVtIRnn5zaFyo5IlbkcA9CjetF7DMsP38HJ
         PusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877020; x=1707481820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8oOpYwr9iTQslYutTkqU0qxshC1/W4QlmLIOUl40bM=;
        b=LbEElf+7CUTvIIQIzU7I3veyIRFriuiJ8VcCc254NH4F3p/BUO5h7lSKfABgGF77Zt
         1R49kVApaWV3rbpW3lyJBB5/rrnXqvf5G2wsprLGN/ySBKjUcbF9uicePqH+VKJNf7RO
         9de7zNoR5uWDT5iT8N42aZ9fjPLCMPJLDHaGaR4Havh1F0ZT1vDTMydqbM9AnzTMlDoV
         m5QXgCMwDpf/qpnbjemqlYTvpEbyg7Bo7w165aEBkJ2XY+RxgYDOHxX+rBETEOV8TWCZ
         PrQ7TI1e/oIj+eY7jIf17TQ6Rslk+keNrsWTiQfRw9gcp5vYHDuUPapKjgoIwMP0CYdo
         JSQg==
X-Gm-Message-State: AOJu0Yz759qyUeQa7n2OZxcUQN6nX5iGnAo2aa+xL7HmyJ0XUjOMbRkA
	PNghTQ5KWc0KTsFgXL0SDwxLds+m4Ls7/HKP/q0cZ4u8SAxjNPLLtzS4YpxpIb9Aj91OiLMtx4w
	F86UZigbCs4lfZAC0qdXP0AowavaPcQUXSI8xUg==
X-Google-Smtp-Source: AGHT+IETPsoeVpj0fMEFsGC6sNVxTsee80Br4NXMlKwi1BUq1xFrUlkgkaLYgBcbwbf7U/G9cwauAMTlt8UuJHRtKp0=
X-Received: by 2002:a0d:ddcc:0:b0:5ff:58f1:9944 with SMTP id
 g195-20020a0dddcc000000b005ff58f19944mr2068910ywe.30.1706877020693; Fri, 02
 Feb 2024 04:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org> <tax3c6o5qjegy6tv3zbgrd5rencfvypr3zg7twxfrmdngscp74@n44ei3q63g64>
 <CAPDyKFpdtrWbzNksLoY++aOY7Ltyt1HhtLZo8bj8sQ05-4Sq0g@mail.gmail.com> <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
In-Reply-To: <l7icfezpajren25545n4cjtqehhividt5b2dxnxgetdsshc3k3@tdws423qdblk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 2 Feb 2024 13:29:44 +0100
Message-ID: <CAPDyKFp1vg2+-pHJ_idkdhb_zZUMpq7W17DnCCGj0eTwd4jFbQ@mail.gmail.com>
Subject: Re: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd
 to be managed by HW
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 00:51, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Jan 31, 2024 at 01:12:00PM +0100, Ulf Hansson wrote:
> > On Wed, 31 Jan 2024 at 02:09, Bjorn Andersson <andersson@kernel.org> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 10:47:01AM +0200, Abel Vesa wrote:
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > >
> > > > Some power-domains may be capable of relying on the HW to control the power
> > > > for a device that's hooked up to it. Typically, for these kinds of
> > > > configurations the consumer driver should be able to change the behavior of
> > > > power domain at runtime, control the power domain in SW mode for certain
> > > > configurations and handover the control to HW mode for other usecases.
> > > >
> > > > To allow a consumer driver to change the behaviour of the PM domain for its
> > > > device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> > > > let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> > > > which the genpd provider should implement if it can support switching
> > > > between HW controlled mode and SW controlled mode. Similarly, add the
> > > > dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> > > > its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> > > > genpd provider can also implement for reading back the mode from the
> > > > hardware.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  drivers/pmdomain/core.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pm_domain.h | 17 ++++++++++++
> > > >  2 files changed, 86 insertions(+)
> > > >
> > > > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > > > index a1f6cba3ae6c..41b6411d0ef5 100644
> > > > --- a/drivers/pmdomain/core.c
> > > > +++ b/drivers/pmdomain/core.c
> > > > @@ -548,6 +548,75 @@ void dev_pm_genpd_synced_poweroff(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_pm_genpd_synced_poweroff);
> > > >
> > > > +/**
> > > > + * dev_pm_genpd_set_hwmode - Set the HW mode for the device and its PM domain.
> > >
> > > This isn't proper kernel-doc
> >
> > Sorry, I didn't quite get that. What is wrong?
> >
>
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> says that there should be () after the function name, and below there
> should be a Return:

Thanks for the pointers!

>
> > >
> > > > + *
> > > > + * @dev: Device for which the HW-mode should be changed.
> > > > + * @enable: Value to set or unset the HW-mode.
> > > > + *
> > > > + * Some PM domains can rely on HW signals to control the power for a device. To
> > > > + * allow a consumer driver to switch the behaviour for its device in runtime,
> > > > + * which may be beneficial from a latency or energy point of view, this function
> > > > + * may be called.
> > > > + *
> > > > + * It is assumed that the users guarantee that the genpd wouldn't be detached
> > > > + * while this routine is getting called.
> > > > + *
> > > > + * Returns 0 on success and negative error values on failures.
> > > > + */
> > > > +int dev_pm_genpd_set_hwmode(struct device *dev, bool enable)
> > > > +{
> > > > +     struct generic_pm_domain *genpd;
> > > > +     int ret = 0;
> > > > +
> > > > +     genpd = dev_to_genpd_safe(dev);
> > > > +     if (!genpd)
> > > > +             return -ENODEV;
> > > > +
> > > > +     if (!genpd->set_hwmode_dev)
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     genpd_lock(genpd);
> > > > +
> > > > +     if (dev_gpd_data(dev)->hw_mode == enable)
> > >
> > > Between this and the gdsc patch, the hw_mode state might not match the
> > > hardware state at boot.
> > >
> > > With hw_mode defaulting to false, your first dev_pm_genpd_set_hwmode(,
> > > false) will not bring control to SW - which might be fatal.
> >
> > Right, good point.
> >
> > I think we have two ways to deal with this:
> > 1) If the provider is supporting ->get_hwmode_dev(), we can let
> > genpd_add_device() invoke it to synchronize the state.
>
> I'd suggest that we skip the optimization for now and just let the
> update hit the driver on each call.

Okay.

>
> > 2) If the provider doesn't support ->get_hwmode_dev() we need to call
> > ->set_hwmode_dev() to allow an initial state to be set.
> >
> > The question is then, if we need to allow ->get_hwmode_dev() to be
> > optional, if the ->set_hwmode_dev() is supported - or if we can
> > require it. What's your thoughts around this?
> >
>
> Iiuc this resource can be shared between multiple clients, and we're
> in either case returning the shared state. That would mean a client
> acting upon the returned value, is subject to races.

Not sure I understand this, but I also don't have in-depth knowledge
of how the HW works.

Isn't the HW mode set on a per device basis?

>
> I'm therefore inclined to say that we shouldn't have a getter, other
> than for debugging purposes, in which case reading the HW-state or
> failing would be reasonable outcomes.

If you only want this for debug purposes, it seems better to keep it
closer to the rpmh code, rather than adding generic callbacks to the
genpd interface.

So to conclude, you think having a ->set_hwmode_dev() callback should
be sufficient and no caching of the current state?

Abel, what's your thoughts around this?

Kind regards
Uffe

