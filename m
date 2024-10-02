Return-Path: <linux-pm+bounces-15049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8E98D1E4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 13:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9C3B23DCD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46841EBFEF;
	Wed,  2 Oct 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOb0wXOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138171E765A
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866833; cv=none; b=XvrSgTQ5tOmRV3GSYf/VnbOR8scltSj7ht+ExVM5wF45PVIUP3zkUJ/NYBn4/FI57MfV99GJkwWKjwMCy04q16wHkbJAeRY3ya89SLx/uFzi8lPF3uLJ7kQsxr1pdZcoQOORTv2s7cftpyWCkb5SCzedoBrlzUW2Q3QuyVriimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866833; c=relaxed/simple;
	bh=xLLdgescBmTN3DuUCZqvW/nsMk9thoZPWyFqVcH9v/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkiX3yrvr7yi07O/kZvf06IPDvc9e1Fw9FyeblQgdK5HBvJMqM8fI6mblQViwvNh1mLYS7OS0O/2wMoMfSDrJjwPvTQQfW7IbXdOKdJ7HUsonZW0cJNV936rHX+BfTPHV4pZdLD/OO7BwZme5rXfsPpM0t+deLQvMO3fd8cwFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOb0wXOb; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e25d405f255so5627706276.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866831; x=1728471631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmcYZA7/wJjtWP/h4dJKihF0bgwj9/ex9+L3+MEoObU=;
        b=EOb0wXObty2F63xGmDJ+74Ss3AjVGz4KeHgGzCHwI+2LTOWewaii+haMAspZcipXDP
         0AKXjoz4bhZ3x789QhMZ1bu+nFg47UvLfKYQwKcWoJ59CQku4YJb9tkT1cpBiG7sl7ik
         xYbTR4vulrzglPn25f23PhYyuSGSNIMNFE5Q0f8/kfMEWHlbG1tOD896IjXDiWZCn7Uu
         wSQ95WSc1CWc6J3fqT9POnsy/v5QIHRGDO/wOsQZMBtM1FW7wYFuj3mQ5taP3W0ygnUP
         3nRkfL1KH7zeyI0ZMFGwDB/stAbaCq+ymk32+QDdLPvgkydj5zMTuFUk3xK4/F3LBQal
         Xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866831; x=1728471631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmcYZA7/wJjtWP/h4dJKihF0bgwj9/ex9+L3+MEoObU=;
        b=tt2VChcFS7IPx7kLp5aAxEQ8MqadPNiCUHkpUe3SdxhzIRSxLz8opuydm8eeGUgYma
         YBoldZ36GdP0FlvEH81vl4nQmkSLpHeh3osUjG1c1gnb9N8XTLzAoSYuQja8MX1OOVER
         CuuQKqhSIYyKyOkhChjEQKfA/IuLfSHuFwHTZ1ba9z4srWHOCBu/SheVBUIvaUj102wy
         GHbyVdcbO/mpF4k7GO1bbrmE1mnK01c++LlU9J1mOv+Lk9Y/GBd3ZOBdkUja10Db12sa
         eopT/+lkWAQOXDVLShuZo/XAphLj7oHwiEe8sfadcF97cly0kR09yZ+scwaVmZdyUqBz
         nExg==
X-Forwarded-Encrypted: i=1; AJvYcCXHeYeRoKna7sxXaxFuz6AAl8Orjzz/KDe9C0WQESsRaJPjBz6VPDyBsYhTYzavlu2xteK0ek4ing==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfS3+ubm8ZsCPW1sw2HbGhPSprrWfD0bzTgnocvHAwyahiolO/
	qxakceJGMixaN66qlvVnTF4OtzFO7DTpZtswC+nW+iQNeTGN/msHKwQny+SYVYjGVjcQkGKfWT0
	fHz685BkfUPwRAZ4K9aPh46JVOqZWO5KS+/wbDg==
X-Google-Smtp-Source: AGHT+IH1/OYH7PyqLLC06P011jS8wjK1A2ttW2EVTz1YfQDhiNruQopqyDimOPKCVrbB2cqpzD/2bH9uqx4KuH6NPos=
X-Received: by 2002:a05:6902:2182:b0:e26:5b7:9f95 with SMTP id
 3f1490d57ef6-e263840f47bmr2076616276.35.1727866830962; Wed, 02 Oct 2024
 04:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
In-Reply-To: <20240919091834.83572-1-sebastian.reichel@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 12:59:55 +0200
Message-ID: <CAPDyKFpWYnqLGdxXc4Wvt_3MNsYkCpRfTJMeUddZzpKTwnY4Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fix RK3588 GPU domain
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sept 2024 at 11:18, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to =
set domain 'gpu', val=3D0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to =
get ack on domain 'gpu', val=3D0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
>
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
>
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
>
> I'm not really happy about the hack to get a regulator for a sub-node,
> which I took over from the Mediatek driver. I discussed this with
> Chen-Yu Tsai and Heiko St=C3=BCbner at OSS EU and the plan is:
>
> 1. Merge Rockchip PM domain driver with this hack for now, since DRM CI
>    people need it
> 2. Chen-Yu will work on a series, which fixes the hack in Mediatek by
>    introducing a new devm_regulator_get function taking an DT node as
>    additional argument
> 3. Rockchip PM domain later will switch to that once it has landed

I have just queued up 2) on my next branch.

My suggestion is to skip the intermediate step in 1) and go directly
for 3) instead, unless you think there is a problem with that, of
course?

[...]

Kind regards
Uffe

