Return-Path: <linux-pm+bounces-30430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC213AFE12D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A457B5C14
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237526E71E;
	Wed,  9 Jul 2025 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNHNUYlS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34343194A44;
	Wed,  9 Jul 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045570; cv=none; b=tKMHeZcD4vbN9hcBt+Z5X79/dSaziUZKREn+DoK9SpLDGKmuh3e6SMECzeOdcjdpMcJJ5SmmxM0h1Jl42yLfYNzVp+M0TqmAA2oWbFasDMqRXdZbLhcBrcdiw62o2MIMVnR9g6M62be8xzHMAyJMutxPBb/kaelxObqKw9pxRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045570; c=relaxed/simple;
	bh=+FdXl/ZUySz07xGC7GHXbM2oS9c+ddkk471S2TEye3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0yukm1q1+H+bEG9wzgfwnjyzvIEHPWpvoyNoGOGQlzL1TcTpf5vZCPmeboT5PY2t+kom8HCD78gLGF/Kdrbws+Lgd6LPbRvQ3Hw2Xs9nA/Tonva69javlXnbYHK2MHx99Eg9S70IokMN1WUle+e+3b60XahpT6knEnbvgxPeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNHNUYlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E7DC4AF0B;
	Wed,  9 Jul 2025 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045569;
	bh=+FdXl/ZUySz07xGC7GHXbM2oS9c+ddkk471S2TEye3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tNHNUYlS0Dno8NlxGiVtmf+nX9FCL9PqikVT7Ggh48NCRYiRp7DnkwPSOSBDiQ0Tn
	 nlph1Co3ANHylobkj8OO6qaF5BPzIByJlae3jKvQV7XVUO1Qe/5/uh19SCzgc1qMJa
	 /fkFRdkkXpxH7tvtxo6uOrRytzjrzgapE2y6BHSUAxhWs7vexg71KMTjq2YSnWGUgz
	 dh+MF8Q8iSdvcbx1P1KxydlAp5sefNjH320lMOysA6VVfirS+6eyQQOPsxRVMrOnQD
	 G2YjLfHXdEGwGe79wcTsfwGsO8fYKB03oAQ+6fJfK2DAK/x1etLez17UAAZi5wQp/r
	 LL0r5E/NK0Guw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c09f8369cso1736096a34.3;
        Wed, 09 Jul 2025 00:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZmbqhWdshGqrYwN05NNtoE/qT9hET05H/rpxNp54IfuG/pb31wse2NgnhVn+YVEua5vevDhQIa/M=@vger.kernel.org, AJvYcCUikZ3dsiZtK71K5n6KWeGYWZG2hcKkLftd/hIE26hf0d7c1P115LUci6s4+sf2m9Jc0YNsBO1QoyRZEY4=@vger.kernel.org, AJvYcCWZQb77GtTKfdweU8DP2gkSllROT7TS23BIiDfimRgZetTQKgoPiPk7EW+W2bgJPXU1A8JfFbUEKurTCTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRVviV1QOFqOmsQUg9gBV3j4XnopWLXkZDOxnlxAakWYIiYRi
	ZNvieArzL3DbJnv8uB6W/bjjEv+UQp8ts8lWBNd2EivaSJQbpxl0XyoZo36BaqFUNi8TABchao4
	fomxqkttAaggfeeKDn9p18fMwSp+R8rw=
X-Google-Smtp-Source: AGHT+IFxc2jjH4fZ/YiHTM/JJ7mtVD0WJzVbdnfdT9Jxzbb+gc/4LF1PBuGm4dK3onCF9pnZwyZmwK1temDraGP9tUI=
X-Received: by 2002:a05:6830:2d84:b0:73b:1efa:5f5b with SMTP id
 46e09a7af769-73ce65b7ddemr786127a34.28.1752045569014; Wed, 09 Jul 2025
 00:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com> <20250707-tegra124-cpufreq-v6-1-fe69c0f9bbab@gmail.com>
In-Reply-To: <20250707-tegra124-cpufreq-v6-1-fe69c0f9bbab@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 09:19:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAGTx7cpesJfhz2q+CzHQh6OJfA2bzC1BB-QOL6QWpEg@mail.gmail.com>
X-Gm-Features: Ac12FXzE54UiOt_Hcf4GJ9n7Sh3G5Qxpxjz126toJvIu-R91hcvgLxTDWb0sq4w
Message-ID: <CAJZ5v0gAGTx7cpesJfhz2q+CzHQh6OJfA2bzC1BB-QOL6QWpEg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] cpufreq: Export disable_cpufreq()
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:17=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> This is used by the tegra124-cpufreq driver.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0cf5a320bb5e864709b259249fb1af8bfbc0b04b..78cddc78ee98630f99ccc332c=
64c94f437297177 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -109,6 +109,7 @@ void disable_cpufreq(void)
>  {
>         off =3D 1;
>  }
> +EXPORT_SYMBOL_GPL(disable_cpufreq);

Please add an empty line here.

With that, feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch.

>  static DEFINE_MUTEX(cpufreq_governor_mutex);
>
>  bool have_governor_per_policy(void)
>
> --

