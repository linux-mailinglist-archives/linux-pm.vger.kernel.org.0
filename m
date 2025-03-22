Return-Path: <linux-pm+bounces-24404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26862A6C819
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 08:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A347177E47
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1767189F3B;
	Sat, 22 Mar 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRLYCWF6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1612868B;
	Sat, 22 Mar 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742629125; cv=none; b=UTGtpnACP+W0noSQV3pNlXMrtIk1h/Ts/aRPd3TJ5O4L4XnCDv+9ZKp9KNRbJVB3HqwRicixqGIbUKAqSLnF0JlTH4ixeH0idO8Y1bOEaQnfkMdg5Ldf6TpZEClsh305ak4FzhHdqM7fMYgXCpKk0HESWW5eyucwws1/pdO9CRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742629125; c=relaxed/simple;
	bh=ayMGlcqMwQb+ftuOYdEgfcPSnBDR+02p6diqdiWcO6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JODwT0RRw+ie7yck/ea0Sli8hvObdUzOmktpiMm/5Ga0HeO/na7D668TnT6rFcULQlVMRSDPoFB91csUam4MkFyahP4HfoicRPQQ7h9S/hodoHP63g+0Yz1ioJKolYFDhnOXLYAO1yr0Zpq3hu/Trg8eBKp9a9VknYEX6tSVvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRLYCWF6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so18184015e9.3;
        Sat, 22 Mar 2025 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742629122; x=1743233922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayMGlcqMwQb+ftuOYdEgfcPSnBDR+02p6diqdiWcO6c=;
        b=JRLYCWF6NzSQ1dYcLejAV0NTgfxVnsEvAGF3EdQ7i2m1JXEU+GFeIbmb8iN38Zhjhp
         X+ugcflqhfSm0CwZ4XBJTFbrxbL7LBgrcs0DVEMmSdwaFIyYWNQ6l5yH5oBJXjCVpn8e
         YQI33XoJ4A5EusZnPvKIhBRca/6M9ZpqZi4pv3ygCit3sEsVEou54VumOewpU7uiU1hm
         wlIlrPkz59ikDRJB2JlXRrV1vOYlRq17GwRFDdOKxeIAICPqgty2WqF+jVeb8wkNxRXn
         rAQufwXeoyZyH3+IwN7OKAPGGWxYJJNja8jkuTgCwvIH61IvV1ML3njvnvHf7e7TMSOC
         /Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742629122; x=1743233922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayMGlcqMwQb+ftuOYdEgfcPSnBDR+02p6diqdiWcO6c=;
        b=WaBNQ36Yj36YVQKwKGo4YgZdGA8+1IgxMhBXEKIYni9/9bNQAcCsFeKb+KZtwy7OD9
         q59pZWDdeHiqkGO8gazKcYg7HR64lb4N2JvdFosjn9U8lYg4dPBswHMzz7Sb7zZ5SGn7
         ElFfye5bKzqJH6a37ODZysJJvjBUJiBBSrzkSlYhnWGUxFkgF3X+3PKJ6GVc3iOp1hPW
         0vh2H2w67ulSJ1vHk+AZirylDAaooTc+gurURoJiF9+THagFijDYb9vQAHCH5pqQEzfM
         iwWcMzx6m3qfiBajwt7MDzGRNOnTti1Al+abVcgXo1sTRBZBEjOqo/jujoCrvGAg+q8d
         6FDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmFEJGhzHwgr3ubqL7Wcw5q59GUyPw3d24C8g07Cq1b3T5yG4XpeJWFo8d4IepGAa1XaNojAmjWJI=@vger.kernel.org, AJvYcCXrZGnE3BSalVZ5It5qEmGDgy9v1/EHI9pvX848Eud7pyBUBs/0si3WR/J2OzZEMmvzhIIdcrb3/O4N79Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YywiWO+/6Jkvcjnw2frGmzAz3E4lBi4N30SJIqlFNQw8SyTmUQZ
	r7F72xfz7AD269CilkqP7drYtzhI3Sv4RMGcGV4NUoFP8KhLjS7I
X-Gm-Gg: ASbGncsErKoLlF0r49qRp0JkHwybm7oz1a3+/bV4LyeilfXRBFwH8TKiSABoF5GWkSo
	iM8jG5CNGA/1q1MesY0rIigHbkWVVFUa9n7eHIfe3SAihfYYN/8e630wI7z+aMmRX0cPlIoLYc7
	XAoysXorEneNzGv2YntnnLRTniu/szWE3ytDZltnzUsis2ztTOTOEGr5iNk01EI96qUf2gX1Y7A
	L6v8lyHWsE66mOLa2joK3VUmXibt4EfPv3gwnscjL7B+Gb4icD95MB9a45P6m10VwmiSLOZjthq
	fsY/R1b/dUf59Yweou9A3I3kPqhorJdqQWhcvJvjMDgeeuc1WwaRIxwGslMxLmR2db3BjoZPX6P
	+R54O4D0cvtlfemvnG63Q
X-Google-Smtp-Source: AGHT+IGOAdcCQV9td5yBg/DeGMyuPfW6QJ09F7Nlor08PYOx21zTuurCfS0tdlMSsD+iLtwPsmEq7w==
X-Received: by 2002:a05:600c:1909:b0:43c:e8ba:e166 with SMTP id 5b1f17b1804b1-43d50a213f6mr57806325e9.22.1742629121821;
        Sat, 22 Mar 2025 00:38:41 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eef37sm4347075f8f.85.2025.03.22.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 00:38:41 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Brandon Cheo Fusi <fusibrandon13@gmail.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: prevent out-of-bounds access
Date: Sat, 22 Mar 2025 08:38:39 +0100
Message-ID: <2772067.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250320155557.211211-1-andre.przywara@arm.com>
References: <20250320155557.211211-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 20. marec 2025 ob 16:55:57 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> A KASAN enabled kernel reports an out-of-bounds access when handling the
> nvmem cell in the sun50i cpufreq driver:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in sun50i_cpufreq_nvmem_probe+0x180/0x3d4
> Read of size 4 at addr ffff000006bf31e0 by task kworker/u16:1/38
>=20
> This is because the DT specifies the nvmem cell as covering only two
> bytes, but we use a u32 pointer to read the value. DTs for other SoCs
> indeed specify 4 bytes, so we cannot just shorten the variable to a u16.
>=20
> Fortunately nvmem_cell_read() allows to return the length of the nvmem
> cell, in bytes, so we can use that information to only access the valid
> portion of the data.
> To cover multiple cell sizes, use memcpy() to copy the information into a
> zeroed u32 buffer, then also make sure we always read the data in little
> endian fashion, as this is how the data is stored in the SID efuses.
>=20
> Fixes: 6cc4bcceff9a ("cpufreq: sun50i: Refactor speed bin decoding")
> Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks for fixing that!

Reviewed-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



