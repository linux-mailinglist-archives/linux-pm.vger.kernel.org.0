Return-Path: <linux-pm+bounces-34018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF658B462F8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F93ACB18
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB78315D30;
	Fri,  5 Sep 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdKJkRnk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F4315D22;
	Fri,  5 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098780; cv=none; b=USyXOK3K6H2K1JHc8eHxYPe5npBjIiHBbb+XXbkacn0IEQVMeQHgYfY+ecLQHptHPxnajc4QxdtDstdt9pLiBAAVsuNvj/SgHCMSHma0o+XcOfnf1hxNb5DkM3ugmw4cRd7Dzve+t9GjVTspFUodOa6E1O0Y5s+C4g18n57QA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098780; c=relaxed/simple;
	bh=lFK6x9Jn+RDIo8hk6YvE4XAAa/pvvhUQnFYDz1Cs4OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sbt2ogh75aJqZJ8JQkJecT0yVLAYAGwu3g+m9EF9ZEAcbr7XudVACJaAE1+7xa6xRkd5PgefuKWOE2lJQlHQ22KBLV66emYrRs6DTM7V9JhoA7zw1MIhdGZNqw+OlbFl9c01FTDYGU50+IP3RY4wbuoeohWfJY8pT+6G3CpuPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdKJkRnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA77C4CEF9;
	Fri,  5 Sep 2025 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098779;
	bh=lFK6x9Jn+RDIo8hk6YvE4XAAa/pvvhUQnFYDz1Cs4OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jdKJkRnkbnHJMRkli9lQG33dV3/fQZAgS7QO930nFXG9dfIEJl+9LcMyEeaGLUjfC
	 5DlEDt2L/BkjL01kTRckA43nFg6Ozo0Ba1Jq5z0xTNFS2tFNJL520VaOUJfVYIURTr
	 A1hWIHpw8jvsithOHfIUXZ89u71XleSvDorTXwbRd7jdewESlLbICbOifqQgxUf2Or
	 xeUv3UCj4ji3aeTitKVVdMCf+tegG/754T45cYjbbOEkgXYi4PCDS+tsqzEZCu7kN5
	 LaNFboJehUpGW4mBEGNzrjvea79VDEIrSMrsSDnwshdf8TI+Z1tRhDEl3IUI81uqTL
	 AOY5WVf+cLujg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61e45cdfafeso539800eaf.1;
        Fri, 05 Sep 2025 11:59:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIkXYOlElniRfa5hQxr7w3cjN5yBpce1+6O/hy9zL/2cK3WPwWV+YK6XETyDtanNH/opei+WarTCcchi0=@vger.kernel.org, AJvYcCVP1HF8lga5EfF2i2ngk+eeY4cZcm/eousZ/KPL6/BspH+LOlD18x5b9Yq2vjDy1Yg4F4LIe5NTi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2Udw739IHoi36L3mZics7MjHpQFIP9C+Vy27Ui/BoOJxfJ5m
	yk/V1JWK4ZfNkkvA/mIm2kGTzAFEGc29wMCizBBQmyYjAJfPWlBOqM6VpszOt5Txh4GLVi1vZpj
	d1Wfz3fGsb8X7E0RWwd4TQZJrpFzx/TM=
X-Google-Smtp-Source: AGHT+IGBZn5bdUbUxZQ9R/VAE48egjxy7wtN2aJCa+dJNcBVRD8YKhEC7iDOHIvCcjhDlPCkYpcfxNDZIk8H+vZ1QR4=
X-Received: by 2002:a05:6808:2f18:b0:438:2629:2fca with SMTP id
 5614622812f47-4382629499fmr6067333b6e.10.1757098778854; Fri, 05 Sep 2025
 11:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-4-rongqianfeng@vivo.com> <20250903041328.qgxv5eoajd6yg6jv@vireshk-i7>
In-Reply-To: <20250903041328.qgxv5eoajd6yg6jv@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 20:59:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jsV1ZOdLa1=PTvrjzoJ9iVUE9fF6oWZbNcGwB+djNvQg@mail.gmail.com>
X-Gm-Features: Ac12FXxs1ss8vivAI2PLfbdSuyFs5Lh1DN8xxMUIsH-ok7cqJQI8Q188vzJPvQ8
Message-ID: <CAJZ5v0jsV1ZOdLa1=PTvrjzoJ9iVUE9fF6oWZbNcGwB+djNvQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cpufreq: speedstep-lib: Use int type to store
 negative error codes
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:13=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 02-09-25, 19:45, Qianfeng Rong wrote:
> > Change the return type of the speedstep_get_freqs() function from unsig=
ned
> > int to int because it may return negative error codes.  For the same
> > reason, change the 'ret' variables to int type as well.
> >
> > No effect on runtime.
> >
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> > ---
> >  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
> >  drivers/cpufreq/speedstep-lib.h | 10 +++++-----
> >  2 files changed, 11 insertions(+), 11 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.18 material, thanks!

