Return-Path: <linux-pm+bounces-21324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB52A271C2
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 13:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319A2162BFF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBB20E016;
	Tue,  4 Feb 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMfrjbyT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE520D4ED;
	Tue,  4 Feb 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671812; cv=none; b=XVl59rIAyzZkR4kVOuMKRXv71IhogvXHblBTvUof1V9fwxL1L3Q+eMAe0j++H3T0fT+BZYQHloGWt965AeIQCW9Uu66yyes/2+Uh7ye0nRNSkD1gjnIBVHgab+v0VViCEAGiDN4pFAgLyujRN4dZlqCd1PLppvPpjs6mmqH7S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671812; c=relaxed/simple;
	bh=1AwBVmhsE6RjZNivDIyJD1c+DOs2FE3JauK+zQhNYbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AT9Ekr9HvhfLGS+Huh8lG1BSkBDp9CtVlRpK1KLdUx54gQmleTpPHNGhfPam9+dKacTWo6NJDwlUrCMZ7hwpjuBYq7MDIAuL5SjEK/Q6A8xp8X4VBoWt/VDy2t7KX71V/NuzOhXa4ZylkphM4DDQMbKqWLT1wo+MigBlHD4YTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMfrjbyT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dca451f922so4278083a12.2;
        Tue, 04 Feb 2025 04:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738671808; x=1739276608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JW6nXgkGnw+4YwH5C7jTt8bg63lJJkPHEUKmMZ4igM=;
        b=SMfrjbyTaSjqHQfUz05REEJqyzfebMUuJ2gBJY1bRwd+GoLkJ4R+v8Mtreh42rL6nh
         sspbQREbKTCBUB9gMC888r1/gAgNTeWKsgSbJMLSak8H7hUeCIxi+w3+JQnMz/CAP3gw
         mGhd9/+CvfX8pKvpa0vrFgZc1f/4c7Qaiigw2GqGVN98eEw6tq8M4Zz/1aSakjMXe52B
         81zUqtITQMGgCzGwk4eKDxFe745jefT7caTygfOodrehEuXZ53b6hebQu1l7FDJ6xrDh
         Jy8TppNItJzZ+Y3g8HxMRlhtUppCZhYrZYmm3UFFrYeppUCLyRU5FogrYLGVWneEdoml
         Ru2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738671808; x=1739276608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JW6nXgkGnw+4YwH5C7jTt8bg63lJJkPHEUKmMZ4igM=;
        b=TRz10F3xdmqF391kMdLWD8KtdDMYkJ0ZkIhyAs1aD3zL3Dbd8k848nstgOwhn1LBve
         It2AN6yNXFetcD7UtNQHGIAPyA9WTCrD3SqcXulqaaghZ/3cTUyQnw6XE8q7KgLg4TyW
         +f31/MYBR3iH1P1vVxr/z+3PKyXTrXnbp88qnVgyUpJ2PddmrmWDTONCzgm2nv6nVBwM
         ax0x4dSRii2jEl9zj1Mmb2L3uQyrZXhelnN/NxLbTLONhf0vnE4undRtVNokSWAaFjUq
         lUVLR8ak1KAfsDIVMgDuMtpLa9Eni85LBq8sHTYbyWKen8uYB1oJeBrbfZvBi27MhLKm
         +n0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBeJst4E9ofKJd6OaqBZE49+f86LAQ97+yQeQMZ1T1i6gtXRQzjwFKNopFZrZgzP2Esiu7zjMGZe8=@vger.kernel.org, AJvYcCUxIhP7iCy3PY51m3flRg3Z9Njjp7fUNovq1CXPCWCFEbqnC5zKgv01RB6TqF2gYznU+cTztgORPaL7FaFQ@vger.kernel.org, AJvYcCWSkOCX92GL8dvYzZaAAqxvRWg2ZqSEVaW+rLL2xid5Y4WY/WqcSAjtPneMEZ0aP4a5NVUC4x1NRao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAKdfqSvA5/+GYTeKqe/7//zecsE6p/1co6nzIfw602vY20GO
	Q36Zp/XCSeIzntkHrvnjy5AXLkob3sWgB93Hj7pMjm2ckQ0DqtSs
X-Gm-Gg: ASbGncsJr86XRmCfYUJMwMywazOGDNHhXinMEaO3//BQTuIzHuGJ8LV/+B2Y6qFnc6I
	IvxSr29BxmVODLqCbffddrWpnNiFidu6b9PoYieN0s0NaBjvvKCbU5iw4M1zKrYJYPtvytkAygW
	WRYLEuHNRxfwkLE5lal8nQ7grYYdIMpujihWP7C32XRqialDcmNs706m2hFaSOTudzxfiqN3gLN
	QRDMTrzYiTf0jrFwV0I7XzWChTg6L0dB3ZRvEnDsASfsadbKLseiqtPR+30TqiFHLqX3mL5ItA0
	Cvwn9Op8IwE6HYQOgDqYHHyHX0HMT3V0pkieUtflHN1QMA==
X-Google-Smtp-Source: AGHT+IErkO44neLieHc6hwPzIGiBDdT4ITuB44WevvVWTsjc7SP/HSFfpELM4neDw/ug1OjRMfoI5Q==
X-Received: by 2002:a05:6402:e96:b0:5dc:7464:2228 with SMTP id 4fb4d7f45d1cf-5dc7464261cmr21034232a12.2.1738671808162;
        Tue, 04 Feb 2025 04:23:28 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e4ceasm9184143a12.21.2025.02.04.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:23:27 -0800 (PST)
Message-ID: <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,  Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 14:23:24 +0200
In-Reply-To: <20250128141139.2033088-1-darcari@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

On Tue, 2025-01-28 at 09:11 -0500, David Arcari wrote:

> +The ``use_acpi_cst`` module parameter (recognized by ``intel_idle`` if t=
he
> +kernel has been configured with ACPI support) can be set to make the dri=
ver
> +ignore the per cpu idle states in lieu of ACPI idle states. ``use_acpi_c=
st``
> +has no effect if ``no_acpi`` is set).

With this change, there will be three parameters:

* no_acpi
* use_acpi
* use_acpi_cst

I would like to make the naming as intuitive as possible. We do not rename =
the
first 2, but for the 3rd one, I think "force_acpi" would be a better name. =
Or
perhaps "no_native"?

* no_acpi - Do not use ACPI at all. Only native mode is available, no ACPI =
mode.
* use_acpi - No-op in ACPI mode, consult ACPI tables for C-states on/off
  status in native mode.
* force_acpi (or no_native?) - Work only in ACPI mode, no native mode avail=
able
  (ignore all custom tables).

Additionally, I think we should enhance the documentation for 'no_acpi' and
'use_acpi' while we're at it. Otherwise, it is hard to distinguish between =
these
three options. Would you consider another patch that improves the documenta=
tion
for 'no_acpi' and 'use_acpi', and then adds the third parameter?

Thanks, Artem!

