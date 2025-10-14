Return-Path: <linux-pm+bounces-36034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E19BD78AF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80183A3C53
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 06:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61FE304975;
	Tue, 14 Oct 2025 06:11:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5D26E70B;
	Tue, 14 Oct 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422301; cv=none; b=h2TspIVeZYIj/zvq2fWx7fNuTVNn9bIRhlUDuWQ+JLGfBegLog7r10DIc3cAbZ8BhdcuTdrB5yuUiq5PynhGpSKCKaCzYOtSYJkSscIBtfkoQ9nYT1QDhcKqJRRrmT+uobR7Y+/h7n1gJ42uaVei9Onh8QTtlOllI8cXneYP+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422301; c=relaxed/simple;
	bh=WEXgui8AO20DzmSZxyE4JtJcfk3ps/p5StxRxjEB870=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWUgqL583snvw6xjXQ4ORa20clTF7jxqmVcfE7ocUG3ip4YyniXKMYodPV5kq+hSrTu6b9Wg+69fmPTVNhqxaBrw8DNQtR8/vRGXG42yC3G7uwmpG698bisC5JYylKVb5ZFAb1M+Z+c6BAPQIMyyDB0mD1uCiGEZwECppOhG9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 412991C6786;
	Tue, 14 Oct 2025 08:11:20 +0200 (CEST)
X-Spam-Level: 
Date: Tue, 14 Oct 2025 08:10:57 +0200
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] power: reset: sc27xx: Add support for SC2730 and OF
 match table
Message-ID: <aO3pcRCZN1qYEDW6@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
 <58441250-1f00-45ee-8583-9863efc938e0@linux.alibaba.com>
 <aNtq4qyYNqZThjeI@abscue.de>
 <982105c4-9dbd-47dc-bfc3-ef37a390a14c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982105c4-9dbd-47dc-bfc3-ef37a390a14c@linux.alibaba.com>

On Tue, Oct 14, 2025 at 09:44:15AM +0800, Baolin Wang wrote:
> [...]
> > 
> > The driver was hard-coded to use registers 0xc2c and 0xdf0. SC2730 has
> > different registers, which were added to the downstream version of the
> > driver in [1]. I have tested this with a UMS9230 phone which has an
> > SC2730 PMIC according to the device tree.
> > 
> > [1]: https://github.com/MotorolaMobilityLLC/kernel-sprd/commit/6165e1afe3eba33089fecc86767d47af9ab176d6
> 
> OK. Thanks.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Please note that due to the feedback about the use of empty device tree
nodes, I have switched to a different approach and sent an alternative
patch as a follow-up to this one:

https://lore.kernel.org/all/20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de/

