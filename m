Return-Path: <linux-pm+bounces-40403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27158D000BC
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995BB302A132
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC0318EF0;
	Wed,  7 Jan 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnWLu1+H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A2318B97
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818659; cv=none; b=kAfBlOTQu5oh/X0w2/94Wf48F5tgZv34QOKu4eaedB9kFlS3GdolXV2rUgRBZsJufaDPPrj7q0odCAXMQoU4lH0TWkpH8NrHJH9Q0Rb4/iVgzvKMEaJ0XkL8O16MjxPg8HZYXLdlZRZ4eSTPC6p0z65SKfzAcuJ+aDp6kEgbKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818659; c=relaxed/simple;
	bh=9npZ62eR1MCcUWj9/MzrPYVXqFhFMol+7fa8iQH7Q3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR+/rex1BSbB6ezLmU5lE1v0ErPdT0s70muV0bqlOoD6t4ZaSav3QzHXBWlSHYv/UOtmOcSWL246+V9OGr5vZmJIrEfCXf0fK+ZTF+DqA97oa5AYU1gPkybqb+ZxWQ7TBomGC5OOzT2L/EGCxIfHS8D7Pgi8kRvVd+zSe3PRsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnWLu1+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29840C4CEF1
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818659;
	bh=9npZ62eR1MCcUWj9/MzrPYVXqFhFMol+7fa8iQH7Q3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SnWLu1+Hgmxo1gL7pGN0k/d7NMM8chisWOdljulyhBo3E1XzSR5ozrq1LbVgZ48Fa
	 XpgAWormAVx70286M9WHkWjnqvgEUjUbQ2wBZmkmMC1zeBXw45kJxQ+55Z1vkBff6j
	 jp2VerGJAghrws56RDOYTw2bwyGqFqreNjlgBGSVLNzw+r0qv/cVIFSncXHFDmciYn
	 kr4PdXsuqGVKm94G/XlKMOiPYoPleEhC+u/Tmi/OgrnkrrO21BnuwGvyiizYGMEDyD
	 q5yHiyIK8QJQLiSlCUMm5cJGSY+6gfXrmPngwzD013pikxUHtdndC397ZrBuiGRcUw
	 9CCQIngUjXE3g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65e94e128beso710703eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:44:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEElHnhr/Xo4Gh0SKZRtd8vG/s/CtqaoOo2UYW5u3914j9QFVvfq52PCrYFrgzvnlhJhY6PQ9dnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtNQyeqQqhRVTa1ZnHoWaYM8HtNvg+6cHM0A4jGV7SbDvuSfz
	QaRJMEnCUOjiXLH+5cR+Dsnz2xCKGGjveCHIDWpNGCou+ENPazr0yweFiOfwtvbWOGw2Cf+gw/b
	VieMtwJL1hbI19O/+SO9E2hcZLfGjySI=
X-Google-Smtp-Source: AGHT+IHR2HdXd4FPM2MFOHgK5OcWaXUFk/JBU4fYbn5iYuvsZ1oCNEGqVaB1P6DFRGVAXoBmGs/zM6qtpbXnsnE3Rqo=
X-Received: by 2002:a05:6820:814:b0:65c:f821:9dd2 with SMTP id
 006d021491bc7-65f545efe60mr1626269eaf.15.1767818658294; Wed, 07 Jan 2026
 12:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251218222559.4110027-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:44:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iukfkGkLPZHvMD5Zm3CuWHj2=UoKTNbDnpkrFptvpMcw@mail.gmail.com>
X-Gm-Features: AQt7F2oVfFRgjqdwx3mUeVcz0Iy3YDadA852utAJInMNAHWHB9UE9m8W_jpeKEU
Message-ID: <CAJZ5v0iukfkGkLPZHvMD5Zm3CuWHj2=UoKTNbDnpkrFptvpMcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] thermal: int340x: Enable slow workload type hints
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:26=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add attribute to enable slow workload type hints.
>
> Srinivas Pandruvada (2):
>   thermal: int340x: processor_thermal: Enable slow workload type hints
>   thermal: intel: selftests: workload_hint: Support slow workload hints
>
>  .../driver-api/thermal/intel_dptf.rst         |  3 +
>  .../processor_thermal_wt_hint.c               | 61 +++++++++++++--
>  .../intel/workload_hint/workload_hint_test.c  | 74 +++++++++++++------
>  3 files changed, 108 insertions(+), 30 deletions(-)
>
> --

Both patches applied (with some minor modifications in the first patch
- please double check the bleeding-edge branch) as 6.20 material,
thanks!

