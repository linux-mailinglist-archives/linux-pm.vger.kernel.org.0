Return-Path: <linux-pm+bounces-40658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78963D126CA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 12:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64442307738A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B88357705;
	Mon, 12 Jan 2026 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="l3OGzIUN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD3357703
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219133; cv=none; b=Y9fzGfJCFjtYo6hIoqaxVgBgX9Tbcb+l5Rq2/6kDCWuTrq4Xy1MTgJ7fO15aegWyR+PQDjuvuAhQWV4NAsVDQAhCTLFSIgq9+Jx3yYNbK9iYFE36RtOIkUuyn1RsIO0V24x8VhJSGc8uPTe9By9yAUwmUa2dcfwZZ4klrGPXUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219133; c=relaxed/simple;
	bh=lAO33T1KFMqFpJot8ObRF3j6h3bz9TaOzcEeSel5n4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMRVGYY5kOojMh1l/nsZ2J98KPPxEgPAFtT37q7NZuBG2W6gKKK0OAt3/3KN4q+Q1s3TfBMkuvnZU2YByonfFHpIcy76NtjuB/Gu33CGVUOlSYDufaBfjE76Sht9o1luonen06yTNdyzUrkJiAwNMy1gB9/RyoTSs7h5cD784pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=l3OGzIUN; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65e9430489eso2217768eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1768219131; x=1768823931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/STUq3tlNYx1CRPqYo/MSQ91muzU5RYxKWjoD/GoBRc=;
        b=l3OGzIUNKhjHJigxQGv0u0n/pGgC0LeyF5T3bcPEnij4UBPH6UDD8kLP8f2z9bXITB
         OcGiZNv0Nzjh+EREf2NKZYcwRFnHPgZVWuv60M525kqlBkjFgPlLT1idGyJcFYupXgKm
         atlqKCBeHvL6IQTa0XShEERKdwQ2ykwZtVNrZ2J56mF2XbhokHL1IF+bCryn8A9dO6wR
         Z1TSROdBVOivCYzHz6RJ1VIRNvgckUqEEXbWzegqS4rNg85G7OwSaOcrSsgEkXBpVMmC
         J4VeCzsmy2Jj9K9aFTH50SpcCxoWttPlQlRITxxz2kvKs/uIBG1K9yIWfy6nArDHarfy
         foaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768219131; x=1768823931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/STUq3tlNYx1CRPqYo/MSQ91muzU5RYxKWjoD/GoBRc=;
        b=V81vxoY6jrmPe3Tu82A8Md74xE6EeK94QLWjZPXzmJUMS0pWc1oDPQUOiF0Kg1R7J3
         sDAjqI0MPlTUFYrm3xWmbY34oXvP+JtvzvIFwyVX4ZKHoWCgEM/4cBtwWb87eLAGp7jl
         6OBsGlkY5dODjso+qcJyNCMdTOR4wy7ZAMCR+i9dBQ1vORL+fdasYfsDn0foY99TiyKx
         G9izec27yHXxfxBKMIsKtEJXddc3hmySacHqxhul/aWG3wSfBZ+nBPxUVJDGKGuCK7a6
         HjXTsVVkZt+ML0T5nbyvmK0dEHQ5gMAZZqX1j6T8X/WW4aZlDTk3AZT78zgWjFTI+Hxk
         OyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgUbtKOJiEynd7yl4QNsBY7Qc507ui8sNaih3262bb/b1bMb7Gn/RWqwsF2rBobnmQ1pbWrsW1Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73xVzex5cmoy6Zup4AJ4iKCUILe6ST5tzliFzwINPEY8rMF9k
	P0uTZl1xaZKej5wLP+QuYWgEWeKKdm5GagDOFLLsjqGqv1jdzR14xj4SwrY9FkW52F/urxFQB7X
	JW/YGxD7YdTHVNG8Q5tWyrKPfS5YviDx5P6/XlSQzrA==
X-Gm-Gg: AY/fxX79a4ffAlhkrVnYNBTJPv5VU4XmUfjtk9mRdRYfc5vuXIQrUP6kanOMUl/eHzp
	Hbgw0aM8lAfBoKEH4WYeOQUUWH9OFPHqX+yXIx+0E1lpap/MS7flAp2MWVuPcSwZfQSXHkZAr/L
	uqjBX3+NQsh6EiV7LNX/PPm9iua3CTNAdTJ+MimdoOhIPk1eMcc8hHbb32Nm7sJanzSJaLqG8Fm
	euHyxPw1Gf/9IJV8umIpceMZCYu9yY+sPK9OzgHeE8JuWRUATAxhOWJAUOZrm39auaUJAgkNc7s
	SK4WMGk94RftnKacfcFMG4JpPI38GGUNVzRbUywHSszRiQW9aZpOOI5ImA==
X-Google-Smtp-Source: AGHT+IF39t3pEDBTDiz8rtvG2ug4qMAL7z0aOTj1Od1tfioVHcOSk11OADaheOvt4o4y6lBRYQlM3myJcoiNTwzaEUw=
X-Received: by 2002:a05:6820:625:b0:65f:6705:3f83 with SMTP id
 006d021491bc7-65f6705421amr5066461eaf.28.1768219130936; Mon, 12 Jan 2026
 03:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-5-joshua.yeong@starfivetech.com> <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
In-Reply-To: <CABdD5xmVVkQu6rYzF52V-JrsdL=NOQa9N9i8PsMgfaOh3GT-Bg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 12 Jan 2026 17:28:39 +0530
X-Gm-Features: AZwV_QiG8kGYWz6U6xcjoWbaLPAqYlKLwNkT660rcNE0-IopoQC27BXEnEP-0xA
Message-ID: <CAAhSdy17NphDM=bgyvM-eNA9DAGku6p56HSXv5hgZh5VmMfE7Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpufreq: Add cpufreq driver for the RISC-V RPMI
 performance service group
To: Rahul Pathak <rahul@summations.net>
Cc: Joshua Yeong <joshua.yeong@starfivetech.com>, leyfoon.tan@starfivetech.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, rafael@kernel.org, 
	viresh.kumar@linaro.org, sboyd@kernel.org, jms@oss.tenstorrent.com, 
	darshan.prajapati@einfochips.com, charlie@rivosinc.com, 
	dfustini@oss.tenstorrent.com, michal.simek@amd.com, cyy@cyyself.name, 
	jassisinghbrar@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:18=E2=80=AFPM Rahul Pathak <rahul@summations.net>=
 wrote:
>
> > +
> > +static int rpmi_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct rpmi_perf *mpxy_perf;
> > +       struct rpmi_ctx *mpxy_ctx;
> > +       int num_domains =3D 0;
> > +       int ret, i;
> > +
> > +       mpxy_ctx =3D devm_kzalloc(&pdev->dev, sizeof(*mpxy_ctx), GFP_KE=
RNEL);
> > +       if (!mpxy_ctx)
> > +               return -ENOMEM;
> > +
> > +       /* Setup mailbox client */
> > +       mpxy_ctx->client.dev            =3D dev;
> > +       mpxy_ctx->client.rx_callback    =3D NULL;
> > +       mpxy_ctx->client.tx_block       =3D false;
> > +       mpxy_ctx->client.knows_txdone   =3D true;
> > +       mpxy_ctx->client.tx_tout        =3D 0;
> > +
> > +       /* Request mailbox channel */
> > +       mpxy_ctx->chan =3D mbox_request_channel(&mpxy_ctx->client, 0);
> > +       if (IS_ERR(mpxy_ctx->chan))
> > +               return PTR_ERR(mpxy_ctx->chan);
> > +
> > +       ret =3D rpmi_cpufreq_attr_setup(dev, mpxy_ctx);
> > +       if (ret) {
> > +               dev_err(dev, "failed to verify RPMI attribute - err:%d\=
n", ret);
> > +               goto fail_free_channel;
> > +       }
> > +
> > +       /* Get number of performance domain */
> > +       ret =3D rpmi_perf_get_num_domains(mpxy_ctx, &num_domains);
> > +       if (ret) {
> > +               dev_err(dev, "invalid number of perf domains - err:%d\n=
", ret);
> > +               goto fail_free_channel;
> > +       }
>
> The domain space in RPMI performance for CPU and Device
> is not separate and a domain can be either CPU or a Device.
> How the driver will make sure that the domains which are returned
> are CPU only and not the device.
>
> > +MODULE_DEVICE_TABLE(of, rpmi_cpufreq_of_match);
> > +
> > +static struct platform_driver rpmi_cpufreq_platdrv =3D {
> > +       .driver =3D {
> > +               .name =3D "riscv-rpmi-performance",
> > +               .of_match_table =3D rpmi_cpufreq_of_match,
> > +       },
> > +       .probe =3D rpmi_cpufreq_probe,
> > +       .remove =3D rpmi_cpufreq_remove,
> > +};
> > +
> > +module_platform_driver(rpmi_cpufreq_platdrv);
> > +
> > +MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
> > +MODULE_DESCRIPTION("CPUFreq Driver based on SBI MPXY extension");
>
> NIT: CPUFreq driver based on SBI MPXY extension and RPMI protocol   -
> something like this

Currently, the mailbox controller is based on SBI MPXY but in
the future mailbox controller for some other RPMI transport can
also show up.

In reality, the driver is only RPMI based since it uses mailbox APIs.

Regards,
Anup

