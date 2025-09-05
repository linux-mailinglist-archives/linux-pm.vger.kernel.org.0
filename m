Return-Path: <linux-pm+bounces-34010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FCDB46206
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F0189AF82
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E41305949;
	Fri,  5 Sep 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9dK17ne"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941F305943;
	Fri,  5 Sep 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096193; cv=none; b=mnM25rIS7DP1rkZi3Zpx8xPD43IWvex6IIhjM/QAY+10Z/de+Z2TF4gqyw72pigiyhLAy++aprbc/KlGZ7KiX6EIU5V2OE/Ro/hWMo4N0dYIsSJ3YNpUv0LLwQdnPG9E1A/UXniVClVqMGRt55ygcvGSIikceRKr/rEzWjWnT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096193; c=relaxed/simple;
	bh=kgeUru8SqZkKjo++DVOShHL+x7j8bEOW8CXZ1n4HJ4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUZqtMR/WDLgIc9UvuZVjgS0/UCfyoLnIJrVDnOlbBzAGnzrk7t/BhXn286WaErPLXobbM19cQTpE9KM0lSuL1pkvrvuZhzzF4IhP0HC7ZuGAw5Zzy/a1lsJ3IX1HUZsOb/0+lZYVRkAt7CebbXRk6zPqUGzSWBs9hGg1stEWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9dK17ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D796AC4CEF1;
	Fri,  5 Sep 2025 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096192;
	bh=kgeUru8SqZkKjo++DVOShHL+x7j8bEOW8CXZ1n4HJ4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O9dK17nejrpL4+/xicNIQtZQomaV8ACmLfmJC62L9iiPr3X3NXJGGj7XYmLCnVPVY
	 +YbOdU58vjYO9FVARAhPHDgE2Xbd/QwbcXXfqZpnIeuYRI4CcEAKUT6ht9Xjh90UjH
	 vZaTt3QFIHD1W20yY/FJzYemKuq+cQubLUtTDEqVC6Rj+PQACqMHkpkzvEyjmX0gD6
	 LvCkBs/pddtNasuF21kZWhM7+ZuDw3fVwgG06EV7HORWGvjwv4RGJhwI32WThXPaj7
	 ir4CMxngo8kKbiLRZISiN3OmV3ttSOLpL5bErZY4FS2HxhE6qaCtC8V6eHTFGrEpHW
	 hPkXJrQaaldwg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e577ada07so608507eaf.1;
        Fri, 05 Sep 2025 11:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqrauRPyY3PzEWpmo2RoKqgSVbqsYViiL1DxLXI2bV76cTE1OO9zDsMe3dI1LPlLsAOGCTfd8sJ8+xHRc=@vger.kernel.org, AJvYcCV6it1pVtXr4n9Yer9XB+ZYzpZTUvHvAoBbAHjJxqDzALmwAt7ooR5xqebuc98Op8mjkdQd7OZGdlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGEONzEwodkwoltuMyrLLVAxW6Y52+DLqeN+telN+2PJV3T1u
	yvT9nbgi9Axt/anPAcBroL1hqrJXyR6YpQB3YSDT+uc40ij+FJwzJNU8h5y7umEHq+3q8yvLnvA
	iWLkGqnMH4nLjDANzO0lpvS0OkvMpi/8=
X-Google-Smtp-Source: AGHT+IGXIW3TkYCSqij0GpZXxVhFjPyivTRhdzaFNa3YQ6G5atigKLs5Mk+dwdIKMoVjnheC8qJVGvGvq0e6pnpWKW8=
X-Received: by 2002:a05:6820:2222:b0:621:7582:b2b3 with SMTP id
 006d021491bc7-6217582b96amr492748eaf.4.1757096192184; Fri, 05 Sep 2025
 11:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902073323.48330-1-zhangzihuan@kylinos.cn> <20250902075624.gcacapuytmwenaxo@vireshk-i7>
In-Reply-To: <20250902075624.gcacapuytmwenaxo@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 20:16:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gApi4_3gcLkCM5dw4MBsTOHB2hCn7oo5Vy_Hkk-oxbSA@mail.gmail.com>
X-Gm-Features: Ac12FXzD5NAt1sCb8IayH0weIQpmF-ruesZzRDg0sc_RFuI9s32Z07JirSxJmnc
Message-ID: <CAJZ5v0gApi4_3gcLkCM5dw4MBsTOHB2hCn7oo5Vy_Hkk-oxbSA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Drop redundant freq_table parameter
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>, "Rafael J . wysocki" <rafael@kernel.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:56=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-09-25, 15:33, Zihuan Zhang wrote:
> > Since commit e0b3165ba521 ("cpufreq: add 'freq_table' in struct
> > cpufreq_policy"),
> > freq_table has been stored in struct cpufreq_policy instead of being
> > maintained separately.
> >
> > However, several helpers in freq_table.c still take both policy and
> > freq_table as parameters, even though policy->freq_table can always be
> > used. This leads to redundant function arguments and increases the chan=
ce
> > of inconsistencies.
> >
> > This patch removes the unnecessary freq_table argument from these funct=
ions
> > and updates their callers to only pass policy. This makes the code simp=
ler,
> > more consistent, and avoids duplication.
> >
> > V2:
> >  - Merge three patches into one to fix compile error
> >  - simple the check suggested by Viresh Kumar
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> > ---
> >  drivers/cpufreq/cpufreq.c         |  2 +-
> >  drivers/cpufreq/freq_table.c      | 14 ++++++--------
> >  drivers/cpufreq/sh-cpufreq.c      |  6 ++----
> >  drivers/cpufreq/virtual-cpufreq.c |  2 +-
> >  include/linux/cpufreq.h           |  7 +++----
> >  5 files changed, 13 insertions(+), 18 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.18 material, thanks!

