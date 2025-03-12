Return-Path: <linux-pm+bounces-23922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39545A5DF95
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 15:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7E61894A2A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D924EA87;
	Wed, 12 Mar 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joa9ZSch"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65324E01A;
	Wed, 12 Mar 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791559; cv=none; b=sbv5J1QpU0T9edeKUNlYATylgTGaO1s2MIkW0Fpl9ZJW0umxq/5asTK1EPgts0QEbJNsNxSPKkLUS5vGtZ5GL58fxdbjOQvFYgnYcdEWhTRWs8Z1I0bLB0oY0i+HMkk54HPzNnM3RrVzrQ9f4NmwQ33f+jT+ElF2BGOYGxIA2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791559; c=relaxed/simple;
	bh=1fAEBoQ5LalZFGrdcJXD/IgKT7X7kSFr8XH/ZV5q5ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AwtkkKQKQpbVNj+ifzHIVP23tLrj6vDMdWrwDfwwI5yBdltm2xbz+hMdwo7hfOJ1IH2HmwLRgGYoshEOua7F9l0kk3cGES4vwWt+2rCJ9NybtW67yB1ABBD9e4J/t7uLJ02JIwxaPgkGIkmd+jj5/doFM0ROp+uOoKY8fDP91z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joa9ZSch; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so154060466b.3;
        Wed, 12 Mar 2025 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741791556; x=1742396356; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vY4Awnn/aaB5x1WDx2/xkXk1nHfjl1OEmOE4k5LCiu4=;
        b=joa9ZSchgS9ztNAFPI7jOXyZBBSg1SzMXTKAISp9bQTYhwFq/n8iKloJrUzS3thaSv
         H6AzYXb3sBVAU9L49RFYsQhBBWnTEePdPU/oX+EqcoN8kJSDeF67qvvfUm9otL7H45K4
         YDGy/iD86qIsJOxIzZWt8YsQAqwubFrlK7RFfQMU2WCvYYvVkBQGcntWcvnjuouZKIHp
         eo4Pubi+we1Jz/QlGa9oN8Hz+fYx201rsJ7g6+uQOJohdnsjFsGyBBNS1mqA0QcOZ+Nl
         PM0sv5Tkz4N6Wcf+YRW2xU3NrAC3MVwsQZMZUnwhZFFqUdXCvXquAJFOozcd2JsdwQZD
         K7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741791556; x=1742396356;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY4Awnn/aaB5x1WDx2/xkXk1nHfjl1OEmOE4k5LCiu4=;
        b=NUOI5IfSyx53FSqtIIXDgY5l/LkDvb5HU3dpahne0eOeAtmBHuW8Fn3r0fVptVZ6Nw
         JcuDngZFJ6VADwDKVc4I69rQNHQJzvMsccKjlYGDZ9n3QXmhfggrmhdP2H9y/3qDPV/d
         oNMGbDcO7atgOxHnrsy5lsm1K8BNu6P/kZBoywRaaTUMigOSaQvPMD1WVqoofgOgMqOx
         MvnOPlztK5mdWwgX9xwacawlQIya7MoiUKkudRDtwiRcJL9RXkw/FZiSyTTL2v+RZ1/W
         +81kSizuvvT5G3jbAxjPeW301zsV4fr7fpE3UxDixAY+BDRRtUYHNecteRmCrmdD3J5Y
         7iYA==
X-Forwarded-Encrypted: i=1; AJvYcCUoiNXSuWwng61YXp1DKATH8uQoOyE7PnIhhMbcXKKmDclC7fgzkPUUQ9QW8Ue+D6SNgBjRyvyYYz07iLk=@vger.kernel.org, AJvYcCVJSBAWeeMZMe6GM6mjOcdreMWGE4dLlK15KqvI0/tgCf4qfi17VYorytnCa/uoaaP6FPIcBT5fZYp9GPFFM1MYnEw=@vger.kernel.org, AJvYcCWul3R+hNyvw8phmeKoXvXcWbs7yhg8RwtCo140v5g/2m+5hIanWH7LKGGC1E40kGBoKwsqWjuMioY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCoTQrg7ri03+NEefcbHgQDie0awX7+APAQKwxZqS3ypACLP3
	Gv6ii3jO78z5Gr7N5EiMDrZUcHKGvCieWgDKt/FXRNLyz7A1iaII31Ksyhm2WwlKflElC5v0MJq
	TWyEB6rqT3CLYzcQqN67maY6RtHs=
X-Gm-Gg: ASbGncsmOcO5xJ097VWgAFI/HzQsrOR9zIN9pg3nlkf0R/E57B7dpSb4n7WKxpFwLry
	HJBo04UkOkonNH0dTVoGtM0ydGrfAaLIOSnDES7S9kr4vkfUtpVoA1Qh4AHXLnUlnsFjMieFb7j
	J6k7gUfwnLT+9oaapRM5jOWEG0qA==
X-Google-Smtp-Source: AGHT+IGiPv/RqZONre6oHaSE9PreL8gyCQ96Y/2k8z7w+Ar336UjLvC65ewlUy5TkAYOXML/OLtyjwmp9Al5GI6HvRc=
X-Received: by 2002:a17:907:9691:b0:ac2:166f:42eb with SMTP id
 a640c23a62f3a-ac25259836dmr2972251766b.2.1741791555675; Wed, 12 Mar 2025
 07:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310143450.8276-1-linux.amoon@gmail.com> <20250310143450.8276-2-linux.amoon@gmail.com>
In-Reply-To: <20250310143450.8276-2-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 12 Mar 2025 20:28:58 +0530
X-Gm-Features: AQ5f1Jo-jjPkEoei21awrWrKjHVJPFPfCS1Ru_y01gNm4hp5leBwMNi4MCMjL_w
Message-ID: <CANAwSgRcuMZTrdn27qdEkZF33cQ4RemjExs5eySO-CMv3Qq6eg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, 10 Mar 2025 at 20:05, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Refactor the initialization of the clk_sec clock to be inside the
> SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
> is only initialized for the specified SOC and not for other SOCs,
> thereby simplifying the code. The clk_sec clock is used by the TMU
> for GPU on the Exynos 542x platform.
>
> Removed redundant IS_ERR() checks for the clk_sec clock since error
> handling is already managed internally by clk_unprepare() functions.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

On Exynos4412 Odroid U3 uses the clocks name
      clock-names = "tmu_apbif";

On Exynos5422 Odroid XU4 uses the clocks name
       clock-names = "tmu_apbif", "tmu_triminfo_apbif";

So Exynos 5433 and Exynos7  SoC use the clocks name
      clock-names = "tmu_apbif", "tmu_sclk";

As per my understanding, there could be a common case for GPU clock in
TMU driver
which could simplify the code, any thoughts

-----------------------8<-------------------------------------
switch (data->soc) {
        case SOC_ARCH_EXYNOS5420_TRIMINFO:
        case SOC_ARCH_EXYNOS5433:
        case SOC_ARCH_EXYNOS7:

Thanks
-Anand

