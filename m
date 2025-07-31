Return-Path: <linux-pm+bounces-31648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E930AB16AF1
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BBE18C5B6E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 03:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970116F265;
	Thu, 31 Jul 2025 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLQJtc42"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BA1CAA4
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933619; cv=none; b=BK4/MzefLBy61nQyBCFFkEKUsIbKhe7wfhpZPeEVPJSndy10bbHHnglck1AStHYD6vptdwXLDKN47f0Gw4cd/VNG44JQBC94CFuIlpbK0flJnmAl1tAT9LUwUAgGmu2iJH0d7CiVqvn/PV++SKD1MRkQQe1u6YPHWJUHDinu7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933619; c=relaxed/simple;
	bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISJJY+lSaYPwGmMxy4dEXoPe7VyP3vu3i72QCT4E4LzZWPRiiq39Bc9t5JSSB/omxJjVLlZsp35VVYKMC4pmN3/8Wdm2XTtl6MubE6NwdT5/lb7L52yrgMbDF5k7SGISIg1PG9IUyTaTLQwIvKSzv15q6jEeyLfhl9vVXnRsTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SLQJtc42; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-884f2b3bc2eso153208241.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753933617; x=1754538417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
        b=SLQJtc42ptwoDJPt/0gyy2PQDgdzIAomyLQl6hr25Hll0eU2/pKMpdzwkiz3YyrYAs
         FPfw9Rzwb0iU0bXtpFpvFqCkcF4IdsTZznUbuohJupEuFLtKqwyzhiK//gxh2pPeWa70
         ckb5ylg5CRgOaRY3ymd/RopymbuOR4Sf6nGko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933617; x=1754538417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YELIpOTk7v58USyg3NWMuW2KC3hMjQSyAozxB3de114=;
        b=l987vmTjCqTsty4Q/UCs4v0AqeZqbyp2P9nPw2jmFSAq3S8hGtA/j/XnGuOmVS70Sh
         cMyPLIlVDku9lqL96H+AJwG+G1eOWdeD9tgPLO/m7ZapKYMoveFaBdUV+Zr+oySP4NZZ
         jSIlgHqW/OI75RH6NBjKNh92Bmj6J1YFeULiwy4f/Y41G9SHIpkPNwBsYun47UjT36D7
         Q0egwQ10uQo6iQoBoQcHBM20IWsPQuPj6poh0faWWfzo4/s/dgqI/oCaxvjpVfUJ3c54
         xirJ0MQe33GuA7FUsB33UW3iokYVP4t36PP0fDHKvgX4q1wk+Jtle2Wp+IiIszcEjV2L
         t1QA==
X-Forwarded-Encrypted: i=1; AJvYcCUgkYa81Izvftwl7BWHzac2Wx9nzs8j1wCTvvCrsnZ2SCkgFdeLxMxH7ZvVG3Y81vgjBod8dDS+iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqmwNXc5u6RsWIVqxPy/SpcRHZccUeXXHxQd/OhZousJEgGH/
	HJvrfJyFxtJYD96EyMg/ORalRe9C9wguX13YbV7dsHEgyaf5Ff3KnxXH7pCvXZSuQNLoeEX/IrE
	xY6o=
X-Gm-Gg: ASbGncvvQ2QugkS5wlPMFjAPiJB4+A0lCdb75O+KTBA2KkJ+ZxT8xl5evUbmhmNFXh5
	581hKRp1XTMCD/o2RaMIWlDebgitnVYPaAyDyIrHB7delGNqljnFx35q++wKGORXp580sF2RfMn
	gN4SISQvHYijJjAq9gPXIIYBksy7ey33aSvYa/fsRiPsoHnXqwV17S4vDBpIPNMMZLBogAZnQcx
	uG4dCGEm+tBXNFAoyu2MbgdkTdmIusN3JJ3cR84dUep8UZOASl66Rx+YFOeES9c75RLVRqYFviK
	+vTD4/yAUK5pNowFwbXsMRImPOPvvWujFfvZtbfda7hqsTtK8tfj4SDq8cOhd7hXEa+1lJkNYsy
	/K6+Py/agTRT8S8LHH9bZox3cQTxD8On7iahzZBOwUsmjpB2k1v2mJKf3BA==
X-Google-Smtp-Source: AGHT+IFIbCAoHHJEgt7uk2xzDLjXQAMQO5VZMneouGuiJEAhqN50IIxzXNePWZiMHvc7u04D+JNwIA==
X-Received: by 2002:a05:6102:1589:b0:4e7:db33:5725 with SMTP id ada2fe7eead31-4fbe7efb07fmr4011752137.3.1753933617135;
        Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fc0d42ba5esm137483137.15.2025.07.30.20.46.57
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e9c8a2026bso122254137.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 20:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUkNnsM2e2F8C0KKWo48drWpVVqrT2gZP1IpxWjvw6PcdTXp3ThQOAirny9nFMzMnkzKDSxh7zfA==@vger.kernel.org
X-Received: by 2002:a05:6102:3e92:b0:4fb:dde8:76cf with SMTP id
 ada2fe7eead31-4fbe8753b11mr3988803137.13.1753933616614; Wed, 30 Jul 2025
 20:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-4-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-4-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 11:46:20 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj9eVDxSxPuntMjTSrwhVAhVLMs_s0aR+COQjM2HB0S9A@mail.gmail.com>
X-Gm-Features: Ac12FXyuQfNec5PpeCVYeU9gZNhVWy6e9AZ1QYJ8r0Oc3K8xhe2Kp-euR4Zabx0
Message-ID: <CAC=S1nj9eVDxSxPuntMjTSrwhVAhVLMs_s0aR+COQjM2HB0S9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] thermal/drivers/mediatek/lvts: Guard against zero
 temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:32=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.
>
> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff c=
onfigurable")
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

