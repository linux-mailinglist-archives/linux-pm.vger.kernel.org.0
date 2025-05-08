Return-Path: <linux-pm+bounces-26874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 742DAAAF385
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790EB1BC74BB
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33376218EA1;
	Thu,  8 May 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAXeA8Us"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF4218ADC;
	Thu,  8 May 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684897; cv=none; b=TcBd9moGsTwwuLc09ay0WUfxhJyLYUo1Jr1Xy9agSGxUtT+Wj98h2wZPN5eHNu7coEUIhAAJ0NK8Isk5LGLHT85FmwUH4UJNOv6gOQPm+AlmMFO7El0+7CwGy6bScnK8X1nyWABwcaff27DU62JqvtAqhk25SWhoKg0ltiDTm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684897; c=relaxed/simple;
	bh=wXgy+XuLnjFIqewOwsE4Lm/BrXyMhV6/acAcCIAyJYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RHtm1fLDx6cjdwBomqfZnnoUfSZUIG/vKV0HUDoH4mtt72FsFkQcIJgg5O1WyuCOIGXt39QDRhvfirva9PdmauqiHK2zcsRZ3OQBC2gj8VNQr+s9794T4lx9+GYi/D6WOIdg6MCjZfKnJJPByE6+FNR28neiTPVFCqWAES/caHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAXeA8Us; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb415dd8faso92800066b.2;
        Wed, 07 May 2025 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746684894; x=1747289694; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkZltZOQqnYsCEsxFuK/qAjYLT5r6t+NrYMqhOg1WBw=;
        b=EAXeA8UscZ9zHSeeTOou1fccC+qRjMnNZ9263ri/JEg9jANix0dJGEV0/UV6bRPumb
         EP34TH14q6JjU6XtJRsSx9Y2CSJ2wxtLV5wDsPiEdnYqXJh4Vi5oXl/TyVSzzpihhcSJ
         dKkTiPZQWKz46j7AWXRU36PehTixBg7VY4fWdR7LfpxA1dSgFAuKKBiXPAqesJRh9Tll
         cKOLJk/Cw6+dhzv5eZtiePTpSGWZBvz6QEANFE6z3FgWUn3gdjphzOaBYXVyJuCEUN4n
         7DjMCdhP0b3ssU0bDJdRhwq59b/Wg1b1F2bJ2YRj0i9jrWJ/C1RZ/couN9PCAwFx08K/
         Mnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746684894; x=1747289694;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkZltZOQqnYsCEsxFuK/qAjYLT5r6t+NrYMqhOg1WBw=;
        b=Bc7eqileiVOnXWeGn5lMQnjFKIJZnc2bkJ27MDLJ1IWIGISMif3+ykfC4K/40UQxM4
         wlr4DO73Q/B6QxYPhWnLQLQ3uEnetWInGCfS2tl0YsnomNC3mWSKY7G3J4hUVU4woHfH
         IprQmzxhFhbiJz2mNNgjQqn5LQjCT8PrS0qsbhzur3VRBIM/gh+5wxNRL0b8KlOqg9je
         gQlZXjH7xU4n7VA/gkZAl/HQwwaMSyKoPhWup3v80biAVhB/aCDQbDQ/TJ5U8/tdvkyA
         Ek+t6zAvwMUtMMt8RZBazDiH5tYCBaNcrXE2pp/JVAS4vUpWN9uN00/Y4eZMOcLhwEpo
         yg1A==
X-Forwarded-Encrypted: i=1; AJvYcCUVkked34Dqu4ZjQjvDCObcqv8yePPxQ34ykkFu2OnsiBF+eogmVv476NcS4NDPTl/+qOkN8PGKVqw=@vger.kernel.org, AJvYcCV1Mo+nVdC1BnPnaFxOEwmszzM+u8Gb0gK3fANKbOhmPjGe39yMTLrA7pWvgBs4N2rjAt5dm1Hvq8M/MHQ=@vger.kernel.org, AJvYcCWw+Dfc2M6Z9+Ta5TpWonauf6plI46XFZUUeW8dGqPf0o0G6jtq7aNS80ePe394V4OR/z0BxcVzGJts+x0DZZRMlA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFY7gsAJuFJn2nZuql+0hTSBIeN8JcL2IuzMlmUA4N1jqOrPJb
	HCOlH4CP2Rym6ZxzM9GqXA7mdm7aXqfz5s/G3i2a20kycUd3iZFWc4eMoK+uqjx+YPcQ1+FgH1X
	i/DfLLlwvH2snnwrMDIqkoa4ovCM=
X-Gm-Gg: ASbGncthrJSSyUytYRP/mjDd0BJJVDXhwcSStPlU7I9jeKiSGfO7aSDJny7rwL9qA9K
	LnYecaplfPqlYKucEPEhqpbB1q6H5eo7EctMmQ45zvRvv/VYID0BR8l0Sc0AsXR8bX/2fJyvRxq
	5i7lYV3nIRLjxNUyjSMa53
X-Google-Smtp-Source: AGHT+IHwxIKpfiu4tWWg3RXYDruBytSXJ3/SIIjPMara76cnzmnUoPQULY0baE/CdfVeC/fMbdZDia8dnddDyX35xNY=
X-Received: by 2002:a17:907:803:b0:ac7:e815:6e12 with SMTP id
 a640c23a62f3a-ad1fe83286cmr181604566b.33.1746684893426; Wed, 07 May 2025
 23:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430123306.15072-1-linux.amoon@gmail.com>
In-Reply-To: <20250430123306.15072-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 8 May 2025 11:44:35 +0530
X-Gm-Features: ATxdqUFnCUlYgpyjo3kkzKj_fP_Vo0jZohWv6em6rAowUWUDTJ21AX7A3N5yL0k
Message-ID: <CANAwSgSXNuNFQ6RiqiLEBY3eCmxz2hQYfWTFij=Vi8S7rS-_TA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Wed, 30 Apr 2025 at 18:03, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi All,
>
> This patch series is a rework of my previous patch series [1],
> where the code changes were not adequately justified.
>
> In this new series, I have improved the commit subject
> and commit message to better explain the changes.
>
> v6: Add new patch to use devm_clk_get_enabled
>     and Fix few typo in subject as suggested by Daniel.
> v5: Drop the guard mutex patch
> v4: Tried to address Lukasz review comments.
>
> Tested on Odroid U3 amd XU4 SoC boards.
> Build with clang with W=1 enable.
>

Genital Ping!!!

Thanks
-Anand

