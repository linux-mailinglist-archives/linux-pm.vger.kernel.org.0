Return-Path: <linux-pm+bounces-7653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D667B8BFF69
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FB01C230E9
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9C839E1;
	Wed,  8 May 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbuEO4zT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347526291;
	Wed,  8 May 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176133; cv=none; b=M62kcUh3I5yjdm8r4z7CiZXiTbHZL805nbNTvxdzLP3ck7kT4FBL/3J2g5gYz/uHIdM+pWcDFGSU7vjSwD4jlcq+p3MqF4vrlGbPraFS7jgLkPWcu85eG9S/3CYOXRtxBXO61Dr1vwe85srN/GT/7F6G3EseuyvzLonPwApS1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176133; c=relaxed/simple;
	bh=RvBvHR8tpaNSPjpIaQ2S9RFa9Z2xB39+FjDYQky6eZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3YFzg3bbQmrU7c6m40+6O6JO3pQFtugQ6Idq4nPiJeOHe1HvpJJBHV9l08c7Xq3vZFlv4jFVZW8DQcEnhrfaq16gaxCnPw6tHePzg+3zl/XSUQOKn9TKkhlZ1xpIF6p8qPnhTfWPWzbBMmzuwYEUpF6X3RiscBUWLGG5Yc5FSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbuEO4zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163F4C2BD10;
	Wed,  8 May 2024 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715176133;
	bh=RvBvHR8tpaNSPjpIaQ2S9RFa9Z2xB39+FjDYQky6eZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PbuEO4zTG/fQr9EtiBd28WYhzFjftQQ34gL6zIOG6gE+z4F/hv9FbahMbp6MOZoLj
	 HMxnib9gYNfB/1nrJbgABcCFJxVPDoXClfewmxTjCRgxr0mS3or9GaK7+Po0P+O+qY
	 n6KrAFSEHr/4fOwpwuVl6RtFkkma0ZNEjOtPfLj2MS9+MhM2/2prEQIsFzm9LEyDfK
	 8LIoBFfNUxfh3raq4ylItkX2YNTuFSfWXMtUrxl/Wzlteu3Vu0kkQIbQZZglFa4tiJ
	 /vXbWAf0J/AQa5UtKMnNkL/KfYOpa+DPddAlKgttERzIeGbjt4nzi2bs/JosoB6824
	 9Q8wAQ6JAsKDA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ebddef73b5so364943a34.3;
        Wed, 08 May 2024 06:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRnLAIJhVj049UqtEqrKsN/x3kJfAwOfY1gMptgkRF9o/0IVrVFYm7cbT5yQbM5ifgM0NILckHgVk8k9HEY+IJqccuNHMUbsYbqk+3BMU1FSp8MA5bNJVsmZsPGoyOzDwIgVAKTQg=
X-Gm-Message-State: AOJu0YyC7sT2IU9PRzZ4s29vsqTLubwmzKYXO41MmQcZPFP89p+bt2mG
	6V0CHwonozp2KOiATVDY0rd04YlsjsNIWzzKbAEkvvND16nR2og3e8BE11XXTzzETCrQD1a2FdR
	rBBTahYIhVcxK55VGq7XOAe+/qi0=
X-Google-Smtp-Source: AGHT+IGr2MAiACXNK6aGcyf4S2YJWds6rAoLmuHB46QUDgNNhweh3FGQ88XaQIXu+DsIzFvY8xyxka/qECvChj7PqZc=
X-Received: by 2002:a4a:3158:0:b0:5b1:ff38:5ee0 with SMTP id
 006d021491bc7-5b24d470f6fmr2499685eaf.1.1715176132398; Wed, 08 May 2024
 06:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 May 2024 15:48:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gV3AB7UjRXm674Yd3O87Q0bFRfe0x8eHoBQ8FQKFUZ3A@mail.gmail.com>
Message-ID: <CAJZ5v0gV3AB7UjRXm674Yd3O87Q0bFRfe0x8eHoBQ8FQKFUZ3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thermal: intel: hfi: Update thermal netlink parameters
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 5:37=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> This is v2 of a series previously known as "Add debugfs files for tuning"
> [1].
>
> Changes since v1:
>
> Rui and Rafael pointed out various problems with using debugfs for tuning
> how HFI uses thermal netlink. Instead, in this version I attempt to fix
> the issues that motivated v1 (see the cover letter of v1 for details). I
> update the two parameters that control how HFI uses thermal netlink: the
> delay between an HFI interrupt and the thermal netlink event as well as t=
he
> size of the message payload.
>
> Added Acked-by: tag from Rui on patch 1 (thanks!).
>
> These patches apply cleanly on top of the testing branch of Rafael's
> linux-pm.
>
> Thanks and BR,
> Ricardo
>
> [1]. https://lore.kernel.org/linux-pm/20240429234152.16230-1-ricardo.neri=
-calderon@linux.intel.com/
>
> Ricardo Neri (4):
>   thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
>   thermal: intel: hfi: Shorten the thermal netlink event delay to 100ms
>   thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
>   thermal: intel: hfi: Increase the number of CPU capabilities per
>     netlink event
>
>  drivers/thermal/intel/intel_hfi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> --

Whole series applied (with Rui's ACKs) as 6.10 material, thanks!

