Return-Path: <linux-pm+bounces-1773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E9822BF9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016CA1F23CCD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26A18E0C;
	Wed,  3 Jan 2024 11:19:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1031018E0D
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso2365871a34.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 03:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704280741; x=1704885541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMNl6kltkXE+YdC+BykUtDHAsS75Qs5ALg2FmWCqRu4=;
        b=U3F4YlSl9ppRX3Xf+4/3mofHEl47tRC4IGlZmXfRrSOdTBdsVB8Wc8J/4orB6IYAdQ
         fvxBtj2fsYqpx2Q6RFkBNmzMCSUcXy4jJEvnyONMk4SMAMiip+T0ygMYT5bRUvfqY1Y+
         N4wb6X4iGIF3lvI3OGSYe6TM3OFj63/HpGIvBnuEFyfTy3VVU4sLmMEw4SNtaAnMMyoq
         WkoEaOdHmX6+0LYkxGockEJb9ydatbXFJAVOyEarjdvo79iwvA/RdfAiHZhj3NMYFnKz
         2j7V1NuSqnJT+lHYYPheiPc9xZE/nWP9gxQdSSRjYLcgYKVKr2bJneXYDfYw84Qmn16F
         ePDg==
X-Gm-Message-State: AOJu0YxbyfMLQPSty+NVBuv9cTy2tIe9lv3H/jSPjXYsxVmgnteatzIA
	aETIeeqpPpsv9euE7quhHXf9zhECrzD9EsIvXjJCRre8
X-Google-Smtp-Source: AGHT+IFxYVQdzgQLFD54mg7yAH62oQ2O1HzI8NRWqjXb6Zw5e/Sf+d/2QJYEap2fRSO5Q89IpnGpEejixEtqm4q6RB4=
X-Received: by 2002:a05:6820:358:b0:593:fbd5:10aa with SMTP id
 m24-20020a056820035800b00593fbd510aamr26991899ooe.1.1704280741020; Wed, 03
 Jan 2024 03:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103110157.5yq5o2hzeq3wwjvc@vireshk-i7>
In-Reply-To: <20240103110157.5yq5o2hzeq3wwjvc@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 12:18:49 +0100
Message-ID: <CAJZ5v0in-Y8WRcqsXUeHxoDZ1eG0eqnWOrCSs19bepOr+uhATw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.8
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Wed, Jan 3, 2024 at 12:02=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 8f96e29aae31354191227ad476dc7f6147ef1d=
75:
>
>   pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP (2023-11-23 13:08:0=
1 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.8
>
> for you to fetch changes up to 0990319a0400db1d6069b5549327cd9105a266d5:
>
>   cpufreq: armada-8k: Fix parameter type warning (2023-12-18 11:22:57 +05=
30)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.8
>
> - Check return value of a function in SCMI cpufreq driver (Alexandra Diup=
ina).
> - Use 'NULL' instead of '0' in Armada cpufreq driver (Gregory CLEMENT).
>
> ----------------------------------------------------------------
> Alexandra Diupina (1):
>       cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()
>
> Gregory CLEMENT (1):
>       cpufreq: armada-8k: Fix parameter type warning
>
>  drivers/cpufreq/armada-8k-cpufreq.c | 4 ++--
>  drivers/cpufreq/scmi-cpufreq.c      | 7 +++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

