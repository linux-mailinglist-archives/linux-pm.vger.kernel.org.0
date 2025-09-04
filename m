Return-Path: <linux-pm+bounces-33889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA2B4472B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 22:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485431C87001
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EFC27E05B;
	Thu,  4 Sep 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvqRjmXz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320A27D77A;
	Thu,  4 Sep 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017175; cv=none; b=asgUIKGACsFC18vVfsnqtDCk4bbBbnrBAOQzTESQ7UeyBEWBk63enX7Hw6l8AcpagaQFjIv8VwDcVwPXItkyPaBT3+gFLo+K/lwabD9xxq19Rw0r5fqPYvLKSfRdCEAdu3RBivEtX3GWQQ2AxMubeo7p/6Xflin5nOF+k/N7XTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017175; c=relaxed/simple;
	bh=1VcNKAEFNBmc/vHbQvTGEEIRpCJEnXjNlNZHTRxexDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKcSzJpEWle0j/3oLyC4TuDqTvcZeDX30H7ZS9TFr6l91uZ6MYcBZXKBS/CNoNgkpDI0d6eSeX3rHK3qxUMYCeLr33/XEJyfLssqLBIqaxTzgxKXK3emZQCflEsApdg7nzYXRjAT12pkAlPmVZ4AVHBb13tEeJkP4ptmInGbPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvqRjmXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B7C4CEF8;
	Thu,  4 Sep 2025 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757017174;
	bh=1VcNKAEFNBmc/vHbQvTGEEIRpCJEnXjNlNZHTRxexDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hvqRjmXzfVFGW5tXF1K8PPr0Lt//tTNJFbogYY8w22mAu7+adSXS5hoe4WHtpa3yF
	 fEXhnGXPu19pVX/2XqgVPsaNswSczmBo5jhpXGk8FvsYSvtm+z14h1YW89M419l+Wu
	 /eNsYFDdNWG2y3rPQtQYXzpFNEMvGks6RGuZJhL8AugUoSeHYTYnl+2cATnQlPj6xy
	 L4s7Ag1N0jei/rHqhfxC0TPp2s93XfILhmTZZ6e9E0/P3yT/t9VyX2nhPn3IaDFadu
	 +GN9gvnkmhx92hziTIjchiDkuaeMTAujOzkWFWMO4+avESBO5my51xP3uMtVdAi5Du
	 lZumUnUyXFIYw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-745a415bf72so433827a34.2;
        Thu, 04 Sep 2025 13:19:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiF+/NYwKQfG8lns4USYfDytF5Pm7wBNs6mnQk7W5WBfMIbTblXKXYWqd8pCQkqsR5R+IXf3qrk3A=@vger.kernel.org, AJvYcCVz+ljHo7aw2RkDR/nLZOkXx8ri/jg2jzYrHO/tkBH4xUcDuoPgzQsUiwiW6el5papf5p3aQbEIy5LLkQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6Evi6lg9XSYQ18tmzZFLaHgv4Q7s41UjD+Ln0Sk+W4klYzMb
	ivDJB5w+4g2Msx9sfuBC7YeKoeaOS7E5Yk2gsegpMSkr6tqQ3Sci8d8Ekq4sztmoq7Vsy2ebtNC
	OHU8FZBHXnRMVyJO+sya51ojxNUDRgmE=
X-Google-Smtp-Source: AGHT+IF4x2Qs0rn/ky21diP4DVdylPNAkWrN8lszliMurTMli+f6jvFvp5R72NVhDEKs4dIuAQroGWwE6FHo+Hsd9kQ=
X-Received: by 2002:a05:6830:67d7:b0:745:4db8:460a with SMTP id
 46e09a7af769-74569dfaa86mr9939538a34.15.1757017173793; Thu, 04 Sep 2025
 13:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828201541.931425-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250828201541.931425-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 22:19:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4W2fC8WsbTSpszoBC2DLnP7QsqvTuuSriEU7oXoVLYA@mail.gmail.com>
X-Gm-Features: Ac12FXzgCXPzlxBHjwh7tioi_0Lh3p9vM7mZulHrUsD2WOam4ePG71EJ5hHYXEo
Message-ID: <CAJZ5v0i4W2fC8WsbTSpszoBC2DLnP7QsqvTuuSriEU7oXoVLYA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/thermel/intel/workload_hint: Mask
 unsupported types
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 10:15=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The workload hint may contain some other hints which are not defined.
> So mask out unsupported types. Currently only lower 4 bits of workload
> type hints are defined.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Removed extra line
>
>  .../selftests/thermal/intel/workload_hint/workload_hint_test.c  | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload=
_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload=
_hint_test.c
> index ba58589a1145..ca2bd03154e4 100644
> --- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t=
est.c
> +++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_t=
est.c
> @@ -144,6 +144,8 @@ int main(int argc, char **argv)
>                         ret =3D sscanf(index_str, "%d", &index);
>                         if (ret < 0)
>                                 break;
> +
> +                       index &=3D 0x0f;
>                         if (index > WORKLOAD_TYPE_MAX_INDEX)
>                                 printf("Invalid workload type index\n");
>                         else
> --

Applied, thanks!

