Return-Path: <linux-pm+bounces-25620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E943CA9197D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BECC7A7D82
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A6225A20;
	Thu, 17 Apr 2025 10:37:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E543D994;
	Thu, 17 Apr 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886276; cv=none; b=Lui+iqgnmske9nt8sFRu1fVoxPItOjHpgqtQP8q+VXUDvq/V5QjH5p+FhNXVB19Oy9oNpzNFTu/8icHY/XL/fakPJkJvNv5l2lXFoHOEnkpLEaiSQ6Vs1d8cO+1lyXZWF2L04JVdMbwxu14DjyA9x56GvCGhMm9c1WBgcHbnI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886276; c=relaxed/simple;
	bh=3wwJBnbscPWhREJodr63Mof+CmE9FyAyP+HTDxaHdOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7fAwnGQkAs1Ry72DNhwZGqYB5cd+D1S7ziIeCA+AfIdrdwu/lqhKWY/22LfOL715E/URK65GpY7MiVkIarbBXlHbRRuKorRm6ZNzeLl5gy3ysNyjo7qhtwlIoh3q4bX6ypJXxyUan9D+fmlDbj4MQQCySy1/PFgK3B8REpEpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB92D1515;
	Thu, 17 Apr 2025 03:37:49 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292163F694;
	Thu, 17 Apr 2025 03:37:51 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:37:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: arm: Do not enable by default during compile
 testing
Message-ID: <aADZ-EKpQ2Sd5KV2@pluto>
References: <20250417074645.81480-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417074645.81480-1-krzysztof.kozlowski@linaro.org>

On Thu, Apr 17, 2025 at 09:46:45AM +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

