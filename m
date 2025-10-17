Return-Path: <linux-pm+bounces-36319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BBBE5E13
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C004EB6F6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2851FDE39;
	Fri, 17 Oct 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="HDZBJ0Mv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30C1C2BD;
	Fri, 17 Oct 2025 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660805; cv=none; b=ShzDfYRMhgs1lcA2o4NX+TeK3uTDpyKCp1/+i0cU8dkQJGCrC3jwGfmshrUR4EVNskFHG8Ywk9k8tccsnkQpgDRGdEtgONutDRra/GMXFCxQ4aco4rJGwWfr+PtmcUAvqonbv8v2Q2Q3eJEPZ7JgoYp0IbPiaqrGbOJ5HrZvmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660805; c=relaxed/simple;
	bh=bS2nfkUCKwHusOOJ1srrBeWgUmOfQacxcVsdDNaH8zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXZuA5z9Jzy2x4oKEA2RFu8g3Jp3NYUBFBxFpq5NTLMhFbYi5SLEsKpJBglTzVX2KYJiBrkHAHkYI4ZXlZM8YEaXKTrjBIuDEkgJ+dLBSarggSdKEhglwq/jjWT8GhNMraMB3WJNZA/X9ndQ607EDzAWtOpu4PuKCVB9r07F/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=HDZBJ0Mv; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cnlxY5N9cz4G72;
	Thu, 16 Oct 2025 20:26:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760660802; bh=bS2nfkUCKwHusOOJ1srrBeWgUmOfQacxcVsdDNaH8zs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HDZBJ0MvKyEn2s4RMGFEQqb9EYxrZZJIxiWG4UfGA3lKFQXvh6CDqXgKpmces9zao
	 7lozrWMVgHLAXgc940LtYjZz4DVBhohz8D6+Hq+YYKWr8Kb1eFrroK76SzrNo2fGzR
	 7rn/XVwAe4QsLvVtsz+ZWdCR2AS+G2TAUKPDv23w=
Message-ID: <abd715e2-6edd-4f35-a308-d2ee9a5ca334@panix.com>
Date: Thu, 16 Oct 2025 17:26:40 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kenneth C <kenny@panix.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
 gregkh@linuxfoundation.org, akuchynski@chromium.org,
 abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
 linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <20251017000051.2094101-1-jthies@google.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251017000051.2094101-1-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I wonder if this is the reason my (Kubuntu 25.04, FWIW) system will 
sometimes show the battery icon as "Charging" even when it's discharging 
(or nothing is plugged into either USB-C port)?

-Kenny

On 10/16/25 17:00, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
> 
> Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/ucsi/psy.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..8ae900c8c132 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
>   {
>   	u32 pdo;
>   
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		val->intval = 0;
> +		return 0;
> +	}
> +
>   	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
>   	case UCSI_CONSTAT_PWR_OPMODE_PD:
>   		if (con->num_pdos > 0) {
> 
> base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


