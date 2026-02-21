Return-Path: <linux-pm+bounces-42970-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBYuMTvNmWlGWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42970-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:20:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1C16D277
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672E9302353D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEADD20DD72;
	Sat, 21 Feb 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp1rzr5n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39B20A5E5;
	Sat, 21 Feb 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771687191; cv=none; b=bxkXE5Vw7TIDlpnkERki6T49Vh6sYpnZ7MnWkmLk4M4By/r7fuHH41CamaiSYW1DQ46dJlykH3TDN6qfvhPDMUVgNxKWNToE+C8FmPuJWRkCT4z1mOyB38Z7z+ZjBZw/R2URsKvPcjxGMOQiBfo+KT/GX5r5d7n5Qgbn9/wy9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771687191; c=relaxed/simple;
	bh=1T8Re5ED5BozTmygy3xqTI48fFiywPKOhZATniRJyoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YtBnDfTojDdY6Noq9m+MiV0xxkFu80r20vz1ya6rspaRr/0ITlPdQt9ogSsG/X0uOYPN5Oiei+GZe2FlIIFvIz71FIzrTeTrUsf9SWZQ8Tt1UT00MOItXg0qdaZQg9imyFWp2WQAR0e6xdSQeQtuCIa8H4nCBZ2AbSYSR+BsqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp1rzr5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FA4C4CEF7;
	Sat, 21 Feb 2026 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771687191;
	bh=1T8Re5ED5BozTmygy3xqTI48fFiywPKOhZATniRJyoM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jp1rzr5nfvaRgo84XMYY1dsl+1ZkLz8/Ptv+1AhsNL+nMqFL0x/wiCM1XZ8GaYj+x
	 h/xqb+EwHRq9JVjje15bGeTGNHeCpJKa9G9MnfaN3WB95cXHPMS61erU8HuH9OeQlD
	 xeRtf4ywrVU24MN/F/m6gj92Xb1C3ZJ0tUw8MeqtTh/gFIxQ7sEmolrrcB7rHWTnZu
	 eAUfvZgAfokOZ5LQby659lqXEu2pZLzywBLVuZfgXcqARcwQr3C7BWWBkdtJg65zso
	 cJdHnBv7Pq7VlE0AK19S5nU4zlBhBRhzZfXS8nM3aYAMxvEw7X2uRf5lNYVeQSEvit
	 7tnkz1bEPDSSA==
Message-ID: <7d0f0ed9-5832-4593-b618-6fbeedbb98c2@kernel.org>
Date: Sat, 21 Feb 2026 16:19:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: supply: twl4030_madc: Drop unused header
 includes
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
 <20260220174938.672883-8-krzysztof.kozlowski@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260220174938.672883-8-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42970-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35C1C16D277
X-Rspamd-Action: no action

Hi,

On 20-Feb-26 18:49, Krzysztof Kozlowski wrote:
> Driver does not use any code from workqueue.h and param.h.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/power/supply/twl4030_madc_battery.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
> index 3935162e350b..a99b3ff26929 100644
> --- a/drivers/power/supply/twl4030_madc_battery.c
> +++ b/drivers/power/supply/twl4030_madc_battery.c
> @@ -11,9 +11,7 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/param.h>
>  #include <linux/delay.h>
> -#include <linux/workqueue.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>


