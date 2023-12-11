Return-Path: <linux-pm+bounces-922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C980DCBD
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 22:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8601C215AC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDB54BE5;
	Mon, 11 Dec 2023 21:15:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADCBE;
	Mon, 11 Dec 2023 13:15:05 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6da06c505ccso550749a34.1;
        Mon, 11 Dec 2023 13:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329305; x=1702934105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShV908uKHQ8j/q2SdlmwNDhfAbS3fETYLN+N3BXqHYs=;
        b=RwnbQpywAqTgpueJ2q/gkzUpxdOVED24PR9imDQn2Fv2zqjjehbZmKk7YizK/KTBK3
         bsp5X68BYe+lelaTK7ysNEQV5fM1gzI3hSRYCaDX0gqvNY/H4Z+rPkak/GPJg+FoC8iE
         T9/MhgdaUdfbe554gbnbCJTCLjuS1sqJqlWNnfn2tbII3UYK0uWsC0Ik2deVUUaT98+K
         Rb6I83F7DmKe7RQmjJjFHY4FKW5DdRtjobGVp2wwMAVzKeyulgh6qW0ZzFskvZLkPjG+
         skZ/ixFjNMhcYVVcdFMnJj2oLcIv6qwCQrsYCaZZ5e6g9qQ/H+UDV2eyi59PrSV2S52n
         z13Q==
X-Gm-Message-State: AOJu0Yy9DZvdYTfmFtDCd5mtQ3ndMoAlPR1vw/53ET66A+SxeITyEs6U
	GCrOIrSXzbIPY8xkaZwhqEgNcoin1olI4fkSFZo1GSoM
X-Google-Smtp-Source: AGHT+IHvGulAvqcIMEplX7CPNUZzrFCuQ8ytXiwmfCM/w9hUMupXPQE+XzfgW/DvSpooPl0Ba8YBd4xLJ/SAfNjPn8w=
X-Received: by 2002:a05:6871:289:b0:1fb:30b8:bb5c with SMTP id
 i9-20020a056871028900b001fb30b8bb5cmr10324867oae.3.1702329304988; Mon, 11 Dec
 2023 13:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027021303.26187-1-kunyu@nfschina.com>
In-Reply-To: <20231027021303.26187-1-kunyu@nfschina.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 22:14:53 +0100
Message-ID: <CAJZ5v0jM=H=mAVLpDHbpUm1yg3rwHJg5JhN6ZyypW9cvo+H8Eg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_power=3A_swap=3A_Remove_unnecessary_=E2=80=980=E2=80=99_?=
	=?UTF-8?Q?values_from_ret?=
To: Li kunyu <kunyu@nfschina.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 4:13=E2=80=AFAM Li kunyu <kunyu@nfschina.com> wrote=
:
>
> 'ret 'is first assigned a value and then used, it does not need to be
> assigned at definition time.

But the compiler may be confused, at least in the first case.

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/power/swap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 90bb583c57bf7..32e8cb6ceaea4 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -679,7 +679,7 @@ static int save_image_lzo(struct swap_map_handle *han=
dle,
>                            unsigned int nr_to_write)
>  {
>         unsigned int m;
> -       int ret =3D 0;
> +       int ret;

It is better to leave the code as is here as the compiler may still
complain about the initialization of ret.

>         int nr_pages;
>         int err2;
>         struct hib_bio_batch hb;
> @@ -1060,7 +1060,7 @@ static int load_image(struct swap_map_handle *handl=
e,
>                        unsigned int nr_to_read)
>  {
>         unsigned int m;
> -       int ret =3D 0;
> +       int ret;
>         ktime_t start;
>         ktime_t stop;
>         struct hib_bio_batch hb;
> @@ -1166,7 +1166,7 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>                            unsigned int nr_to_read)
>  {
>         unsigned int m;
> -       int ret =3D 0;
> +       int ret;
>         int eof =3D 0;
>         struct hib_bio_batch hb;
>         ktime_t start;
> --
> 2.18.2
>

