Return-Path: <linux-pm+bounces-33886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC6B446B7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A116CA26
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C0272E45;
	Thu,  4 Sep 2025 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfV7Gi02"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C665202C43
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015332; cv=none; b=YunMcVMDlBV1LHfCUPiNZSpRMRkw3aOFTGCOV7bPRzFiHl5GQWuFEXeTESUSN1jLipvU69v843HRWP4HQnTSxW0FiQGABYmg41CLJRms+mAPEwRHiX4ejyZnlBd2L5dyg5SX+G/xXUZNdEmQNu9G1dJNjc52JLnoS6eu+H0+JAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015332; c=relaxed/simple;
	bh=OjIzYITrVy+xFFtJK8jw3hSSn0UbOMJJeWUcp2V+PfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOyIRTHWDVYAdxe0BTMcuG/edt559K5QctQziLYWjjUR7ZwQXspec93vI9rR1NgIfPff3OwVGpwzYp2VwsvbkHnG5MhdzlFJYlQCQZbVYprZuRVPIffkzeQwYldM6kVmuvx0xh7InQYKxAeAx0sI333uQ+Lc3dTSz1Fu7q2CBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfV7Gi02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F65C4CEF0
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757015332;
	bh=OjIzYITrVy+xFFtJK8jw3hSSn0UbOMJJeWUcp2V+PfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JfV7Gi02idejT2AAjdRPl2sjZyhC9W2Jq1slqHM+RKGvuY6UpTAQgSSgdHVBKcjPS
	 08gWWj56OcvD4vxsxmkD/kO0Kt7tXNRPfPDs0hnMLB8BoKxNaqtQAXTul9jujtXnnb
	 8kOpAiAG+7kc5WOMELTbpmHzCkJ8epV9xq7C6qxI0zy0AApITFChCsZ+LuuSiJzdDR
	 ylr4E9jfqzvDK4MrphzbBhoGq/MuiLZgEc03k2OUG3m50QbHxhr+mWz1SkEsnZd8tC
	 5yeqdWL0RtPXY3VsiuNHW4KXpANE3qylrFRFP/vX9iOQTmzbzEKMmhRNkic68AILVp
	 RRR4OFAOaV7uQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-746c06937c3so527454a34.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 12:48:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXlqwhg78CoEB/qt0hc3nNrGl8lbNGFngfJ8TPBOXcCDctNVgequrAYpMhLwYOT5pjOVA5WMSj8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgixDJ7vJxbKghTqDrqAvzeBNA2sOyBHrO6fxzCi9e9ndLnz0
	+uPw6MkowmNJVIJP26bv7e1s5AM9hX3M22ayyEyMDyzD4AE1mK/VgbJOpw7ZPsuSXKIPeLcTyr8
	Uf2xB3r0Wa9lGWHUxg6krkVGWSVm/w6s=
X-Google-Smtp-Source: AGHT+IG9ftamzv26SJwAcxxsjqPIJrR9WdUldfAI6dv5Q0zYCqAYtodo+SQYBvJ41eJUrtVL7zZZFF8Zqycg140hcpA=
X-Received: by 2002:a05:6808:2f05:b0:438:1d7f:4170 with SMTP id
 5614622812f47-439ae5416afmr481983b6e.7.1757015331372; Thu, 04 Sep 2025
 12:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826104650.100200-1-lijun01@kylinos.cn>
In-Reply-To: <20250826104650.100200-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:48:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h5z2rbJE4CaQkEPV_UmWShkS6FhNxDf9tW+X7aUeLFOw@mail.gmail.com>
X-Gm-Features: Ac12FXywAbqpVzAOZB8Gw9cIJW2lgLaNrWUWSMyMaq7wvG-QArd44Yrl2TeZ41E
Message-ID: <CAJZ5v0h5z2rbJE4CaQkEPV_UmWShkS6FhNxDf9tW+X7aUeLFOw@mail.gmail.com>
Subject: Re: [PATCH v4] hibernate: init image_size depend on totalram_pages
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:47=E2=80=AFPM Li Jun <lijun01@kylinos.cn> wrote:
>
>   Some automatically loaded applications greedily occupy
> memory, when total memory is 8GB, the image_size is 3GB,
> when total memory is 16GB, the image_size is 6GB, when
> total memory is 32GB, the image_size is 12GB. some
> of these applications,user may not use them. They occupy
> a large amount of image space, resulting in S4 time of
> over 100 seconds or even more.
> The experimental data is as follows:
> TR11A2 loongarch 3A5000 Kylin-Desktop
> image_size =3D 6723878912
> 1. hibernation 15S  wakeup 43S
> 2. hibernation 15S  wakeup 44S
> 3. hibernation 15S  wakeup 44S
> image_size =3D 3361939456
> 1. hibernation 9S wakeup 38S
> 2. hibernation 8S wakeup 37S
> 3. hibernation 8S wakeup 38S
> image_size =3D 0
> 1.hibernation 8S wakeup 34S
> 2.hibernation 6S wakeup 35S
> 3.hibernation 6S wakeup 34S

Well, this is not really convincing.

If there are applications that actually use the memory they allocate
and it all needs to be swapped out during the memory preallocation
before image creation and then swapped in after resume, doing that
will take much more time than you can save by reducing the image size
in your case.

Yes, the hibernation/resume times measured between the start and end
of the hibernation process may be shorter, but the user may need to
wait for all of the requisite memory pages to fault it much longer.

Also users can reduce the image size via sysfs if the default does not
work for them very well.

I see no reason for changing this, sorry.

> Record timestamp use tty and minicom.
> hibernation time is from
> [2025-06-03 13:51:30] [13235.652150][ 0]  PM: hibernation entry
> to
> [2025-06-03 13:51:36] [13241.599299][ 0]  PM: S|
> wakeup time if from
> [2025-06-03 13:52:20] Shut down slave cores done!
> to
> [2025-06-03 13:52:54] [13240.271609][ 3]  PM: hibernation exit
>
>   When the current physical memory is 8G. the total number of RAM
> pages is probably 7.7760GB,less than 8G a little=EF=BC=8C
> the CNT_8GB >> 23 is 0,when the current physical memory is less
> than 8G, the CNT_8GB is also 0,so the current image_size will be
> initialized to 2/5 of the totalram_pages().
>   When the current physical memory is 16G. the total number of RAM
> pages is probably 15.7330GB,less than 16G a little=EF=BC=8C
> the CNT_8GB >> 23 is 1,so the current image_size will be initialized
> to 1/5 of the totalram_pages().
>   When the current physical memory is 32G. the total number of RAM
> pages must be greater probably 24GB, the CNT_8GB >> 23 is 000011,
> so the current image_size will be initialized to 1/10 of the
> totalram_pages().
>   When the current physical memory is 64G. the total number of RAM
> pages must be greater 56GB, the CNT_8GB >> 23 is 0000111,so the
> current image_size will be initialized to 1/20 of the totalram_pages().
>   When the current physical memory is 128G. the total number of RAM
> pages may be greater 120GB, the CNT_8GB >> 23 is 0001111,so the
> current image_size will be initialized to 1/40 of the totalram_pages().
>   This way, when there are 16GB, 32GB or 64GB, the size of the
> image size will be controlled to be slightly more than 3G.Just
> shrink more NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON,
> NR_ACTIVE_FILE, NR_INACTIVE_FILE pages,this may cause pages to be
> flushed to swap during the "shrinking" of memory and restore will
> spend some extra time,but this time compared to the additional
> 3GB or 9GB of image data from read-write compression and
> decompression,this time is definitely less,may be this time is
> consumed after hibernation exit or display screen is illuminated.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 501df0676a61..dad2e17b1a18 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -135,10 +135,13 @@ void __init hibernate_reserved_size_init(void)
>   * try to create the smallest image possible.
>   */
>  unsigned long image_size;
> +#define PAGE_SIZE_KB   (PAGE_SIZE >> 10)
>
>  void __init hibernate_image_size_init(void)
>  {
> -       image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +       unsigned long CNT_8GB =3D (totalram_pages() * PAGE_SIZE_KB)>>23;
> +
> +       image_size =3D ((totalram_pages() * 2) / (5 * (CNT_8GB + 1))) * P=
AGE_SIZE;
>  }
>
>  /*
> --
> 2.25.1
>

