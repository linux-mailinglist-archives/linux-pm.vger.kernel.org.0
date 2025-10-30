Return-Path: <linux-pm+bounces-37136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B85C21DE8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBD34C611
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C852320CAB;
	Thu, 30 Oct 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0yQSi0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AE2F6199
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851382; cv=none; b=IF4uCbaiEsiK4A4BfuLPldUwKmkYPWVTT1JFk1g4GjOJxbLVeAzVHriCUSPcu6kjz9RymQfJJHcTELs4K8FgbOmJHf8XbJwmASnKBYeetOICUNciq1tIySC3WcXvKPoDLzP8nobToDQbR8NH8TeymxTUuBUr6xu4ocgoR2gYmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851382; c=relaxed/simple;
	bh=EyuBk+X4Xtv/VHuZ4DGi74RMzDlECKuEB5Qc0qEFpTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucvgkeQtg3LHdZtXLQYMKh094rSmvaGWqhQEc5TJqZYqs9YFj+nKg69sRSxEGCiANqRLKK83dHMVNxWTsOpvJzew5f4mTwfJ8ELFtMfLJn0kct0P91TZopyShKmlKcL59IUtFlQ6Kp2zw0Xk1bmg0tqqchf5RO3Q4BrKwNo1cNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0yQSi0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E877C4CEF8
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761851382;
	bh=EyuBk+X4Xtv/VHuZ4DGi74RMzDlECKuEB5Qc0qEFpTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0yQSi0/XE8eNzL6xoP8KLZ9qWEF7xhkttoGPFaBgcL+A3OUuSJpU6BxdR1RIxeM3
	 RXr89YpAc1UXykMgmtR88wRQ05EU1tX7WgDbpJowAUhtB/yUBuOMzz1JTIHy0zE5z7
	 jR1q+sG/uDfWDgQZLIkB0EfAZc174ffgjp5ADzC2dRVqsjmPXdGXXyuCVikEnLRy4m
	 7ua5MuewGOoDSZ3cSRt2L/WpVM1c5I6nyOZAtGupIQz0CKkKP019yBhMXO1q8WWpJG
	 ruPNnRWPYA2FAiXEo9QHZYTy6tvicSJnf44LrvgOaVcHmc9YKmSGCVywqeDaZ+zwhY
	 pZc5C/oGibCEA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-651c743b2d9so649585eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:09:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtVIjdmO3NlWGyXNtfyGBBcP12M4vcFwsffu7F7nZx+SdAD+uKq4sQ3wyTXY8vwsNQkn8PE5a87g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM9KaeUYBp+45kf82tE+jJAj3QCOE5XqVedgxkvt232KWVF8V
	BqTha3zwPX73cu6bXaMSNQEOzUoZX9UGVWoCeZBJnGvX2ErhwFjLYr/rYr/UrJOk1AuwoRkQat6
	bM55XR7FmnnqMsSbm5F+SiUz4yHB5Haw=
X-Google-Smtp-Source: AGHT+IF6/vemkc8wGB+v/a2MDv0yQBS8cuTZTP4rHdPYEzL/6vxgdSA6TqUt5s0tYWepDl2HrqbLJN5OwR0Dh4tATmY=
X-Received: by 2002:a05:6808:c2d3:b0:43f:7287:a5e7 with SMTP id
 5614622812f47-44f95f86734mr380125b6e.34.1761851381403; Thu, 30 Oct 2025
 12:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 20:09:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmmHORHg7HSyTKfZrSwY22geh54JT3T6JemtXpaXgtiQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkYHuPmGji0cMG97NrFUpvvbXYCaLmgmSgt2giu5eTBAk8DrCmpLOZ62HA
Message-ID: <CAJZ5v0jmmHORHg7HSyTKfZrSwY22geh54JT3T6JemtXpaXgtiQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] PM: hibernate: make compression threads
 configurable and support dynamic crc arrays
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:37=E2=80=AFPM Xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> Hi,
>
> This is v5 of the series to make hibernate compression/decompression
> threads configurable and improve scalability.
>
> Following feedback from previous versions:
>
> - Patch 2 (`PM: hibernate: make compression threads configurable`) has be=
en updated
>   to rename the GRUB/kernel command line parameter from `cmp_threads` to
>   `hibernate_compression_threads`, making its purpose clearer and more
>   self-explanatory.
>
> - Patch 3 (`PM: hibernate: add sysfs interface for hibernate_compression_=
threads`)
>   has been added to provide a runtime interface under
>   `/sys/power/hibernate_compression_threads`. This allows users and
>   system integrators to tune the number of compression/decompression
>   threads dynamically without rebooting the system.
>
> - Corresponding documentation updates have been added:
>   - `Documentation/admin-guide/kernel-parameters.txt` now documents
>     `hibernate_compression_threads=3D` GRUB parameter.
>   - `Documentation/ABI/testing/sysfs-power` describes the new sysfs inter=
face.
>
> This series ensures that both boot-time and runtime configuration of
> hibernate compression threads are supported, improving flexibility
> and scalability on multi-core systems.
>
> Xueqin Luo (3):
>   PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
>     threads
>   PM: hibernate: make compression threads configurable
>   PM: hibernate: add sysfs interface for hibernate_compression_threads

All applied as 6.19 material, thanks!

