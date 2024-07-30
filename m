Return-Path: <linux-pm+bounces-11668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE99413A6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C222D286112
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486FA1A08AB;
	Tue, 30 Jul 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE7E8UMg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA141A08A0;
	Tue, 30 Jul 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347533; cv=none; b=u3oboxXWqysvIvoYK4CBpU9mOIzVCkcKZtwZkffxhV95wT7OqO6qdgboM3fl+Ze676HmAzcShihahIzLLMcFwTRs+q5t7iFJJGQQHB9gs9nL07yG5lZI3jXv8f2t4aXG5/LUxL7+2BQ2TSkmeFr/QrqzCZECAuV+pwEIYzXYOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347533; c=relaxed/simple;
	bh=JB1JmpQOHXQSbmP4KdJxJfStFVVP6caJ1tkYro5w+UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaGZADcCbgZKuc2wHPuNPCpt1q0oz8mSpQq41Pn686/ckeZrxDeSPVLEvnEr8SyNsZINYfB7licIZZH7z8SNe4vSmu5Mw4jp6bQytwfroYcWiI4VTu0+L3Z1e2sTsjmK6DugjxBA8HoZa4ZUu52rACrQv+fTHXq8RoBkflZi6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE7E8UMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12FBC32782;
	Tue, 30 Jul 2024 13:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722347532;
	bh=JB1JmpQOHXQSbmP4KdJxJfStFVVP6caJ1tkYro5w+UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HE7E8UMg71EPqW0ZW5L68kmJ1zfnq6HJXU2asMPLep660uG69Tw3cT6hcX4nmlnvL
	 BddxOvoCByds58G2rUeoDSKt7XOC7meRleLR/9YLQElvv1iCjquAW9dAlJDpGii1sP
	 WeIwZPweBgNgracm+VtVHnKmN3q3a3JhsdC6ZrhPKjFbyAYpp55/Sn1xULWkqTcPk1
	 6F0sCXltfU/n7w6H8O9XH5ePq4DsA8EepF4ZxcC9JHOttO33zbG1XHwgEw/A3knVye
	 wZDuzc/q6hdZ5yXQhpGWDLJTjTI4W7QnuwhyXkyOnP+OYevvhWPOS5QpretGs9Tu2z
	 lqzIPXPx1HWdQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db18a5835dso250024b6e.1;
        Tue, 30 Jul 2024 06:52:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9YEaZk9TS+F3tksTqfLKgo0VF+ILfDNMSWrbKtoAd4vVIT5Yiig8MM3rsv0y+w+vDGOcX9bR2+bfE314=@vger.kernel.org, AJvYcCV44opGkEz10g2fdIaVzRpfgoeXJyweQDwuw+yoB+ZRTAlTtVVWBHwLH3jj9P3n+7CSL4bXNfndVKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjwzHShd7Wv9QY0p+xogwfe7v4N23Gqq75l6MFe4QKrXkA3Hs
	5F4l4c/8+blqZ2tcV5oAgWkQ6nqUGE+0QCWM6K4xbi/7bHwyGza0iDwlrtgPNt9ozGnnLcmXbUL
	HgzWHVpcXGoFVuTJ3ok5y6+ktXNo=
X-Google-Smtp-Source: AGHT+IFUaD3/qlGfwQrOf1J1ggoANMlVkbDqTmMHN1JFNnYvLDRoFFcJWFyJC27cQnNe7zR+nGaQ3AIPBs0JiZFbzyg=
X-Received: by 2002:a05:6808:199e:b0:3d6:9b79:1536 with SMTP id
 5614622812f47-3db11f60f0emr10883949b6e.0.1722347532035; Tue, 30 Jul 2024
 06:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240723140228.865919-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 15:52:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifNGa6yOZkGnbvUKX=S-HLmpU8ESf6i1fjKUQqKAZUig@mail.gmail.com>
Message-ID: <CAJZ5v0ifNGa6yOZkGnbvUKX=S-HLmpU8ESf6i1fjKUQqKAZUig@mail.gmail.com>
Subject: Re: [PATCH 0/3] thermal: intel: int340x: Fix Lunar Lake MSI support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yijun.Shen@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:02=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On some pre-production systems, there is a partial support for thermal
> interrupts. This cause kernel warning and fail to register TCPU sensor.
>
> This series address these issues.
>
> Srinivas Pandruvada (3):
>   thermal: intel: int340x: Fix kernel warning during MSI cleanup
>   thermal: intel: int340x: Allow limited thermal MSI support
>   thermal: intel: int340x: Free MSI IRQ vectors on module exit
>
>  .../processor_thermal_device_pci.c            | 29 ++++++++++++++-----
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> --

All patches applied as 6.11-rc material, thanks!

