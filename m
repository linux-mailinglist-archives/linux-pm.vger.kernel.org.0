Return-Path: <linux-pm+bounces-35124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97474B8E293
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952D71896C20
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959626E6E2;
	Sun, 21 Sep 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utnWX05/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76214258CE5;
	Sun, 21 Sep 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758477066; cv=none; b=AP+8zv4kKdo7O/PJUWEoEn+9UERfzS+QHTAa89vd1iZJhCs+qI6NCwKZRx4BHe2i7LIiLMYrjC99TNZa2tdTBMbZkOoeG2m9Fl4xJjhB2Q92VAAWR8I3s6r6dIn3dA6WBwMZhsdOeGScii1yWo2yMuaQQd6LjxVgfG2jWn1ug4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758477066; c=relaxed/simple;
	bh=e/lBJw/pvOeOhA+TnoE8B9EgHverZBvwU1Z9gNAbIbE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=a+pUn6mln5ePyDeXlR51sagMuNqOxnSv1/9UkdlDG4udvGw2CZ2klTHFWet4nZbyLgaF2jupgNYkcK4oOPxbu7wWdnOYyY+fExR00P+8gH4/L4fVYPygQcwpHC16S4UjzM7OWDlEAK3+FxXai7Zn77p8idiA/qZu6hjHgpdPM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utnWX05/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E615CC4CEE7;
	Sun, 21 Sep 2025 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758477066;
	bh=e/lBJw/pvOeOhA+TnoE8B9EgHverZBvwU1Z9gNAbIbE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=utnWX05/rsIn1ShsYYQQjUjEpkqzGWCNfoKPCRIbfgNZyHfKxFOZtvWJppj6U6cvC
	 WMvyP9nTRqm4EEonMC8BI0pZLyktz5kDMjV7s4f4TxO5iu5GORbRq8Avv9+wL/dr/z
	 MCp/Olzf7wjDJSJEIwsWjIL6CkTIdojhXUPG8kksZYbk7txcQwdfV2DVbbE+m5noyu
	 OGIUOk7ORLhJX9Z3ACX5VXJqhvg7Djc1/3rdkKVJtpflAWzlBPivFRoSqyc6ZbUpQV
	 8gWRng22bVbrlLSuLGf/emRwdTfSaZALXmyjkcHzgXOpV7e3KPYzQjl7yNUos1/Kgu
	 5A2cX9kHttFVA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250913-pxa1908-genpd-v4-3-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz> <20250913-pxa1908-genpd-v4-3-55e4cf32f619@dujemihanovic.xyz>
Subject: Re: [PATCH v4 3/4] clk: mmp: pxa1908: Instantiate power driver through auxiliary bus
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Duje =?utf-8?q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
To: Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <dujemihanovic32@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 21 Sep 2025 10:51:04 -0700
Message-ID: <175847706450.4354.2268547686521833352@lazor>
User-Agent: alot/0.11

Quoting Duje Mihanovi=C4=87 (2025-09-13 14:12:50)
> From: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>=20
> The power domain driver shares the APMU clock controller's registers.
> Instantiate the power domain driver through the APMU clock driver using
> the auxiliary bus.
>=20
> Also create a separate Kconfig entry for the PXA1908 clock driver to
> allow (de)selecting the driver at will and selecting
> CONFIG_AUXILIARY_BUS.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---

Applied to clk-next

