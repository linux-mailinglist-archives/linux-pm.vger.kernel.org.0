Return-Path: <linux-pm+bounces-9323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFB90AC10
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A480A287ED8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B1194AC7;
	Mon, 17 Jun 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI+5kHSn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F151946C6;
	Mon, 17 Jun 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621194; cv=none; b=bSTYiYl9tSf88QjPzTSeOA77aiFI+BRbbPtTfqbIet/VZ6TMmuBBz4El1njBaenKrSukzrtvwMcM9mL1FceDnnDtsHejshjGq7VocwCbSu+0P8PKm/tjTtQ9TeYiT2eLVLOhI9/orOcTKs5hQPtOwZWK3oi4CY1lD+7a2TDoZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621194; c=relaxed/simple;
	bh=icYPkKYUZHeKZk/PG3ca0DQXitXP9H3IxzD0krrXso0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCjoURxU0IJKeMDcOOMCY3kekHcEfTi9NWsHhUu4EKoVjkN46xoCyTBdgKCoKfu6zTcY5xIDpwdHWFACBlpCy0Z5p4G0f/lsPsdfS02L03p4S16BW1fGSju1h7O30MkChBRps4UFnvZ2JddQ2sVlkYMC64SmpCbO9yhVUyuRmVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI+5kHSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45975C4AF1D;
	Mon, 17 Jun 2024 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718621194;
	bh=icYPkKYUZHeKZk/PG3ca0DQXitXP9H3IxzD0krrXso0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eI+5kHSnAnzGZKiOHrz47zZG/aWvbMpcrjkRmE5y65y3uskLwIeIYRF9JCXqMo1To
	 xDpi4PYHK3H0JCS+5bHPOQFVd4uZp281v6A90MNSapmmcNS4Hjs1eLGgBjyvMo+zCQ
	 e0wb5DVlmdR5feRoIz3I5p7yrQcRdpAGzOiNfz17xsuiYelZDdDKws5a/FiWKAdwhH
	 hnHkoIbLrVr3XJxryJOYdq9ZKRuI+1t/v2FOj+CBXjEsbAwicrPAOp1Q3swiclwgEy
	 XgjkMhmsLBs07pQX3umGRnebuvoGZjL3b7KB3nRo973YQw5sHjFRSv1LbEkDBR6H4d
	 1qU17voSYCu1g==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5bb33237b60so123564eaf.0;
        Mon, 17 Jun 2024 03:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb4YXzk5Au7nKGlJOHSyYNbGm9sO8lwCrmQNrr7F/Fjk7Ub7b1hrfMAM7+O14erpraSvbh8OkL1EyN44sB2TjsVlO065YgtjkZe4lq/otZbKp0xINO5/sYsGbHZ2DE1WHZYkxXD4w=
X-Gm-Message-State: AOJu0YzPSphNkv8kFGrtQtT6A9vVqVrOfOCqKs/xwXJc1k9XipZltKih
	Is0glb1Wzg9w8OtGWV0+82dvtJCLY+AuBgGIP+YpWCgpoRmIJCgflqBVctznVUn7ZYs8cxpp2PS
	X9Kfo0rhq5+/vFUCbR9Z2sReZUVE=
X-Google-Smtp-Source: AGHT+IE199w8GS/G+P9yhQtVrA6avwRmdTpatWJx9CJOBGxbASnMHtj1gHRGL4yH+g9Tbpo6yQnKw6LQnpEpoMfJ8Yw=
X-Received: by 2002:a4a:315d:0:b0:5be:9981:bb69 with SMTP id
 006d021491bc7-5be999105c4mr4575058eaf.1.1718621193563; Mon, 17 Jun 2024
 03:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
 <312649b1-eea9-4346-af93-76a821e88eb7@yahoo.de> <CAJZ5v0jfvRWK0M3Xf=36e74cVQ9rN5T1WdZZVnuk1XmZ=xu==g@mail.gmail.com>
 <78549853-1763-40cf-9974-3fc737fad093@yahoo.de> <CAJZ5v0h5pQDaA-bEOmcz_TpE87kFqWLFLJC+=OLjg5ZtF3hxpQ@mail.gmail.com>
 <91d94429-fc7e-4828-914d-1a251ee1ba99@yahoo.de> <CAJZ5v0gPZHDfuK1FRdTAG8Eqjf0NWUQdf-_GCWsWf6dCBE=1dg@mail.gmail.com>
 <543787c3-db5b-4f63-b5e0-df508300db73@yahoo.de> <CAJZ5v0h7jDw3yX689nZdB+YeJbCk0vFoUgVb4Yi0cqDxjL5chQ@mail.gmail.com>
 <40ec1e53-2bc8-48aa-9909-fac9072adb57@yahoo.de> <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
 <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
 <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
 <bcac5925-fe2b-4570-83b6-182f4a301721@yahoo.de> <CAJZ5v0h7WnfQxhobA6B7S3Tvo-AnKTR9kP+5aexa6rixqpyHJg@mail.gmail.com>
 <3f5d01fa-f725-429d-b6a3-7b9617b8b561@yahoo.de>
In-Reply-To: <3f5d01fa-f725-429d-b6a3-7b9617b8b561@yahoo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 12:46:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0if=8LV+-ZN4Hv++Hg5xiT1Fj4DtQ1p3hL6g4RMi-oWPg@mail.gmail.com>
Message-ID: <CAJZ5v0if=8LV+-ZN4Hv++Hg5xiT1Fj4DtQ1p3hL6g4RMi-oWPg@mail.gmail.com>
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "fhortner@yahoo.de" <fhortner@yahoo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 9:50=E2=80=AFAM fhortner@yahoo.de <fhortner@yahoo.d=
e> wrote:
>
> Currently I am running kernel 6.8.12 with reverted commit.
> But yesterday I had a strange behavior.
> After resuming from S3 the laptop registered a low battery, immediately
> after resume (notification in KDE Plasme). But as far as I could check,
> the battery level and stats where fine. Nevertheless, after 1 minute it
> shut off. I guess the low battery reading directly after after resume
> triggered it.
>
> It is not directly related with the commit, because I have reverted it,
> but nevertheless, maybe it is helpful to understand the underlying
> firmware issue.

We can do that, but please create a new non-regression BZ entry for it
against ACPI/battery and let me know its number.

> I' going to test your last patch and let you know.

OK

