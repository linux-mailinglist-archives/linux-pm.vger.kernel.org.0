Return-Path: <linux-pm+bounces-6164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5189EEAC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294631F27E13
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B78156861;
	Wed, 10 Apr 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOZwytox"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4D8BE8
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740860; cv=none; b=AUInzGDHIWfyiOkFOkiUXTQHyblfZndiYW5WkTMfrDr+SFJ5u3Sdpq0HGwjXpDdgh7AUkl7ncvFVrpu5th14LWKutduU12p5XdjTcRfh0UajBzcplDdKGL8XdlKlqKqraqX349/HlyFc959Rpqgg3yG7mRboE8nk6+2/dzqJRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740860; c=relaxed/simple;
	bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB07NVk1VA8YfEDcFuYMKmkf6cNuABxLJbhNcQlOl7sXf+97REDCpFFdE1lo0Uxuxtq94AK70kq7g20Dw5428ZJIiAZW97dni8lHiCaQF3PS6IT4FKEiXQH6ThHa1WclVheNW9igbNYUaVQcFlEJaTYClYeq0Q3ofhbRiiSWVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lOZwytox; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8743ecebdso46169221fa.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712740857; x=1713345657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
        b=lOZwytoxyU/pUArKN0fsqC4w3VprMSwPRtA+1E3nCcqB9vASpxZg9ZjMAc9sycmCE+
         CyGqHi0R9pEbPYlNwJ1mP0K3f421voB6BD3sBBUYkHgA82eaeKk/Lh2rbD1+MmW1HKu3
         ABwWcQBSPeNQLgb8Jxt+uPtzGbgU2D2Cv1HdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740857; x=1713345657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
        b=QvwndkCUW6n2VkJEwaluNthMgsTi8SOwamNlfQrOQSfT9nGbkirq03ISwxsyK0N+T1
         Q0xGpQ02/uctM5k4oA57KW+HVjD7gi3pFambyeSfidNHE30Dsl9xPKSQNLH+7+XY/8Nm
         phRqgXYgQv1igkfDJ1t/EqOr1vXGiCER3vek2q5kOSWDw1Pvu3FjinX88OguNqTopze1
         NyYNMUWezaLiQD7ueuzz0tQOfRTDP2bwCnZZSG8/W1oC6ca4NtBXBb7UawPcLHe5v5nr
         +H6h/Co3Vy0Ek00fspM8NPsQE/XRByj294+kXVJ826IQjo1+P8D9gXoCPLEgJScs4LOa
         O6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJd57UxLKwA7YV/PbfabPaXusbfb/ZtMwGfnPvWXQuAlIYpvWnkTPQlsPFuzubR/90rlqfEiFgNLemA+kZL3kb7Q3yaNMnKSE=
X-Gm-Message-State: AOJu0Yz+hOpmi+YpfHzHXxs5GiKU3CCq9720PzYkHud7qyRcGlrzBhmh
	Bpy8weJF0qnIHmz2e3WvNTug4bnLF9KMOP5UWjgirnzd1CHXq+q/MRh4jvDDM8cCvkJIYItHFUP
	MMk9EyrZPXDOyRCuTUb5Chh2SyEEUyd7P4l6w
X-Google-Smtp-Source: AGHT+IFL6KPS7uL0x/EtSSqM+BxaTQB6YKxFAO4dVgt7h/JSlGs8pTFg9ELkmasVKscLtesWpTkQnSz+ws7ho1rA6oM=
X-Received: by 2002:a2e:9913:0:b0:2d8:2fea:2e4d with SMTP id
 v19-20020a2e9913000000b002d82fea2e4dmr1821870lji.2.1712740856858; Wed, 10 Apr
 2024 02:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Apr 2024 17:20:45 +0800
Message-ID: <CAGXv+5FJM2_yr0dwD=FhaDi4FJzYn50=jY6fJsFnder2q7TKrw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: mt6360_charger: Fix of_match for
 usb-otg-vbus regulator
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sre@kernel.org, matthias.bgg@gmail.com, mazziesaccount@gmail.com, 
	gene_chen@richtek.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:44=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The of_match shall correspond to the name of the regulator subnode,
> or the deprecated `regulator-compatible` property must be used:
> failing to do so, the regulator won't probe (and the driver will
> as well not probe).
>
> Since the devicetree binding for this driver is actually correct
> and wants DTs to use the "usb-otg-vbus-regulator" subnode name,
> fix this driver by aligning the `of_match` string to what the DT
> binding wants.
>
> Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger s=
upport")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

