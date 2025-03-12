Return-Path: <linux-pm+bounces-23935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEFFA5E53D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B44177CCC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54111EB191;
	Wed, 12 Mar 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFyF/bYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB803D81;
	Wed, 12 Mar 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810837; cv=none; b=kEYoDOqgjgm5s4mXHJ5GNxmZKpN/jwLMbhAai1NtgExRN8fUddp38kO81tZnQ0+rCG7iVL7Wu1VxCvBe785PHZkFbrYz65Ewu9l0I+MjsrKba19mpufmYyYxono+VzovQxj5ImTP1Pdmj5wSAflJM1TG2mH+eO1abMdr0O3coQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810837; c=relaxed/simple;
	bh=191cN9Be6lYXTlsG5ApbiQoMSU4OQE2UppDIftw7wL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meRntukfcSmdSvhNVSeXgpzwjWxVqzAooexGsadC5rse9NM/gweEug2siC7oLugHgc43Q52QIqpha3twO3p772RNASzYfDGGjoPUvItpaQJWzFgc3aflK7hs1fAwTG1WPyRM7zs1hjZpW8I81UAlyPA9NHPZgcDYAk+/2q2vdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFyF/bYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37723C4CEE3;
	Wed, 12 Mar 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741810837;
	bh=191cN9Be6lYXTlsG5ApbiQoMSU4OQE2UppDIftw7wL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HFyF/bYSVYtukHoyXWBFESDdzn60lTmtTg9dVLtsyW2B9J9uu5eNtAUjCbnZprmL0
	 WlCai9Ii601DdgNiK2WaUxSCjU982O9rHpwntcTEoTv9Qs0jatgHDgLPCXcShUpiME
	 LP5eU3JQZwjpywxY38nKHZ7yj2JgN4MdZ8pPS6MQfw9QhZrEvIQBy621d7Nsidr9ne
	 R/ZRRcmVbtvW6GsipA9rATfWUzR38WyfF4pLxfXcGJu9PReaB9OHLwpQEZWkEb0LXm
	 68kK4n8NGGDf+JuSjXU7Ps1CHLfEUbEKuOUbkw38bu2A2z6StZWXwicX2l1bK7LsLR
	 Jh7gSpSzZr0aQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so254820fac.1;
        Wed, 12 Mar 2025 13:20:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsnMsZ8xMNSksqzil0plPzLrkYP9Vlg0CyUGEbFRPirWagWX88towMvpRIZfM19szOQmX/tOkDTQE=@vger.kernel.org, AJvYcCW38L75g3bxOS8UcJPjYsJVN8NYpJeG0OKK16orhQlk8iMiuOq7QLY6YnabTmU+6su9I/q7Z+WMV8G/3jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuAoNJ1s2MiZx/NSf/dLkUp9mNGTsQQXnOOcyeN/qRzl4Vm2V
	PWD5jW+XtWQpnSi60hJL/fU+lKSqF5NOA7gUk+iveWRIEf4fsr7o+gbP4qDeVxMs/JgoXCJmvBo
	PcCPLQui4GAUZ/4gjQpJ3mqb5ULo=
X-Google-Smtp-Source: AGHT+IFkQqFePGtzUqvRMUdvv06++o/IztrYHiosgInnc+5rxXilGbqHpHMEewloEEyPDF2c28FvTHjEKv2JdKlV6k4=
X-Received: by 2002:a05:6870:d886:b0:2c1:5dbb:ecb6 with SMTP id
 586e51a60fabf-2c261398a70mr11822143fac.38.1741810836496; Wed, 12 Mar 2025
 13:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311160827.1129643-1-ulf.hansson@linaro.org>
In-Reply-To: <20250311160827.1129643-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:20:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo4bcmkwN3s7uVPG_AArFVAMqWOsxYbRVJfnVX3sUEfnb9nLW56cGhcvVg
Message-ID: <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PM: s2idle: A couple of minor lock-simplifications
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> While working on s2idle a few things caught my attention when looking
> closer in the code in the s2idle_enter(), in regards to locks. These two
> patches tries to improve the situation a bit.
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (2):
>   PM: s2idle: Drop redundant locks when entering s2idle
>   PM: s2idle: Extend comment in s2idle_enter()
>
>  kernel/power/suspend.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> --

Both patches applied as 6.15 material, but I rewrote the new comments.
Hopefully, this is not a problem.

Thanks!

