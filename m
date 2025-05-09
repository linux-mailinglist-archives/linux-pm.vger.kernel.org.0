Return-Path: <linux-pm+bounces-26967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E9AB1A9B
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B852A3A53A9
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D6231841;
	Fri,  9 May 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8kDJ7G9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC818DF8D;
	Fri,  9 May 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808554; cv=none; b=Uuw1o4BXm2pLKg6wO9/a0LofXIF+ZlUSUsDvHJjKsHCUnJ/Mw/4NK02PbQm1v9oEm6fpE5qE+lbb3Kc+DHcF+Taxv3+92+kp43aFWNO2slPf3LVoP5RTTSSgMOlCR0LsGlg+Vn1iokNH+eqkRUSJpVDLcWFdv/j5+81jDnCClKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808554; c=relaxed/simple;
	bh=I6f8x4iGGQ/6ezXUYixBV4CDobLsuQYJkTwCWtE3PLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvviZCOnIiIZc/ZWU18iJuHqVN+K5y8cjm4g+9NrCeGsKfsqT3zZzOO5f9fWGhCHP5tRKKm6bGyGDV1Yi6ud2OR+GwwpegAUTmsHar9KlWpcBxtn0iaAbN4xs41ARlONBmsJfxUmXRr2p2sVtX2JofNUX5A+woM/jwQ46WxPYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8kDJ7G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689A5C4CEF1;
	Fri,  9 May 2025 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746808553;
	bh=I6f8x4iGGQ/6ezXUYixBV4CDobLsuQYJkTwCWtE3PLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8kDJ7G9bQ2O+uSanklGt7kI8E5hTqWfW2tLzM/uHVAbzNHUSqE3NwboUrLLzRWAp
	 Bx34IXFqHPzMfEHDrst4kRk8JZgvl3+f9tiUE4A9sRA9mI33xkQRKvLVxfZsjL7vLO
	 AQ1Ru16qLPvqvVtoxGotywgktKYMXdI6yQbOiQjYw+CHm0atppES7XgDxo5K6YPLU0
	 sgDRCrAcekyJ5dqHh29mhPlwQCkZRWiZFZchbSHIxVBP/LHhkvtFr5h4pAw+8rZbvW
	 bIT82pRJ0xxmaVIWdR2XhIkyVZnTZBy7K6Z60TyhcEWhLMOvc2QGiYJJpQb+mVsoZO
	 fBPNn15pcE76w==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c40235c34so718200a34.3;
        Fri, 09 May 2025 09:35:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2ZEAVGagVUAj6ATC1txhLnQypug3puDEvMPj8GbgnxPdhND51sIKhAi29GLHwFyH7B9s+JJ8Risg=@vger.kernel.org, AJvYcCVs8osOLjWtvg4aHwADgqtt5+JME4rboKrLchE0laQnFJ8d4yUrU5hyoh7Ae9C3++eQl3+ApSNoJkXKIJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlS2yWai1THSFQmihIK/Gsq0eiNizLlJSNAF/GcKwQKsrvH9U
	7zmMb/5kSfRVKNH0PifMFUPJBedV5/h89WaVltdMtcxb0MHfBo1sgYC34M2PpF5QDDzfQ8fcA2B
	zB0WEZ5Kc4U9K8VTtzurS9mOmjNU=
X-Google-Smtp-Source: AGHT+IEv9CjHiPlnvDy5IOb3rZUcr8bYyMFTGmb7zMjbaUanNOyIS/EVm/gEihDRjAygoxhYpGTYdGAk36zJo7VtPco=
X-Received: by 2002:a05:6870:5251:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2dba42a441emr2471934fac.10.1746808552569; Fri, 09 May 2025
 09:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506220057.5589-1-moonhee.lee.ca@gmail.com>
In-Reply-To: <20250506220057.5589-1-moonhee.lee.ca@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 18:35:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRn0EKXNkYgbo8UMqj5Hq39LWn_Fseg38ZuQw2yCVtzw@mail.gmail.com>
X-Gm-Features: ATxdqUEtrAsngD3bvjmsyDO6bu-yczjM4N5J20DvDwYRYdhreKQ77vuOammTAn0
Message-ID: <CAJZ5v0hRn0EKXNkYgbo8UMqj5Hq39LWn_Fseg38ZuQw2yCVtzw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: fix typo in energy-model.rst
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 12:01=E2=80=AFAM Moon Hee Lee <moonhee.lee.ca@gmail.=
com> wrote:
>
> Fixes a grammar issue ("than" -> "then") and changes "re-use" to
> "reuse" for consistency with modern spelling.
>
> Changes since v1:
> - Limited scope to .rst files excluding translations, using:
>   find Documentation/ \
>     -path Documentation/translations -prune -o \
>     -name '*.rst' -print | xargs codespell
>
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
>  Documentation/power/energy-model.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/e=
nergy-model.rst
> index ada4938c37e5..490ddd483f46 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -230,7 +230,7 @@ Drivers must provide a pointer to the allocated and i=
nitialized new EM
>  and will be visible to other sub-systems in the kernel (thermal, powerca=
p).
>  The main design goal for this API is to be fast and avoid extra calculat=
ions
>  or memory allocations at runtime. When pre-computed EMs are available in=
 the
> -device driver, than it should be possible to simply re-use them with low
> +device driver, then it should be possible to simply reuse them with low
>  performance overhead.
>
>  In order to free the EM, provided earlier by the driver (e.g. when the m=
odule
> --

Applied as 6.16 material, thanks!

