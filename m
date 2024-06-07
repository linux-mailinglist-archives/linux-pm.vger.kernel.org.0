Return-Path: <linux-pm+bounces-8805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A256B900C77
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D53285963
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BE125C0;
	Fri,  7 Jun 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfo+YLZO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C39DDC9
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788629; cv=none; b=ILW9s6001BNqSsSjyAl4JCg3Ihnx0fh9EMufo3aRVhGrcnutYmrYmIyuoBMuZyUgpz2Jdr4azytfChONiLZDtiLFelo64AbzN81cRwrSTYdO7FOFREF+19qoJzt5uD+OfK4Gupm97ql0jpNxVppbxSH4D/ls2R53h+kqvRv65NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788629; c=relaxed/simple;
	bh=aM8DbRADmzNNzQG67PsIVFpUYTds7c90MYYnmHN5+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgI+TBnx21mehv7+KixSLYpepq32GeszosbXyZ5oyZ2D05yNR5HsPvOv6N2QJ/BIVpluGWwXO+HDvFb6PPx5qfJwFaoJvDPfzKkBJX1LifpgvY99b5R/pEr1NvIe2eLBWnC4AV24tEmgPSdkbq0lV4aFCuj3tis+Rxvn9gPYxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfo+YLZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C945C32786
	for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2024 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717788629;
	bh=aM8DbRADmzNNzQG67PsIVFpUYTds7c90MYYnmHN5+uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfo+YLZOEO5liLBPHvSltj1hBTi6RzdJzJS+R3i7LwTriSu35ool2TSTi6Ho8WyGF
	 lkDCw8tCQntSl26GLqyOy00SCv4XOJA4AqyOGrGOcihvB03Y+P+NXIbpGT/nK0or2y
	 9hT6+gWeCAuRpcol8nNdT2sFNopVaH5qqKbwFr9z/xApldo+LiXM8Cz9ZTsySQZVgk
	 wIPseGU4yyLfLvgtapyshXOp6PtZhvuHRW3l8aThFJ1U4I4g4AlPfo2IP2aVIaGUzP
	 c86rKEzOQ2fd2AEySOKBRNjzDz0E2VdiHMjOXDDAwwQQSopVhERL+DHK+UbNuYOsi8
	 Ka7D2UZdVE4Ng==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5baa9b4d2ceso225853eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2024 12:30:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YzgVus5sW0a0jzn0g2NZzAZgCZdri236lNDS41KDailm+gZ8WLt
	Eb080X8Yn6bs2N+VR3d1fumWcc8ZU7GsTogQz3nRCDcaWjg+ycVCN/TEwcQjGoNYbHxNjVOw8Rr
	VVhuZElu4Olv9SKJKP3VfQ81YYFE=
X-Google-Smtp-Source: AGHT+IGDCPIMFe2WrB6HAz+AsP4XaeNiPKlZj5jCMy5VujOGs+ipOs7dqGyRXUrc3WXkNuTcUWQJrfPrNV7IyaJdbfU=
X-Received: by 2002:a4a:cb84:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5baae9ee8bamr3292708eaf.1.1717788628369; Fri, 07 Jun 2024
 12:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717146154.git.todd.e.brandt@intel.com>
In-Reply-To: <cover.1717146154.git.todd.e.brandt@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:30:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggBwYGQTL15vCSeqxZzbhAYMpCekrOhCc4w=K-4HThkA@mail.gmail.com>
Message-ID: <CAJZ5v0ggBwYGQTL15vCSeqxZzbhAYMpCekrOhCc4w=K-4HThkA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pm-graph v5.12
To: Todd Brandt <todd.e.brandt@intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, 
	todd.e.brandt@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:13=E2=80=AFAM Todd Brandt <todd.e.brandt@intel.c=
om> wrote:
>
> pm-graph v5.12
>
> Code revamp for python3.12:
>  sleepgraph/bootgraph function correctly in python3.12 but include a slew
>  of deprecation warnings for unsupported regexes. This patch fixes up all
>  the strings in the code so that it comforms with python3.12 standards.
>
> Other updates:
> - fix S3 suspend fail double run by using fp.flush to /sys/power/state
> - when running turbostat print the return value
> - handle case where html files have binary data
> - max issues in summary-issues is now 100 (in case there are thousands)
> - add backup to dmidecode, use /sys/class/dmi/id/ in case /dev/mem fails
> - update summary page to use full mode (disk-platform instead of disk)
>
> Todd Brandt (2):
>   pm-graph v5.12, fixes
>   pm-graph v5.12, code revamp for python3.12
>
>  tools/power/pm-graph/bootgraph.py  |   16 +-
>  tools/power/pm-graph/sleepgraph.py | 1098 ++++++++++++++--------------
>  2 files changed, 571 insertions(+), 543 deletions(-)
>
> --

Both patches applied as 6.11 material, thanks!

