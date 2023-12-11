Return-Path: <linux-pm+bounces-899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25280D073
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0A0B20CB4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B904C3BE;
	Mon, 11 Dec 2023 16:04:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58290101;
	Mon, 11 Dec 2023 08:04:17 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5908b15f43eso319191eaf.1;
        Mon, 11 Dec 2023 08:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310656; x=1702915456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIMpn6ss9umZBhmSuB1vL8NZMVZxwbPaHeyzVO2W8AE=;
        b=eiweLRNqgiIU82+TqvzvRwzHf6kMsf6y18dksSAOwQ5K/ytWZYzGteST3wJ0J8jORH
         KbtsF64AKkiU3zSkCAgjIOWFQUEorHOjEtsYs7kYM6ffjkfqVj/LrLMSFdk66aiydFDf
         szbQV1BjISj+VQCPm6zW5W1tFAqdjJefjP3BCI2PxryTZurSJnI5f96XIlFiq9zBFCs2
         adj5Tl0TSjofJZ6+mz0j1RnEm8f/bZNcDxPITKFCQSLA8F7OIATjE9cmviKXBvACK7x4
         GqH3iHMmeMplDFY6b5TuoNxALNNJOO3DRLOdTgOEn+ag08muJjbn7pDQpULjx20So1zE
         hv8w==
X-Gm-Message-State: AOJu0YxIZpVBggSR17qCm/lOvYslE5N6swDyzZ8n6Ndui+Hk9tKA+Szy
	vFdpdmfPJsSTVYLVoq97lZCKTVmWC1SzOgRlBt4=
X-Google-Smtp-Source: AGHT+IGFDTjBOL0lxSzuXs3XLispvYpZjZ3z0ervlBlI3IeXDcvyTmVIVNOE7sGrmOBpS6mUShyIaB8Fjm5Sokz0rlI=
X-Received: by 2002:a4a:d130:0:b0:590:5de3:cca6 with SMTP id
 n16-20020a4ad130000000b005905de3cca6mr7188043oor.0.1702310655912; Mon, 11 Dec
 2023 08:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
In-Reply-To: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 17:04:04 +0100
Message-ID: <CAJZ5v0jZAOmnccbEUsBNw3f-Uh6TmO-6JGgU+PJazmjFASczHQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
To: chenguanxi11234@163.com
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen Haonan <chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:52=E2=80=AFPM <chenguanxi11234@163.com> wrote:
>
> From: Chen Haonan <chen.haonan2@zte.com.cn>
>
> kmap_atomic() has been deprecated in favor of kmap_local_page().
>
> Each call to kmap_atomic() in the kernel creates a non-preemptable
> segment and disables the missing page exception. This can be one of
> the sources of unexpected latency. Therefore users should choose
> kmap_local_page() over kmap_atomic().

Do you realize that the code being modified runs with only one CPU
online and with interrupts off on that CPU?

> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  kernel/power/snapshot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 50a15408c3fc..feef0d4d3288 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn,=
 unsigned long src_pfn)
>         s_page =3D pfn_to_page(src_pfn);
>         d_page =3D pfn_to_page(dst_pfn);
>         if (PageHighMem(s_page)) {
> -               src =3D kmap_atomic(s_page);
> -               dst =3D kmap_atomic(d_page);
> +               src =3D kmap_local_page(s_page);
> +               dst =3D kmap_local_page(d_page);
>                 zeros_only =3D do_copy_page(dst, src);
> -               kunmap_atomic(dst);
> -               kunmap_atomic(src);
> +               kunmap_local(dst);
> +               kunmap_local(src);
>         } else {
>                 if (PageHighMem(d_page)) {
>                         /*
> @@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, u=
nsigned long src_pfn)
>                          * data modified by kmap_atomic()
>                          */
>                         zeros_only =3D safe_copy_page(buffer, s_page);
> -                       dst =3D kmap_atomic(d_page);
> +                       dst =3D kmap_local_page(d_page);
>                         copy_page(dst, buffer);
> -                       kunmap_atomic(dst);
> +                       kunmap_local(dst);
>                 } else {
>                         zeros_only =3D safe_copy_page(page_address(d_page=
), s_page);
>                 }
> --
> 2.25.1
>

