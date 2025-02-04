Return-Path: <linux-pm+bounces-21346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B39FA27878
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C41886747
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EE211A20;
	Tue,  4 Feb 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6ltmn9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8515886C;
	Tue,  4 Feb 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690431; cv=none; b=c49p0eDFCZkCkcrvbKCV3qLj5zJGfhr7WHOF6o8JMMTwAKQXmPD+9ns1NyIen77IBKF7kTCwFBiqeoMvbe+E9wK358TFjjBRhi4e0wDNE/+Z5duQ2UxvWeLqOB1hQvQp1MgRptcjg6G+R1g02Slj+/AFrizhH2NdJ9Nh2WaOQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690431; c=relaxed/simple;
	bh=z14qptEX8dgee2mKsf4iXeOQjjM4K3gXtY3Lw5bll2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvjfGFL9fJAa4A+81u6O2DQ01caanzC4qdR4Dl2Y/wDQVb9xsCADrnVqiRPiu3nYcwJYQnvPViVP/xgVi++LG84JqRNT6yjfOCtkKy8m1Yu/RkE87dTJDUefzIR1gbh0BFs3QOrJnYs5Teerp4L5usitYYr2OZP6zPVwmN0Mlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6ltmn9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7127EC4CEE2;
	Tue,  4 Feb 2025 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738690430;
	bh=z14qptEX8dgee2mKsf4iXeOQjjM4K3gXtY3Lw5bll2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S6ltmn9mD12TyBOK6e/inimC3en6q8JPrwq1BIWPFnksOIVrhFMu/32lIDUyNpudC
	 WSUNKrzwZ+UFLaP0qjgM3ZqDlBA565rHxPJRbXIP77eeCH9tv7zZCdruyTa+zlHVW7
	 4OYCCKU3aLSpuJx2KTC+uA2sYVEKsorfTGXOQCaHJGyBMtcl0SeoH8+eMg+AUS7TcB
	 s8pAjVpW4WONsw6+G/jNEEN9og3JRIHbj8goFTS+pTRjdj5QdZyuQfluehsw9iR7M0
	 LbPp7vlHJYQ813odrBIxZ5ePtN9KOpyBb2e0DJQsFgJcchtD1+CbQI5b2OMr8Xpc/7
	 AGE8HWThzbCnQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f31841c6f6so3393778eaf.0;
        Tue, 04 Feb 2025 09:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUG/7uu3m1PtbUqb/M1yUWxnDa0RBEHFk8vAcJ2hMXFs2nuGa+n6FAjXUBVNu8W6CBt5t1CNTzs3g=@vger.kernel.org, AJvYcCWGttsxx6cTSJr1MijuQGXUjlBOMVoJo2pn6iF9T0BcRqI3qFic1sewFKfrIWGl2dGCnzEZGHTDGf8=@vger.kernel.org, AJvYcCWK/Blw0PBtfU1Kjd8eR6aUWcNXtTEKAzlmbqqfCpvgoapyc88nfSbBGAJ4i+98L5jVKDeYIYswIeEbmHph@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6D3LDAHAjMji9nrfhUDOpzbm8XovEKJrW9f0LIpuQQh+fZkWs
	ydYZZD9brtwwO6ZgGP7uXP87frZwzp13JCm3Y8kjyhhObEc7SxLBitkbbLAH2H5IZGj0/yBSEFH
	5mUABFzKefYHzTnuabyJwDSNhPC0=
X-Google-Smtp-Source: AGHT+IG5csJjUZrxcF85Flq+6ozCKXbmOHVoa7nqXwt27aesawndLFNH9vE2Yabj62rSM2ZPvlVM6wgAxlXcppqBEW0=
X-Received: by 2002:a4a:e849:0:b0:5fa:7d7f:d035 with SMTP id
 006d021491bc7-5fc00454302mr18411653eaf.6.1738690429734; Tue, 04 Feb 2025
 09:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com> <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
 <c3f03a5837e191c5371593ac0a0e3c56e4204567.camel@gmail.com>
In-Reply-To: <c3f03a5837e191c5371593ac0a0e3c56e4204567.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Feb 2025 18:33:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gKsqrruwSBQLk_1cC8MMRyznzE-FbsqDyzs7xFMgZoQQ@mail.gmail.com>
X-Gm-Features: AWEUYZmrxZF7V5xgxErnFyATEwm7y7dvecF7av1vNW1DRAlYgItJTQJYDco8paw
Message-ID: <CAJZ5v0gKsqrruwSBQLk_1cC8MMRyznzE-FbsqDyzs7xFMgZoQQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
To: dedekind1@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:30=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.co=
m> wrote:
>
> On Tue, 2025-02-04 at 16:21 +0100, Rafael J. Wysocki wrote:
> > But it could be something like "prefer_acpi" as far as I'm concerned.
>
> When I see "prefer_acpi", my intuition tells that it is just a preference=
:
> "prefer ACPI, but may be native too". But I understood that the patch is =
about
> "only ACPI and never native".
>
> The reasons I suggested "no_native":
> * Sort of consistent with "no_acpi"
> * Suggests that native won't work.

"no_native" would be fine by me too.

