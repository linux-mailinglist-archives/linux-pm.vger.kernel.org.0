Return-Path: <linux-pm+bounces-36181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C487EBDE59D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7998A4275DC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089E324B26;
	Wed, 15 Oct 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tNx9mFAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E174324B07;
	Wed, 15 Oct 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529460; cv=none; b=oDJIWwAukSMYmCrKOVBscaz/X0r8bmi6iCP24bhwnZI6VIgiPwAu6lQ8mEQZzS3oyJko2gT9Dl3qpG+7kYz97Y+cQYYBfipoESf8fhZMDRurnWy1pxDYwV7RPjEFEWYwZmkMLjtYG/3LtzsQAOIVB0d49YdSVG+l20dkSTfLOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529460; c=relaxed/simple;
	bh=ATeC9gj4S446/SpUnSdOaIpTGhUndKhEaNaAW6fDr+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/CZMBjGSL2gGC2d6psvJJtiW+rNA451CAxSj+7OG4+G03xWnnBYGs949rWJeYTcQmI8k8UqJLNQgDjtA1grvbAP/C07k8sykYrjU9Vx6+TI6UOmr8wB0HhyBqUjmy8v0Iw3fVMKC0Zes+KbG03iqDV8T2rqyZ27p86JP+w/snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tNx9mFAY; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBvVmN1394747;
	Wed, 15 Oct 2025 06:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760529451;
	bh=A71VNqtYzCF1KmkfjOwAYiWADn/MUPCfX0D+lW9Z52c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=tNx9mFAY8N98fw5w4y7bej8GRvHwwqbv1pgYGzNMVo9Eiah6JACpLMYTqjnM/uBQg
	 qIzPYMU+RmGE3CoT3yMvfLrY30vjnCNXWzbk7t+lb9lRmPayLfEvnmkdCidi25nouG
	 WHWtSI9oVa6u3hgUJxrHS7845GeY63Nbs/mgpc8A=
Received: from DFLE205.ent.ti.com (dfle205.ent.ti.com [10.64.6.63])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBvVNX382728
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:57:31 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:57:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:57:31 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBvUN51853984;
	Wed, 15 Oct 2025 06:57:30 -0500
Date: Wed, 15 Oct 2025 17:27:29 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Michal Kubecek <mkubecek@suse.cz>
CC: Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        Hans de
 Goede <hansg@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: use ktime_divns() to avoid 64-bit division
Message-ID: <20251015115729.64eglmp262u7g3so@lcpd911>
References: <20251015075957.8F40620057@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015075957.8F40620057@lion.mk-sys.cz>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 15, 2025 at 09:56:31 +0200, Michal Kubecek wrote:
> The build of intel_dc_ti_battery module on i386 (32-bit) fails with
> 
> ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko]
> 
> This is caused by 64-bit division of ktime values by NSEC_PER_USEC. Use
> ktime_divns() helper which handles the division correctly on 32-bit
> architectures.
> 
> Fixes: 8c5795fe5527 ("power: supply: Add new Intel Dollar Cove TI battery driver")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

Good catch!
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

