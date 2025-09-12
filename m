Return-Path: <linux-pm+bounces-34582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BFB558FD
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 00:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CF21893C6C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080D3680B8;
	Fri, 12 Sep 2025 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4I8qU5z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA62D541E
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715084; cv=none; b=SKy8D/z20mmog0M6AW+TAoA21Nt9hMSSJ5SE/IYDz+3rWD5MW+PlPtgB2MuqlTzawGkaSe5mlcGwoldk3A6zcDB5IapigHiFgFm1QqxT4bvI7Ao5sah4mlFm7wzRFj7U+LdDxPt2wX+GcqvwlZEEgACEAsavmzxbC5mqpQ8GbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715084; c=relaxed/simple;
	bh=SbE2cgv2kQcmjvErb4P8aWuTkv80m0Jw5VHNYIRdjbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4Z6xWPy1mSTGUfvfdpka5FarYe7eCJmAmvQYMPvQY0iyzlUXgKyy5dNb7qTODFWqXbjY5areBpIgUu32wARdUoSvIulmB4VDtIqDLA50Wu7fsXRejg5c9EN9GCZw8XktPJHx3dYUm+dyjr2f3AyFRDMB3wjYfOi/jf0EXyCwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4I8qU5z; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so1547377276.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715081; x=1758319881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCZT/K4e4byUQqhyOs9c8fQ3Jbf6/69LbbDKjwZwLE=;
        b=H4I8qU5zYYIajG0cFBKg9XLkC+arvjtzsJSFXvheCL6rEFjkBDjc3hegecUkfboRZJ
         o+YKR91VOx5F4mC0NBXl1rGgTBplAfhta0YJG18OPylwKqPOunK7HTNz2EPsOewmiZ7b
         Bqxs/BsbSOTDAngNZiMnuhnORI7pSDWuf/FyvtAF5G0cFF+NNpjd7VBXJNIYdLsxy3tO
         8unUO2ooWffSDOCwop9ER6npWKnjKYm/uQ+3wcxMTLVNmoQ/tJ6Z3aQsDPRp6pM/gWsV
         f8qbeVEPO+hCJ7RRpn+rf90Ejl0TJuM2dxqhA2pdPJCfpeoHGBh8ew8oti7p0xQn2yYz
         HH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715081; x=1758319881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCZT/K4e4byUQqhyOs9c8fQ3Jbf6/69LbbDKjwZwLE=;
        b=GC24OuFtgeFUBF+SYHcOKdCNV1t/785HfGclcd1Gf0L6SLYv3gIRcUbyXiGd3ivnQx
         1fbBrD7fU/H6fJ6t764YoX3VHUmk0SuLKA+Bnab6eU07TnXsXr0oCFz4QPLcsxGg4BnJ
         x1DLY74eX63SHNEsx88uSIUynsuTTIEFwknuKnrybm88g8ZNkxpt8uMj49ZsagQe2BVU
         KKutJGEW5o3qPYpaBjKlL53dYuoA9qvq210E1Lo1KZv6csMpi+218R3HTwx49eXoHmoJ
         NxTT6GrIyC3l5ZAQgFQ5sL1Qzn4/3kkzwUQcNuYGukIcZu8BwgNVRMF08zqOqQB9Xcsb
         7kOA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DzpmCgpt5a+sqjZ3A0OVau9PAUiWSc2GHT6huBoxK8XAvF61EdbfeUKXhpZXrRX6P8icNeBgSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqesQ5fBF5JqTy7ZYpLfRv3EfycRYWZHucFm2CUl3bKtk2/nB
	383KE/RR0GtFT90FoXbbtV8wjZHRomGTNCd3CQtHqor3pOsh+IeFCTQvVGSc3YmXVA8Ij7NPHBU
	bV/lwGGPqvXnrfYBVb1Fk/iGY8xpg9Ic=
X-Gm-Gg: ASbGncvPwQjSCmy3AZ9tse8Mo76XIsWF6FsIErmvDgK30ORl7KikgsjQqLPCmv0URdu
	Ts6dDSAOMt85NLRBTlfcpx8pR2XdpDp50AyyX+wH+Shf+MIrhChQxwd5VVb8qeuwqaK0oDxjIZa
	hqhYmdCYggIIV3YS3TpR0EUS9GvXFB6e4ZwV5rOMqFUcs6xcwcfa8t/99I1gE6OeCDRJTFEvfcR
	EF4Xykw0xJUGcc5cYVmvE9m2kY85CHqFcmUG1WbVo44BBktmaUJGHg23pKY3S85coq7yZDr
X-Google-Smtp-Source: AGHT+IHvIYQO4e+EnIIRJTQWJn4b+DyuGOUZd4hIxE3/1w0g4hnoPddMFEkakoXj6yfAPLr17VsI/RA83QQAwziujdk=
X-Received: by 2002:a05:690c:4c09:b0:723:bd6c:4f2a with SMTP id
 00721157ae682-730625cd9f7mr37664467b3.7.1757715080775; Fri, 12 Sep 2025
 15:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com> <20250912-mt8196-gpufreq-v2-5-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-5-779a8a3729d9@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 12 Sep 2025 15:11:10 -0700
X-Gm-Features: Ac12FXxS_5OX767ts7gHLmsyJJeyNECHrzeeo_cAOYq8vugrFis3NtJYNr5wYEs
Message-ID: <CAPaKu7Q+KAzEtKBWy8KO2Kp+H4y-Mqo34uo=jgH1_iooaDq3hA@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
<snipped>
> +static irqreturn_t mtk_gpueb_mbox_thread(int irq, void *data)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D data;
> +       int status;
> +
> +       status =3D atomic_cmpxchg(&ch->rx_status,
> +                               MBOX_FULL | MBOX_CLOGGED, MBOX_FULL);
> +       if (status =3D=3D (MBOX_FULL | MBOX_CLOGGED)) {
> +               mtk_gpueb_mbox_read_rx(ch);
> +               writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_CLR=
);
> +               mbox_chan_received_data(&ch->ebm->mbox.chans[ch->num],
> +                                       ch->rx_buf);
Given what other drivers do, and how mtk_mfg consumes the data, we should

  char buf[MAX_OF_RX_LEN]; //  MAX_OF_RX_LEN is 32; we can also
allocate it during probe
  mtk_gpueb_mbox_read_rx(ch);
  mbox_chan_received_data(..., buf);

mtx_mfg makes a copy eventually anyway. We don't need to maintain any
extra copy.

Then we might not need rx_status.

> +               atomic_set(&ch->rx_status, 0);
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}
> +
> +static int mtk_gpueb_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> +       int i;
> +       u32 *values =3D data;
> +
> +       if (atomic_read(&ch->rx_status))
> +               return -EBUSY;
> +
> +       /*
> +        * We don't want any fancy nonsense, just write the 32-bit values=
 in
> +        * order. memcpy_toio/__iowrite32_copy don't work here, because f=
ancy.
> +        */
> +       for (i =3D 0; i < ch->c->tx_len; i +=3D 4)
> +               writel(values[i / 4], ch->ebm->mbox_mmio + ch->c->tx_offs=
et + i);
> +
> +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_SET);
> +
> +       return 0;
> +}
> +
> +static int mtk_gpueb_mbox_startup(struct mbox_chan *chan)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> +       int ret;
> +
> +       atomic_set(&ch->rx_status, 0);
> +
> +       ret =3D clk_enable(ch->ebm->clk);
> +       if (ret) {
> +               dev_err(ch->ebm->dev, "Failed to enable EB clock: %pe\n",
> +                       ERR_PTR(ret));
> +               goto err_clog;
> +       }
> +
> +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_CLR);
> +
> +       ret =3D devm_request_threaded_irq(ch->ebm->dev, ch->ebm->irq, mtk=
_gpueb_mbox_isr,
> +                                       mtk_gpueb_mbox_thread, IRQF_SHARE=
D | IRQF_ONESHOT,
> +                                       ch->full_name, ch);
I don't think this warrants a per-channel irq thread.

mbox_chan_received_data is atomic. I think wecan start simple with
just a devm_request_irq for all channels. mtk_gpueb_mbox_isr can

  read bits from MBOX_CTL_RX_STS
  for each bit set:
    read data from rx
    mbox_chan_received_data
  write bits to MBOX_CTL_IRQ_CLR

