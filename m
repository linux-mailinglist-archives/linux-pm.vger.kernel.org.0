Return-Path: <linux-pm+bounces-40311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D09CF852A
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57FEC301EA28
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD76326953;
	Tue,  6 Jan 2026 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOujkwb6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9648309EE5
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702713; cv=none; b=HHo6qTFFaxsbqhBGMj0IHx5dyffJuOL/04rYWs2oi3qNKyJVJmHYYM46dh8I6RaV+fUu/6q6URAYfi9NZjDrq1funs0VyT49J3tQ+oaNCO/nLRNcR4GD5hx80pcN/nfHLZnv0Sah9UZKldleYnuU5uiYBRCyKnnBjOC2xrXy41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702713; c=relaxed/simple;
	bh=hkToN4ECsG3MudPOwQYTR0U4TyBoX8kGNtWHmfV4Vbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG9en1C8MVAsqkUWyrwlj9rn6OCWhZi/8Xx6b5zM4Iyf9md40vsxz+rYvWd0+2LvRNTmZj9UOr/JEJqDkACie1fow0sSr9tJZrN4q+xawlDjJQez5VmwMGPO6CVcxYLaqmK7Y7ADqQaKUoa+NLmWeka+tbGmXSYHpxivmZzCVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOujkwb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B9BC2BCB5
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702713;
	bh=hkToN4ECsG3MudPOwQYTR0U4TyBoX8kGNtWHmfV4Vbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mOujkwb6bMD8rzDaSHSkYx8OjwEInrJxUuBRj1PQtwd2iVuOFj95TFLz/HIe5m6b4
	 JFCtSlFDE6EI2w0ZVIbDJ1otvSnulYNoVUf+NRkWGcoFoX8nn36gYVzlRQa8qiUtsT
	 chJE0COSzraPDn3y+bL4oqPwwnh3W6TFe/TDY2TKMIY3o/cLyofSgpW0Z2kG+Yvs67
	 l79HG1GTvtrUkxCOt92LR1WXhnZ+Rr5BYxkzarDZ4hC7cnVCXK6RYFnuVp0u5Z1LAV
	 mgC7wC2iudZM316pRGDMnehBsd9/ci4mnjW8XIBPXQxyqrLAMvAuLq6sHRsEfIo3O7
	 qcjJakQbt4f3A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37fdb95971eso7107621fa.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 04:31:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIiW0BuTYxlncmabEi9neIVRh3l+3bXfPmfL0Cbwn0yk4s3BXzYfQm6woddiG85gRUImbM1vHf1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOT7lp6NtOSJvcBdKewX+71rjlfXfN1PTGZQ/Q/gYyl+1M9zo
	UHPDe3jrba3sfDCoP+UjX12b5eYl8gtcZrQsfZZGJHViNVjIfCAwsO5JmO8nwtWooMhLL8Waimy
	IcTAwzb3H9xBCIp/HTD5tUm3XvtBF08jEfd23UuHagQ==
X-Google-Smtp-Source: AGHT+IGAgUkYHb6c2adQeG89MGXDusPgXEG8AgpWKhx2YWzaObHsgiKa1FY1iLZX9m/J51WaZQMV+gh52Wy4JNwMhjo=
X-Received: by 2002:a2e:a555:0:b0:37f:cb34:2144 with SMTP id
 38308e7fff4ca-382eaa6025cmr8054501fa.2.1767702712063; Tue, 06 Jan 2026
 04:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
 <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com> <06619e53-7260-7bd2-1954-dd10b92dc354@oss.qualcomm.com>
In-Reply-To: <06619e53-7260-7bd2-1954-dd10b92dc354@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 13:31:39 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfaS=zAXj_YMOyV0DJBULbtysF5VU_mx3BFmhPWSYTnHw@mail.gmail.com>
X-Gm-Features: AQt7F2pN4gC2sUo7-pfcb6UAcqBXjb_7kw1NmqpeCuPqNOQAqpYTTP5tEx92_QA
Message-ID: <CAMRc=MfaS=zAXj_YMOyV0DJBULbtysF5VU_mx3BFmhPWSYTnHw@mail.gmail.com>
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based allocations
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:54=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >>
> >>         INIT_LIST_HEAD(&reboot->head);
> >> @@ -82,19 +87,17 @@ int reboot_mode_register(struct reboot_mode_driver=
 *reboot)
> >>                 if (strncmp(prop->name, PREFIX, len))
> >>                         continue;
> >>
> >> -               info =3D devm_kzalloc(reboot->dev, sizeof(*info), GFP_=
KERNEL);
> >> +               if (of_property_read_u32(np, prop->name, &magic)) {
> >
> > Please use device_property_read_u32() if you have access to a device st=
ruct.
>
> Ack. Can it go in same patch with the fixes tag?
>

I would be fine with it but it's more a question to Sebastian as the mainta=
iner.

Bart

