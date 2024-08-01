Return-Path: <linux-pm+bounces-11789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847E9441F8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 05:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DF2284329
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9551386B3;
	Thu,  1 Aug 2024 03:41:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD91D696;
	Thu,  1 Aug 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483686; cv=none; b=N2sikesUkjfk4DiiEk3otEVP8GiuiW62i5nBduXqaiwKvXGAR9rajusEpxkhbZEPM1H2oV1DBDz8lGUs76qdNfaJho615w2AsXBBXFxzy4kjJzLjFy94wXzY4b1xftlXI65loaBnpIcbcIeD5I+kdTqPO4GjZWUkHb40MyehO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483686; c=relaxed/simple;
	bh=m4xYWVIGQDvqhmSV4J6ZUQ0pXgYRiqcojx1bzWRAQZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9XF3ysY6z/PKEAWnz3T9HVsjoUQgwY18uUH9YPGQ2RCjQsVXhdIK97mFEyzFsU5euoXGhLictqVHH9xh+opG2vEISzNzckwOuwC244tjHOhz5YKYcyZZrQgVrEDrHrqr3V9oIW4J3d+YmtRLL7mDIClGiCLgcAYAxQhJy81RKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f04c29588so11276801e87.3;
        Wed, 31 Jul 2024 20:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722483679; x=1723088479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpFbA20aLHJ+Am8YxkTg4RUa3XKubG9hiY6Kx7P8xtw=;
        b=BgklITCmfph6+TAK/5SDJRcTfJW+/EFo4ouPLINs+yun6+lbYCQVNB+xPwJL28mOfK
         j9FYKv0pG8UCf+n/yPmSbqflsdmvhw8Gi7flNH2t5UKounimF42PCrZgda7ZXtnD7bfM
         /qfy/vKWgp/f9Oym2DCRVUhAyHM63NpfSAdDtVgFm1P7rrR8OoyUf+3qIuqS32xi4tZX
         nrtQnaJcCZ+w0vWbfmSwiY+bq5oJ5HKZ6sUBjKv9djdsYOEg1XxK6Y0MLN2XpsNCCRiH
         DTTkJEABQAy39Hleakx/euLJmA40rApTYxxjKtmjMk74+wr1cvg5D8no3WUhAUljH8PY
         2qtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEd0mdO9FeABGTJpKCIHnQ6Tkl8KszzRIdJb4k1wWE+6uuV9UcDt5Iqi7+eyhm3Gk/uDKeuGOjfRw9WvBIpCg5fyc8zrVJishiOXaGggov1Jw/tO2bcAaxgfJ+XO86S55a5qbh6hs=
X-Gm-Message-State: AOJu0YwQ7R3syJ0oDxv8X7a/QwXOAXt89k/O/pCaEsDpv2DOm/tnF0+D
	HHjY3gt+rge9lA9nBcARZ2jvYtZ+LlC9fDzrmqdrpjRnQPJs4eAtD3GaZj/D
X-Google-Smtp-Source: AGHT+IFqufg3Fcv4wGHBqwtLT1U995I3T+ndCFXxkKguAyErTVMg/YL6FPe2w1TglDwPn5t5XkenaQ==
X-Received: by 2002:ac2:599e:0:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-530b61aa834mr494952e87.16.1722483678989;
        Wed, 31 Jul 2024 20:41:18 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc42b4sm2395710e87.12.2024.07.31.20.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 20:41:18 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so101779151fa.2;
        Wed, 31 Jul 2024 20:41:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXee0Lg8KGSLw+GuIu+fnWTbl6aM+G1sm/LGrtBAaCG2CQylDc2qMLcTQnPdZ3+9yY2V+NeSws4th0/eqpuUdyBD9LBijQHH5Nrr/YjnaOpuigWx7qQz/UPo1+IUvP0bGhwsArJiEA=
X-Received: by 2002:a2e:84d6:0:b0:2ee:7a71:6e3b with SMTP id
 38308e7fff4ca-2f15310167cmr6804891fa.27.1722483677641; Wed, 31 Jul 2024
 20:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-2-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-2-robh@kernel.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 1 Aug 2024 11:41:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GvkyMS3kZWEADGWKvZ818w5uvJASkEMrox535c4Ba_Q@mail.gmail.com>
Message-ID: <CAGb2v65GvkyMS3kZWEADGWKvZ818w5uvJASkEMrox535c4Ba_Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Use of_property_present()
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 3:13=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 11 +++--------
>  drivers/cpufreq/pmac64-cpufreq.c       |  2 +-
>  drivers/cpufreq/sti-cpufreq.c          |  2 +-

>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>

