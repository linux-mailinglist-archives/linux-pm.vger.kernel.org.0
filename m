Return-Path: <linux-pm+bounces-21550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D728A2C7FD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DD718850CE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E123C8DD;
	Fri,  7 Feb 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvqpfiB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9123C8A8;
	Fri,  7 Feb 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943729; cv=none; b=TWXZcqciMslUkXpA4A3qR4sRfHN9H2CwO5kPeP9Fs3dkOx81TWSzIyRyQMCkoj28Q053RmngJ2wIYYRsr5gnCthG91g9yvYRxz+TpnsohlFIOJnnAR4iK/Ytv+vy47YVf8J5NaspCb/1fXqeNrOlPZcV7HqwIRl2x+w3Caf/IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943729; c=relaxed/simple;
	bh=qx/r69FfMWfPcpZgztgDmNJpqMSLhbgIBlX5jUCHHrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0MlWy5CfujJprCHH+s4G0sIcok3hf4meh1WjUSXFdXqYudnZSfNK07XCTygKAifiAhxnwXm8WKMVcWKTynk4UHBN9V7BtupLEeFfirQ8gNKIwJZ2124FqRhM7NsvAHYCczMURGTOZ9HOtsZ3HbBUq1CRFARogKTEKwLNrZwZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvqpfiB3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so1087040a12.3;
        Fri, 07 Feb 2025 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738943726; x=1739548526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx/r69FfMWfPcpZgztgDmNJpqMSLhbgIBlX5jUCHHrQ=;
        b=GvqpfiB3wCiW8jNHyeCcwv/Dumae/6X2Q7wREnIMkU00SJOO+VLxtnOYvnsaAfolul
         z5L8povAi2CoPyfWKuDuLpGRO1qe+fthDpujSYlLnyUfviSozglDDs3Rlhn7rFJm8Rvh
         QB7e3dedXkytin/rAqcbCvPXhAWbgWMZTB/30pyLsTTk9vh+kYFE2eC0zNhLp6FLcvPI
         zs86X0729S2aC9SMtEtDTK11WXUsH/Cxu0u6ofPwRek9cSNojkJ7qCQW9W1VVM4mDsuB
         lP7x2v1I8QKcIi2gftPnTujfFp/3+m3qayR+bKci8L8ydmlpVfT4qFPh6Mexl4WVusiA
         Ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738943726; x=1739548526;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qx/r69FfMWfPcpZgztgDmNJpqMSLhbgIBlX5jUCHHrQ=;
        b=bUNB9q/cCV7d5gTTa5eqNME66VM7EdbR2mj/ffm0CtGVKS6Hmbdkp4LbO0ZNxLWXh3
         0URFEDUfaOe7pmBIgo2L9Fqzv+lY7uXWsoP8Ew8vfzrO7PxRU+FEmSmauDhlSOFTb7eC
         SKEKIJNDc3seVnrsOyHXlqZyc0aJtAHuuRE7QXqN8TT8PbJsQ+ZGWXsIowc6fQ9BDuNl
         vl2yjU+Aec3Msdh1TMZH3okX4ZsVIB78m910m2h+5dp7KwLmks+5C8ZPtZm3Dl+cN2T2
         0tljd1qjSOmrv3hW4XqzUFGSgRmR8w6mymKJ+Vzgo4ke9TPnhLT14vqmR/F3m7uloCUp
         Kpgw==
X-Forwarded-Encrypted: i=1; AJvYcCVGQ/WoZwmj6jLiLO9u5hsh8nqFh7yh365gXiGpUHGfVeWifL3hxY+B+OjmCfO6vkZQtxBVrCF8p6Q=@vger.kernel.org, AJvYcCWAL6I3bVliOaDsQ+jTXp6ziuYwGqiJiMjtt3OTQi7WQf151mGQuK0YqrXjB1ZbVKcRlB2wXnkRMTo=@vger.kernel.org, AJvYcCXP7DSBZgvYdswUWVbrkZHMMU2kxxkg9k6drvMoj/j6gLcsuKShfYTZ/sktbLdjEegqb7VMChfwNqxuMQ3s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZYGBCef3Rn/tfjPw/n40gJvIrFK9OIJJtbAf49iUWyEEq1Nd
	9hTLjeMjxG8uB2i+UZiizcLREg59ntqyYJKxO7f+qef95cuI8bNY
X-Gm-Gg: ASbGnctHMCYTL3w/gFocmpPmlaOU7LGxb2s44pK3NK7JsfNE+x6kpOdavmRiFNML7eC
	GKfPl6kfVydzVJAv5sFQzqWwAl2srtAb0tPWb3x9sYR5fZOhcoWfQTdqIjdSLGdfIIwkzQhdGig
	iM5C39KfmYDQ4S2yODCCZi/Ckm0oyKLrn6UUZN740Mg7o7vzNZGO80yg3Lhz5bcG5HE9Iis0yLE
	/paZgmZ7m9iEEGJXYNQ87QWANjI1wl3as6KbFIAXmOOKCSPMbo18af+LEa3Bdpos1fMAJd+xjgw
	mGo+C2vFwgWucmAQyXZTyChDYBQg6xp1hMqSlj6xLpNLhw==
X-Google-Smtp-Source: AGHT+IFhdnFhD1x+nif8vrnMuRN9dZ3Pt1Mf+cz8uFEARcf5qzMnlu6uMGAwxKCOk3KU8vTljkXbsA==
X-Received: by 2002:a05:6402:2106:b0:5dc:ea80:bffb with SMTP id 4fb4d7f45d1cf-5de4508815emr4226974a12.29.1738943725484;
        Fri, 07 Feb 2025 07:55:25 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf6c9f9b3sm2741593a12.59.2025.02.07.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:55:24 -0800 (PST)
Message-ID: <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
Subject: Re: [PATCH v2] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,  Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 07 Feb 2025 17:55:22 +0200
In-Reply-To: <20250206164009.816232-1-darcari@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <20250206164009.816232-1-darcari@redhat.com>
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

On Thu, 2025-02-06 at 11:40 -0500, David Arcari wrote:
> +The ``no_acpi``, ``use_acpi`` and ``no_native`` module parameters are
> +recognized by ``intel_idle`` if the kernel has been configured with ACPI
> +support).

And if kernel was not configured with ACPI support, are these not recognize=
d? Or
they are just no-op basically?

Looks like there is a stray ")" at the end.

> +
> +``no_acpi`` - Do not use ACPI at all.=C2=A0 Only native mode is availabl=
e, no
> +ACPI mode.
> +
> +``use_acpi`` - No-op in ACPI mode; however, the driver will consult ACPI
> +tables for C-states on/off status in native mode.

I think "however" part is a bit confusing. Would you consider re-phrasing
without "however" ?

> +
> +``no_native`` - Work only in ACPI mode, no native mode available (ignore
> +all custom tables).

Other than these small nitpicks,

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

(I tested it on an Intel Broadwell platform).

Thanks!

