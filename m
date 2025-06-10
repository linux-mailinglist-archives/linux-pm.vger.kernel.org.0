Return-Path: <linux-pm+bounces-28358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D69AD3496
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5836D1695D0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF428DF32;
	Tue, 10 Jun 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2Yq/7sQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CB28B3EF;
	Tue, 10 Jun 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553751; cv=none; b=mFzty24JTIy4zzgNhBOxkrJL+QdqFyD0Vj+AgrWwPTKjHlgpMPK+jmvuUlN4D9HbXfG2WxU17GE/GL4zDpVkPg5QNR/mCnScePbC76sgswkUNh69+Z1K1JMxbozJfKSGDCNqmpYMkBFZkUMwa6vDTw4Pil0ILPmNvaz7dECKb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553751; c=relaxed/simple;
	bh=dzzDigNbQWvFnbgIjdwltehjUydpRvZcm8J0CiyGL6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdemSVzB1qpNwHHjLG/lkdyPyye4+3O57/xB7ZEccz1EE+bk6AahAoHky32T7vZ6qjVLkZh881AQDelSQinPfIUKZHIUZK+FQ+UX+yABXM/WoadMcqBMkKUob73QagummsLLqwOe3Ie7zJzqwCciuGvtWoKaNBIx7LI+zjSkH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2Yq/7sQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45300c82c1cso9377665e9.3;
        Tue, 10 Jun 2025 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749553748; x=1750158548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzzDigNbQWvFnbgIjdwltehjUydpRvZcm8J0CiyGL6A=;
        b=Y2Yq/7sQnRs8P0rdsctJE3bOCJ1IBA2XExaiU2e7ANYBKp5Dq5zzdTHlK9j/SNUiYt
         Pi85J6w8somcrCIMQrlEHkHckJ5SFQI8ieldpNytbtVRJGEoWV8fMLHEwamna9QShY1J
         ybGV/Sqh7ELtH58v+YTsFwGkA+xGxwOW79xzcV25kAMrddl54RPjcLGAH9FdJNN0UBy9
         i9BVfHKQgd/251fC6jmflAd1mxcbB4uspHPATlrMm6XpkHZGzgQxX52NaBWcoS9qlW4C
         yCkKJfU0GatFs3WwtohOtzcN2yy53DFA8/krlQglbm0Ij+5VOPtCEeCuk7kRyqLTZmUv
         UylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553748; x=1750158548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzzDigNbQWvFnbgIjdwltehjUydpRvZcm8J0CiyGL6A=;
        b=BW3XlvnLQQkbLQzuB8D+I57IzHgbpSu9JUzzZfL6W2R6ViV04ys6rnHrBXV/6TP2AM
         Si3IWI7kGeM7Ss4503mjTxnj/3YdmhRu4kFMmCJ9L4wGmM1CiG3+rp7BzP30Jf4RVKEl
         4qIfohD8qZZUv0YtoJXL2MIeRzf96XyphL0QE/LzScuUFIqV3UZgECC/cWQ6vvEYC7zj
         Ha2FZKIQweHVsm7kOx730ow8oXC2v3lC0CQ/IksTe+Ah1sdwzEDhjI8jAqQKaZvInEIq
         VN3TpNmdj51nCeqDk5iMD9E4bUcjJ4/MsvO+YRjR77jNd0BcJ2Z6oNahHEfTqSg53sNf
         ubGA==
X-Forwarded-Encrypted: i=1; AJvYcCV79Mm75Kk2AkQ1Nbo6PNTEOA8onfJJI/qhXWLKXCTSdTfXIXP3QFZBHII0Sl1s588vCvFqFX/NSDNqCXmQ@vger.kernel.org, AJvYcCWhPUy4CdUdz5XJT0PqSX2sLunErWEsnyGVvGYF1d1RmbxHivrrXkNvYbBeR7m7P3DzdvS9eOZKZIN1ttg=@vger.kernel.org, AJvYcCWkDTM3yxLHqvYx1EU9a4zXRNA2P/ggCnLfRQsAFeuxD8xHQizH5e20Ghnv54nuUdQ413JzJ9CZqHY=@vger.kernel.org, AJvYcCXeC3Ib2M9QZZmpKwGxk0m+15LQ+sDK6NoxCu2zxLCUbxowmUMEu9q7kviGZBD6dZQUHoHiXycdW18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1LLFhirbVQTuV4r9RJMtzaJ1vB49u2D3RfmG4jj8PVChBYyk
	R7lh5sKRNmxWGZ46dOYRB4A7kQvXpfznfh12Hn3uArA8i7JykhwJDnlc
X-Gm-Gg: ASbGncslmIDDmbxSMyYJx/6XHdeD2I/0BsIN0YDXdaUcPYHy6nal3TdNNtONRKxSBot
	blkqtJCmcymVn1hXatWekAGIOxl14Fp6YTDGPdW90vj39T1S/3+8NbhdZ1CxLe0iy8ZSGey9+T7
	q4+ILPoNH0gkPoWbUcqvDv8rJG/Dlz6yyGoYvopVevK4k6AnJWcoS9VTqQyo+h9GuWy1UMqjrSx
	zyqlTT9EDd1Fv+BlFMRra4a33RNv1jQEOqcBZzG812fvYiTM7R656BWSZsMc+hLGuxYn8YI92CR
	q/kWTK4qGtAei1T+w+OfO416SK42RzM4hiP1+s/JMU3LCtg2KD8PBUOrzgB1udABoNN1++E4LVm
	ax5T44S/2c6MGaO2LIHCGsbzbRGlDXI8PWPa/1Y66Dkn4oLGM
X-Google-Smtp-Source: AGHT+IG68oUn/KlqqErVvFmv6p1audzggHo+5krqXAROPFaPY2NiSSWkghrcrZfQLAO3t9T1pwRiwA==
X-Received: by 2002:a05:600c:8718:b0:450:d07e:ee14 with SMTP id 5b1f17b1804b1-452013ada08mr171855775e9.17.1749553748299;
        Tue, 10 Jun 2025 04:09:08 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324364f1sm12316562f8f.58.2025.06.10.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:09:06 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:09:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
Message-ID: <svbpvo5cpwonxae46wre7ar2w4yf5j2xbfkb4hek6xgnue3jpl@5v57pp4iz7uv>
References: <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lc2bghryyziuu5ih"
Content-Disposition: inline
In-Reply-To: <20250321095556.91425-2-clamor95@gmail.com>


--lc2bghryyziuu5ih
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
MIME-Version: 1.0

On Fri, Mar 21, 2025 at 11:55:54AM +0200, Svyatoslav Ryhel wrote:
> Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.

It might be confusing to refer to this as both Tegra 4 and Tegra114. I
think it'd be better to stick with just Tegra114. Otherwise:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--lc2bghryyziuu5ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhIElAACgkQ3SOs138+
s6Fk7g/6AjRUWbg6q1l0nhejjkpwMeIxmpQSymJfQ98bwI0lntbIDB26QfmZZFfR
8rIjlsf53Uu6LWe0KOxxOot4X9uIauE5EZsAb9y3ESBzxC+0k6PYXb2wpLFwyIDo
lQ7jlr6lPvjf9RMdO/hrdbcZr6UI6A3jfXJ2BpoiLOSuDSjqHGMzLJX3M+3WovdL
WFjhVLaosl7gq8eF40ozOz5PZpb5WxhtcqhJbKWhZc5SEpbd/SHNWf6teBRDqiBB
Km7V8NqYUBvWpN7SoJj+X+JI13tokegEDiHIgEX3AIQ9ldy9SeExkPKQe1j7ak2H
PqDs7iMd1g7e1AKZBAkbcn2IxM+guFwnIOzfXU89iWNs2lQG8LQuqlbFVtd4bbY+
2lUyM/vRoghKPpXpGB7TdRkZwa6WeiOZu4TYI6sNXx3vCgPo8Zne37hoGeoaquCM
8N/8oS3ZxVKtGWQPXIYspoM5JdN9X8lEldHmp5duWk2YsMpnpEu2qENBLt3YEK6l
xLnLxGuX71x1dMAigYe7hayAvSo5B/iAszYFKPS0o0FMQZMxAwxJb2ZrhhpmaF5R
x4Xcrvub1yXS+L3r88x9zoo9xTlPcVDHOZtpnfK6AG2dbEixauPN/U6h9acuD7/W
FzTLT/GCrGjoq5VYBE6Fh+fT8BlXGRFPegB4nH0/ZfCYLyFp990=
=Hh0/
-----END PGP SIGNATURE-----

--lc2bghryyziuu5ih--

