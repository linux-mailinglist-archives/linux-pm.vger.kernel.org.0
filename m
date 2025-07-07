Return-Path: <linux-pm+bounces-30257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7FAFAFE1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E63AEFA8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B728D849;
	Mon,  7 Jul 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="D5wg2CKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6B28A72A
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881030; cv=none; b=RLoNSRYyG8FdNCyHFXiKdfpw3lOsPYADErQAVF8u0zzaHKUM3Cf412Ejx2tVhGPgAJEyBU3dMIyt+K/c2zR+UdZ1uhvWWAjUAlz2fqnAvzrIl2CVjanXN6DDpnUPkyZ0lhRvH20HvxZOyliysJLSk9/os5MLcwoD8Flq1p2GEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881030; c=relaxed/simple;
	bh=SYLryKLAzyfZUajtOxDGatOvMMnUda+6b5kKcAomvx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipcNEWpdS6cKL+3Wu+SJqafKrLTxnIukikRKPJCpIeIpwCxBtoS5ic+/Cmh8iC0e2NUJM1395HNwnPGX7uoDUZdGvjkQI7nmai1XEU1Ej/q0H/RKDqsUbt91tfV07B415++zkyUwQavpptHH+Qm3g5jVOqHiClVw0iN3UAIp2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=D5wg2CKD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df2ddd39c6so10850625ab.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1751881027; x=1752485827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VfweRdHv9ufprfg1Atwss0HvbCxmH7kEC9W20OMaU4=;
        b=D5wg2CKDeLHHC3TH+iX9NCGzZSpVlOCJ9u+VGMI7rN08fccH3ubIJ+H3WIkMvxXun4
         bIC7ehkSYeuQXAHdnPZTZu501i+WqavWN62QeHfag+u1JGj1hDhO//0MUsXb6Ggd7M5M
         TmaQXcX/WVVcG7Cs4E7wq0ELHyRfOstKVv0b8dEpHAtg8inyUA+XG/MY79gZl8bkGrwW
         qQJv9YJ9n0qQatUySsw9FXzAcWINLe6URRL5+yOUkm67Ns4zwG6DJ282TMwHLy6h55J3
         Qc+hoWxWt9K6SlzSLcjdq/jpoYugxvY6Izg1pVeVvmM3NxOIgek9uF6RBRZNZWv/ONYB
         1fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881027; x=1752485827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VfweRdHv9ufprfg1Atwss0HvbCxmH7kEC9W20OMaU4=;
        b=ByIAAd9yhMDZUAhDvhFm/tP+LKIffMqwbK0MgIX3z4xU+tYog2pEL4GupBsJQttf8f
         hXxWEQgMNQ+n0So13k3I8Tomsk562YF7sZAqwd/A47NZsEO3J4SCCeD8U+XcAz4uPJ+r
         C64eEcjsLiX+TVxOAsgps5cF0SZk/mxFPK2R0SCNBlPmPphH2cxkNVUoblG0dMTMq/h5
         FNZ3YpiCxrM3fpERU01svXS6mvrZmPqpYvyM0+mW+C31D5gSi3aE8FlLaglAIe12M8L3
         SSbzZAfS452TolER1dBXiljJNNPbPvclRqrpNsTVLxBfXRJCqU9YEPEIGe2gLoJqM4F/
         cvtw==
X-Forwarded-Encrypted: i=1; AJvYcCVq1ME6naH9hbe15uk6mrmaWMLHh5AtALPt1pxkvmiIuUxYQJodB7KfWDiymuPDft5AbYxNRYJGkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU6FZvkDfdeDApywmYWzrnzRi7/DoUFzlShHVIreqzEsSKEbK
	DGk2dPVMeG9UkVfFLPAXD9b6kkbSStKcWzj5Le2NPsGqdmn5Bmf6NTLlqsrZiLAC1LfgTuzd2UH
	1VjhlXyZ6SoQZ3t0MbeYTFbdbpgt9VLzYuQIw88eNgg==
X-Gm-Gg: ASbGncunoQhlCKID1HycZQgEUZj9W6cnP9+QiBjuGso0Hn/5zs45pVYPJpQDLwT/7yH
	Sh2OHoU+rE6D/MsPIAzmIMfZDrq0faBWmThwUiMdNXUUro5SIJG8VISUNcrcnSlB8xiH8wDNFC/
	iWV3g+zLiJQiHWUxEIuBSSvHXED2ZdjafnV0mfgriGulhL
X-Google-Smtp-Source: AGHT+IH+SePIS0aSzniflQp0S8Iw7JaUsbC6szdrpRvO5SkC/AQGSEVL3nboJR1AEhxiDDNFmQa8kIbvcXwwHXpVOK4=
X-Received: by 2002:a05:6e02:380d:b0:3df:2f47:dc21 with SMTP id
 e9e14a558f8ab-3e137204107mr107268135ab.22.1751881026965; Mon, 07 Jul 2025
 02:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <20250701114733.636510-12-ulf.hansson@linaro.org>
In-Reply-To: <20250701114733.636510-12-ulf.hansson@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 7 Jul 2025 15:06:55 +0530
X-Gm-Features: Ac12FXxpaKMFAHlr5TcRHSgcV-Hs57tR_KopRD8ZRlv3-fvgnPWZ2ytZglu0vVg
Message-ID: <CAAhSdy1V_hGt8CG4CBVTAeYk07Nbd7aT3WtJrgXhnsj7rUpQvg@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] cpuidle: riscv-sbi: Opt-out from genpd's common
 ->sync_state() support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 5:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> The riscv-sbi-domain implements its own specific ->sync_state() callback.
> Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.
>
> Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
> power off unused PM domains.
>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: linux-riscv@lists.infradead.org
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xi=
linx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index 0fe1ece9fbdc..83d58d00872f 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -347,11 +347,16 @@ static int sbi_cpuidle_init_cpu(struct device *dev,=
 int cpu)
>
>  static void sbi_cpuidle_domain_sync_state(struct device *dev)
>  {
> +       struct sbi_pd_provider *pd_provider;
> +
>         /*
>          * All devices have now been attached/probed to the PM domain
>          * topology, hence it's fine to allow domain states to be picked.
>          */
>         sbi_cpuidle_pd_allow_domain_state =3D true;
> +
> +       list_for_each_entry(pd_provider, &sbi_pd_providers, link)
> +               of_genpd_sync_state(pd_provider->node);
>  }
>
>  #ifdef CONFIG_DT_IDLE_GENPD
> @@ -396,7 +401,8 @@ static int sbi_pd_init(struct device_node *np)
>         if (!pd_provider)
>                 goto free_pd;
>
> -       pd->flags |=3D GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> +       pd->flags |=3D GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
> +                    GENPD_FLAG_NO_SYNC_STATE;
>
>         /* Allow power off when OSI is available. */
>         if (sbi_cpuidle_use_osi)
> --
> 2.43.0
>

