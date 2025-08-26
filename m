Return-Path: <linux-pm+bounces-33110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46CB35D5E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158597C5EC9
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAB334717;
	Tue, 26 Aug 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3pfuScp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B43277A4;
	Tue, 26 Aug 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208605; cv=none; b=nK1kOjRCaGLrRa2ocyvxVnZGcNeyIR4PuVBnsPnFCINHACSIqoYwL+lfF6opa1v6irrgsOhjWzLX56+bY6/FBSAFmPV/khALCUU9a40L6DvTxEC267PCf6v+3EO9WhnGDFGm3UXb824u3LXMitFWt1K4geEwyEJBQKBFCm/6nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208605; c=relaxed/simple;
	bh=LfyUfTryKsWamA6F21pn6X8pyV8Y62YeqSF5xoWsciM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i92Ok5gFZKwskwN58YlZ2HvSrMsDijFIWw+JpctmdlLfiBm7DOPxhAfDsBO64dKmNFsiM4JxwPZlF/1oBzFa9Wr2ST/uTB7BacQCTIISKn48vfracKhK3HXQEPlHWNKW5+r4f3jNCHT5Wv+i10h+Wlze9Y5xhYkLbPBqqWzV+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3pfuScp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E6C4CEF1;
	Tue, 26 Aug 2025 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208604;
	bh=LfyUfTryKsWamA6F21pn6X8pyV8Y62YeqSF5xoWsciM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l3pfuScpmZcRiXD0mTShqOofGy4dhtPTZB3L6EFriWdEMMew7bRP86AhjzEHXAtz2
	 OHpRFbP82YikDcu9vVPEtsGC3rpeyhv6fd122iycChoTkQXaNY29l4/WH4mD/fZKf4
	 808cvdWegqDYtBRQ5p0KtHzET6muiZSTny0+CV3bKvmhwgfV6vDg+oq6lkdRHKTZit
	 ndA8uRRl+wAeyLQFDI94As9Rs1gyNzmJic3ILctLDp1KaF98tKDSN9+5hX8XYuYLev
	 MqYJqX+Wvw1rwOYOXjg3sHt7J6uU/AysIfJjVIHS//Buwf7kv5pN8U1TREmF5/O2Wv
	 L3BGCCzshdXiQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca7a46so562267a34.2;
        Tue, 26 Aug 2025 04:43:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPhkl6HMMFQ+cr7EdcaeETodGtXnjpxWVswhwJHBoELeDrdey4uiryDl3m88nuk1RPZcbyTRQ2CLjCpZ4=@vger.kernel.org, AJvYcCW/LBHnCBF3FAgB+YZkjM6NscZV2I8ZzZMXDprwzRCWFcu+CmmmilVnuYR2Ft+o4ua8W+Fi3v8py9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5PlpOoLi/AAp3ie8y3+DfVDTtL0mOD1einN+Q6bGuSw6vBtU
	fzmLJfVvwoqYQHdV0OsJwI1nLQSP9H6bZD2dgnqc2Do4g8Ufn7bjf+Ragf9JOBiYDMSbbzWAxEc
	ELiLk/M44nxu8y/68uSJd0zBcsXvAEfI=
X-Google-Smtp-Source: AGHT+IFaeDEb21XcBUS/Zu/xogYBJx/QKbPKr2CLIGd3LD4u1AibGKcOzoBL7ge1dklMpy2FDSXxYsZBYGOv/8AWrbE=
X-Received: by 2002:a05:6830:d09:b0:744:f0db:a1a6 with SMTP id
 46e09a7af769-74500aaec39mr9177603a34.34.1756208604069; Tue, 26 Aug 2025
 04:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826091937.991667-1-luoxueqin@kylinos.cn>
In-Reply-To: <20250826091937.991667-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Aug 2025 13:43:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gD8RkKG8+6MneaDkxndS-oAm8a1AswEDP1w8HVCGZDdw@mail.gmail.com>
X-Gm-Features: Ac12FXz4QTe2eFTZrv9VFMMOZJQ1vEZB9h-wvJZ_0H7xsq6_xN-sC7V6EEbrZPM
Message-ID: <CAJZ5v0gD8RkKG8+6MneaDkxndS-oAm8a1AswEDP1w8HVCGZDdw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: make compression threads configurable via
 kernel parameter
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:19=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> =
wrote:
>
> A new kernel parameter 'cmp_threads=3D' is introduced to
> allow tuning the number of compression/decompression threads at boot.

And why is it useful/needed?

> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/swap.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index ad13c461b657..43280e08a4ad 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -520,7 +520,8 @@ static int swap_writer_finish(struct swap_map_handle =
*handle,
>  #define CMP_SIZE       (CMP_PAGES * PAGE_SIZE)
>
>  /* Maximum number of threads for compression/decompression. */
> -#define CMP_THREADS    3
> +#define CMP_MAX_THREADS        12
> +static int cmp_threads =3D 3
>
>  /* Minimum/maximum number of pages for read buffering. */
>  #define CMP_MIN_RD_PAGES       1024
> @@ -585,8 +586,8 @@ struct crc_data {
>         wait_queue_head_t go;                     /* start crc update */
>         wait_queue_head_t done;                   /* crc update done */
>         u32 *crc32;                               /* points to handle's c=
rc32 */
> -       size_t *unc_len[CMP_THREADS];             /* uncompressed lengths=
 */
> -       unsigned char *unc[CMP_THREADS];          /* uncompressed data */
> +       size_t *unc_len[CMP_MAX_THREADS];             /* uncompressed len=
gths */
> +       unsigned char *unc[CMP_MAX_THREADS];          /* uncompressed dat=
a */
>  };
>
>  /*
> @@ -703,7 +704,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
>         if (!page) {
> @@ -1223,7 +1224,7 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
>         if (!page) {
> @@ -1667,3 +1668,14 @@ static int __init swsusp_header_init(void)
>  }
>
>  core_initcall(swsusp_header_init);
> +
> +static int __init cmp_threads_setup(char *str)
> +{
> +       int rc =3D kstrtouint(str, 0, &cmp_threads);
> +       if (rc)
> +               return rc;
> +       return 1;
> +
> +}
> +
> +__setup("cmp_threads=3D", cmp_threads_setup);
> --
> 2.43.0
>

