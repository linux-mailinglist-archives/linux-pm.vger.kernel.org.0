Return-Path: <linux-pm+bounces-11822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D7945B0B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EBA1C2115B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CF1DAC6E;
	Fri,  2 Aug 2024 09:32:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B181C3794;
	Fri,  2 Aug 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591159; cv=none; b=hSpqVc38eNM+Hu7kD4h1pLPJxt5mE01SwTC4doxi0Rg+no+vHwnsLkGXtJJNKE6st8RsJsYm9sbNHDKvHo1CLY3tmWayCT7QD93KfnRKam1sApQibT0GU6Oygt7a7LShjyWmoDlVzQER4a3df9Vp4ULF4iFzdTse5YzIuQRWY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591159; c=relaxed/simple;
	bh=RmTFvEP8cQMU+zfTmPKcfKdwqPciPafUo/Qszg1NYWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVW7ryoHC6l90AGmyn60Z3ztZZYJ4A/PeR2zmrhr+gwu0CMi0SH3WpAqDJvZhri7YgBFRxY7Jte5C0pIZQdx2Y1fla82eD3vpw9IEA1Yjkl5kkHboSe78S7ORjuFKZKY5SnmRlaeQu6HdyX2zHN0njLwioFDjDXgSshRNnTWQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C761007;
	Fri,  2 Aug 2024 02:33:02 -0700 (PDT)
Received: from [10.57.12.204] (unknown [10.57.12.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE29E3F766;
	Fri,  2 Aug 2024 02:32:35 -0700 (PDT)
Message-ID: <5a4405dd-cbc5-4178-9fcb-f42676c793fe@arm.com>
Date: Fri, 2 Aug 2024 10:33:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Update thermal zone registration
 documentation
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <2767845.mvXUDI8C0e@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2767845.mvXUDI8C0e@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/24 15:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The thermal sysfs API document is outdated.  One of the problems with
> it is that is still documents thermal_zone_device_register() which
> does not exit any more and it does not reflect the current thermal
> zone operations definition.
> 
> Replace the thermal_zone_device_register() description in it with
> a thermal_zone_device_register_with_trips() description, including
> an update of the thermal zone operations list.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   Documentation/driver-api/thermal/sysfs-api.rst |   65 +++++++++++--------------
>   1 file changed, 30 insertions(+), 35 deletions(-)
> 
> Index: linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/thermal/sysfs-api.rst
> +++ linux-pm/Documentation/driver-api/thermal/sysfs-api.rst

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

