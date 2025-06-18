Return-Path: <linux-pm+bounces-28971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C6EADEE2B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6A54A15E1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87D2E9ED7;
	Wed, 18 Jun 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mw3JERWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82562E9EBA
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254177; cv=none; b=knTxRYxMCvw1q3EHmgR6/hDrvo9k8GL5BRlDXUxXdrxc69qD2zifc2GiLF5Iowh3w3IBTghnyRQL0JcmF1nyhFI3pPlR/K6qem+nW/eUVIcLifrPZP0wpF99pq8REUsBUSM7n93ommxvDKYgf0wOgiq5A/U9cXMFb1aOzCdE0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254177; c=relaxed/simple;
	bh=tz0a9+M5C7nElDvvHd2ysFpCEWklRNzZpChi88lTTGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJbREAQ1AKUy7gL6IZuVI9WJkM+KQZ1yDrckxTKjIvviq3FaOpipFCtNdwQPMo2l6xqcI2iqXf04qJRmzWUizcuf/H6AzlrINPRmQpedDrKh0BolTtzx8de5ulLeDQ45B/HE8CwowE3FdviRB7WdJMARhCHjPN2G0Cfkoj6QgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mw3JERWu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33677183so60786055ad.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750254174; x=1750858974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz0a9+M5C7nElDvvHd2ysFpCEWklRNzZpChi88lTTGs=;
        b=Mw3JERWuIGJ5V5wrNWkTEkUYjZ2E9KOnEGxrQc3b84q0QNLUUrNZqdFwrGvSCuLQhA
         z2JYfsOBqgnWAJq8ao7Dg9P5xH4zcJ8Ti7zIfd5muHFBp1f2sEJQrF71UcInDMTDbvrO
         tBfNdHjHE9yXuA0s/ATWvoYrjnxYnEJJ2rI2kK54nBsXZhsRjQMBL+44Bad+aO5aOp/1
         HwZyj3cOJYoMVIWwzBZdXds0wknG/WJ5PYCpdITBgTCtrSK2HGBB5fhUtj+SaxvLUTpB
         Tuuhzpv0UDnJ9YGbPJBpSROKm01hcmkMCZN1zAClHmIgtAFzeiWMohR4bfrTGFOeAR0A
         pXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254174; x=1750858974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz0a9+M5C7nElDvvHd2ysFpCEWklRNzZpChi88lTTGs=;
        b=Q4kjDHApH29R2aZjhb+wiTFAun35OdNXp5jJU2Id4PqE+4B/OHwh3nG/tbvNPrjJlc
         KfO+oEqE8NFwirMNNKzVM95EwkVLCSfvE1fARXIdTj823CsD+IrXYtG2zy/xTrLd5Ja/
         vK/8TNX6ui3Wj/efAv9h3OXodIYgjmTGn7oqrGur0F+HnkQ8gm+yixbuTK3enI6zLbYv
         jXM/n4OyTFIMnICMI/qPIoi/MhOeMoEzpn0bLZmHY31Hn6g29g+MEoscnPPsyriF6zla
         kAtgx4JNr4qJUXihzcfh9PW96x7hRipQ5erK37xzMOnoKE2Gv9rfa4M2OdEa1X3hZAmr
         lJTg==
X-Forwarded-Encrypted: i=1; AJvYcCUMeFJHNEvtiWKMBQbhM5Btk6N2xOCSVB34IM2fJq5ZQ7b2F4OWwrgMvOLmktBcaHR27pGsb8aC5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlgOGv5pA0+hF6tgdPXtKePeIhEF4fL7A68QnFTdIyPrpGwLk
	WvavseEutpGGL4nv6wbLyL37+J0TJIXocjJFyFVGHsgiqHFhSNk7skIFiWsZy7zWIPN44o/adCa
	wHu8fFWkmh2Zxi0n2vf5nONR6nwrZmkSIItmk4OveWw==
X-Gm-Gg: ASbGncu853w6P+Ad3EoUsKW/RzqnjYH0yqq6c2g6vIdUZWPOkVf2e3BmZQg22+dfVed
	Yqc92GpMhtBeFjnGHtLb6mdcQpfhpxWP3h2bM6M/3fJhWGrzFlMX5nkJnOPg+NVHgA7nkIdhgP3
	OK43T9p/1TS96PfEXZfEnISOcBDHTd1omSiEwpX7ONlBhiEEEBc4sfqdRI+u9R/Uh4sj69AWqsg
	w==
X-Google-Smtp-Source: AGHT+IElrVhMfyL96c9QVT6DbL+Lc21boXjlquqgqsoD4fhNOqUmdIoDw1JXTFKsvyhQJ4W4uPfVUPd6XCcj78sx+6c=
X-Received: by 2002:a17:903:46c8:b0:234:c22:c612 with SMTP id
 d9443c01a7336-2366b17b6d8mr272722965ad.43.1750254174423; Wed, 18 Jun 2025
 06:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618102230eucas1p2573610db9d4a9f3543d0048c30b2df9e@eucas1p2.samsung.com>
 <20250618-apr_14_for_sending-v5-0-27ed33ea5c6f@samsung.com> <20250618-apr_14_for_sending-v5-5-27ed33ea5c6f@samsung.com>
In-Reply-To: <20250618-apr_14_for_sending-v5-5-27ed33ea5c6f@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jun 2025 15:42:40 +0200
X-Gm-Features: AX0GCFuzTphnup-dhM3gVd1jGswJjfqrqmNVH_fP0A_YpAvwshbZGGJ4zdPhw5k
Message-ID: <CAMRc=MfKx+S-8yYpab1YO0XsGN6a9-ybJpyRoyN6wCrKcm=j2w@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] dt-bindings: gpu: img,powervr-rogue: Add TH1520
 GPU compatible
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:22=E2=80=AFPM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Update the img,powervr-rogue.yaml to include the T-HEAD TH1520 SoC's
> specific GPU compatible string.
>
> The thead,th1520-gpu compatible, along with its full chain
> img,img-bxm-4-64, and img,img-rogue, is added to the
> list of recognized GPU types.
>
> The power-domains property requirement for img,img-bxm-4-64 is also
> ensured by adding it to the relevant allOf condition.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

