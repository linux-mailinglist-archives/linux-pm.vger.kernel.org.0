Return-Path: <linux-pm+bounces-37621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60ADC409E1
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 16:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D110188726B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311B2F83BC;
	Fri,  7 Nov 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR2yb5c9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD68268690
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529815; cv=none; b=rFOPY0RPg+1A+KigqylZu+1v9yWwMOtO5DeWy/akUWefwUl3qhZYAlyldy6Bx7NzV8aYxZODw6lrJh7ZLW91SQWrG1mevwaaUAeab+EMlaAye1lJUU01Ww7eEBfFEYv4oJQUWc6CQ6uTWTnT8Ja9WRUPPYICRUIN1cSGuAKwHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529815; c=relaxed/simple;
	bh=Si2Bq8Ogur87f5qpKbgXK8PPxENzv8KywcYsabwMvc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdxH2rkfhZeS48o97aV8/hZMkWjGskYLe+qZc+Hza9RPHbJQCrpvW9yVCJtjlp5u8hhhBKHzDdipJexeZSf1Tf3LJPk8FTLaQ5RWqJlVOolrulTlDZg6lBqh5z3JbJ32kOt4IA6N4/4uve9ePsfhJHf3fiJIzAWpk/nc8RdFG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR2yb5c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38386C2BCB0
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529815;
	bh=Si2Bq8Ogur87f5qpKbgXK8PPxENzv8KywcYsabwMvc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KR2yb5c9YsDcniYO9MhFxn8ROzzP61FaKLLKDq/2b0fX45fmexiKPW71Yl2Hulsey
	 Hj9RkVvIM53wgNnTNQcgv+X47CExD2V8a7VNT1nt2GLFcg/14zQpQ+p4wOD4ocRvUT
	 KlFcMNQlUg7rq0LG89sjO+JMYD94clcTjMSifQNhBs56V7XdZjAZ8Xcn0hQPPkdjzo
	 PibnhB0ikeVEnpA1eNtQqkO+AVZ8pFy3DAATyJ7Y3c/9N43zCzm7Y2nPxRi8Xlftb1
	 Sxr678V6g52OJibI388rn67K527nhkcmAHw6ZDImKOTq6w2MJopZcNxm8m2DAVZYID
	 EodC5E2P/xtYw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450154aa53fso390628b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 07:36:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxD+azikFI/DykZYIaZHnfTMEMF24F15LREaJioDy0TOGxgn0x5O+kuzTmnLfc2AzkgUhoh4V0wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUT4hpKhROL4CYHT38Wh8bD3HcTE+or7793WzJGwSysdzS9Yo
	VsooQQeUbf8/s3VOsRxdYJRZCKjLIvLNod/BSdM4g3OWWLH3khoEv5F6zZ6MAtNHfjzNwi8noRl
	yCnAjJSIKmz0mNtd/Nl+bR4ewyRfkD10=
X-Google-Smtp-Source: AGHT+IF+hF0a/4jdccGprT1Ok5sOlEoV5zNYSD6Sa1iO8XyJe7DWuz0CF46Gyo7rs83DksyLvuUHXTduouMUBwzEkNA=
X-Received: by 2002:a05:6808:c145:b0:441:8f74:fcc with SMTP id
 5614622812f47-45015f57eebmr2100597b6e.57.1762529814298; Fri, 07 Nov 2025
 07:36:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com> <20251106113938.34693-2-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251106113938.34693-2-adelodunolaoluwa@yahoo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 16:36:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gG3C4r-d+v2xGPqcF1Hn927NR7yBA7kLx4t6TjEo0rGA@mail.gmail.com>
X-Gm-Features: AWmQ_bln76la9sUIlc6o0dhJ2_1ERWzWQa1zkPxNs6CHxbD_ok4RRm8d0omTNBU
Message-ID: <CAJZ5v0gG3C4r-d+v2xGPqcF1Hn927NR7yBA7kLx4t6TjEo0rGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] power/swap: add missing params and Return:
 descriptions to kernel-doc comments
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, mingo@kernel.org, 
	tglx@linutronix.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:40=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Kernel-doc checks (scripts/kernel-doc) reported a number of warnings
> for missing parameters and `Return:` descriptions in kernel/power/swap.c.
> These missing return descriptions make the generated documentation
> noisy and break doc-build when -Werror is used.
>
> Update the kernel-doc comment blocks to add explicit
> Return: lines (and a few parameter tags where helpful) for the functions
> that were triggering warnings. No functional code changes are made.
>
> Example warnings that motivated this change:
>  - Warning: kernel/power/swap.c:535 No description found for return value
>    of 'save_image'
>  - Warning: kernel/power/swap.c:687 No description found for return value
>   of 'save_compressed_image'
>  - Warning: kernel/power/swap.c:941 No description found for return value
>    of 'swsusp_write'
>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>

These comments need more changes to become proper kerneldocs and in
some cases it is not even necessary because the functions in question
are static.

If the goal is to avoid warnings, why don't you change them all to
non-kerneldoc regular comments?

> ---
>  kernel/power/swap.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 0beff7eeaaba..3f0df7a26bc3 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -341,6 +341,8 @@ unsigned int swsusp_header_flags;
>   *     and get its index (if so)
>   *
>   *     This is called before saving image
> + *
> + *     Return: 0 on success, negative error code on failure.
>   */
>  static int swsusp_swap_check(void)
>  {
> @@ -367,6 +369,8 @@ static int swsusp_swap_check(void)
>   *     @buf:           Address we're writing.
>   *     @offset:        Offset of the swap page we're writing to.
>   *     @hb:            bio completion batch
> + *
> + *     Return: 0 on success, negative error code on failure.
>   */
>
>  static int write_page(void *buf, sector_t offset, struct hib_bio_batch *=
hb)
> @@ -528,6 +532,11 @@ static int swap_writer_finish(struct swap_map_handle=
 *handle,
>
>  /**
>   *     save_image - save the suspend image data
> + *     @handle: swap map handle for writing the image
> + *     @snapshot: snapshot handle to read pages from
> + *     @nr_to_write: number of pages to write
> + *
> + *     Return: 0 on success, negative error on failure
>   */
>
>  static int save_image(struct swap_map_handle *handle,
> @@ -676,6 +685,8 @@ static int compress_threadfn(void *data)
>   * @handle: Swap map handle to use for saving the image.
>   * @snapshot: Image to read data from.
>   * @nr_to_write: Number of pages to save.
> + *
> + * Return: 0 on success, negative error code on failure.
>   */
>  static int save_compressed_image(struct swap_map_handle *handle,
>                                  struct snapshot_handle *snapshot,
> @@ -906,8 +917,9 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>
>  /**
>   *     enough_swap - Make sure we have enough swap to save the image.
> + *     @nr_pages: number of pages we need to save
>   *
> - *     Returns TRUE or FALSE after checking the total amount of swap
> + *     Return: TRUE or FALSE after checking the total amount of swap
>   *     space available from the resume partition.
>   */
>
> @@ -930,6 +942,8 @@ static int enough_swap(unsigned int nr_pages)
>   *     them synced (in case something goes wrong) but we DO not want to =
mark
>   *     filesystem clean: it is not. (And it does not matter, if we resum=
e
>   *     correctly, we'll mark system clean, anyway.)
> + *
> + *     Return: 0 on success, negative error code on failure.
>   */
>
>  int swsusp_write(unsigned int flags)
> @@ -1078,9 +1092,12 @@ static int swap_reader_finish(struct swap_map_hand=
le *handle)
>  }
>
>  /**
> - *     load_image - load the image using the swap map handle
> - *     @handle and the snapshot handle @snapshot
> - *     (assume there are @nr_pages pages to load)
> + *     load_image - load the image using the swap map and snapshot handl=
es
> + *     @handle: pointer to the swap map used for reading swap pages
> + *     @snapshot: pointer to the snapshot handle that tracks image pages
> + *     @nr_to_read: number of pages to read from the snapshot
> + *
> + *     Return: 0 on success, negative error code on failure.
>   */
>
>  static int load_image(struct swap_map_handle *handle,
> @@ -1195,6 +1212,8 @@ static int decompress_threadfn(void *data)
>   * @handle: Swap map handle to use for loading data.
>   * @snapshot: Image to copy uncompressed data into.
>   * @nr_to_read: Number of pages to load.
> + *
> + * Return: 0 on success, negative error code on failure.
>   */
>  static int load_compressed_image(struct swap_map_handle *handle,
>                                  struct snapshot_handle *snapshot,
> @@ -1529,6 +1548,8 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>   *     swsusp_read - read the hibernation image.
>   *     @flags_p: flags passed by the "frozen" kernel in the image header=
 should
>   *               be written into this memory location
> + *
> + *     Return: 0 on success, negative error code on failure.
>   */
>
>  int swsusp_read(unsigned int *flags_p)
> @@ -1567,6 +1588,10 @@ static void *swsusp_holder;
>  /**
>   * swsusp_check - Open the resume device and check for the swsusp signat=
ure.
>   * @exclusive: Open the resume device exclusively.
> + *
> + * Return:
> + *        0 if a valid hibernation image is found,
> + *        negative error code on failure.
>   */
>
>  int swsusp_check(bool exclusive)
> @@ -1631,6 +1656,8 @@ void swsusp_close(void)
>
>  /**
>   *      swsusp_unmark - Unmark swsusp signature in the resume device
> + *
> + *      Return: 0 on success, negative error code on failure.
>   */
>
>  #ifdef CONFIG_SUSPEND
> --
> 2.43.0
>

