Return-Path: <linux-pm+bounces-24495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26774A709D2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 20:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E994843A9D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41D1A7044;
	Tue, 25 Mar 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTijed4x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADDA2E337C;
	Tue, 25 Mar 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929019; cv=none; b=d98HQ71xBdCT3MfZxFpo0U26MuJ63BXiazfswVZSRaqpzx+xOZLjqiUAH75Dk2XrUM9NaWJGh7rQ1xmfVXjBucwuitrlSFTA/33WpqwoctNEzbNP56WVZd9AJRRKhnPUr0uYRwdPcTUAR2Id5cDWzuIbng+zD43X/C7rGcbjJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929019; c=relaxed/simple;
	bh=2QzP5JqawscAyGA62aDcgEiUGMdCdATZjb/lp/MKWwM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=S+E0xKgTnfMMV5przu6JgcxdJWLUD00pV4f5qqU6EvOam8Y3xazM91LafzXVwKQdXPPWfR2kHNGfSVitovQ2jsfYbs3aJITxpcd7CSIVetEpEH/sFOp6oOxfvhiKJoZT0FarGyz16zde4mlW6J9N2YTc5xgdH3KHmJJu3qLZmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTijed4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DB5C4CEE8;
	Tue, 25 Mar 2025 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742929017;
	bh=2QzP5JqawscAyGA62aDcgEiUGMdCdATZjb/lp/MKWwM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tTijed4xSGTvP94O9sYfWb8vS13K4/x6ZwlXQ0cyUauZqv9Eu8XGA/H44jOXe+1AG
	 R1MQFnN8ld/qRTGRJj393NVRACIqOPqEL/hfpUa55sVcKN5FU2boZKh/bklwYcSkW/
	 CljvbIWWC9mr1WZ7uIqFWfa0fjJnpbtbHidUUeMJp9T85dUopLqLQXJof2bzeya72H
	 h6H6BL2LXKie6epVgaScDtxbawQQPLREj4ORNjhFqcx3bTuqgfo4WRW6LmrOs4j0a9
	 8UIbiCCIgVUGOuyVa0I7Or8lce88+caSv32WZXbZ1naeBLUxAjcqutTmM14xrWRwKU
	 cN5QLH1Zc24WQ==
Message-ID: <69024f13d296cf2127e7f4229d1e6ece@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250321095556.91425-3-clamor95@gmail.com>
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-3-clamor95@gmail.com>
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
To: Jonathan Hunter <jonathanh@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, Rafael J. Wysocki <rafael@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 25 Mar 2025 11:56:54 -0700
User-Agent: alot/0.12.dev8+g17a99a841c4b

Quoting Svyatoslav Ryhel (2025-03-21 02:55:55)
> Extend the Tegra124 driver to include DFLL configuration settings required
> for Tegra114 compatibility.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---

Drive by nitpick. The subject should drop "drivers: " because it's
implicit from "clk:".

