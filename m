Return-Path: <linux-pm+bounces-24722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6CA78AEA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3973ACA41
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E092356BE;
	Wed,  2 Apr 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z6O36sOu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51823371D
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585663; cv=none; b=sKyimHSB7mKD0shfZqmRMiT/122LTfgcINyxiLMxmdqkro1WdM9KqVGNpDVuyVFNwx8sQPdvQRKwfjjMih2YgbWxVYfT2dhJJVfR30M7a2OD+BoLyZP8mtQenjKGjAAs68YEFZYBXnWY45qRTq4hem29Mic1oBM+3gE3yjMK1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585663; c=relaxed/simple;
	bh=cyRR7YwcTt1RVUuFWFxexpTiWgrITNp4gvcysQ5tmtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+CzxIWYPH7UhKMBB4XnMJzXgbFpcoYnAMsms6To3vyVGKWYzd063HviVqmreMyfStQntWtEp07skSqloE9l/g6JtyHFs/aqwwIW8ySHdWDQ1MqpQA4IgIXTY3MRNgbM8ea+cFyqlNmVQ8nZdPh/SdiKKfha23xr7Wv5Od3gUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z6O36sOu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54acc0cd458so805928e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Apr 2025 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743585658; x=1744190458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyRR7YwcTt1RVUuFWFxexpTiWgrITNp4gvcysQ5tmtU=;
        b=Z6O36sOufnewZxbHbgW9XPWl2THCMwLLTTow6DtxbOjoiFYQT38kANPQyXBDbVxreM
         ntnkAED85IwQR/4tyOIkctnYf7tCgUH12IAV2OguMj4Mot6Ww+7ddkkwFa7ctq5ogzCi
         MW+LRh+UVTM3989CbBgwdQlyHtvLnZkrpVXFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743585658; x=1744190458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyRR7YwcTt1RVUuFWFxexpTiWgrITNp4gvcysQ5tmtU=;
        b=T8cd9wUa+Fwfs0oZ4QlSkYwWKKRgE0iNQIGanj90GojJFfmsPEzoY3nebe+GkQjRry
         MeJdjufXuO2Y2ddqZRsFkJj7dkI/IFixFbVoCVdNilCp7D+FcOKF91U+SCoW1SzXXEyV
         xTdfHgURP+HCeLy8oxnGxUZF4v0X3y3J6SBe1u4WEyVLghYeTmbqPGWhu/kqkGQ6IX7R
         X7TArcBGf2ndj49Er1c/TIeqlG1HQ8qtipFZfN7/L/LLbwoC1nKJzBZNePou5rm3tysz
         6U2bsTbNyXQs85CNxfMU20+EuQZhOVwWBDfseEsL76oR3RUFaXz6zvisUzhWCY/zwl9X
         xgmA==
X-Forwarded-Encrypted: i=1; AJvYcCWqQgnKtl3JRw2TDQ9lV1srj7D++qDzbW1dEj5Vb3wd/CIx5683CreL+SXLifzTGImPttlzHp95SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfOlJMkgT2qmVxN5JM6Jg7TBo1+B/qygguwZIadLMpTc7WGl5
	xgWz/LeTbFejvpA1l8+b7HKUfXwzakJjkVpXgC8xYFqfkFKhVRxDfBF1ma9no7ohdzBa/dUsuGP
	soTxLd/XC0qyUNKj7LdJn/whz55ol5jlkdEZv
X-Gm-Gg: ASbGnctxnsRAudiUSnsNYQ7WcaXeZgHkpkKtCLkJq3HjpYRDMo3s0QOOc3QsoPtFuZ/
	dbusDLB+18Bi+ZEzv29CWDXtODXmaoiXJMHv3zqET+aYu+CuxiiMGl1qaaBjOiay87RCc9DA7TS
	twCCW2kRqlHf2Tplpyq83x2c0aJqQNF0UA9uHn+7S3GPt16i+uYlQ2
X-Google-Smtp-Source: AGHT+IFNQ8rh8uohCED3FsKCQuotU4QQf82Ifu/wJJpZo0zeWoQri2IhxtJ24b7PrATskKr8lE3tJp/lmcDLayTcKSY=
X-Received: by 2002:a05:6512:1582:b0:53e:39e6:a1c1 with SMTP id
 2adb3069b0e04-54c19c81f80mr468673e87.43.1743585658589; Wed, 02 Apr 2025
 02:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402083852.20624-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250402083852.20624-1-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 2 Apr 2025 17:20:47 +0800
X-Gm-Features: AQ5f1JrBOnaeLpNxIHL0qnzLitrLXH_ivJZiH5ry-mQ9PevMkY1uBQey-dy93ik
Message-ID: <CAGXv+5Fo3-5J1Tyn1JGP0+aTeCnkUJhwxiuLt71MLUp-zVSCkg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, npitre@baylibre.com, 
	jpanis@baylibre.com, nfraprado@collabora.com, bchihi@baylibre.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 4:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> When running the probe function for this driver, the function
> lvts_debugfs_init() gets called in lvts_domain_init() which, in
> turn, gets called in lvts_probe() before registering threaded
> interrupt handlers.
>
> Even though it's unlikely, the last call may fail and, if it does,
> there's nothing removing the already created debugfs folder and
> files.
>
> In order to fix that, instead of calling the lvts debugfs cleanup
> function upon failure, register a devm action that will take care
> of calling that upon failure or driver removal.
>
> Since devm was used, also delete the call to lvts_debugfs_exit()
> in the lvts_remove() callback, as now that's done automatically.
>
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Therm=
al Sensor driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

