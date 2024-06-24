Return-Path: <linux-pm+bounces-9906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098AF9153CE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32CB1F24E9A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72F19E7F0;
	Mon, 24 Jun 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eF8/XYVU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEA19E7E1;
	Mon, 24 Jun 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246491; cv=none; b=oH5yo2g32hTAaW2JFO12TDB3nS430gFU1dymcft9fynqpJVF3OgxhhqLHzycZzUeLbBPCwVEqWrkjtH5v6lGRvjYzBbVtd8N0J3WS+5S4hLqvcGoYZciIscqnlxkwCGxa4FsCVxv6JwjeEWwnyt91wlNJ4VAazTx9hb4MRVyc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246491; c=relaxed/simple;
	bh=JXedkQbeFM/RywiYZABiZ6G9sfYpi6PxI3HPVYh8h1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9tIF5eN4Vn/Bvcc7yvyk1ik8yeW9IoI8gG9d1QtVAGqpY0fqbsN4hmU5kMrES7/VkviQjwwUpTFsKPu2UedXYXm4WVBZUV8lynIk2R/p6LFpUxooT2G2ZyVkKeVePbhOQ+tfB2wcvk/zXc2LpKhl3Nxt4qhxb/CHmf3HEXlM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eF8/XYVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC48C32789;
	Mon, 24 Jun 2024 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719246490;
	bh=JXedkQbeFM/RywiYZABiZ6G9sfYpi6PxI3HPVYh8h1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF8/XYVUaZoFZJVATYQd2GfE67L+AtFCAA7fytVcaX2+4ZY+AAj17xhHxHrMlVxXb
	 6uc+vHFXB6irM411OPvS9BZxcOtJjrAs2Ys/IGR5h7TWAjrRVH84QjuEBnYfkDSrxH
	 z6nyhf15bacVbR2KMc1GZNKGwr+eKKhPyncAlsAc=
Date: Mon, 24 Jun 2024 18:28:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL RESEND] Immutable branch between pdx86 lenovo c630
 branch, power/supply and USB
Message-ID: <2024062440-guide-knoll-94d0@gregkh>
References: <e42fb2e9-81d4-4e40-ff3a-f9d6a46d03f9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e42fb2e9-81d4-4e40-ff3a-f9d6a46d03f9@linux.intel.com>

On Mon, Jun 24, 2024 at 07:24:55PM +0300, Ilpo Järvinen wrote:
> Hi,
> 
> This is v2 of the lenovo c630 IB branch with the build fix for non-ARM64 
> platforms (built on top of the commits in the previous IB PR). Resent with 
> full Subject line.
> 
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11-2
> 
> for you to fetch changes up to 13bbe1c83bc401c2538c758228d27b4042b08341:
> 
>   platform/arm64: build drivers even on non-ARM64 platforms (2024-06-24 18:22:15 +0300)

So was the first one rewritten?  Or is this just the second patch on
top of the previous one?

confused,

greg k-h

