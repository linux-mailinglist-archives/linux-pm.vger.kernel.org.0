Return-Path: <linux-pm+bounces-36317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED2BE5DFE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93B5B4E8AE4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801341F0994;
	Fri, 17 Oct 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="tAkh1p4W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7219D08F;
	Fri, 17 Oct 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660673; cv=none; b=VclBg3HVaH916+mh30qj0nwTvkSsNlH5MKphw13S7WgPyZsE87w75xLxz007Zq3C3bwFahh2vsYovdmmYm1ZoUX35pYnhOaqLax+ZiwYfCtqggL4k2p6dfJGmcalmuVpAKboqbcLAHrNQnZ2LZGwhrcSQ9BBz8cayYXS/WsLCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660673; c=relaxed/simple;
	bh=+tngxAwMJmyPy9uijR+ZE4dvzpgm5DRP2pbvKBo3Gno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdB952hfCItjmFgIfVzettidpi7GMEjqwChp1gtyXuofxVUfYwKYkVOb0qY4Sk8xytJHsEfxFd18N6AOoSdsJvnObcjuFH9F6irJ6dpi89xyluN1iQSZGIEjMmGnSiKa5RUOvep69FjQ5xxom4YV3mxxXZZ12JaHFH4tnfdaEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=tAkh1p4W; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cnlv10qqWz4G78;
	Thu, 16 Oct 2025 20:24:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760660670; bh=+tngxAwMJmyPy9uijR+ZE4dvzpgm5DRP2pbvKBo3Gno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tAkh1p4Wp0gKs07wSxXkIYNJazUOHIuO41jTgAL8MbIgSYiQwT9ZBlC3TA44vOtS9
	 ZY1ctialnzbqbizJ2BwdtBQ56rcR+5hDE1xxPVd6JMyRuzXTSBwue7ovDgMf+P4wA5
	 B80CWi/Zfu+WJ8b9saFgTKwXTocuNTvufgWT4VlA=
Message-ID: <25d9d483-3447-41c8-826a-8c71af737868@panix.com>
Date: Thu, 16 Oct 2025 17:24:27 -0700
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


Tested-By: Kenneth R. Crudup <kenny@panix.com>

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


