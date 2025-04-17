Return-Path: <linux-pm+bounces-25627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADEFA91C68
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AF75A56DF
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E12417DE;
	Thu, 17 Apr 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3d+UkbN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFF1E49F;
	Thu, 17 Apr 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893388; cv=none; b=tbMSdWX7j4Ha73ooqi5gzT49cJfSQ7txkQZdc1N2bZ3BkntppwnT+6arBW+GvFfzbyqLAnAsUQczpg73Vao8rqalFZ9T4OahUBnEdQYOox7q07qjotGu/SbYQvMsiFTX61vfNzb8A7c1CvIgtJdGGjQA8zWiWwcjKunLcwr2pBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893388; c=relaxed/simple;
	bh=tMwxcK4oqs5TWumcOBcDWbtg583pM2GZOY6xs2JAxs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adF8k0H0A2eERGVZVjkPINCdCZ3imoK1wz3Lg4NEuxb38prdc1zDlcc0ZYY+foA/MDQO8XZAM8k7XXEpUnoy1UeNXxFraiRYhJDMd3aWFjl81PtcytPSAh3p18p2GfRDxkk+WHI9nqnXv1wxAGlvERmuyzV8NoMrGh1J7+0stI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3d+UkbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D793EC4CEEA;
	Thu, 17 Apr 2025 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744893387;
	bh=tMwxcK4oqs5TWumcOBcDWbtg583pM2GZOY6xs2JAxs8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e3d+UkbNdU3RKfIRjCSsYnNfj1DyR9CxhwPsQSEH+qvZmAqvWRf9v/mCQxFI+XWE3
	 oN4/DTQ/kcwkA1umtW9scgyEHH8jCvyf+F94Zc+K2FRXUqcdFsSmE2VBSC6IpNtcDk
	 HgxkDq/zsw3WAPNuoFoXHZygvecrd7a9MjTFfxqAiTxsP2Iovg+ayEF+BxClwujko7
	 VpP7Kh7roRds5dlW5OL0PRGSwBpF//xyR4btpsB2cgOAMDcb6uoAKEK24T3CyjKf97
	 cHqRCmY4h6o6LW3hVpb2ocWYEtIZDxGbzsyKT/IgUa2seveu0vDqqZ8yM+J5Q5AiN3
	 R0jLjJJCPLj8g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2504fa876so186480fac.0;
        Thu, 17 Apr 2025 05:36:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUULQJ1lP3n51cqJwNeRt/eZQG8PR8/5/z729iI4syHI3WjdHuNlZgyaS82HT2x9EQ/OtUxqrd3cM0ixTM=@vger.kernel.org, AJvYcCX3oyTa7BNTIF6+YuPdQkwekx7dLoaqbguhCgUbAcWfIncTbgbolLMUhqKK0NJxWb4PM1Ob2WXuawQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHu6b6G/3UvaOTo/SVAxT21/0kjCLEocINnOT3pYy82zb5PANw
	TihV8KY2yHUTEIPcw9xb79AloXpEqi4B3fUden9AVcV+Oxnzd3Wc4qD+wpdDnLfdToiy9pzWjAu
	opZku6Gk4BSO/OaNx/ByJbyUoQGA=
X-Google-Smtp-Source: AGHT+IEZ5GMrM+1vFDRzr05NLDmdK5Olfk+2O0cx0aqeF08KCbM29hIYZLBWxGoEx8RyJ/4pxXYLM5jIdzwHeT6gBmc=
X-Received: by 2002:a05:6870:230e:b0:2bd:456c:92a with SMTP id
 586e51a60fabf-2d4d2aa1540mr3608461fac.10.1744893387148; Thu, 17 Apr 2025
 05:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
In-Reply-To: <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 14:36:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4YW760xwXB_u_pf3oSUVkuWPBP150TJRPeUQJxK+B5w@mail.gmail.com>
X-Gm-Features: ATxdqUHNIR4zk6zFts8FWQAAfsEHRWaqS-0dcPEU0obtvpnnpQLIe2ATDQ3-fKc
Message-ID: <CAJZ5v0i4YW760xwXB_u_pf3oSUVkuWPBP150TJRPeUQJxK+B5w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:02=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 16-04-25, 19:54, Nicholas Chin wrote:
> > Unfortunately the issue I reported still seems to be present after
> > applying this patch. Upon resuming from suspend, the system is still
> > entering boost states descpite the boost flag being set to 0.
>
> Okay, so this is what we know so far:
>
> - Force synchronizing (disabling here) boost state at resume was
>   making this work earlier.
>
> - Setting the boost flag to "enabled" state during resume works as
>   well, as that makes the cpufreq core disable the boost frequencies
>   again.
>
> - This patch (though doing the correct thing) doesn't work. This is
>   one of the known places where boost was getting enabled before going
>   to suspend though.
>
> - This means that some other part of kernel (or hardware ?) is
>   enabling the boost frequencies at suspend (or early resume), which
>   the kernel was disabling earlier and not anymore.
>
> Rafael, any suggestions ?

This a resume from S3, so the platform firmware may enable the boost
in its resume path.

