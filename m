Return-Path: <linux-pm+bounces-34705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C4B58DAF
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 06:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EF4869E8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 04:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBB26B973;
	Tue, 16 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtsrrG2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B426561D
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998545; cv=none; b=NeLKLvI7emT+B1D+oiBUqFvweOmO3lb3JVlB4wqbhRmHrYMfbrTuW3dxpApjDMt9eYvRTKDmZ0je2S0PV2Hx/vcVzVqPXjOE/CaMCNFeIznwYH/uyj/6PP6Cs5hjLIEwX/P2sV7DAUXxbmi2M1nSFuAjfvHeuyiYzbxGnyNPZ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998545; c=relaxed/simple;
	bh=5rE76gQgJQKBWzXKcgUF0aME2xKJUWOEZnpj27dj58s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO7Pvm9SKDgUiGGFJNLceHlnT78m5dqOPZid9xXVoY3hYDT8H4HBBGk8jv3gmU8az+g8ZuC6wdZTheBHqGC3aCulpUmpXWtlezYgNaSMP5rOBLTJyABiquvD1sJxWvlQesK2L2UH2eIlzNz0DM4bfql6O4PujyX2TIeS4VMSQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtsrrG2k; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e94d678e116so5158493276.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998543; x=1758603343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBcjRbm3FVwYUlOZdbgLY3RSHrk0clAp1Nkb0I9SPZU=;
        b=LtsrrG2kPLIwwR71JmQyCe02cf4X+I8llghjpAOPsRFd+h62zT3iDIyz0ravAftmCo
         cFXlr5+JvP/6sfBg8IgjHtLNQx7wufqxyjtsnZb9kRq6xPMVRagc2UnVNJNZgoFxuLkO
         zm4F2IgBryMCEupRBBW0FYNW5ngtfpZ6hpnm8pGXCuDMjUohc/RPZ5r4bv9Fxhe/DRID
         Bv95sldw4iQE0cwmtUodxEpfpRqvaWW4yugQ+I2fERAtUYyGVhShMs01dUkemLBXZrSQ
         QXprEfM7HpqNKZTC3pZDmxJy9/d65zKOBTRyOkW5jgCAO9BYn2uKCBmcO/pv+xiGrcOG
         LiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998543; x=1758603343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBcjRbm3FVwYUlOZdbgLY3RSHrk0clAp1Nkb0I9SPZU=;
        b=Nk7wnxZVpugqHlUtrj0j7KpUcHnQtwsEoBTpek1S3BWdmT+TKsvTSjNJFhANN7hL6A
         /FNt9lbuzpt0eg+7Aa1XOyzEvKxxdMdz56aknu+DIk8OxPPvdDzthIoRUf6JOg8xrutN
         lSZPrlPjRmEJXpR9BDx9EdRdOI2NA1H2Ya4TTlthXav0U2hPFPbVI7p7qQQg8CKAHjwh
         iXaeKbdFw8RvZ+c88iOqW2MlE+YORdTszvuuOy1lT1rMg07LKZbSrNTtislSCRG85Cue
         aBlfOK6yfsYJINynh2URY7wNCRwEpumPFtj9vvPrbHZO00LCgN91017j+jPm1vM60Yi3
         /KPA==
X-Forwarded-Encrypted: i=1; AJvYcCUa39MWkeNy0BwxFuP1sgWs6KcHqUdA1944MDkB5Nx2CsJSC131oBHHscf8gPggaxUvT+Y50QEeww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYGhG4gHuQyonf8GrLuyT7WfWHQwe7x9z6xaQ0iUCeBm3VmS3
	/LlH852stUW34vIerQzJGnbTe7ks5cIti0yYUXkxWbEwCRK3fOctBt6/dyNiBaUqvilF/ha2VdT
	MDM4TneHRuIJa2FfnC7I6Tl31f8DgMY0=
X-Gm-Gg: ASbGncv9B/ShZOywlEbplz5C8swYlI8PoAqk3s3TZkFC26VCuuqYxD0rWwp1DXESbfg
	tnQr0dTzvDYy3cGJUacBp4iclfwmID49cpeejieqFak2emNCZ812RxODno7fnrszRDdiolQCoVq
	XYtL7K0uOmqmVDiLygq06qIm7jBAyB5JWR8BnAWrmiJJ/p+ffrLSE4ZSWiiEqj3hEejMgwrBsKW
	I3MQMCMyvhesgAzygUq4Z2GDSJxgvivrQ576n4DIQtWwrFYX83PEA9Idzjv4HJEJa2uN8I+
X-Google-Smtp-Source: AGHT+IFXVrlkAw4hIUMkjDUsgYvyK7EgpmYsPWpx/dWgsCW+cokg9VHakZyQIrCx9AHlixfNXCZ76u+Wtg35mXq2D/U=
X-Received: by 2002:a53:cb41:0:b0:612:891a:9ecc with SMTP id
 956f58d0204a3-627202230a3mr10138013d50.9.1757998542602; Mon, 15 Sep 2025
 21:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com>
 <20250912-mt8196-gpufreq-v2-5-779a8a3729d9@collabora.com> <CAPaKu7Q+KAzEtKBWy8KO2Kp+H4y-Mqo34uo=jgH1_iooaDq3hA@mail.gmail.com>
 <8577914.T7Z3S40VBb@workhorse>
In-Reply-To: <8577914.T7Z3S40VBb@workhorse>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 15 Sep 2025 21:55:30 -0700
X-Gm-Features: AS18NWCUMIgi23a5SaUlUvMdo-ihykJDXaO9mGCW6rE2ZLrI7uXsuBJkrMkP79E
Message-ID: <CAPaKu7STDDp6D_fDGVfAKFrb5aWcxtwsT3nYtYDQQYCs7G9upA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mailbox: add MediaTek GPUEB IPI mailbox
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:34=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Saturday, 13 September 2025 00:11:10 Central European Summer Time Chia=
-I Wu wrote:
> > On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > <snipped>
> > > +static irqreturn_t mtk_gpueb_mbox_thread(int irq, void *data)
> > > +{
> > > +       struct mtk_gpueb_mbox_chan *ch =3D data;
> > > +       int status;
> > > +
> > > +       status =3D atomic_cmpxchg(&ch->rx_status,
> > > +                               MBOX_FULL | MBOX_CLOGGED, MBOX_FULL);
> > > +       if (status =3D=3D (MBOX_FULL | MBOX_CLOGGED)) {
> > > +               mtk_gpueb_mbox_read_rx(ch);
> > > +               writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ=
_CLR);
> > > +               mbox_chan_received_data(&ch->ebm->mbox.chans[ch->num]=
,
> > > +                                       ch->rx_buf);
> > Given what other drivers do, and how mtk_mfg consumes the data, we shou=
ld
> >
> >   char buf[MAX_OF_RX_LEN]; //  MAX_OF_RX_LEN is 32; we can also
> > allocate it during probe
> >   mtk_gpueb_mbox_read_rx(ch);
> >   mbox_chan_received_data(..., buf);
> >
> > mtx_mfg makes a copy eventually anyway.
>
> We don't right now, at least not until after the callback returns.
> So we need to have the copy in the mtk_mfg callback, not after the
> completion. That's fine and I do want to do this as this is what
> the mailbox framework seems to expect clients to do.
>
> > We don't need to maintain any
> > extra copy.
> >
> > Then we might not need rx_status.
>
> We can probably get rid of it if we keep the per-channel
> interrupt handler. Otherwise, we may still need clogged,
> as we don't want to process interrupts on channels we have
> no user for.
>
> >
> > > +               atomic_set(&ch->rx_status, 0);
> > > +               return IRQ_HANDLED;
> > > +       }
> > > +
> > > +       return IRQ_NONE;
> > > +}
> > > +
> > > +static int mtk_gpueb_mbox_send_data(struct mbox_chan *chan, void *da=
ta)
> > > +{
> > > +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> > > +       int i;
> > > +       u32 *values =3D data;
> > > +
> > > +       if (atomic_read(&ch->rx_status))
> > > +               return -EBUSY;
> > > +
> > > +       /*
> > > +        * We don't want any fancy nonsense, just write the 32-bit va=
lues in
> > > +        * order. memcpy_toio/__iowrite32_copy don't work here, becau=
se fancy.
> > > +        */
> > > +       for (i =3D 0; i < ch->c->tx_len; i +=3D 4)
> > > +               writel(values[i / 4], ch->ebm->mbox_mmio + ch->c->tx_=
offset + i);
> > > +
> > > +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_SET);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mtk_gpueb_mbox_startup(struct mbox_chan *chan)
> > > +{
> > > +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> > > +       int ret;
> > > +
> > > +       atomic_set(&ch->rx_status, 0);
> > > +
> > > +       ret =3D clk_enable(ch->ebm->clk);
> > > +       if (ret) {
> > > +               dev_err(ch->ebm->dev, "Failed to enable EB clock: %pe=
\n",
> > > +                       ERR_PTR(ret));
> > > +               goto err_clog;
> > > +       }
> > > +
> > > +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_CLR);
> > > +
> > > +       ret =3D devm_request_threaded_irq(ch->ebm->dev, ch->ebm->irq,=
 mtk_gpueb_mbox_isr,
> > > +                                       mtk_gpueb_mbox_thread, IRQF_S=
HARED | IRQF_ONESHOT,
> > > +                                       ch->full_name, ch);
> > I don't think this warrants a per-channel irq thread.
> >
> > mbox_chan_received_data is atomic. I think wecan start simple with
> > just a devm_request_irq for all channels. mtk_gpueb_mbox_isr can
> >
> >   read bits from MBOX_CTL_RX_STS
> >   for each bit set:
> >     read data from rx
> >     mbox_chan_received_data
> >   write bits to MBOX_CTL_IRQ_CLR
> >
>
> I don't like this approach. It brings us back to having to process
> multiple channels per ISR, keep track of when the interrupt should
> be enabled and disabled based on how many channels are in use, and
> also is not in line with what e.g. omap-mailbox.c does.
>
> Remember that `mbox_chan_received_data` synchronously calls the
> mailbox client's rx_callback. In mediatek_mfg's case, this is
> fairly small, though with the request to not make the rx buffer
> persist beyond the rx_callback it will gain an additional memory
> copy. But we can't guarantee that someone isn't going to put a
> slow operation in the path. Sure, it's going to be atomic, but
> waiting for a spinlock is atomic and not something an ISR would
> enjoy. I don't think mailbox clients would expect that if they
> take their time they'll stall the interrupt handler for every
> other channel.
>
> So we'd keep the interrupt disabled for all channels until the
> client that received a message has processed it.
>
> I can see myself getting rid of the handler and just having the
> thread function as the bottom half, but I'd really like to keep
> the one-IRQ-request-per-channel thing I've got going now as it
> made the code a lot easier to reason about. However, doing this
> would mean the interrupt is re-enabled after the generic upper
> half, when all the business logic that needs to not run
> concurrently for an individual channel is in the bottom half.
>
> As far as I can tell, this would then mean we'd have to add
> some concurrency exclusion mechanism to the bottom half.
>
> Moving all the logic into the upper half handler function
> would make that handler somewhat longer, and I don't know
> if IRQF_ONESHOT masks the interrupt for all users of that
> IRQ number or just for those with that dev_id. If it's per
> dev_id, then I'm fine with moving stuff up there. But from
> my reading of the core IRQ handling code, that does not
> appear to be the case; one channel getting a reply would
> mask *all* channels of the mailbox until the upper half is
> completed, and if the upper half calls into a driver
> callback synchronously, that may take a hot minute.
>
> Put differently: Is there a problem with one thread per used
> channel, or are we going off vibes here? The way it currently
> works uses the shared interrupt to mark just that one channel
> as busy with rx_status before letting the IRQ for all channels
> be unmasked again, which seems ideal to me.
No, one thread per used channel can work. I can't say I like it, but I
also don't know the hw as well as you do.

