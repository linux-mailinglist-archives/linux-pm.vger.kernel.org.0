Return-Path: <linux-pm+bounces-37875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD5C54627
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0E534E2A6E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151027703E;
	Wed, 12 Nov 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0+s0V8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196431397
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978073; cv=none; b=uwgDtjnrtRbq/wKVjToS2XypMSicXwXGUYlimMK5b/JmLUCajyr3ps0i78k6RU6RXaspCyDrAxhUvKWUR2RsFLjSwvuapCsskn0Gcmift5Lld+NGG4sn2KfPiCxrsYftX6MlZVob+LG2pfmcROS/ile2AQs7zp3SGDm4VhMl8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978073; c=relaxed/simple;
	bh=vVBal5Kzk7fkAnG9uQe2oIMU6cm2imGDuVo7gW5jwAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8ZN/GSgqILWHrHkIkSBQ/Gqwp35ufPCOGyBdULfirrenL8dfBiOG20hzRHnWJoT5vdWT1z1kJzi+dlNrRHVoc3FO+EVo1b75D819Nq2I6nopgIo+gYSCFLeJfbhuzTpeCc1LI2/OMU1esx3AclfSFoxj5eZ1Xn9NpLzjI6Da2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0+s0V8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0A5C19424
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762978072;
	bh=vVBal5Kzk7fkAnG9uQe2oIMU6cm2imGDuVo7gW5jwAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u0+s0V8YrP04MnWYsacxqQiVb7+jQXAhKfjtmIgbO41DIylhypDJ9F5CjXPnFbzK3
	 l8cZjdFb63WW2ub77KpieuGyfzftvlGrW4xsoN40Keru4U2Au4if35e3vEJCmh0cFg
	 0cktA2+1VGXMTWu7zMeOBJNEKH7INPtHQMZYckZBBnkQM7C6SzJXtTIZ5uUN4mw5bP
	 s6wbP1R2hBKMWEAT7QVOoVISrM4X0woHVC/h/RqQQBtnyyAtVZQio2uEayAVoPr2VS
	 JMDnZUFu1CoWWgkQI1fm43vN454fwchjL5135YAuLwkYLSnfbdOyg3gVgiep2PACJ0
	 J0PcYv4DX7Rjw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-651cda151f0so64366eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:07:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjwXIQaeqniJVpyznMuxGBVKFsETyjO614irvsBzzTXGkL0sC/tKFyMdoaML17dRPPlKrI3ymN9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMWKus6Wa2UUkbCdFmLPzovjNGyLl4Wa4TBv75UrCpcczNNCz
	MEGgKU/74JGc+Szy++TYU3TRf43i+A9h3lCM7XM9lhVDfTwlsUJxa4zpjwNQiyF0yfZ5VJTJrVx
	oW5fUZBJmkhFgYLngGfc1k/MoI7jDNxU=
X-Google-Smtp-Source: AGHT+IGwYiIFbRkFL3h9dqQCSKOrBzmm7cihC9sfDuJDHgJXo9D38mFo2766T2t3LE1zcWGlwd1hDaIAFO5QfYPjpzc=
X-Received: by 2002:a05:6820:1896:b0:656:9c61:9db8 with SMTP id
 006d021491bc7-65716252535mr2141137eaf.4.1762978071898; Wed, 12 Nov 2025
 12:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035955.62171-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251030035955.62171-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:07:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gSDfsnrnh0a8LaKv8+_RbarA-uemhRmv1c356Rx87ijw@mail.gmail.com>
X-Gm-Features: AWmQ_blj1OXIMB_Gd_a-ePWWOloo6nu7Dmhj-JjbC9cGAPOX_vSfu3yrt31bB8c
Message-ID: <CAJZ5v0gSDfsnrnh0a8LaKv8+_RbarA-uemhRmv1c356Rx87ijw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: Use symbolic constant for UUID prefix comparison
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:02=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace sizeof() with a symbolic constant for UUID matching to maintain
> existing ABI behavior while improving code clarity. The current behavior
> of comparing only the first 7 characters is sufficient to distinguish
> all UUIDs and changing to full string comparison would alter the kernel
> ABI, potentially breaking existing userspace applications.
>
> Use a defined constant to make the truncated comparison explicit and
> maintainable.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Use symbolic constant instead of strlen() to maintain existing ABI
>   behavior as review feedback
>
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 908cc1bf57f1..128556632685 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -16,6 +16,8 @@
>  #define INT3400_ODVP_CHANGED 0x88
>  #define INT3400_KEEP_ALIVE 0xA0
>  #define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with 20C */
> +/* UUID prefix length for comparison - sufficient for all UUIDs */
> +#define INT3400_UUID_PREFIX_LEN 7
>
>  enum int3400_thermal_uuid {
>         INT3400_THERMAL_ACTIVE =3D 0,
> @@ -199,7 +201,7 @@ static ssize_t current_uuid_store(struct device *dev,
>
>         for (i =3D 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
>                 if (!strncmp(buf, int3400_thermal_uuids[i],
> -                            sizeof(int3400_thermal_uuids[i]) - 1)) {
> +                            INT3400_UUID_PREFIX_LEN)) {
>                         /*
>                          * If we have a list of supported UUIDs, make sur=
e
>                          * this one is supported.
> --

Applied as 6.19 material, thanks!

