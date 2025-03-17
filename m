Return-Path: <linux-pm+bounces-24215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B1CA65B92
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0587A8098
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120E1AF0C1;
	Mon, 17 Mar 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j3TAu1YK"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10A1A3A8A;
	Mon, 17 Mar 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234044; cv=none; b=lKlGcNDejhB1Cf+Mfkn9spYzdjvOWA/lUhJKwK/ENPYLYgodGF2xuW5vpx5bEoPmyC/72SHrpNGK8oAHLGsfU0ccl7CMX+JvxqWwErl3HK3ZDINpFWYKNXh0NHFJC7ywthccQKpR98gsk9pubf3zMuFcwNYUFUmzGkP3Nwp6qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234044; c=relaxed/simple;
	bh=RJOQ6RDmm1JFX1wiyQMBjrLOWJI+C8CFGYNjlIXxlWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz36lKsDwWmOzn7fze6r5r9c/Fb5pUXF4AZ3jcyil33YEUTstx+M0Bv38RZQ7SjbK2ZE8E2UlcBgFCUS0btQpSPQwBlv0PQyRKhog0Gtu40bBTPtN5hYbydwEq9foD4xCDXZD5SJp1B3o0vTyz8/8cbz94jf9tJlPGzO5q7w0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j3TAu1YK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742234040;
	bh=RJOQ6RDmm1JFX1wiyQMBjrLOWJI+C8CFGYNjlIXxlWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3TAu1YKDQwiBj9PyIOUOv1dfqM7OAfqkD/gEiw3pQTM/1ih5rbOsdMYZjZHlSD+r
	 8+a++lRnlzJKTAat14MMwRGMGFdWmlaZzWlnX1Cp2nB7atffmQwi18crAiON9R5AYV
	 0AIQvq77v7GdLhnYjxa+ihR794rQYUcHsOHHhjRw=
Date: Mon, 17 Mar 2025 18:53:59 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v5 04/13] ABI: testing: add tt_toggle and tt_led entries
Message-ID: <634d0a28-9fd7-40d6-a5b7-3f4dabcbf417@t-8ch.de>
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-5-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317155349.1236188-5-lkml@antheas.dev>

On 2025-03-17 16:53:40+0100, Antheas Kapenekakis wrote:
> When tt_toggle was introduced, it was not added to the platform sysfs.
> Add it, then add documentation for tt_led.

The patch subject should mention the specific ABI file.

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-platform-oxp | 26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp

<snip>

