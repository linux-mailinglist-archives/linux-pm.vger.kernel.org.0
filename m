Return-Path: <linux-pm+bounces-35684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EFDBB64C0
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 11:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E1B4A127E
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36727274B55;
	Fri,  3 Oct 2025 09:02:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550131F152D;
	Fri,  3 Oct 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482163; cv=none; b=DKutEppTaP4Wc/SwULQDTHUctKLGWCRoY7d66r93vJ5iwUeXhZvHmSVSssjaF0ldyszS8PwKlKyq9kFUDJeGQXtApsEqmYCYv7E3TUdFHzNUHscu0+xaJC5deOfHy9/IHE5yo9+OySqRRXbH3Zn847fjLSimUj1SaOnWxBlHLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482163; c=relaxed/simple;
	bh=Eavg20eZ88CohzaNKd0NzSoVQIJLLR8NX8lfxSrl9No=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfUJjUjGZPxlPOTiJW2DselkRt4RAaYKXety3Er/Dddm65MQkKFwGMfau3n5IFq7kQ0eOVD0h9CMdHufFDHira3KnPvS+5psG1EIrn5Pwwi/qlahffRNubY/Y4iquIfyX+tDzeSgFoiPY76zda739zG2etBoGWLG7BJWT2Yorv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdN0g3Pdcz6L4tL;
	Fri,  3 Oct 2025 17:00:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CE34C1400D9;
	Fri,  3 Oct 2025 17:02:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 10:02:37 +0100
Date: Fri, 3 Oct 2025 10:02:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Takashi Iwai <tiwai@suse.de>, Dhruva
 Gole <d-gole@ti.com>
Subject: Re: [PATCH v1] PM: runtime: Introduce one more usage counter guard
Message-ID: <20251003100235.00003a98@huawei.com>
In-Reply-To: <12752072.O9o76ZdvQC@rafael.j.wysocki>
References: <12752072.O9o76ZdvQC@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 01 Oct 2025 19:34:29 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Follow previous commit 9a0abc39450a ("PM: runtime: Add auto-cleanup
> macros for "resume and get" operations") and define a runtime PM
> usage counter guard in which pm_runtime_get_noresume() and
> pm_runtime_put_noidle() will be used for incrementing and
> decrementing it, respectively.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make sense to complete the set.

Reviewed-by: Jonathan Cameron <jonathan.cameorn@huawei.com>

> ---
> 
> Commit 9a0abc39450a is there in my linux-next branch.
> 
> ---
>  include/linux/pm_runtime.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -610,6 +610,9 @@ static inline int pm_runtime_put_autosus
>  	return __pm_runtime_put_autosuspend(dev);
>  }
>  
> +DEFINE_GUARD(pm_runtime_noresume, struct device *,
> +	     pm_runtime_get_noresume(_T), pm_runtime_put_noidle(_T));
> +
>  DEFINE_GUARD(pm_runtime_active, struct device *,
>  	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
>  DEFINE_GUARD(pm_runtime_active_auto, struct device *,
> 
> 
> 


