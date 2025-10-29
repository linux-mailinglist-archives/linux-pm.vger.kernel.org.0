Return-Path: <linux-pm+bounces-37058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68514C1C5AB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DC645352
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73092F4A1E;
	Wed, 29 Oct 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg+Ncr2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D132F0692
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756024; cv=none; b=ENzvVWUbnnLoFIajzrjqgqEu7t/0+Fmnp7pBfQ9is7PezpKI+OJ91YXbZJ5szBE273RB+44UzW84GVb4ybcF7U5u6lktblN5/YvfFQ63ABOy5XGKYs/P+ov95QLbzNH9AA+hgq3HyMrfsd/Ipvn5t82EP10cY38Ran30URVQGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756024; c=relaxed/simple;
	bh=G/BTBuP6XNNK9/4zgp/uJvSUWcsHQxl07syVUgkncbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF9iAUESt6Z2NevkQHXoE1KsfLHHHHIiUtw29dFXWDQXq0D4+i6c0FkOrcEL3afGiE+nparQdDuwS2xDbNVh3uJJ3Ah0+Ien5wyadmB2EQQl9Eei2aQnikWPlDFlwfr4afRnkOyTdLAuwwZv1ZTG5m9AnRFtCiVGdKZWTdL1QB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg+Ncr2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17EC4AF09
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756024;
	bh=G/BTBuP6XNNK9/4zgp/uJvSUWcsHQxl07syVUgkncbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xg+Ncr2kX+zfQ5E4CidV5L2t1CjuxzoYAP4fFLvu4eN72lBza7c/gp31HLmzxdU5J
	 5thzR8v+RhqCb015UwtYIupPz4J63dRNIdXkEawyT44OXlHRQ4RR4Sxgp+r2W4ckhr
	 5SMQ7eZ7qyz9WfTau+Qf7idfm9ULaVOdzPmIL1WtaSl66MENdWOa5h7iFYwg6bFqaN
	 uNR9Q0+dhWAxhnRZzUbpUBPHqL0CHhhiJ0Ug6I7/7Qi+rwCk0IJ6hWDQU8mSfzQilG
	 5jYD7q8Xv9IeT/+AarP7jWywPE6ewyUN5k/Qhb8X6XYIWeTI3IQyBAx3h6gD6RgvVn
	 XBjybLj1ytCvg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65675447dbbso7580eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 09:40:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ0xKutAmF0akeqqjKwjXIkAGrmps3PLUEGSFYNLQYe6ZZdN8U4WrhliKrvnOVGLfOalv7G8JyGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyogWQ3UTXLy9Fe0xKTi+A/KqF1k7uN8ZNqHKqme1NJThwBBm5L
	BLz+SIScFfBHGnKCNjHg+4IEL+X4UGJDHhS2KWhvE8QerfQ2RrhB00hHeheYCpLlSuV+rcSS4Oo
	xVDcTGtDrBFqaMgtLnsRdwuwAZt5Rb3U=
X-Google-Smtp-Source: AGHT+IEJtb/qiU8UMtHGSNkJON9tr48bsioWynRPRmReL70XpwmlEl6bJlHxQ0fxYjsCYS0xLVW6B4mH7ITSfItCpCQ=
X-Received: by 2002:a05:6820:823:b0:654:f193:26dc with SMTP id
 006d021491bc7-65677e553a0mr1388542eaf.2.1761756023518; Wed, 29 Oct 2025
 09:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017072703.2064390-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251017072703.2064390-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 17:40:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hK+ZaV2F8_LEjyCQyyvE-HeWX4Oyw-MVjzODQucyurkw@mail.gmail.com>
X-Gm-Features: AWmQ_bkUof-4UOoJTR3u93kW32JfpIKIPW7d2OW47xnB_7lL6JUSmXcgEgEXlbU
Message-ID: <CAJZ5v0hK+ZaV2F8_LEjyCQyyvE-HeWX4Oyw-MVjzODQucyurkw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Fix UUID string comparison in current_uuid_store()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:29=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Use strlen() for UUID matching instead of sizeof() to ensure
> correct comparison of supported UUIDs. sizeof() returns pointer
> size instead of actual string length, causing incomplete UUID
> matching.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 908cc1bf57f1..236003d12dc7 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -199,7 +199,7 @@ static ssize_t current_uuid_store(struct device *dev,
>
>         for (i =3D 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {

Exercise for the reader: Add a printk() here to print
sizeof(int3400_thermal_uuids[i]) and see what number gets printed.

>                 if (!strncmp(buf, int3400_thermal_uuids[i],
> -                            sizeof(int3400_thermal_uuids[i]) - 1)) {
> +                            strlen(int3400_thermal_uuids[i]))) {
>                         /*
>                          * If we have a list of supported UUIDs, make sur=
e
>                          * this one is supported.
> --

