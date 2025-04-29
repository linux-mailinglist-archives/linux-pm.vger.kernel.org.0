Return-Path: <linux-pm+bounces-26388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8BAA1B51
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7F83B0B71
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940F25F78A;
	Tue, 29 Apr 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="X1Gp4j+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AB24C083;
	Tue, 29 Apr 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745954726; cv=none; b=XCXBEyA0r25W9dNLEuO3BpbSzPmA2OF8sbGuTjD9kmaXSKQ2wTzmHG6t3qvLWF8jV+L1E74kLXxm3pXgvn3EGefNbSTL2T0ZXYHvUesTyreYftpGMuMJaAlnYKNJjnLBUA1YNHNkfdFMiFKsuh/gyaoJONPbUCfFu+//JuoI+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745954726; c=relaxed/simple;
	bh=mUFSIbOh0ZERHVxEyLTbjHnLuloD8xCAXL6STo3jemc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqtD0Ig0zCQVhxK7mXNtO3br9G53FchYEbG9YoNc3wcD53/ypv1KNbIKK0EQpBlgn/uVoWn7W4hIkheaEMMTNz0Ocwcdof1I4g2uJuH8x7y/9rvjYLzSI+TmU5z54uJ9nNU38uuZprM9u4LPIU4/YNEeeE9NLbvXXZoM3UFzHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=X1Gp4j+j; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745954719;
	bh=mUFSIbOh0ZERHVxEyLTbjHnLuloD8xCAXL6STo3jemc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1Gp4j+jtE+7s/Ln2koM142muoh0/5BNh7S7VjLubaJbjhYFz7qx9Vc79AJv9GTVS
	 xj/uwv6z5jntVBafphaqZpQ9NCXAH168NHBgQr4aeicnwW0q9Fs150smmJXz16UsI5
	 1xP/Hj2jkzBPaeRwfqkISrL/D7wyExEknEssH7Io=
Date: Tue, 29 Apr 2025 21:25:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: cros_charge-control: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <084dfe42-8aa7-415f-8435-f1310be89747@t-8ch.de>
References: <aBEmk6ixfrQ2XpTw@kspp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEmk6ixfrQ2XpTw@kspp>

On 2025-04-29 13:20:51-0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of a
> flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/power/supply/cros_charge-control.c:57:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/power/supply/cros_charge-control.c | 26 +++++++++-------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index 02d5bdbe2e8d..e33bc4c55bcc 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -53,23 +53,17 @@ static int cros_chctl_send_charge_control_cmd(struct cros_ec_device *cros_ec,
>  		[3] = sizeof(struct ec_params_charge_control),
>  	};
>  
> -	struct {
> -		struct cros_ec_command msg;
> -		union {
> -			struct ec_params_charge_control req;
> -			struct ec_response_charge_control resp;
> -		} __packed data;
> -	} __packed buf = {
> -		.msg = {
> -			.command = EC_CMD_CHARGE_CONTROL,
> -			.version = cmd_version,
> -			.insize  = 0,
> -			.outsize = outsizes[cmd_version],
> -		},
> -		.data.req = *req,
> -	};
> +	DEFINE_RAW_FLEX(struct cros_ec_command, msg, data,
> +			MAX(sizeof(struct ec_params_charge_control),
> +			    sizeof(struct ec_response_charge_control)));
> +
> +	msg->command = EC_CMD_CHARGE_CONTROL;
> +	msg->version = cmd_version;
> +	msg->insize  = 0;
> +	msg->outsize = outsizes[cmd_version];
> +	*(struct ec_params_charge_control *)msg->data = *req;

Please use cros_ec_cmd() like the LED driver.

https://lore.kernel.org/lkml/Z-rKcgFjsyKvd58q@kspp/

>  
> -	return cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> +	return cros_ec_cmd_xfer_status(cros_ec, msg);
>  }
>  
>  static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
> -- 
> 2.43.0
> 

