Return-Path: <linux-pm+bounces-41543-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA9HBXvNeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41543-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:36:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1095D24
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E050F31B3F88
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F035C1B7;
	Tue, 27 Jan 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjaLrc0g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4235CBAF
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524090; cv=pass; b=NneSOM/351NUrPjvWDKaMIzyq3h9VKtET7KODg3tRbIn0NlEJgawPtG43SzLZrRlYXrNH5uVWG/tGpW7ApjWmi9o5J+Y4Okk1eVV8gVCEeEdpjGquH4fbBLlGcCeX4etSToaONYuBEM0MybwTa+potJztWqkFkP6g7l+nMtaJpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524090; c=relaxed/simple;
	bh=OiTeEcGKcBFXkRotAq2rLJUFGoS2e/8S4B3ZUHMIoc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcQ2N1yrRf+WVFeOBIZkqn4NWfONCVm6Cvk0DjawsznL9KNnBWHPwZDC6loZwfsE2uQauM2dFD/edEqvCWsQ3PJcOS8MhEo+hF1xeWSn6MrYhJDQoBcvuN/xgIlb6nrKsjIZHOOnsni6l+SqoVeCS7UOFLFfLAqlV7amkOF2wQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjaLrc0g; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de8860b94so4014148e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524087; cv=none;
        d=google.com; s=arc-20240605;
        b=TRgpx/24w4Qclbn6Py34oJhvSwhT01Fj9LpTT8btgBYTPGnlfkSpwl/l9KbLPaCj6B
         QpWwLV4NYXC8EVMkFeGB3rzPcjH4Z4j2YNzub7Ezpzqr6d/j1YrHLiL3WbObv8VCLL4Z
         2GjSQ2GgYxZZZ9dc/yqlaMUY+VNNPHtTTPymZm2d0SOQX6A6nduFBzR0qNukz7GcmyR3
         oX+7wbXhtpmHpf52//0vdjCtc0Sxyq6l/ZTA3+o+0Cmtus/iwnC9Jmo9FbuJsWqEhYs5
         lHjOkZBjL4HWaH2m7SePVz04N54+5DcOR6UvbXuXfw5ZCEMOcpMhhaNPBoRK2bLjv1oU
         Xulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYoopOl2EeQQVQoZQ/OaPmSnvdUbaPF603nZGlMkhL0=;
        fh=VYdNZPPW4+HPQiP/4Z4vadIJTbcshZUOs2OsZZpXdPA=;
        b=B9SeOhjPo0uekv+D8NQIW8KNR43vz5n2PvvAulpB4FA1D2EXmnshffPKkJWRFLE9G8
         QEhn1iEZqCkQvLwIdFXi89BsS2nfVObzK74NCIkqX43BFqRmfd9vMfI9EY2XT8FdY4eI
         sNHnUNaRWUJwgHpj0EyaCplbMmZFywwlSfy2RpobakPDPlsT3SBlNepRmMqKg5eJEtst
         6qvHNFBIolBA1BQPND0y1A1qbbdGdh28dRxUb4MT4zc4rmcUzZ8pjd0sUo9HLaVogKm4
         euokMqrjr11LLonv0agGBpcgl3om/J8BYFthtl3V18oJc58NKAMhOPGz7TXy+Q+61fEY
         ZmSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524087; x=1770128887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYoopOl2EeQQVQoZQ/OaPmSnvdUbaPF603nZGlMkhL0=;
        b=DjaLrc0gofNfHeS6QWkohfZvo+7AAfdjtdq6/31/hdavy0hoStH0UGcFNbQhly6YAL
         81fPHr5UEWoNDvSRYnIG8QAN4DnjfmSZVYs3okzfcbnyD4GNKu0iVxTc1fIlqk5wafTy
         CYWHM65HIsFc5alX1/fvHZvfbaZ4q9xoJwiaWNt+HoP8x6iGZGAb6MiESTohew/bShiA
         1D4LNhnQ63P7XGuvyVP9X1uEanNVDFKdX87GBRgHFhp7Vozlw4hOYLrzKUVehwU76MTI
         W4/7TPS3qCXuOrY0lYpxkkFdtv2IiphXiTnsZIRy/m3cRu88HN4DsIK/h837vevB6ZmF
         tyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524087; x=1770128887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYoopOl2EeQQVQoZQ/OaPmSnvdUbaPF603nZGlMkhL0=;
        b=Mwr3ywV9/FLi6Bb0Ke7q2lL4HfXsfgtsyjhcGHGax7jPSXrrqn11kJ7ndnsnOE+D6f
         mSiCMViYK/rSUcAys/PACMydaewllExe0JCZ0O8ucJx1wjvr1Q4puLvTrnzaWAvzS53o
         DnKOi0jNqkqN5OitkNg6PhY+MROJVkI2mVE/3ACv/0acrt2gAA3VQ0cxGTNwLe4j2VQV
         LwLno3fKmPsSo5EjM3IRuPXeYcL+PzrfmnRoWA6AsohLea3wf1zElx+5CjHIkUa/EJXE
         FbFh4QBaoQzIWBbHYhhBi+B01C5Yx1ap4uahD14gzJ+bNObRbylC/XtzSY8LYl/i+QPc
         rVfw==
X-Forwarded-Encrypted: i=1; AJvYcCUudkYnrKQrfvenTLvdxGz/hTymS+RHHCjhMUh2UeP5CLt8aqhwYvVC6Vkrv3SGLWUDogyaUrhITg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVYN51BqnEyUw9n1vSum4mfrDh8k46oq5N6iDQ+IkvG0Ytyfc
	trT3mEsmYXJOMN2cRhBkN54L160QbyzCvrotxMDC11NQbNIKMjTaTp0xfo6VE6QYgPe5raFRlqV
	qd3qh186aYlKeEFXAORS+F5jwM3oV1bHE5yhamq2V0Q==
X-Gm-Gg: AZuq6aKYhyXDFAAvcN6nXyhylGESsHjO+OYfLWntOHN7fJ7PZ/DFMyj9fU+ooIOr/Aj
	sW1cLJQyEE2RRwwk0gfYwdbBusp8XLVP5H25ZKUU4ijfBtCUpwyvLdIluKklJOw6wUbsyoOHkCr
	an1Ov6JiawIScY/Xhzlyy/zgScnH7wngILpLt66BkLOOBYqkY0zDshdgX2Lpxvf4TgYxZUhqiRs
	AzJ7m78WDW5GAHtDP6sn7fYd93iGBEc7i1SZYtlpLg65Bdx4DX5U5pzkjnU7knKUBoOTK1/
X-Received: by 2002:a05:6512:92:b0:59e:417:27fa with SMTP id
 2adb3069b0e04-59e041728cfmr750014e87.48.1769524086693; Tue, 27 Jan 2026
 06:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
In-Reply-To: <20260123-imx8mm_gpu_power_domain-v3-1-3752618050c9@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 15:27:30 +0100
X-Gm-Features: AZwV_Qjot6TJIfN7wNGu1pyiZ5mH2AbueFO2BcAtWkdlZPb-DGIO_mxVmpUYEnk
Message-ID: <CAPDyKFr9pLaZRBXypf-9cZWahJOMcBc6QB-udY46GEvb0tFyNg@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
To: Jacky Bai <ping.bai@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41543-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,mail.gmail.com:mid,pengutronix.de:email,nxp.com:email]
X-Rspamd-Queue-Id: 73F1095D24
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 03:51, Jacky Bai <ping.bai@nxp.com> wrote:
>
> On i.MX8MM, the GPUMIX, GPU2D, and GPU3D blocks share a common reset
> domain. Due to this hardware limitation, powering off/on GPU2D or GPU3D
> also triggers a reset of the GPUMIX domain, including its ADB400 port.
> However, the ADB400 interface must always be placed into power=E2=80=91do=
wn mode
> before being reset.
>
> Currently the GPUMIX and GPU2D/3D power domains rely on runtime PM to
> handle dependency ordering. In some corner cases, the GPUMIX power off
> sequence is skipped, leaving the ADB400 port active when GPU2D/3D reset.
> This causes the GPUMIX ADB400 port to be reset while still active,
> leading to unpredictable bus behavior and GPU hangs.
>
> To avoid this, refine the power=E2=80=91domain control logic so that the =
GPUMIX
> ADB400 port is explicitly powered down and powered up as part of the GPU
> power domain on/off sequence. This ensures proper ordering and prevents
> incorrect ADB400 reset.
>
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Fix the Suggested-by tag typo
> - Link to v2: https://lore.kernel.org/r/20260120-imx8mm_gpu_power_domain-=
v2-1-be10fd018108@nxp.com
>
> Changes in v2:
> - add prefix to patch subject as suggested by Krzysztof
> - refine the patch to move the GPUMIX ADB400 into GPU power domain
> - Link to v1: https://lore.kernel.org/r/20260119-imx8mm_gpu_power_domain-=
v1-0-34d81c766916@nxp.com
> ---
>  drivers/pmdomain/imx/gpcv2.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index b7cea89140ee8923f32486eab953c0e1a36bf06d..a829f8da5be70d0392276bd13=
5fb7fc1bbf10496 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -165,13 +165,11 @@
>  #define IMX8M_VPU_HSK_PWRDNREQN                        BIT(5)
>  #define IMX8M_DISP_HSK_PWRDNREQN               BIT(4)
>
> -#define IMX8MM_GPUMIX_HSK_PWRDNACKN            BIT(29)
> -#define IMX8MM_GPU_HSK_PWRDNACKN               (BIT(27) | BIT(28))
> +#define IMX8MM_GPU_HSK_PWRDNACKN               GENMASK(29, 27)
>  #define IMX8MM_VPUMIX_HSK_PWRDNACKN            BIT(26)
>  #define IMX8MM_DISPMIX_HSK_PWRDNACKN           BIT(25)
>  #define IMX8MM_HSIO_HSK_PWRDNACKN              (BIT(23) | BIT(24))
> -#define IMX8MM_GPUMIX_HSK_PWRDNREQN            BIT(11)
> -#define IMX8MM_GPU_HSK_PWRDNREQN               (BIT(9) | BIT(10))
> +#define IMX8MM_GPU_HSK_PWRDNREQN               GENMASK(11, 9)
>  #define IMX8MM_VPUMIX_HSK_PWRDNREQN            BIT(8)
>  #define IMX8MM_DISPMIX_HSK_PWRDNREQN           BIT(7)
>  #define IMX8MM_HSIO_HSK_PWRDNREQN              (BIT(5) | BIT(6))
> @@ -794,8 +792,6 @@ static const struct imx_pgc_domain imx8mm_pgc_domains=
[] =3D {
>                 .bits  =3D {
>                         .pxx =3D IMX8MM_GPUMIX_SW_Pxx_REQ,
>                         .map =3D IMX8MM_GPUMIX_A53_DOMAIN,
> -                       .hskreq =3D IMX8MM_GPUMIX_HSK_PWRDNREQN,
> -                       .hskack =3D IMX8MM_GPUMIX_HSK_PWRDNACKN,
>                 },
>                 .pgc   =3D BIT(IMX8MM_PGC_GPUMIX),
>                 .keep_clocks =3D true,
>
> ---
> base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
> change-id: 20260113-imx8mm_gpu_power_domain-56c22ce012a1
>
> Best regards,
> --
> Jacky Bai <ping.bai@nxp.com>
>

