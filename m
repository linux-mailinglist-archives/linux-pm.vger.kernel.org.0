Return-Path: <linux-pm+bounces-35939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2416ABD1340
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 04:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FC1C4E9363
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 02:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34BE27F18B;
	Mon, 13 Oct 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIPkiHkQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054DA1E4AE
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321933; cv=none; b=qU/eIZQmQAgOzhA2dPCX99/wZwIC2B4ysno4mQAZRgCw5oidok81H4zC4ipmq/Oq/U3Jc8JVzVkPdcjoR3vAPxr7QhAoQiC98a79b0ZEwzwnBP/DFDt9l/v04TRzSJzjguBeO1irIyo4qtY8VUZ8+GZY8//IIya5N4dGjroRa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321933; c=relaxed/simple;
	bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw9SlHImqkq9gISlkO7TYy4g9DMNOgbDIhxnobTyuvRRLULSd8KvG6ykWh4j8i8i1D/VD+hHEEbVpKkzOPyyir2bfqfVfsdJZ3mp6cQzDMiaZ4bSx6qcWnVPRsIgeAK809EblvYcJELyrJbzFZ6EVR5VR2cc0unRypcBC8qWBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIPkiHkQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57a604fecb4so4841100e87.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Oct 2025 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760321930; x=1760926730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
        b=kIPkiHkQTsEnp+Hl3dnoCd6vUP3X6XN5l4n9+ixvmJTjJ10hhqgA68j0wmm/5u3iZy
         DPmlmdWEgMAg/VqRQp/p/ConAqk5fkdUET2819ZYBHry+5pXknRSAW27uAeeicslb+py
         uSFPqa0iQelmQbHtwE1yXrgMFoNNDQVey4Oop+cW6puqav33Wji0VVQdqak9JQYuj1xu
         yj2os50x8xGvr62JRi2ylg5fMwBVREj06d6MkOPjzO+PCozaeJbd5Ap3TCzJaAs03pfL
         vndKRRLTb1a1E8/gRyfqwH44AHqf2kx1gcYSCPmwkGiKg3wB/sgs+uLWL/tpQPbsvUbB
         GJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760321930; x=1760926730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PDrTUGmEtHhlWROJVzFemxew+01a7v8V9YahKSqAgw=;
        b=PUkB6j7dziuR0kFp78nQUrN66rbrIqrOe3xDUdBRHdsNHe7UTJxIUBYZt0iQS7GNZ/
         G6+444yHxCxmN97OtU3bT/A31BAKj1jLpD79rIaHg9iTqD7O9zCtFxXCvrsxGNEIqig3
         /EJIybQHyPRrCdz8k0OyNrFY++Br9y19hy62bUogM1+/C4ETgzrerpZXgtped3P1wEZJ
         3aauLlEYBUOHA4x4yfk/p/VSBbpAb4KXdefBJSweh52ygLZMby9X1FIc+QuepUETHG5/
         xARnwXHDVgAbLf6buk7cjgFUQ6J1jZhcZs4i9QHy2m9D3tXC+nSEA6qrN+WTvGDn0Jcp
         5ImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSTd34Rz3ucmt8tkIqGtmGIFlzvjwikP4bFtOh2lnHcZwIUbV3Mj54IRWcp284qr2oBRap4GsuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCmTFQ+8b92SOXDEXRCT6FjOrP1hTG3Fb4KRNKKBFCpLWQlWt
	1mrDWcysa2kf4hdKXrjZEdG7JOg22nfer4pHd3nozqPMUzYLuMyRHDzllzKWNLCZic00iINUSpm
	1ppexzXHqBPrzP/ApAePqQHY1/jetBfo=
X-Gm-Gg: ASbGncvH/LirlAVMDMxWgsAB0tJLGczJPKSd7I/AD4gSvunf/uw/kbcGxOmkuN1zywH
	nUTAbHGJO6cJ8IH6X71zEQRxpEqAgnel8vgbDxUITfItdwQUjK4bJ5R2EWfOGSzUcx/BZdkVaSd
	eEad+jM5I2KSE9bsGow1ulx4gAyW5bQBAl8ImCtjignoQrys6dDFV4LAFYkMvr5eNqPs9kBp6px
	QzuiDgcD5brDh6AGLdCKKM64Q==
X-Google-Smtp-Source: AGHT+IFiw45hdvimFqGDURQaGtDLi9ENkklrzwLA8phy4Ic6ETpmgrs7KC/3t2Arw0r0YQyBDrm+0eG6CRv5jVYMkRw=
X-Received: by 2002:a05:6512:3082:b0:561:9635:5af5 with SMTP id
 2adb3069b0e04-5906dae7bb0mr5720922e87.48.1760321930016; Sun, 12 Oct 2025
 19:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com> <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org>
In-Reply-To: <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 12 Oct 2025 21:18:38 -0500
X-Gm-Features: AS18NWAIF1xrgNjZf5B4apzT_7FVhvYHWdeOCO6h_dIwtjEyeBNHBiTCRjDDt_8
Message-ID: <CALHNRZ-okVZ8tzKYa=jqudDu3dZ_Yq1CkeErdcvxi5xJEgJFbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 09/09/2025 15:21, Aaron Kling via B4 Relay wrote:
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
>
> Nothing improved:
> https://lore.kernel.org/all/20250902-glittering-toucan-of-feminism-95fd9f=
@kuoka/

The dt changes should go last. The cpufreq and memory pieces can go in
either order because the new code won't be used unless the dt pieces
activate them.

Aaron

