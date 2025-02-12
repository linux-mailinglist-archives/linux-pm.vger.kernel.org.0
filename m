Return-Path: <linux-pm+bounces-21931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F8A31F9F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 08:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B5E7A2BEB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F61FF1B7;
	Wed, 12 Feb 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR5eoN8V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B81E9B04;
	Wed, 12 Feb 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343896; cv=none; b=fM7mFyBdj8yHObWamUYFxlJ4aHy82B/NOR+BPfNXwJTDrDrO141yIQnDV/u/EDm41idEaYSQkxvT1+uRR1QpnLCO3Wp9hoyw22s77dGH3gSnV0+K7uLp9s9Vq0V7PfRGrUk3oc45XX5yoDh5nKA7BfnsWu9GD0BKJ+b+PX0QZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343896; c=relaxed/simple;
	bh=XZknmyTZpuJ/vYhf9yhvHpuHXU7uvg3lPc+DRXtI5S4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWDnedZaFOCHl30Wn8z5rPG4mbjoooZGwlXDS7PhvF/26IwMx1DQc9k1P0biAdF0fCzxll5V1kcpUPptCWESVHsnaXeqfGcDWUQT75NUgvG4wql4tac8HkOFSxa7wJLVUuT8seLGnSz7eezlEytp6hmHG9mPEvP3nveRX9+BAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR5eoN8V; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7d58aa674so322785666b.0;
        Tue, 11 Feb 2025 23:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739343893; x=1739948693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZknmyTZpuJ/vYhf9yhvHpuHXU7uvg3lPc+DRXtI5S4=;
        b=LR5eoN8VCCD2U2alOwqZWW+nzvNQQqwyS7jcqdcypgSMNGS0CYl7e+qzFM67gD2QW4
         TEmWG4u8dp8nFgg/bnHWdmof4PDOORgO4ODYuAIrLKjzb5xrq7Y5fEqWXAtHgrP7Qqn8
         U1aODSPbpp61cqCtQ9mVajxb9UFcxdTGtZ17bk8sJSPpr13O55wodvUsVYqZC9HplVW0
         aOoGMl/2TFVqMYsvRqz7IxYYqkHGb4psA+vmwLXQRqQToZvUtxeTWcMo3tF6V1ozcbu4
         RUbu1Q6MBTEPlgVh70DTgX4Zvb6h7TJ2Y6Mq/H+gBGxbQ1EMdCjfuAjhFPKJmN+2pg28
         Py5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343893; x=1739948693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZknmyTZpuJ/vYhf9yhvHpuHXU7uvg3lPc+DRXtI5S4=;
        b=gUtowyFr7vIEGOukL4BkdD9v8Z95MJjOsad93ohisxuIDV8W6a+0+zgcun6gOwx5XZ
         235CrB9LXbuT83Igx/hARPq7LbiHlUjCDoObVvWvgt+dpNwEois/5FS7foZGszoI5fpH
         yPXpkTIgNiL45ePpsMeqSFMTKJc/nnnLGJPerQFMu0G71PpkoyAHiInqh+4Z8XdW+P9Y
         27WTtUvb8ZLJhWf73NkF5+BR3YQTsB9EMlgMtaDRh34+wiaOLEO4xrS8twG8jQisXEUL
         rbpfl8rrQhUk5m+4/8upFSyq+OVJ1/5LxSkrBAfaCMboU3NMqJ2+kJ3EaXZtlcJ+i+xo
         J34A==
X-Forwarded-Encrypted: i=1; AJvYcCUsSjxyiLNkwQUs9DQiYlkSKY0z22JsvXzNB8tsxos4/BYVzAUQSeomv5MNvZzOL3YttdDIJ+42x6o=@vger.kernel.org, AJvYcCX1doEHSIIJnBNz0vrbsW6Q7EblXUWEkXvBJNcYFe8wSsprf0qEeUy4ZvT34qCZKyoSmyKmfb3r8tI=@vger.kernel.org, AJvYcCXAycuMB+6QdZUSwrflS4oPy2Y9LS7k8EqtiJpat+SeONnT2NjPPlA7Da5OBLaHDh7gjLmoG/XkKLRzCvn2@vger.kernel.org
X-Gm-Message-State: AOJu0YyWyuafMc8moH/ReB8qouZXUHZug4CoLPdNK4p7/cVsRts4Eh0+
	SayP85+Z7LGfACAyG8kJpFLeNuTG78cA/sJJODPenqi/dZfVPPby
X-Gm-Gg: ASbGncsMXwMb1iXRiF2Cx3K4L3xnFnTKvFM+9fJ1oxYRnJQJesnZMfr//F2Nhc5hizN
	mDxoCn4esle1Z+gFMi9oOaH/q0yF1sh11FUmcRBSgzPwa2PfWGwqoBaswCFWH4aW+zJOLAHbQ1R
	q5iJ8n7Dm0Vu7Wd56wGRB6/IsKFt2Y+KWV7rGv2QY2rmqiLfLB0BBEfKsKEuvEbv8E8IiLILUwW
	PeL6ySP4xG3cLS0E33TXqM1Td88+Qqs2GhKL1aHkWFZcHMib4U8Je/qPBHT/gH0wgxCtZXkuSvZ
	nEOhE/z9T2YlH4AP+reyLGSpSD/oQEN8zj078mkt1GQyrw==
X-Google-Smtp-Source: AGHT+IFw0knxSS8K/s8LJBCcVpkUFKsw4fDsN4n1F+1zZY89z/X1MaaaItGkcnvBdrGg9qkLRY5BVA==
X-Received: by 2002:a17:907:7288:b0:ab7:d06d:b4bf with SMTP id a640c23a62f3a-ab7f34af30emr143645666b.39.1739343892477;
        Tue, 11 Feb 2025 23:04:52 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e8050dd2sm222571166b.136.2025.02.11.23.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:04:51 -0800 (PST)
Message-ID: <6417e41c8564fccbeb97babb14656988e6b2ac7a.camel@gmail.com>
Subject: Re: [PATCH v3] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 09:04:49 +0200
In-Reply-To: <20250211132741.99944-1-darcari@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <20250211132741.99944-1-darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 08:27 -0500, David Arcari wrote:
> Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor model=
s
> without C-state tables") the intel_idle driver has had the ability to use
> the ACPI _CST to populate C-states when the processor model is not
> recognized. However, even when the processor model is recognized (native
> mode) there are cases where it is useful to make the driver ignore the pe=
r
> cpu idle states in lieu of ACPI C-states (such as specific application
> performance). Add the 'no_native' module parameter to provide this
> functionality.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: David Arcari <darcari@redhat.com>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Prarit Bhargava <prarit@redhat.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> ---
> v3: more documentation cleanup
> v2: renamed parameter, cleaned up documentation

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

