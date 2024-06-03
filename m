Return-Path: <linux-pm+bounces-8510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B738D79D2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 03:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE11C20B8B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDA929A5;
	Mon,  3 Jun 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNRX3tQd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041A15D1;
	Mon,  3 Jun 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378690; cv=none; b=n9wisPVx5DmHGbjQy8qOrhOSHIaZJOrN3y8E4t2HShn46rkD+uWNvgJrcwNSaFqew0bnir1t0BJELs4rZf9UsrRTK898xStKPKME+6SgGSxaY8J9TGgkEt3ODbCa51z7pWflSMYTqOyZXeHoYnFz+vQENm6AcsbCOdAVFvBVULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378690; c=relaxed/simple;
	bh=2fLwkmNgaJCamzedXflmbfZUwM9kaGgUCxGV9+QFYFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR1YrRLYQkbyUhkRQ2oTBKDwpmKFo75YtcnHbtHnUXhDFYqAlH8AcP8yhMozklrbjCO63TamE4DWs2v6ZkSOth3h2uaDudz2IExAW9UMG8h1NUN6g9sOf+N9obKgeA/LS24Vno/lGxSiDRZ2mI6X2/uP8kD6qaho47o7A0QmQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNRX3tQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4AEC2BBFC;
	Mon,  3 Jun 2024 01:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717378689;
	bh=2fLwkmNgaJCamzedXflmbfZUwM9kaGgUCxGV9+QFYFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNRX3tQdbd5qpneYFPQw2f9EnmzoRmDpX0N3J4H+Wl/LV/6jyxrKT5ZePyN2wkJCp
	 n5owcmbgIm5p2Z/uf3uJaAxdiBhmpBdERqzxfTl0/E2roFMel1hJyDqNMMsjqGolOQ
	 VNFajhrqg/N3xFN7k0CoB3awpT3k3VK2or6cWn9kPGq9NJVGTZdkEXnzhUGCvuUxPF
	 zGfvXPukFGbZmViU3zToxXyBqd1CGOgOqUIYOEBy7HFa32rfdZxFyQhRqLnqJqGu0W
	 8pIS2UjZ0LwEPJZRlT4f8M2CNraH7h9QkX+UCtFZo/CTChMeoOQ+Ql0ZEkd5GxSYCv
	 NZuPSFR5Nh9wA==
Date: Mon, 3 Jun 2024 01:38:05 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dustin Howett <dustin@howett.net>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/chrome: Update binary interface for
 EC-based charge control
Message-ID: <Zl0efdjskOcbM0LH@google.com>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <20240528-cros_ec-charge-control-v2-1-81fb27e1cff4@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528-cros_ec-charge-control-v2-1-81fb27e1cff4@weissschuh.net>

On Tue, May 28, 2024 at 10:04:10PM +0200, Thomas Weiﬂschuh wrote:
> The charge-control command v2/v3 is more featureful than v1, it
> additionally supports charge thresholds.
> 
> The definitions were imported from ChromeOS EC commit
> 32870d602317 ("squirtle: modify motionsense rotation matrix")
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Checked [1], the changes matched:
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

