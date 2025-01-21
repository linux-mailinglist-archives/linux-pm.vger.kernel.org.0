Return-Path: <linux-pm+bounces-20753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DDA17A26
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6446D188BE10
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC181C1F05;
	Tue, 21 Jan 2025 09:28:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF81C07D5
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451700; cv=none; b=YOSks9i/UQwdBTKyPlctBJvf1dEIHsRPOICPVORGBb8iMq8gdVRFar6v1Rss2Sb08Lm9uyiyipMQSsaBxh6ru+Nh01QYGllnfggZEhMVxFm0C24YIxTSGonbfVak4+rZADqLQknx8IXb3FQfDPPZXGejKAe5f4fs3eHWRoli+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451700; c=relaxed/simple;
	bh=o1kL8kt+AXGjJ2DSrH3rG7DQ3wNaZkClXMiy69KbBTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxRS9xhGyAo20CquAC8TV26zmLziNbRcLJyv0n0Hw8Kx2QifO4LLtFRX46unM6zLz+laq6ryWTpheJdMY+ftqA/ay7OOURkY25fZlQ5QY59/HsdM4RCR+pkBYrcSsJmtv5lxy0GBO42nj8zITLvJ9AIkh1fsHsb1Jfzjn8M02VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1taAY6-0003oE-84; Tue, 21 Jan 2025 10:27:54 +0100
Message-ID: <981e62da-00a4-415b-b53a-617992babaca@pengutronix.de>
Date: Tue, 21 Jan 2025 10:27:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] reboot: replace __hw_protection_shutdown bool
 action parameter with an enum
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org, chrome-platform@lists.linux.dev,
 devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-1-161d3fc734f0@pengutronix.de>
 <Z4325IopvxTN_34R@google.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <Z4325IopvxTN_34R@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hello,

On 20.01.25 08:10, Tzung-Bi Shih wrote:
> On Mon, Jan 13, 2025 at 05:25:26PM +0100, Ahmad Fatoum wrote:
>> Currently __hw_protection_shutdown() either reboots or shuts down the
>> system according to its shutdown argument.
>>
>> To make the logic easier to follow, both inside __hw_protection_shutdown
>> and at caller sites, lets replace the bool parameter with an enum.
>>
>> This will be extra useful, when in a later commit, a third action is
>> added to the enumeration.
>>
>> No functional change.
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> With a minor question,
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for your review.

>> @@ -1009,10 +1007,10 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
>>  	 * orderly_poweroff failure
>>  	 */
>>  	hw_failure_emergency_poweroff(ms_until_forced);
>> -	if (shutdown)
>> -		orderly_poweroff(true);
>> -	else
>> +	if (action == HWPROT_ACT_REBOOT)
>>  		orderly_reboot();
>> +	else
>> +		orderly_poweroff(true);
> 
> It probably doesn't really matter.  Does it intend to change the branch
> order?  As s/shutdown/action == HWPROT_ACT_SHUTDOWN/ should be more
> intuitive for the hunk to me.

My thinking was that having poweroff in the else branch underlines that
it's the default, i.e. either reboot was explicitly asked for or we fall
back to the poweroff default.

I see that this is subjective. I can change it for v3 if that's preferred.

Cheers,
Ahmad

> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

