Return-Path: <linux-pm+bounces-42967-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JIgNH7MmWkvWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42967-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:17:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480D216D22C
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D75300CFF6
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2715687D;
	Sat, 21 Feb 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC8rZjjA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620510FD;
	Sat, 21 Feb 2026 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771687035; cv=none; b=vDQKQgoK4fXdczVUSzgRe6Xdk0FQErlDC2LUuqDKN18w0ynE2DcHC0BuGGi2EIQwqFWsMvlO+FMg+T4hQyxpBUWwb9JmlVuKz9wEPK5bB4h4C7vt1761CYHf9XYH8efsHAMYxaKgdGEw7lejgM8Hb2e2BTVIROhjjGUSxJWtCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771687035; c=relaxed/simple;
	bh=5rRvK4UqSzYb6hJHK0ht9Oi4O+1viWlSpW9vNbhW5uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4TcPh9cHY3Zs0+Uoez+xJ8tSz22B+kl6NpJ4N073xnf6TNlNHJUZV/kjTUtDgwSt2HwCpKgv/Z0Dm05/BjWn6iKGf5synmMdbFpC7pFypYOhNuOHOzf3b3IloCCvFm0D7qRloJZjEGbegteG7WrRmCT57X5hKL6VMvWJkPklhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC8rZjjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F08C4CEF7;
	Sat, 21 Feb 2026 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771687035;
	bh=5rRvK4UqSzYb6hJHK0ht9Oi4O+1viWlSpW9vNbhW5uU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gC8rZjjA9C8P3w/BGuH7J/kow/Y5IRs57jBkmJdmO6ZCk4BrnjXiF2C5iRrK1jMrq
	 Qy5dcmekQpvcSMP9cyDLPU+6704lvr7E5hDDsNnnqLwzhhYZfFkUP+XeaGkT5s+pXD
	 dZcNjPIWJy4eKkL+oilg5ObihyFPZ1jQyONbPUnt89K9/iVYXJQJ7mFcOwB/HAaRac
	 4UnKE4V0D8767Kx1lgR60o2k9N807d2f8STl5QhN7qUqYg0+LIClTO+G8kA342aotC
	 H8K8WKKpSicta7siFxvjA9EmEzVROu1G37JwiVM5jIxIpcODlX0DYqHd03sTTqymNF
	 A3hVRtBdNkocg==
Message-ID: <8a23c0cd-12a8-4c1d-9420-fd029ccf30e0@kernel.org>
Date: Sat, 21 Feb 2026 16:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: supply: axp288_charger: Do not cancel work
 before initializing it
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42967-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 480D216D22C
X-Rspamd-Action: no action

Hi,

On 20-Feb-26 18:49, Krzysztof Kozlowski wrote:
> Driver registered devm handler to cancel_work_sync() before even the
> work was initialized, thus leading to possible warning from
> kernel/workqueue.c on (!work->func) check, if the error path was hit
> before the initialization happened.
> 
> Use devm_work_autocancel() on each work item independently, which
> handles the initialization and handler to cancel work.
> 
> Fixes: 165c2357744e ("power: supply: axp288_charger: Properly stop work on probe-error / remove")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/power/supply/axp288_charger.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index ac05942e4e6a..ca52c2c82b2c 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/module.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/device.h>
>  #include <linux/regmap.h>
>  #include <linux/workqueue.h>
> @@ -821,14 +822,6 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
>  	return 0;
>  }
>  
> -static void axp288_charger_cancel_work(void *data)
> -{
> -	struct axp288_chrg_info *info = data;
> -
> -	cancel_work_sync(&info->otg.work);
> -	cancel_work_sync(&info->cable.work);
> -}
> -
>  static int axp288_charger_probe(struct platform_device *pdev)
>  {
>  	int ret, i, pirq;
> @@ -911,12 +904,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Cancel our work on cleanup, register this before the notifiers */
> -	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
> +	ret = devm_work_autocancel(dev, &info->cable.work,
> +				   axp288_charger_extcon_evt_worker);
>  	if (ret)
>  		return ret;
>  
>  	/* Register for extcon notification */
> -	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
>  	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
>  	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
>  						&info->cable.nb);
> @@ -926,8 +919,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	}
>  	schedule_work(&info->cable.work);
>  
> +	ret = devm_work_autocancel(dev, &info->otg.work,
> +				   axp288_charger_otg_evt_worker);
> +	if (ret)
> +		return ret;
> +
>  	/* Register for OTG notification */
> -	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
>  	if (info->otg.cable) {
>  		ret = devm_extcon_register_notifier(dev, info->otg.cable,


