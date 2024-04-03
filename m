Return-Path: <linux-pm+bounces-5844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478088969E8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031B128AFC0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Apr 2024 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257771B32;
	Wed,  3 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Y7bIfD5n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19A70CC5;
	Wed,  3 Apr 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135060; cv=none; b=uQ62dp327JPD/cFZYkSO1PzOjIcRXcXS6vAIj6e6i4d9HYuV4fr3MlIAZGRFgsr0pSwUG4eLeIOqmDjxwsXaTk7FEtP1uapCXdkCKsQ37ewuB8s4/bUAWqtKcjfLIwDtfhxJe/tyg5fQeABffkdnjHEYaJo8XkKRThQ623GE0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135060; c=relaxed/simple;
	bh=B9pqVkXkQIM5UBsUcxu5e8T/vTfwDeUMaKzh4EysHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEPUbwRtd+0dyEVuhFfmuFvi///MRsCprXBj+SaBPptNNb6EZJTKaDtExD4pVaeQaPtzIcz0b6IVAQ1jgQ959r3p6YpZZJDtEKUT1vNcKrG/xPoEeV9LiDwHSwdOx/Hqrcurz+G65SmatKse5jk9oeNOjelPWXz23O/w0KO3rwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Y7bIfD5n; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CA5C560859;
	Wed,  3 Apr 2024 09:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712135058;
	bh=B9pqVkXkQIM5UBsUcxu5e8T/vTfwDeUMaKzh4EysHfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7bIfD5n0KYF9WJur2xGwO04aJHsdFHQw2qWA0Hl9yAhTo4a64oIZKu4NqH/zIGih
	 J+5MhbxlFBtE3MjRj01QkYLhqR/h+alDlZKa8bCTIGF2UO7uoeAjJueba8FaXvNCU1
	 4vuDbsFUwz9GNqx8d4XRY3+Dq/NsOvU1UxepwkNH1y9B4+osuyRGtGw0L1J1WPWXzh
	 +BIsBrI2Ed+RRtoBgxvrRXGNVPAXmHKNFoadtANhmlubQHDPnE2UVHbuO/443F/OGR
	 YBgCfl047CrG0lEt5V5XCzj82vN3GhO5NrkNvAA4GrMmaizUsZQXFUAYjO005/gwMt
	 GmEwLtpJd8+TQ==
Date: Wed, 3 Apr 2024 12:03:54 +0300
From: Tony Lindgren <tony@atomide.com>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: devicetree@vger.kernel.org,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	pali@kernel.org, sre@kernel.org, spinal.by@gmail.com,
	maemo-leste@lists.dyne.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: set charge current limit to 950mA
Message-ID: <20240403090354.GN5132@atomide.com>
References: <20240228083846.2401108-2-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228083846.2401108-2-absicsz@gmail.com>

* Sicelo A. Mhlongo <absicsz@gmail.com> [240228 10:40]:
> From: Arthur Demchenkov <spinal.by@gmail.com>
> 
> The vendor kernel used 950mA as the default. The same value works fine on
> the mainline Linux kernel, and has been tested extensively under Maemo
> Leste [1] and postmarketOS, who have been using it for a number of years.

Thanks applying into omap-for-v6.10/dt.

Tony

> [1] https://github.com/maemo-leste/n9xx-linux/commit/fbc4ce7a84e59215914a8981afe918002b191493

