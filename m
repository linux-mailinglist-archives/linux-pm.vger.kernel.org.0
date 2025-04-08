Return-Path: <linux-pm+bounces-24921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A8A7F449
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 07:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6789117C279
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 05:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D325F78F;
	Tue,  8 Apr 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCrRynXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7F25EFAA;
	Tue,  8 Apr 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090832; cv=none; b=q8m+iIxW0SKKvV5FqZEfBsZLjXQF6d7NwwPL246i0LzwgjhTb83SKIeG6CJ/Nvbkw/zUU1DoFTmde9Zvb1u8fV3ePes+RkLJlSgS9mkpoYEFHGs/gx+3Vid7LCRXQZfZeJ/ZNznooF8528wvExkDWzukD//kc0vIo5PxQys3yDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090832; c=relaxed/simple;
	bh=JqryJqnBL6vBQBF2JhLv1OsdHxFNy4u1dsJZVxvK6Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5ynwsV7UUvE8RX/hAT+7oXQBtHvKKb3vBKMKogHHIsyR1ckyFNuTwo6SnSrlmWnYB2SIeishdjfarF4eunS+55DJJ8YY5Zfzsc066oxV4puGh/fj1kN5+geb0lD6JPUohW+kigEpcr3PcBMububaE6/IfK6dtVm3L8616uuPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCrRynXV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf848528aso41181485e9.2;
        Mon, 07 Apr 2025 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090829; x=1744695629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3GTqf61Bnr6E3gFypGdydx1ayMsoXVO9MpTGoXDQ+Y=;
        b=lCrRynXVNhno6VJ548aID7UM0KGgbXyVigTIvUbZOpMQf1TsVOnZlNrqFZmWXm8KEE
         dQ5btVgjufTi0uhMm+wr6Mncs4WM/1fI15MTS7aUr8tXzlFVjkiyWkxIwvi+5FSB5zWe
         SAGsdNbKwxbnDqr7waAQNqQnHiI+MrAR7k53Sv+UFcSntpOiO0Du+XgPDSKzWgxwIcrR
         wBD7KE3mp1z4Ekt+vM5lT4oSrYjG/G9sfPqDNdHs4Zpr6RCdC32I6DUNnlBMqdI2gDSD
         7+pMTjGJVE7V/kFVHgkY7jXzogyCjibYZ/tLsqO9iwYkgWYca6lklgHGuOEtAiJ+oPGn
         109A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090829; x=1744695629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3GTqf61Bnr6E3gFypGdydx1ayMsoXVO9MpTGoXDQ+Y=;
        b=sqfWIMA97EJN0D4exhysdUMxYBg8JrZr3QdmNqzNCS1aRqDrD6zzdej2Fu+qWGkVG3
         702rj2k6Z7zvMr83OVdWWV5hfNfEMOuw7IBpJU0wizA7lXkgEJGVRJJMimqCq74RyfsC
         ce4VgEe1NopVvPvL+scDm0W5DSEYedYhv8JGx1yiARRVBPw62RTDadHVIkq3vcGbnlBY
         b7E39AWsWfu2SmE5AadOxhb1UhKz4hM66FaUfHVEUUx/4eDpuE4F3ctYOJBMO6g8aOCY
         4cRUD7kiKqmnANHnlNV7FRw92TORukjNK0rUwJ6ZjtlWB7wJAnoSt0Ka0r4IsXhz2P9i
         X4ug==
X-Forwarded-Encrypted: i=1; AJvYcCUZcz2WkkNzutFQgqv2gzitP0lGYrhzoCvuw660ZjcaO5VSlL7k4gbo269reCaKV23GEDlEQrNP6bWM@vger.kernel.org, AJvYcCW1NwN3Fn1ujCmgYgsVAsNHrcL+vCtIRH+I9lLZL2z2/U9EbncY12xjepaa0jALqa1D+Ipf2swGRKK5KAQa@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvZxShyDSJGjnewVo8KftebiSSKcVaoVCVF4dlhvD5HXUbt2q
	kwhA/NLsnthblJBNXqjko73MZjbcyGcVIdNiTR8UrCL4Y6a5mwDdZEsPSjWNU73yskXl7AfhGkn
	qelm9BK8hfGgnGUTQb3CJL8zaoGE=
X-Gm-Gg: ASbGncs9jTLEeIenLvBH8TfzhTHVbzVGTqq88ABL4zHjZ6nLnnSbgZSFqU/vHHFQA/c
	dwvbrKmq2lI34UsWPqgtY0r9H+DrodVxJfGEiz61V3zJtSeKlLcnk8/Mt40vH8p6qpEZdVbYiT/
	7f0kIMlinR5Oy0XhSo2K5M/7tqV20=
X-Google-Smtp-Source: AGHT+IEoCMSHoj6LX7zEMPpGl4kBP88kMk7JMzqofVjGDFsp3+V+t4uRtgquAA/3W9X/QL6JC0mKCCuxASppti3h39I=
X-Received: by 2002:a05:600c:1d0d:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43ee063da68mr134725485e9.10.1744090828770; Mon, 07 Apr 2025
 22:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320072947.8174-1-clamor95@gmail.com> <20250320072947.8174-3-clamor95@gmail.com>
In-Reply-To: <20250320072947.8174-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 8 Apr 2025 08:40:16 +0300
X-Gm-Features: ATxdqUFbtp_2jsA4Cxqvw5F8BXDsY4yEvFFJuimR8jvb7bvK5M7v2b5To0sJNQo
Message-ID: <CAPVz0n30gJp7=YhxShzMWNtPOPFFx7ggdbQAgYATSpS3ZMB6zQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] power: supply: Add support for Maxim MAX8971 charger
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 20 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:30 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The MAX8971 is a compact, high-frequency, high-efficiency switch-mode
> charger for a one-cell lithium-ion (Li+) battery.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power |  43 ++
>  drivers/power/supply/Kconfig                |  14 +
>  drivers/power/supply/Makefile               |   1 +
>  drivers/power/supply/max8971_charger.c      | 750 ++++++++++++++++++++
>  4 files changed, 808 insertions(+)
>  create mode 100644 drivers/power/supply/max8971_charger.c
>

These patches had no activity/feedback from maintainers for a while,
so, in case they got lost in the depths of email box, this is a
friendly reminder that they are still relevant and I would like them
to move on.

Best regards,
Svyatoslav R.

