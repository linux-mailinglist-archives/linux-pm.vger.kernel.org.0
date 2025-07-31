Return-Path: <linux-pm+bounces-31674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFCB16E29
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 11:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C63BFB8D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB328F937;
	Thu, 31 Jul 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RiHBtilE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA628FABE
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953037; cv=none; b=Ox1vmTtIJUNTr4ixBQojSScEm6xNEMkW2NVoLZVMQvuxSCEwht2JsCl9MaGHjgtsi9CCK4gZzxL/omaCtnO9rPLbQPlX/WeSKbYbTXZEDkQsMWEUAbdQifJJzfSvi0K7GcArUJ5FA2qVzZf05kR2M0QUofXOwy39y44jmvaWU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953037; c=relaxed/simple;
	bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMOsqdhKc+VeMVGxY6NCeah2f7700w4UUt2JRKa8mWHqcJNbfyoxRV5bkqVkWXnXYvKCLXVZ4RjoXGfPMLjJ1PsSGhEY8G6aVnr74OtZ9q6aKdrGY6fmB9u1A2RwtEvROvcTCezZ5ZGJLpkClLfKndMLWTFWUCnp2uWErxJjgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RiHBtilE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32f1df5703aso4945391fa.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753953034; x=1754557834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
        b=RiHBtilEOcpNQOf2Mb6gowx6H86rTZa18rAyvh4ThgmMZVqHQJ6XAi5GIH8JYT8yjX
         XENXHmf3/RCKSAsEW1ZBwWIN8neNeIM9NFmggqu0eBs7pAQkM/FNjgj/dsaQyaKWn/zO
         7ixKdbHHCuWtuz0w9JYdFWOpg0mXCG9w0lBRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953034; x=1754557834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRwq5x4VwHGS6JkevscNB7G4mlDeMcL9xsQzNX6TfQY=;
        b=l39i61/ycyCOuM4Ch8X79QQePGTX9uT6Yi8JU8X24ajI9VAGN4DKgnkjFbVC8r2I4W
         HZMYpl3m3JpoGqQxi/ZyvI80mGoYuQFz044tF/fTPSYl0b9PxDuoZasuZQXEfjIk5wgQ
         YrLCdGRNpfvd6JhOL3AZ+dWsxYex0Y2GJYN67YpXqlyKSoYyQ5wLo49GPX3tT7gxyjxj
         XfI7jG2QZOpbUfmz39uwm6B9cDsaeTQCIxryNvhiRIpMjdoH1jZVir6Wf8soI66L0khQ
         X8l2ILuYfqLW4mHWCiolR4q9dB3L9AQqhw+6F0mksq87sWFGwNuwDyAtZMvUO40dFU90
         LLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVj4Ib7sdcx8u0NNgQZrMOeCevuSLR1uZzUITq4c4MFB8MG+dw2kO85VVazRfGTm3j65HQ4/dsCyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmPNIim7aoKuULZaCymDgWQ20QpWvOAB3e2U7HbXBs7WxmoaO
	n0k1wiAGjjrAzo0g2nwYTIhyHxz0YxOVSfzpb2DT+2JoWIIx9CjnhYMCRp/EgPpomLIGb8yTiH2
	wJqF+axr3TNDUh0vS4N0DCrKOcJD5A+7R+2ZgguUF
X-Gm-Gg: ASbGnctJEjQkaRJnHIRx4/wDwPCS1Z+GLgg8EctVb027tMyNVMVqwbeGVdJVz903fTe
	Ex6aQ6uyR9ngjR9k+Svz/x01iWooUkPwMGbp+zyRGTeHZmXmKwWN3AxANbul+36wriEqzbbDlCp
	0C4ZLixhtvYh12rVR0i6UvIRUGroB0JAUmNeLknyc+pL8xV5OuMPjiY6IM3dMQcE21Kdl97Mwcp
	AjwyNsKi2SXz7Iw6GthFfmwqatJ55B0dG0=
X-Google-Smtp-Source: AGHT+IGy0Gr0CeJFqOAF9pederTnU2rsst1o/T1ozFpoxo2U18QbJElG5oX2wY8idW4WJNxX3lI94NTcxLdGpZxd8nA=
X-Received: by 2002:a05:651c:554:b0:332:1720:2ec7 with SMTP id
 38308e7fff4ca-332248beecamr19682921fa.0.1753953033319; Thu, 31 Jul 2025
 02:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-6-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-6-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 31 Jul 2025 17:10:21 +0800
X-Gm-Features: Ac12FXwCRD80agK2VpVTgVXGMFnqiS6tk-7RfCAqmaHj7sFRHCdDG6ywSscGSLk
Message-ID: <CAGXv+5En_Yxy1BoWWTsQPSLYCqvd0_r-JCtEByan9xNU0QLmDg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, nfraprado@collabora.com, 
	arnd@arndb.de, colin.i.king@gmail.com, u.kleine-koenig@baylibre.com, 
	andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com, 
	frank-w@public-files.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:22=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
>
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

