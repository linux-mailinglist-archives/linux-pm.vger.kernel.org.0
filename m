Return-Path: <linux-pm+bounces-6695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5D8AA702
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 04:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE27F283789
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E15139F;
	Fri, 19 Apr 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG/TJZSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B5EC2;
	Fri, 19 Apr 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713494297; cv=none; b=NrMoyMJVij6KY/hXTn/zRCDpKBgAGZKW6GzksbgZPv1Q+GtqTAmP527HXq95FPXQcniVDBSsqwg+DtWg5ifj0DF9PglCwKuU9A3A8mvhRD8gRzdPrfrj+Oh5kQ2dc38THLnYOAjHVW6F0spK1qCIgnepZIeNtiqwQt3hvwtl2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713494297; c=relaxed/simple;
	bh=xzZaDKQCajONdDPkH2JD5yDjBQ9k3uvrrujE70hekjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxtcOPBsd/UKgs0lk2dkUbrsAzYA26jTwS/XwFZgCJD7PafeZLJbsFSym7s+e4wAsX71BxoRdqtNv5phLYEdfrWeyOv/pTIAhVeyHnr/7OeIeWQFOhgqBG3uxSkbqwGRAjQeQFFFBfst2OlDm1otP0qKwUGESRWuKuM8yAecWEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sG/TJZSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F770C32781;
	Fri, 19 Apr 2024 02:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713494297;
	bh=xzZaDKQCajONdDPkH2JD5yDjBQ9k3uvrrujE70hekjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sG/TJZSZBNizb5Iqoyv7S/0J76xmNEMACX0JVh0IbIPHkZCZoxW4ysIRYzRp5XEEz
	 XmKCT5AM3bN0k2X846NPVyLQ7eBZysdU+YSmaGcoXsqSpIWKXJq+YPLwKaPjwKzFoI
	 LmlqrpJjagY6JchWpNagJgjCQsGN2TxRyuybD6c56vyU8M9LJaU3ZnDLhpyRpoODvK
	 GlydDZHhxWEEoVqbZE1dqXEnehbYadUy5J9azIeEGdSoGoaSoTYcCzwVNxPEfppgHC
	 7rcqCpDnIQVuedxMapMmASpUU6RjmIjTH8WAOzjVElXLihBHa7s+qQyVQSIweXaf8P
	 8v4zVxToMjK4Q==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a555faf94fcso166109166b.0;
        Thu, 18 Apr 2024 19:38:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViTCBjOz5mQ/tOJ9SqPlgB3JMSA5Z7p0M5NtsoFDmlXxWR5Oj+9TyNAMbBSsHA2VmcxDTdwsOArXCL7k2MuRgvN5foiDSHYDQl5FfuPkE+HpxGKR2RbvPbgWL5AJS3C6YxsQAR
X-Gm-Message-State: AOJu0Yy+CLdOyqyr2ENR4SkeXRya3toyng77y4N7n+1CZYSUInrfcbMd
	ND7JxaQmXJKNdXH9XswZLG2YMtHepKqA4xsxcwh+oTdyY13YpmoKmsI3PKBK083tvMWGZTFX1UN
	GyhWqzMv0NcgPrOuvk5eOB9yV1SI=
X-Google-Smtp-Source: AGHT+IFvJBDzpblBBk5owp/jNp174Uf+GT5yFZPBmXeUNdMF0htnSdr7d3gaaZ3cjoI9Y1Ah6DzRSUBCZxGeB44qLvI=
X-Received: by 2002:a17:906:a008:b0:a55:4d24:6f9a with SMTP id
 p8-20020a170906a00800b00a554d246f9amr494679ejy.6.1713494295714; Thu, 18 Apr
 2024 19:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713147645.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1713147645.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 19 Apr 2024 10:38:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7uOW3tgoPP0OWXHoNV4LFM69NFSUQRd7EdkBuNnP7-Jg@mail.gmail.com>
Message-ID: <CAAhV-H7uOW3tgoPP0OWXHoNV4LFM69NFSUQRd7EdkBuNnP7-Jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thermal: loongson2: Add Loongson-2K0500 and
 Loongson-2K2000 thermal support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series,
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Apr 15, 2024 at 10:31=E2=80=AFAM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:
>
> Hi all:
>
> This patchset introduce the Loongson-2K0500 and Loongson-2K2000
> temperature sensors.
>
> The temperature sensors of Loongson-2K series CPUs are similar, except
> that the temperature reading method of the Loongson-2K2000 is
> different.
>
> Specifically, the temperature output register of the Loongson-2K2000 is
> defined in the chip configuration domain. We need to define it in dts
> and calculate it using different calculation methods.
>
> Thanks.
>
> ---
> V2:
> patch(2/4):
>  - Add Acked-by tag from Rob, Thanks.
> patch(3/4):
>  - Add "minItems: 2" to the reg attribute of Loongson-2K2000.
>
> Link to V1:
> https://lore.kernel.org/all/cover.1712733065.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (4):
>   thermal: loongson2: Trivial code style adjustment
>   dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500
>     compaible
>   dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible
>     definition
>   thermal: loongson2: Add Loongson-2K2000 support
>
>  .../thermal/loongson,ls2k-thermal.yaml        |  24 +++-
>  drivers/thermal/loongson2_thermal.c           | 111 +++++++++++-------
>  2 files changed, 93 insertions(+), 42 deletions(-)
>
> --
> 2.43.0
>
>

