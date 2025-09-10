Return-Path: <linux-pm+bounces-34357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C29B515E1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC961C84213
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271327F747;
	Wed, 10 Sep 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBs1aXtG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39193279DCB
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504187; cv=none; b=p5IOL04bhFxLUsP7idbC6p/F8UDwhDyfdk0kLUljzwU/2ixSoaCmzP0pJyGuAIXsTFGzp4tq6m1XZMVUYzvxTRXTJZTeCdMReXvfB0RJ8kP8f9nCIE3EwVuKMN99PECUpDoEV6JlzH2lCvInBUfhls2m/3QSLT3C3HLM+YtLnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504187; c=relaxed/simple;
	bh=sx745xYWNlQTz7IJ+l5XW0LtbZ4FRTEwu33ThUwCe7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQDnA6sVRg8aryatRLH8hObaPXeHPagYhEM0ANvoIx2rs3fofBRW5DoIuXaS1IoxA9hvzyOXjYZvTRQpg7pfjxZrkzGrRzIs7hLNaEvuFdSSow4nFc1OG6VN/4lbo1flXuJAvSmPHkHJ1I2Un48Qyv56wsFCKuee50cjBJB5aJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBs1aXtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD4C4CEF5
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757504187;
	bh=sx745xYWNlQTz7IJ+l5XW0LtbZ4FRTEwu33ThUwCe7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZBs1aXtGGaTI80cS1mtr5ixOzUetamUriresW3xxwkeg8VrJTP9LT6Jn7fV/uI7eD
	 xjt0xmHdar4Ms63ZReN1V0QuXXcTFAOfOQUz4R2efyP2+RGMheRhEFmASqwE4jTDqG
	 8GfWNhxLe59jDRMQZFCsx6GyOKR2EJF48Xhqu4RwRARWWeEy7eWh+kjHxm3GZWuBH0
	 GemGuOZYs4ecvVGb/golSDZ4tHozfGi0Sb2XHytYskB9rdUi5gwbGhMjUx6fWtbT8i
	 Px9XrXpJ7FqNfYJ+ATWuysKAAPB878Yyx6/I46AcuWPpLCEn1dIyF6jU9rkD+MIbT7
	 th0uX/KeTun0Q==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-62189987b47so1826608eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 04:36:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcnnHB9TLK6OrKzdHAqAVQwWTL51tYAB22UwhfAh6aiNTJnJDmyKrSU51psJxS0aNk4X7XrhRvCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzESyCifN+NsUXXkLeBMsVui8FPitVPge7b7eQB9GtUL2nevW8C
	CVVeHGRf+y0s4FUEcaXshUhdJZrxHvh9+UCUijuu5DbouhEbNzivt23QhqkcMWyNhd8QGpMrPg1
	i+T9lRPeHTdwilU2f07Rud5fBFvR+LMg=
X-Google-Smtp-Source: AGHT+IEJO7lV7IxQ2LoalC1HeIn3RsvWclTAZHN7seU9U5SjUk6ilxWC/Yd7dP9gyeE3b0ua+DJCzPKBOUc8oYM21NI=
X-Received: by 2002:a05:6820:828:b0:620:7998:64aa with SMTP id
 006d021491bc7-621789fd31cmr7072039eaf.1.1757504186425; Wed, 10 Sep 2025
 04:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908152213.30621-1-johan@kernel.org> <20250908152213.30621-2-johan@kernel.org>
 <6a00646c-2b25-4193-8db2-157669817d61@oss.qualcomm.com>
In-Reply-To: <6a00646c-2b25-4193-8db2-157669817d61@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 13:36:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gXY-QRFonw1fU7ok5k0ieNXo99gmQhXTbXQ8icDwEhCg@mail.gmail.com>
X-Gm-Features: Ac12FXyVqN9IGLh7O7_astg1sdoDIW3e_DesBVTeINM0sGt0jkF6qY4MvvkCO_0
Message-ID: <CAJZ5v0gXY-QRFonw1fU7ok5k0ieNXo99gmQhXTbXQ8icDwEhCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: qcom-spm: fix device and OF node leaks at probe
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 5:40=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/8/25 5:22 PM, Johan Hovold wrote:
> > Make sure to drop the reference to the saw device taken by
> > of_find_device_by_node() after retrieving its driver data during
> > probe().
> >
> > Also drop the reference to the CPU node sooner to avoid leaking it in
> > case there is no saw node or device.
> >
> > Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main=
 SPM handling")
> > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.or=
g>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied as 6.18 material along with the [2/2], thanks!

